Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C72C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436A2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfLPPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:51:58 -0500
Received: from sauhun.de ([88.99.104.3]:41960 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfLPPv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:51:56 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id D6F4A2C2DA4;
        Mon, 16 Dec 2019 16:51:54 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 07/16] media: pci: saa7164: saa7164-dvb: convert to use i2c_new_client_device()
Date:   Mon, 16 Dec 2019 16:51:34 +0100
Message-Id: <20191216155146.8803-8-wsa+renesas@sang-engineering.com>
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
 drivers/media/pci/saa7164/saa7164-dvb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/saa7164/saa7164-dvb.c b/drivers/media/pci/saa7164/saa7164-dvb.c
index 05ab4734ea67..6a527dbc1daf 100644
--- a/drivers/media/pci/saa7164/saa7164-dvb.c
+++ b/drivers/media/pci/saa7164/saa7164-dvb.c
@@ -116,8 +116,8 @@ static int si2157_attach(struct saa7164_port *port, struct i2c_adapter *adapter,
 
 	request_module(bi.type);
 
-	tuner = i2c_new_device(adapter, &bi);
-	if (tuner == NULL || tuner->dev.driver == NULL)
+	tuner = i2c_new_client_device(adapter, &bi);
+	if (!i2c_client_has_driver(tuner))
 		return -ENODEV;
 
 	if (!try_module_get(tuner->dev.driver->owner)) {
@@ -637,9 +637,9 @@ int saa7164_dvb_register(struct saa7164_port *port)
 			info.addr = 0xc8 >> 1;
 			info.platform_data = &si2168_config;
 			request_module(info.type);
-			client_demod = i2c_new_device(&dev->i2c_bus[2].i2c_adap,
+			client_demod = i2c_new_client_device(&dev->i2c_bus[2].i2c_adap,
 						      &info);
-			if (!client_demod || !client_demod->dev.driver)
+			if (!i2c_client_has_driver(client_demod))
 				goto frontend_detach;
 
 			if (!try_module_get(client_demod->dev.driver->owner)) {
@@ -657,9 +657,9 @@ int saa7164_dvb_register(struct saa7164_port *port)
 			info.addr = 0xc0 >> 1;
 			info.platform_data = &si2157_config;
 			request_module(info.type);
-			client_tuner = i2c_new_device(&dev->i2c_bus[0].i2c_adap,
+			client_tuner = i2c_new_client_device(&dev->i2c_bus[0].i2c_adap,
 						      &info);
-			if (!client_tuner || !client_tuner->dev.driver) {
+			if (!i2c_client_has_driver(client_tuner)) {
 				module_put(client_demod->dev.driver->owner);
 				i2c_unregister_device(client_demod);
 				goto frontend_detach;
@@ -682,9 +682,9 @@ int saa7164_dvb_register(struct saa7164_port *port)
 			info.addr = 0xcc >> 1;
 			info.platform_data = &si2168_config;
 			request_module(info.type);
-			client_demod = i2c_new_device(&dev->i2c_bus[2].i2c_adap,
+			client_demod = i2c_new_client_device(&dev->i2c_bus[2].i2c_adap,
 						      &info);
-			if (!client_demod || !client_demod->dev.driver)
+			if (!i2c_client_has_driver(client_demod))
 				goto frontend_detach;
 
 			if (!try_module_get(client_demod->dev.driver->owner)) {
@@ -702,9 +702,9 @@ int saa7164_dvb_register(struct saa7164_port *port)
 			info.addr = 0xc0 >> 1;
 			info.platform_data = &si2157_config;
 			request_module(info.type);
-			client_tuner = i2c_new_device(&dev->i2c_bus[1].i2c_adap,
+			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap,
 						      &info);
-			if (!client_tuner || !client_tuner->dev.driver) {
+			if (!i2c_client_has_driver(client_tuner)) {
 				module_put(client_demod->dev.driver->owner);
 				i2c_unregister_device(client_demod);
 				goto frontend_detach;
-- 
2.20.1

