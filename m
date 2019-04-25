Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BCFC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C812206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfDYBmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:42:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388188AbfDYBmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134221"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:43 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 2/5] mmzone: new pgdat flags for DRAM and PMEM
Date:   Thu, 25 Apr 2019 09:21:32 +0800
Message-Id: <1556155295-77723-3-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556155295-77723-1-git-send-email-fan.du@intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One system with DRAM and PMEM, we need new flag
to tag pgdat is made of DRAM or peristent memory.

This patch serves as preparetion one for follow up patch.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 include/linux/mmzone.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fba7741..d3ee9f9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -520,6 +520,8 @@ enum pgdat_flags {
 					 * many pages under writeback
 					 */
 	PGDAT_RECLAIM_LOCKED,		/* prevents concurrent reclaim */
+	PGDAT_DRAM,			/* Volatile DRAM memory node */
+	PGDAT_PMEM,			/* Persistent memory node */
 };
 
 enum zone_flags {
@@ -923,6 +925,30 @@ extern int numa_zonelist_order_handler(struct ctl_table *, int,
 
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
+static inline int is_node_pmem(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	return test_bit(PGDAT_PMEM, &pgdat->flags);
+}
+
+static inline int is_node_dram(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	return test_bit(PGDAT_DRAM, &pgdat->flags);
+}
+
+static inline void set_node_type(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	if (node_isset(nid, numa_nodes_pmem))
+		set_bit(PGDAT_PMEM, &pgdat->flags);
+	else
+		set_bit(PGDAT_DRAM, &pgdat->flags);
+}
+
 extern struct pglist_data *first_online_pgdat(void);
 extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
 extern struct zone *next_zone(struct zone *zone);
-- 
1.8.3.1

