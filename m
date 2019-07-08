Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6CC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9285720861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfGHMgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:36:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfGHMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:36:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F5538B1A157E02D993C;
        Mon,  8 Jul 2019 20:36:40 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 20:36:32 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <willy@haproxy.com>, <ksenija.stanojevic@gmail.com>,
        <miguel.ojeda.sandonis@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] auxdisplay: panel: need to delete scan_timer when misc_register fails in panel_attach
Date:   Mon, 8 Jul 2019 20:42:18 +0800
Message-ID: <1562589738-10595-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In panel_attach, if misc_register fails, we need to delete scan_timer,
which was setup in keypad_init->init_scan_timer.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/auxdisplay/panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index e06de63..e6bd727 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1617,6 +1617,8 @@ static void panel_attach(struct parport *port)
 	return;

 err_lcd_unreg:
+	if (scan_timer.function)
+		del_timer_sync(&scan_timer);
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
--
2.7.4

