Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD787CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A752084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbfJWHtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:49:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732328AbfJWHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:49:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D6F1A282FB7E3A318CC;
        Wed, 23 Oct 2019 15:49:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 15:49:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: comedi: dt2814: remove set but not used variables 'data'
Date:   Wed, 23 Oct 2019 15:48:27 +0800
Message-ID: <20191023074827.33264-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/comedi/drivers/dt2814.c:193:6:
 warning: variable data set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/comedi/drivers/dt2814.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
index d2c7157..e7c6787 100644
--- a/drivers/staging/comedi/drivers/dt2814.c
+++ b/drivers/staging/comedi/drivers/dt2814.c
@@ -186,21 +186,17 @@ static int dt2814_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
 
 static irqreturn_t dt2814_interrupt(int irq, void *d)
 {
-	int lo, hi;
 	struct comedi_device *dev = d;
 	struct dt2814_private *devpriv = dev->private;
 	struct comedi_subdevice *s = dev->read_subdev;
-	int data;
 
 	if (!dev->attached) {
 		dev_err(dev->class_dev, "spurious interrupt\n");
 		return IRQ_HANDLED;
 	}
 
-	hi = inb(dev->iobase + DT2814_DATA);
-	lo = inb(dev->iobase + DT2814_DATA);
-
-	data = (hi << 4) | (lo >> 4);
+	inb(dev->iobase + DT2814_DATA);
+	inb(dev->iobase + DT2814_DATA);
 
 	if (!(--devpriv->ntrig)) {
 		int i;
-- 
2.7.4


