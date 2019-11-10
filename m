Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBAFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6005E20869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfKJK6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:58:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfKJK6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:58:22 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B782BC5F4735ABA30E0;
        Sun, 10 Nov 2019 18:58:21 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Sun, 10 Nov 2019 18:58:15 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <dri-devel@lists.freedesktop.org>,
        <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] staging: fbtft: Remove set but not used variable 'ret'
Date:   Sun, 10 Nov 2019 18:57:07 +0800
Message-ID: <20191110105707.136956-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/fbtft/fb_ili9320.c: In function read_devicecode:
drivers/staging/fbtft/fb_ili9320.c:25:6: warning: variable ret set but not used [-Wunused-but-set-variable]

ret is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/staging/fbtft/fb_ili9320.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index f2e72d14431d..f0ebc40857b3 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -22,11 +22,10 @@
 
 static unsigned int read_devicecode(struct fbtft_par *par)
 {
-	int ret;
 	u8 rxbuf[8] = {0, };
 
 	write_reg(par, 0x0000);
-	ret = par->fbtftops.read(par, rxbuf, 4);
+	par->fbtftops.read(par, rxbuf, 4);
 	return (rxbuf[2] << 8) | rxbuf[3];
 }
 
-- 
2.23.0

