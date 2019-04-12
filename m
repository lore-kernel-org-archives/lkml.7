Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3359C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4BE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDLBXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:23:15 -0400
Received: from mail-out-4.itc.rwth-aachen.de ([134.130.5.49]:33450 "EHLO
        mail-out-4.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbfDLBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:23:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ACAwDU5K9c/54agoZlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZYIRghMKhASVEJNXhxEPAS2EQAKFcyM4EgEBAwEBCgEBAQECbSiFSwYjBAs?=
 =?us-ascii?q?BRhAlAiYCAlcGDgWDIoIJBKw+fDOJH4EPCQGBASWGcoRVghaBOAyDHYURgj2CV?=
 =?us-ascii?q?wOKXwqIcJJEBwKBLFuSCyCLWokULZ8+AgICAgkCFYFmIYFWcYM7gkGODT4yfAw?=
 =?us-ascii?q?hjigBgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2ACAwDU5K9c/54agoZlHAEBAQQBAQcEAQGBZYIRghMKhAS?=
 =?us-ascii?q?VEJNXhxEPAS2EQAKFcyM4EgEBAwEBCgEBAQECbSiFSwYjBAsBRhAlAiYCAlcGD?=
 =?us-ascii?q?gWDIoIJBKw+fDOJH4EPCQGBASWGcoRVghaBOAyDHYURgj2CVwOKXwqIcJJEBwK?=
 =?us-ascii?q?BLFuSCyCLWokULZ8+AgICAgkCFYFmIYFWcYM7gkGODT4yfAwhjigBgR8BAQ?=
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 12 Apr 2019 03:13:25 +0200
Received: from pebbles.fritz.box (93.135.108.28) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 03:13:20 +0200
From:   =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 2/3] media: dvbsky: Remove duplicate error reporting for dvbsky_usb_generic_rw
Date:   Fri, 12 Apr 2019 03:12:59 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
References: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.135.108.28]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Message-ID: <1e8ef77a-ca76-463e-9399-94e7725280e0@rwthex-w2-a.rwth-ad.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors are already reported by the common code in dvb_usb_v2_generic_io
(which dvbsky_usb_generic_rw is a wrapper of), so there is no reason
report the error again.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/media/usb/dvb-usb-v2/dvbsky.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvbsky.c b/drivers/media/usb/dvb-usb-v2/dvbsky.c
index e28bd8836751..dffcadd8c834 100644
--- a/drivers/media/usb/dvb-usb-v2/dvbsky.c
+++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c
@@ -100,8 +100,6 @@ static int dvbsky_gpio_ctrl(struct dvb_usb_device *d, u8 gport, u8 value)
 	obuf[1] = gport;
 	obuf[2] = value;
 	ret = dvbsky_usb_generic_rw(d, obuf, 3, ibuf, 1);
-	if (ret)
-		dev_err(&d->udev->dev, "failed=%d\n", ret);
 	return ret;
 }
 
@@ -139,8 +137,6 @@ static int dvbsky_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			obuf[3] = msg[0].addr;
 			ret = dvbsky_usb_generic_rw(d, obuf, 4,
 					ibuf, msg[0].len + 1);
-			if (ret)
-				dev_err(&d->udev->dev, "failed=%d\n", ret);
 			if (!ret)
 				memcpy(msg[0].buf, &ibuf[1], msg[0].len);
 		} else {
@@ -151,8 +147,6 @@ static int dvbsky_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			memcpy(&obuf[3], msg[0].buf, msg[0].len);
 			ret = dvbsky_usb_generic_rw(d, obuf,
 					msg[0].len + 3, ibuf, 1);
-			if (ret)
-				dev_err(&d->udev->dev, "failed=%d\n", ret);
 		}
 	} else {
 		if ((msg[0].len > 60) || (msg[1].len > 60)) {
@@ -170,9 +164,6 @@ static int dvbsky_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		memcpy(&obuf[4], msg[0].buf, msg[0].len);
 		ret = dvbsky_usb_generic_rw(d, obuf,
 			msg[0].len + 4, ibuf, msg[1].len + 1);
-		if (ret)
-			dev_err(&d->udev->dev, "failed=%d\n", ret);
-
 		if (!ret)
 			memcpy(msg[1].buf, &ibuf[1], msg[1].len);
 	}
@@ -201,8 +192,6 @@ static int dvbsky_rc_query(struct dvb_usb_device *d)
 
 	obuf[0] = 0x10;
 	ret = dvbsky_usb_generic_rw(d, obuf, 1, ibuf, 2);
-	if (ret)
-		dev_err(&d->udev->dev, "failed=%d\n", ret);
 	if (ret == 0)
 		code = (ibuf[0] << 8) | ibuf[1];
 	if (code != 0xffff) {
-- 
2.21.0

