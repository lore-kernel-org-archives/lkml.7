Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FAC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfILCzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:55:10 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:38774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729256AbfILCzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4C50318225E0B;
        Thu, 12 Sep 2019 02:55:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wash17_837480261ff44
X-Filterd-Recvd-Size: 3818
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] nvdimm: Use octal permissions
Date:   Wed, 11 Sep 2019 19:54:33 -0700
Message-Id: <93cf2f046486416fbcea19a8194411e3f44fd2d3.1568256706.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the use of the S_IRUGO define and use 0444 to improve readability
and use a more common kernel style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/btt.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 6362d96dfc16..9cad4dca6eac 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -229,27 +229,24 @@ static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
 		return;
 	a->debugfs_dir = d;
 
-	debugfs_create_x64("size", S_IRUGO, d, &a->size);
-	debugfs_create_x64("external_lba_start", S_IRUGO, d,
-			   &a->external_lba_start);
-	debugfs_create_x32("internal_nlba", S_IRUGO, d, &a->internal_nlba);
-	debugfs_create_u32("internal_lbasize", S_IRUGO, d,
-			   &a->internal_lbasize);
-	debugfs_create_x32("external_nlba", S_IRUGO, d, &a->external_nlba);
-	debugfs_create_u32("external_lbasize", S_IRUGO, d,
-			   &a->external_lbasize);
-	debugfs_create_u32("nfree", S_IRUGO, d, &a->nfree);
-	debugfs_create_u16("version_major", S_IRUGO, d, &a->version_major);
-	debugfs_create_u16("version_minor", S_IRUGO, d, &a->version_minor);
-	debugfs_create_x64("nextoff", S_IRUGO, d, &a->nextoff);
-	debugfs_create_x64("infooff", S_IRUGO, d, &a->infooff);
-	debugfs_create_x64("dataoff", S_IRUGO, d, &a->dataoff);
-	debugfs_create_x64("mapoff", S_IRUGO, d, &a->mapoff);
-	debugfs_create_x64("logoff", S_IRUGO, d, &a->logoff);
-	debugfs_create_x64("info2off", S_IRUGO, d, &a->info2off);
-	debugfs_create_x32("flags", S_IRUGO, d, &a->flags);
-	debugfs_create_u32("log_index_0", S_IRUGO, d, &a->log_index[0]);
-	debugfs_create_u32("log_index_1", S_IRUGO, d, &a->log_index[1]);
+	debugfs_create_x64("size", 0444, d, &a->size);
+	debugfs_create_x64("external_lba_start", 0444, d, &a->external_lba_start);
+	debugfs_create_x32("internal_nlba", 0444, d, &a->internal_nlba);
+	debugfs_create_u32("internal_lbasize", 0444, d, &a->internal_lbasize);
+	debugfs_create_x32("external_nlba", 0444, d, &a->external_nlba);
+	debugfs_create_u32("external_lbasize", 0444, d, &a->external_lbasize);
+	debugfs_create_u32("nfree", 0444, d, &a->nfree);
+	debugfs_create_u16("version_major", 0444, d, &a->version_major);
+	debugfs_create_u16("version_minor", 0444, d, &a->version_minor);
+	debugfs_create_x64("nextoff", 0444, d, &a->nextoff);
+	debugfs_create_x64("infooff", 0444, d, &a->infooff);
+	debugfs_create_x64("dataoff", 0444, d, &a->dataoff);
+	debugfs_create_x64("mapoff", 0444, d, &a->mapoff);
+	debugfs_create_x64("logoff", 0444, d, &a->logoff);
+	debugfs_create_x64("info2off", 0444, d, &a->info2off);
+	debugfs_create_x32("flags", 0444, d, &a->flags);
+	debugfs_create_u32("log_index_0", 0444, d, &a->log_index[0]);
+	debugfs_create_u32("log_index_1", 0444, d, &a->log_index[1]);
 }
 
 static void btt_debugfs_init(struct btt *btt)
-- 
2.15.0

