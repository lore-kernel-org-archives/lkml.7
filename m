Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2120717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLPPwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:52:16 -0500
Received: from sauhun.de ([88.99.104.3]:42006 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfLPPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:52:03 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 3E9B72C2DB8;
        Mon, 16 Dec 2019 16:52:02 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 15/16] media: usb: dvb-usb: dw2102: convert to use i2c_new_client_device()
Date:   Mon, 16 Dec 2019 16:51:42 +0100
Message-Id: <20191216155146.8803-16-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216155146.8803-1-wsa+renesas@sang-engineering.com>
References: <20191216155146.8803-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newer API returning an ERRPTR and use the new helper to bail
out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/dvb-usb/dw2102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index b960abd00d48..8b584507dd59 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -1590,8 +1590,8 @@ static int tt_s2_4600_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x68;
 	board_info.platform_data = &m88ds3103_pdata;
 	request_module("m88ds3103");
-	client = i2c_new_device(&d->i2c_adap, &board_info);
-	if (client == NULL || client->dev.driver == NULL)
+	client = i2c_new_client_device(&d->i2c_adap, &board_info);
+	if (!i2c_client_has_driver(client))
 		return -ENODEV;
 	if (!try_module_get(client->dev.driver->owner)) {
 		i2c_unregister_device(client);
@@ -1609,9 +1609,9 @@ static int tt_s2_4600_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x60;
 	board_info.platform_data = &ts2020_config;
 	request_module("ts2020");
-	client = i2c_new_device(i2c_adapter, &board_info);
+	client = i2c_new_client_device(i2c_adapter, &board_info);
 
-	if (client == NULL || client->dev.driver == NULL) {
+	if (!i2c_client_has_driver(client)) {
 		dvb_frontend_detach(adap->fe_adap[0].fe);
 		return -ENODEV;
 	}
-- 
2.20.1

