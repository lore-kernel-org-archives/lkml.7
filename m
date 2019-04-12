Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FCDC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6908120869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDLBXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:23:11 -0400
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:35282 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfDLBXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:23:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ACAwAV5a9c/54agoZlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZYIRghMKhASVEJNXhxEPAS2EQAKFcyM4EgEBAwEBCgEBAQECbSiFSwYjBAs?=
 =?us-ascii?q?BRhAlAiYCAlcGDgWDIoIJBKw/fDOJH4EPCQGBASWGcoRVghaBOAyDHYURgj2CV?=
 =?us-ascii?q?wOKX4h6kkQHAoEsW5ILIItaiRQtnz4CAgICCQIVgWYhgVZxgzuCQY4NPjJ8DCG?=
 =?us-ascii?q?OKAGBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2ACAwAV5a9c/54agoZlHAEBAQQBAQcEAQGBZYIRghMKhAS?=
 =?us-ascii?q?VEJNXhxEPAS2EQAKFcyM4EgEBAwEBCgEBAQECbSiFSwYjBAsBRhAlAiYCAlcGD?=
 =?us-ascii?q?gWDIoIJBKw/fDOJH4EPCQGBASWGcoRVghaBOAyDHYURgj2CVwOKX4h6kkQHAoE?=
 =?us-ascii?q?sW5ILIItaiRQtnz4CAgICCQIVgWYhgVZxgzuCQY4NPjJ8DCGOKAGBHwEB?=
X-IronPort-AV: E=Sophos;i="5.60,339,1549926000"; 
   d="scan'208";a="75440745"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 12 Apr 2019 03:13:24 +0200
Received: from pebbles.fritz.box (93.135.108.28) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 03:13:21 +0200
From:   =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 3/3] media: af9035: Remove duplicate error reporting for dvbsky_usb_generic_rw
Date:   Fri, 12 Apr 2019 03:13:00 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
References: <20190412011300.5468-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.135.108.28]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Message-ID: <a63e7320-25a7-4516-9e9e-0fbdcee6f528@rwthex-w2-a.rwth-ad.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error cases inside the function already report errors via dev_err(),
and dvb_usb_v2_generic_rw also reports all error cases, so there is
no silent code path when an error has occured.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 80d3bd3a0f24..920596f78460 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -120,8 +120,6 @@ static int af9035_ctrl_msg(struct dvb_usb_device *d, struct usb_req *req)
 		memcpy(req->rbuf, &state->buf[ACK_HDR_LEN], req->rlen);
 exit:
 	mutex_unlock(&d->usb_mutex);
-	if (ret < 0)
-		dev_dbg(&intf->dev, "failed=%d\n", ret);
 	return ret;
 }
 
-- 
2.21.0

