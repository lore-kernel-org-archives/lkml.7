Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0787AC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 23:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C521120645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 23:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kyle.ee header.i=@kyle.ee header.b="S068obiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFOXWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 19:22:16 -0400
Received: from mail18.static.mailgun.info ([104.130.122.18]:64462 "EHLO
        mail18.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfFOXWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 19:22:15 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jun 2019 19:22:15 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=kyle.ee; q=dns/txt; s=pic;
 t=1560640935; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From: Sender;
 bh=u290sqO0VjaBIRpGZZlIVS+lU6vFel0XM4QZU58RiuI=; b=S068obiuFyciK04frKWQFoII50SzT+i+E6lpSW645y+BKq6XJxxkhgZsGK9V8L/zjgpJyhe6
 jXHScyQqylFa1GpoNGnYizihuLk6iQqslWR5Ps6BY8nqgrt16Li3QAFcFDF+2PDmcdHrkvTF
 8JybU0lL6bq4GUUuUVpIrPg78p4=
X-Mailgun-Sending-Ip: 104.130.122.18
X-Mailgun-Sid: WyI2NDU5ZiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImVkZmJhZiJd
Received: from Thinkpad (c-68-52-90-92.hsd1.tn.comcast.net [68.52.90.92])
 by mxa.mailgun.org with ESMTP id 5d057c79.7f08738e1c30-smtp-out-n01;
 Sat, 15 Jun 2019 23:17:13 -0000 (UTC)
From:   Kyle Godbey <me@kyle.ee>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Godbey <me@kyle.ee>
Subject: [PATCH] HID: uclogic: Add support for Huion HS64 tablet
Date:   Sat, 15 Jun 2019 18:15:06 -0500
Message-Id: <20190615231506.17443-1-me@kyle.ee>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Huion HS64 drawing tablet to hid-uclogic

Signed-off-by: Kyle Godbey <me@kyle.ee>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 84e0c78d73cd..86ed32dd18ca 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -569,6 +569,7 @@
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
+#define USB_DEVICE_ID_HUION_HS64	0x006d
 
 #define USB_VENDOR_ID_IBM					0x04b3
 #define USB_DEVICE_ID_IBM_SCROLLPOINT_III			0x3100
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 8fe02d81265d..914fb527ae7a 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -369,6 +369,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
 				USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
+				USB_DEVICE_ID_HUION_HS64) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 0187c9f8fc22..273d784fff66 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -977,6 +977,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		/* FALL THROUGH */
 	case VID_PID(USB_VENDOR_ID_HUION,
 		     USB_DEVICE_ID_HUION_TABLET):
+	case VID_PID(USB_VENDOR_ID_HUION,
+		     USB_DEVICE_ID_HUION_HS64):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
-- 
2.21.0
