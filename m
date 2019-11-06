Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4455AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11292217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfKFVVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:21:52 -0500
Received: from sauhun.de ([88.99.104.3]:59072 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732671AbfKFVVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:21:30 -0500
Received: from localhost (p54B33505.dip0.t-ipconnect.de [84.179.53.5])
        by pokefinder.org (Postfix) with ESMTPSA id 93DEF2C0558;
        Wed,  6 Nov 2019 22:21:28 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] media: usb: dvb-usb-v2: rtl28xxu: convert to use i2c_new_client_device()
Date:   Wed,  6 Nov 2019 22:21:13 +0100
Message-Id: <20191106212120.27983-14-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
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
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 5016ede7b35f..3a4eb992024a 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -697,8 +697,8 @@ static int rtl2831u_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x10;
 	board_info.platform_data = pdata;
 	request_module("%s", board_info.type);
-	client = i2c_new_device(&d->i2c_adap, &board_info);
-	if (client == NULL || client->dev.driver == NULL) {
+	client = i2c_new_client_device(&d->i2c_adap, &board_info);
+	if (!i2c_client_has_driver(client)) {
 		ret = -ENODEV;
 		goto err;
 	}
@@ -918,8 +918,8 @@ static int rtl2832u_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x10;
 	board_info.platform_data = pdata;
 	request_module("%s", board_info.type);
-	client = i2c_new_device(&d->i2c_adap, &board_info);
-	if (client == NULL || client->dev.driver == NULL) {
+	client = i2c_new_client_device(&d->i2c_adap, &board_info);
+	if (!i2c_client_has_driver(client)) {
 		ret = -ENODEV;
 		goto err;
 	}
@@ -960,8 +960,8 @@ static int rtl2832u_frontend_attach(struct dvb_usb_adapter *adap)
 			info.addr = 0x18;
 			info.platform_data = &mn88472_config;
 			request_module(info.type);
-			client = i2c_new_device(&d->i2c_adap, &info);
-			if (client == NULL || client->dev.driver == NULL) {
+			client = i2c_new_client_device(&d->i2c_adap, &info);
+			if (!i2c_client_has_driver(client)) {
 				dev->slave_demod = SLAVE_DEMOD_NONE;
 				goto err_slave_demod_failed;
 			}
@@ -982,8 +982,8 @@ static int rtl2832u_frontend_attach(struct dvb_usb_adapter *adap)
 			info.addr = 0x18;
 			info.platform_data = &mn88473_config;
 			request_module(info.type);
-			client = i2c_new_device(&d->i2c_adap, &info);
-			if (client == NULL || client->dev.driver == NULL) {
+			client = i2c_new_client_device(&d->i2c_adap, &info);
+			if (!i2c_client_has_driver(client)) {
 				dev->slave_demod = SLAVE_DEMOD_NONE;
 				goto err_slave_demod_failed;
 			}
@@ -1025,8 +1025,8 @@ static int rtl2832u_frontend_attach(struct dvb_usb_adapter *adap)
 			info.addr = 0x64;
 			info.platform_data = &si2168_config;
 			request_module(info.type);
-			client = i2c_new_device(&d->i2c_adap, &info);
-			if (client == NULL || client->dev.driver == NULL) {
+			client = i2c_new_client_device(&d->i2c_adap, &info);
+			if (!i2c_client_has_driver(client)) {
 				dev->slave_demod = SLAVE_DEMOD_NONE;
 				goto err_slave_demod_failed;
 			}
@@ -1217,8 +1217,8 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
 			info.platform_data = &e4000_config;
 
 			request_module(info.type);
-			client = i2c_new_device(dev->demod_i2c_adapter, &info);
-			if (client == NULL || client->dev.driver == NULL)
+			client = i2c_new_client_device(dev->demod_i2c_adapter, &info);
+			if (!i2c_client_has_driver(client))
 				break;
 
 			if (!try_module_get(client->dev.driver->owner)) {
@@ -1240,9 +1240,9 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
 			board_info.addr = 0x56;
 			board_info.platform_data = &fc2580_pdata;
 			request_module("fc2580");
-			client = i2c_new_device(dev->demod_i2c_adapter,
+			client = i2c_new_client_device(dev->demod_i2c_adapter,
 						&board_info);
-			if (client == NULL || client->dev.driver == NULL)
+			if (!i2c_client_has_driver(client))
 				break;
 			if (!try_module_get(client->dev.driver->owner)) {
 				i2c_unregister_device(client);
@@ -1271,8 +1271,8 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
 		board_info.addr = 0x60;
 		board_info.platform_data = &tua9001_pdata;
 		request_module("tua9001");
-		client = i2c_new_device(dev->demod_i2c_adapter, &board_info);
-		if (client == NULL || client->dev.driver == NULL)
+		client = i2c_new_client_device(dev->demod_i2c_adapter, &board_info);
+		if (!i2c_client_has_driver(client))
 			break;
 		if (!try_module_get(client->dev.driver->owner)) {
 			i2c_unregister_device(client);
@@ -1316,8 +1316,8 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
 			info.addr = 0x60;
 			info.platform_data = &si2157_config;
 			request_module(info.type);
-			client = i2c_new_device(&d->i2c_adap, &info);
-			if (client == NULL || client->dev.driver == NULL)
+			client = i2c_new_client_device(&d->i2c_adap, &info);
+			if (!i2c_client_has_driver(client))
 				break;
 
 			if (!try_module_get(client->dev.driver->owner)) {
-- 
2.20.1

