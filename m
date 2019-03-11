Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AC3214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfCKUYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:37486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbfCKUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300712"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C6C5C301E31; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 06/10] perf, tools, report: Print better message for JITed code
Date:   Mon, 11 Mar 2019 13:24:42 -0700
Message-Id: <20190311202446.10210-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The message about missing /tmp/perf-* for JITed code is quite confusing
to users. Add a better error message, but only print it once.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/map.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..d476b76abc6a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -316,6 +316,15 @@ int map__load(struct map *map)
 
 	nr = dso__load(map->dso, map);
 	if (nr < 0) {
+		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
+			static bool warned;
+			if (!warned) {
+				pr_err("Cannot find executable, JITed code present? May need agent.\n");
+				warned = true;
+			}
+			return -1;
+		}
+
 		if (map->dso->has_build_id) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-- 
2.20.1

