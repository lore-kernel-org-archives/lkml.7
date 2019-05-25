Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A91C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3595E2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEYN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 09:57:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbfEYN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 09:57:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C8AF8ADA2498956F5CEC;
        Sat, 25 May 2019 21:57:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 21:57:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <airlied@linux.ie>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] agp: remove some set but not used variables
Date:   Sat, 25 May 2019 21:56:52 +0800
Message-ID: <20190525135652.3688-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warnings:

drivers/char/agp/frontend.c: In function agp_find_seg_in_client:
drivers/char/agp/frontend.c:105:6: warning: variable num_segments set but not used [-Wunused-but-set-variable]
drivers/char/agp/isoch.c: In function agp_3_5_isochronous_node_enable:
drivers/char/agp/isoch.c:87:5: warning: variable mcapndx set but not used [-Wunused-but-set-variable]
drivers/char/agp/isoch.c: In function agp_3_5_enable:
drivers/char/agp/isoch.c:322:13: warning: variable arqsz set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/char/agp/frontend.c | 3 +--
 drivers/char/agp/isoch.c    | 9 +--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index f6955888e676..47098648502d 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -102,14 +102,13 @@ agp_segment_priv *agp_find_seg_in_client(const struct agp_client *client,
 					    int size, pgprot_t page_prot)
 {
 	struct agp_segment_priv *seg;
-	int num_segments, i;
+	int i;
 	off_t pg_start;
 	size_t pg_count;
 
 	pg_start = offset / 4096;
 	pg_count = size / 4096;
 	seg = *(client->segments);
-	num_segments = client->num_segments;
 
 	for (i = 0; i < client->num_segments; i++) {
 		if ((seg[i].pg_start == pg_start) &&
diff --git a/drivers/char/agp/isoch.c b/drivers/char/agp/isoch.c
index 31c374b1b91b..7ecf20a6d19c 100644
--- a/drivers/char/agp/isoch.c
+++ b/drivers/char/agp/isoch.c
@@ -84,7 +84,6 @@ static int agp_3_5_isochronous_node_enable(struct agp_bridge_data *bridge,
 	unsigned int cdev = 0;
 	u32 mnistat, tnistat, tstatus, mcmd;
 	u16 tnicmd, mnicmd;
-	u8 mcapndx;
 	u32 tot_bw = 0, tot_n = 0, tot_rq = 0, y_max, rq_isoch, rq_async;
 	u32 step, rem, rem_isoch, rem_async;
 	int ret = 0;
@@ -138,8 +137,6 @@ static int agp_3_5_isochronous_node_enable(struct agp_bridge_data *bridge,
 		cur = list_entry(pos, struct agp_3_5_dev, list);
 		dev = cur->dev;
 
-		mcapndx = cur->capndx;
-
 		pci_read_config_dword(dev, cur->capndx+AGPNISTAT, &mnistat);
 
 		master[cdev].maxbw = (mnistat >> 16) & 0xff;
@@ -251,8 +248,6 @@ static int agp_3_5_isochronous_node_enable(struct agp_bridge_data *bridge,
 		cur = master[cdev].dev;
 		dev = cur->dev;
 
-		mcapndx = cur->capndx;
-
 		master[cdev].rq += (cdev == ndevs - 1)
 		              ? (rem_async + rem_isoch) : step;
 
@@ -319,7 +314,7 @@ int agp_3_5_enable(struct agp_bridge_data *bridge)
 {
 	struct pci_dev *td = bridge->dev, *dev = NULL;
 	u8 mcapndx;
-	u32 isoch, arqsz;
+	u32 isoch;
 	u32 tstatus, mstatus, ncapid;
 	u32 mmajor;
 	u16 mpstat;
@@ -334,8 +329,6 @@ int agp_3_5_enable(struct agp_bridge_data *bridge)
 	if (isoch == 0)	/* isoch xfers not available, bail out. */
 		return -ENODEV;
 
-	arqsz     = (tstatus >> 13) & 0x7;
-
 	/*
 	 * Allocate a head for our AGP 3.5 device list
 	 * (multiple AGP v3 devices are allowed behind a single bridge).
-- 
2.17.1


