Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81626C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1FE206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLQMYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:24:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfLQMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:24:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 037B23EF96BC14A49FED;
        Tue, 17 Dec 2019 20:24:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 20:24:05 +0800
To:     <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] agp: remove unused variable arqsz in agp_3_5_enable()
Message-ID: <0cb8770b-70eb-575b-edf7-6ae771a0baa0@huawei.com>
Date:   Tue, 17 Dec 2019 20:22:57 +0800
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
drivers/char/agp/isoch.c: In function ‘agp_3_5_enable’:
drivers/char/agp/isoch.c:322:13: warning: variable ‘arqsz’ set but not
used [-Wunused-but-set-variable]
  u32 isoch, arqsz;
             ^~~~~

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/char/agp/isoch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/agp/isoch.c b/drivers/char/agp/isoch.c
index 324992439ee8..7ecf20a6d19c 100644
--- a/drivers/char/agp/isoch.c
+++ b/drivers/char/agp/isoch.c
@@ -314,7 +314,7 @@ int agp_3_5_enable(struct agp_bridge_data *bridge)
 {
 	struct pci_dev *td = bridge->dev, *dev = NULL;
 	u8 mcapndx;
-	u32 isoch, arqsz;
+	u32 isoch;
 	u32 tstatus, mstatus, ncapid;
 	u32 mmajor;
 	u16 mpstat;
@@ -329,8 +329,6 @@ int agp_3_5_enable(struct agp_bridge_data *bridge)
 	if (isoch == 0)	/* isoch xfers not available, bail out. */
 		return -ENODEV;

-	arqsz     = (tstatus >> 13) & 0x7;
-
 	/*
 	 * Allocate a head for our AGP 3.5 device list
 	 * (multiple AGP v3 devices are allowed behind a single bridge).
-- 
2.7.4

