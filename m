Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAD0217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfKFVVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:21:34 -0500
Received: from sauhun.de ([88.99.104.3]:59054 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbfKFVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:21:31 -0500
Received: from localhost (p54B33505.dip0.t-ipconnect.de [84.179.53.5])
        by pokefinder.org (Postfix) with ESMTPSA id 532E32C054A;
        Wed,  6 Nov 2019 22:21:30 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] media: usb: dvb-usb: dw2102: convert to use i2c_new_client_device()
Date:   Wed,  6 Nov 2019 22:21:16 +0100
Message-Id: <20191106212120.27983-17-wsa+renesas@sang-engineering.com>
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

