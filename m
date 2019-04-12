Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDAC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0E220869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDLBWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:22:55 -0400
Received: from mail-out-4.itc.rwth-aachen.de ([134.130.5.49]:33421 "EHLO
        mail-out-4.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfDLBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:22:55 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 21:22:54 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AgAQDU5K9c/54agoZlGgEBAQEBAgEBA?=
 =?us-ascii?q?QEHAgEBAQGBZQKBZSqCHbICgXoPAS2EQAKFcyM6BAwBAQMBAQoBAQEBAm0ohUs?=
 =?us-ascii?q?GJwsBRhBRVwYOgyeCCQStOjOJH4EPCQGBJgGGcYRVghaBOII9bGmEKIUUA4pfi?=
 =?us-ascii?q?HqSRAcCgSxbkgsgi1qJFJ9rAgICAgkCFYFpDhCBVnGDPIMtAQKNHT6BLgwhjig?=
 =?us-ascii?q?BgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AgAQDU5K9c/54agoZlGgEBAQEBAgEBAQEHAgEBAQGBZQK?=
 =?us-ascii?q?BZSqCHbICgXoPAS2EQAKFcyM6BAwBAQMBAQoBAQEBAm0ohUsGJwsBRhBRVwYOg?=
 =?us-ascii?q?yeCCQStOjOJH4EPCQGBJgGGcYRVghaBOII9bGmEKIUUA4pfiHqSRAcCgSxbkgs?=
 =?us-ascii?q?gi1qJFJ9rAgICAgkCFYFpDhCBVnGDPIMtAQKNHT6BLgwhjigBgR8BAQ?=
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
Subject: [PATCH 1/3] media: dvb-usb-v2: Report error on all error paths
Date:   Fri, 12 Apr 2019 03:12:58 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
References: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [93.135.108.28]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Message-ID: <f58ff4ca-9b9e-44af-a617-cdaa9e71f15f@rwthex-w2-a.rwth-ad.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

actual_length != wlen is the only error path which does not generate an
error message. Adding an error message here allows to report a more
specific error and to remove the error reporting from the call sites.

Also clean up the error paths - in case of an error, the remaining
code is skipped, and ret is returned. Skip setting ret and return
immediately (no cleanup necessary).
---
 drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c
index 5bafeb6486be..5b32d159f968 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c
@@ -37,14 +37,19 @@ static int dvb_usb_v2_generic_io(struct dvb_usb_device *d,
 	ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
 			d->props->generic_bulk_ctrl_endpoint), wbuf, wlen,
 			&actual_length, 2000);
-	if (ret < 0)
+	if (ret) {
 		dev_err(&d->udev->dev, "%s: usb_bulk_msg() failed=%d\n",
 				KBUILD_MODNAME, ret);
-	else
-		ret = actual_length != wlen ? -EIO : 0;
+		return ret;
+	}
+	if (actual_length != wlen) {
+		dev_err(&d->udev->dev, "%s: usb_bulk_msg() write length=%d, actual=%d\n",
+				KBUILD_MODNAME, wlen, actual_length);
+		return -EIO;
+	}
 
-	/* an answer is expected, and no error before */
-	if (!ret && rbuf && rlen) {
+	/* an answer is expected */
+	if (rbuf && rlen) {
 		if (d->props->generic_bulk_ctrl_delay)
 			usleep_range(d->props->generic_bulk_ctrl_delay,
 					d->props->generic_bulk_ctrl_delay
-- 
2.21.0

