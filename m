Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917FC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C10220665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFUJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:17:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55914 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfFUJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:17:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so5638669wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 02:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3dnealLbWyKFjr0ipaHscOu2tOtwFDnep9BD/IPqN0=;
        b=oZTZphewxO3UUSAKf3xZWned8JRK46o/FAaRc7TyM/jnJyJQMiduZzyLroZamA+Fnw
         sUKDLK9ZbfrOWZqYSacWikEVri876/NAR3Jg47ZreDgJ865XgiKDPSTES8FBPQJy5SEZ
         sU+0HngplR8cD9dIjF0KOifX8856SU6VeiUpig7WFsJim23L7IGT9Vls5TkqZu+Zm1yE
         2f3jOevRDg8AKXbViVzLR+B1xlv7J2GlWCwWpZGEEV4xvB6OMJ3DCD4VpOAn4ss0J5J8
         UAYsP/EPZqRIAcNK3mgygE0ePZqJDx+YSsObKwfYe6v2t/LF/WNgdI2LRRf4+zGmZUjf
         qLEg==
X-Gm-Message-State: APjAAAXGPgBjuiawbyxxHm+iM0gZEhMm1dK152OiFyT8MOYpRylHDxZR
        oNrX/eX1CMgyWtstJh1KNiQWBw==
X-Google-Smtp-Source: APXvYqxHgEfyILwYCkmxsqsTCXwxiiJpJc4v55sF3T1608Z/IqVl+kc1VnKFmZhemZ3jBom5b0F/bA==
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr3212935wmf.111.1561108658412;
        Fri, 21 Jun 2019 02:17:38 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r2sm1933610wme.30.2019.06.21.02.17.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:17:37 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Parschauer <sparschauer@suse.de>,
        Dave Young <dyoung@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] hid: add another quirk for Chicony PixArt mouse
Date:   Fri, 21 Jun 2019 11:17:36 +0200
Message-Id: <20190621091736.14503-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've spotted another Chicony PixArt mouse in the wild, which requires
HID_QUIRK_ALWAYS_POLL quirk, otherwise it disconnects each minute.

USB ID of this device is 0x04f2:0x0939.

We've introduced quirks like this for other models before, so lets add
this mouse too.

Link: https://github.com/sriemer/fix-linux-mouse#usb-mouse-disconnectsreconnects-every-minute-on-linux
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index eac0c54c5970..69f0553d9d95 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -269,6 +269,7 @@
 #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE	0x1053
+#define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2	0x0939
 #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
 #define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index e5ca6fe2ca57..671a285724f9 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -42,6 +42,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK), HID_QUIRK_NOGET },
-- 
2.22.0

