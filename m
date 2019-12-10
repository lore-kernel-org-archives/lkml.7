Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EBEC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79FB206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLJJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:15:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:29109 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfLJJPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:15:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 01:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="244777952"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2019 01:14:58 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v2 2/3] perf x86: Add compaction function for uncore attributes
Date:   Tue, 10 Dec 2019 12:14:50 +0300
Message-Id: <20191210091451.6054-3-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
References: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

In current design, there is an implicit assumption that array of pointers
to uncore type attributes is NULL terminated. However, not all attributes
are mandatory for each Uncore unit type, e.g. "events" is required for
IMC but doesn't exist for CHA. That approach correctly supports only one
optional attribute which also must be the last in the row.
The patch removes limitation by safely removing embedded NULL elements.

Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 24e120289018..a05352c4fc01 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -923,6 +923,22 @@ static void uncore_types_exit(struct intel_uncore_type **types)
 		uncore_type_exit(*types);
 }
 
+static void uncore_type_attrs_compaction(struct intel_uncore_type *type)
+{
+	int i, j;
+	int size = ARRAY_SIZE(type->attr_groups);
+
+	for (i = 0, j = 0; i < size; i++) {
+		if (!type->attr_groups[i])
+			continue;
+		if (i > j) {
+			type->attr_groups[j] = type->attr_groups[i];
+			type->attr_groups[i] = NULL;
+		}
+		j++;
+	}
+}
+
 static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 {
 	struct intel_uncore_pmu *pmus;
@@ -980,6 +996,12 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 		if (!type->get_topology(type) && !type->set_mapping(type))
 			type->mapping_group = &uncore_mapping_group;
 
+	/*
+	 * For optional attributes, we can safely remove embedded NULL
+	 * attr_groups elements.
+	 */
+	uncore_type_attrs_compaction(type);
+
 	return 0;
 
 err:
-- 
2.19.1

