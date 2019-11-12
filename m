Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02056C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF89206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:47:55 -0500
Received: from mail1.g16.pair.com ([66.39.65.22]:53849 "EHLO
        mail1.g16.pair.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfKLMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:47:55 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 07:47:54 EST
Received: from mail1.g16.pair.com (localhost [127.0.0.1])
        by mail1.g16.pair.com (Postfix) with ESMTP id 300575E2B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:41:25 -0500 (EST)
Received: from gateway2.fiddes-enterprises.com (cpc156731-sgyl45-2-0-cust468.18-2.cable.virginm.net [82.31.53.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail1.g16.pair.com (Postfix) with ESMTPSA id B4BA75E28
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:41:24 -0500 (EST)
Received: (qmail 18204 invoked from network); 12 Nov 2019 12:41:17 -0000
Received: from snowman.fiddes-enterprises.com (192.168.1.54)
  by gateway2.fiddes-enterprises.com with SMTP; 12 Nov 2019 12:41:17 -0000
From:   "David J. Fiddes" <D.J@fiddes.net>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David J. Fiddes" <D.J@fiddes.net>
Subject: [PATCH] media: rtl28xxu: Add support for PROlectrix DV107669 DVB-T dongle
Date:   Tue, 12 Nov 2019 12:40:59 +0000
Message-Id: <20191112124059.23706-1-D.J@fiddes.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the PROlectrix DV107669 DVT-T dongle which
uses an RTL2832 and FC0012 tuner.

Tests:
 - Verified correct operation of DVB-T reception with VLC across
   several UK multiplexes

Signed-off-by: David J. Fiddes <D.J@fiddes.net>
---
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 2 ++
 include/media/dvb-usb-ids.h             | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 1a36bda28542..55da3d56acc7 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -1954,6 +1954,8 @@ static const struct usb_device_id rtl28xxu_id_table[] = {
 		&rtl28xxu_props, "Sveon STV27", NULL) },
 	{ DVB_USB_DEVICE(USB_VID_KWORLD_2, USB_PID_TURBOX_DTT_2000,
 		&rtl28xxu_props, "TURBO-X Pure TV Tuner DTT-2000", NULL) },
+	{ DVB_USB_DEVICE(USB_VID_GTEK, USB_PID_PROLECTRIX_DV107669,
+		&rtl28xxu_props, "PROlectrix DV107669", NULL) },
 
 	/* RTL2832P devices: */
 	{ DVB_USB_DEVICE(USB_VID_HANFTEK, 0x0131,
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 52875e3eee71..fce3123bfb80 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -423,4 +423,5 @@
 #define USB_PID_EVOLVEO_XTRATV_STICK			0xa115
 #define USB_PID_HAMA_DVBT_HYBRID			0x2758
 #define USB_PID_XBOX_ONE_TUNER                          0x02d5
+#define USB_PID_PROLECTRIX_DV107669                     0xd803
 #endif
-- 
2.23.0

