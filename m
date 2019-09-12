Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E2C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436062085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfILCz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:55:26 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:49341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728947AbfILCzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EF03A8024B45;
        Thu, 12 Sep 2019 02:55:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast04_861bb7d71dd62
X-Filterd-Recvd-Size: 3643
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:21 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] nvdimm: btt.h: Neaten #defines to improve readability
Date:   Wed, 11 Sep 2019 19:54:39 -0700
Message-Id: <d1815f376a158c940cc9f9f6d5000398ba531237.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tab alignment to make the content and macro a bit more intelligible.

Use the BIT and BIT_ULL macros.
Convert MAP_LBA_MASK to use the already defined shift masks.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/btt.h | 54 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 1da76da3e159..fb0f4546153f 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -10,34 +10,34 @@
 #include <linux/badblocks.h>
 #include <linux/types.h>
 
-#define BTT_SIG_LEN 16
-#define BTT_SIG "BTT_ARENA_INFO\0"
-#define MAP_ENT_SIZE 4
-#define MAP_TRIM_SHIFT 31
-#define MAP_TRIM_MASK (1 << MAP_TRIM_SHIFT)
-#define MAP_ERR_SHIFT 30
-#define MAP_ERR_MASK (1 << MAP_ERR_SHIFT)
-#define MAP_LBA_MASK (~((1 << MAP_TRIM_SHIFT) | (1 << MAP_ERR_SHIFT)))
-#define MAP_ENT_NORMAL 0xC0000000
-#define LOG_GRP_SIZE sizeof(struct log_group)
-#define LOG_ENT_SIZE sizeof(struct log_entry)
-#define ARENA_MIN_SIZE (1UL << 24)	/* 16 MB */
-#define ARENA_MAX_SIZE (1ULL << 39)	/* 512 GB */
-#define RTT_VALID (1UL << 31)
-#define RTT_INVALID 0
-#define BTT_PG_SIZE 4096
-#define BTT_DEFAULT_NFREE ND_MAX_LANES
-#define LOG_SEQ_INIT 1
-
-#define IB_FLAG_ERROR 0x00000001
-#define IB_FLAG_ERROR_MASK 0x00000001
-
-#define ent_lba(ent) (ent & MAP_LBA_MASK)
-#define ent_e_flag(ent) (!!(ent & MAP_ERR_MASK))
-#define ent_z_flag(ent) (!!(ent & MAP_TRIM_MASK))
-#define set_e_flag(ent) (ent |= MAP_ERR_MASK)
+#define BTT_SIG_LEN		16
+#define BTT_SIG			"BTT_ARENA_INFO\0"
+#define MAP_ENT_SIZE		4
+#define MAP_TRIM_SHIFT		31
+#define MAP_TRIM_MASK		BIT(MAP_TRIM_SHIFT)
+#define MAP_ERR_SHIFT		30
+#define MAP_ERR_MASK		BIT(MAP_ERR_SHIFT)
+#define MAP_LBA_MASK		(~(MAP_TRIM_MASK | MAP_ERR_MASK))
+#define MAP_ENT_NORMAL		0xC0000000
+#define LOG_GRP_SIZE		sizeof(struct log_group)
+#define LOG_ENT_SIZE		sizeof(struct log_entry)
+#define ARENA_MIN_SIZE		BIT(24)		/* 16 MB */
+#define ARENA_MAX_SIZE		BIT_ULL(39)	/* 512 GB */
+#define RTT_VALID		BIT(31)
+#define RTT_INVALID		0
+#define BTT_PG_SIZE		4096
+#define BTT_DEFAULT_NFREE	ND_MAX_LANES
+#define LOG_SEQ_INIT		1
+
+#define IB_FLAG_ERROR		0x00000001
+#define IB_FLAG_ERROR_MASK	0x00000001
+
+#define ent_lba(ent)		((ent) & MAP_LBA_MASK)
+#define ent_e_flag(ent)		(!!((ent) & MAP_ERR_MASK))
+#define ent_z_flag(ent)		(!!((ent) & MAP_TRIM_MASK))
+#define set_e_flag(ent)		((ent) |= MAP_ERR_MASK)
 /* 'normal' is both e and z flags set */
-#define ent_normal(ent) (ent_e_flag(ent) && ent_z_flag(ent))
+#define ent_normal(ent)		(ent_e_flag(ent) && ent_z_flag(ent))
 
 enum btt_init_state {
 	INIT_UNCHECKED = 0,
-- 
2.15.0

