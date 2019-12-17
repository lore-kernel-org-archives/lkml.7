Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BCDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550C821739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfLQMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:23:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfLQMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:23:10 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CE44463DC972C0C67C9;
        Tue, 17 Dec 2019 20:23:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 20:22:58 +0800
To:     <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] agp: remove unused variable mcapndx
Message-ID: <a7c98193-1180-732b-df86-843deca64275@huawei.com>
Date:   Tue, 17 Dec 2019 20:21:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following warning:
drivers/char/agp/isoch.c: In function ‘agp_3_5_isochronous_node_enable’:
drivers/char/agp/isoch.c:87:5: warning: variable ‘mcapndx’ set but not
used [-Wunused-but-set-variable]
  u8 mcapndx;
     ^~~~~~~

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/char/agp/isoch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/char/agp/isoch.c b/drivers/char/agp/isoch.c
index 31c374b1b91b..324992439ee8 100644
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

-- 
2.7.4

