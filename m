Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4820717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfLPPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:52:14 -0500
Received: from sauhun.de ([88.99.104.3]:42018 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfLPPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:52:03 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 99BA32C2DB6;
        Mon, 16 Dec 2019 16:52:01 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 14/16] media: usb: dvb-usb: dib0700_devices: convert to use i2c_new_client_device()
Date:   Mon, 16 Dec 2019 16:51:41 +0100
Message-Id: <20191216155146.8803-15-wsa+renesas@sang-engineering.com>
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
 drivers/media/usb/dvb-usb/dib0700_devices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index ab7a100ec84f..4ef3fa98d20f 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -3772,8 +3772,8 @@ static int xbox_one_attach(struct dvb_usb_adapter *adap)
 	info.addr = 0x18;
 	info.platform_data = &mn88472_config;
 	request_module(info.type);
-	client_demod = i2c_new_device(&d->i2c_adap, &info);
-	if (client_demod == NULL || client_demod->dev.driver == NULL)
+	client_demod = i2c_new_client_device(&d->i2c_adap, &info);
+	if (!i2c_client_has_driver(client_demod))
 		goto fail_demod_device;
 	if (!try_module_get(client_demod->dev.driver->owner))
 		goto fail_demod_module;
@@ -3800,8 +3800,8 @@ static int xbox_one_attach(struct dvb_usb_adapter *adap)
 	info.platform_data = &tda18250_config;
 
 	request_module(info.type);
-	client_tuner = i2c_new_device(&adap->dev->i2c_adap, &info);
-	if (client_tuner == NULL || client_tuner->dev.driver == NULL)
+	client_tuner = i2c_new_client_device(&adap->dev->i2c_adap, &info);
+	if (!i2c_client_has_driver(client_tuner))
 		goto fail_tuner_device;
 	if (!try_module_get(client_tuner->dev.driver->owner))
 		goto fail_tuner_module;
-- 
2.20.1

