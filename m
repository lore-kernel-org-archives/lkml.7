Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54857C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F62C2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otOL9Mov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfCZQ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:56:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:56:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id bg8so1905524plb.0;
        Tue, 26 Mar 2019 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z8cXnutfyg4Hwio09am68L70RiRqzsguuMWJ8tGeGUs=;
        b=otOL9MovmFWHsmzOibEaV6aJOA5IVev5xZgc2pgWhm9/tDvW/43GLG3jL6Brn6iEI/
         +PWbWex4BZg2W1lXVLVP/nTu7XS4HmBFJNxxMngncNjYNvltRsfq0/SnheRJfphXy2/J
         WgIIrriEJ7mgxRbqMGZ8gVVFUHnAQJlbkE3+wQq0ADMp3nIXHTd0Q9vZ6KDJdEmOM7x1
         OtA2pSLtCtK4iYTXXzncQdypqc++YJXXye04RhpGiDpl1zvkjephBXzP7HenjfUj0GDB
         7t1lK4cv7n0KxhZGnzjn0XWTC56pmJrECgC/hadR3qjMMuqhNQVuvecqKh8n9bfH7UeC
         d2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z8cXnutfyg4Hwio09am68L70RiRqzsguuMWJ8tGeGUs=;
        b=sIR6639l4qllh7LedXIkpvmRqH6xc4SotghyKOjwZ3keWVHdKwhNTTknQwtykXZVME
         BXxxqdy+fAh3CV44b021XipiFRxN91DHUindxS6O5LyV3zS6w9N2k+i8cWCXVstouGGO
         e1UdyY/GbdEFu+gSNxAfmv2QFLo466Yq3pfRljLPaNWPgROdDAqnKXgdDeK0tcW91uYi
         WQCYt14/cwYZqIyIUi6Y8481c0Fqswb5unj/6nDkk0nmQs8GfLdhNDoTYMskjIYMGjgN
         OPo04vnHnV6P03hWW2ViD8qg1r3+UvkUYkGiKNrKMxMokqpWK4U6ydVQ72OqiQYCbU1Q
         fy1g==
X-Gm-Message-State: APjAAAVHHOEiZ6tVu1M3IO/mxdQ6wBDG3AtM4W0TPCqcB+0VTznHHE02
        bfMfv8fJNJvNPfMjqDcHwjk=
X-Google-Smtp-Source: APXvYqy8jxA/ewweRWPoStr5colZvDBBkiFRkIOH5jfw4/CiZer8LsJ3YF7T8oRrMKdV34Zx6XfdjQ==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr31815705plp.247.1553619366722;
        Tue, 26 Mar 2019 09:56:06 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id z128sm40016066pfz.107.2019.03.26.09.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 09:56:06 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630
Date:   Tue, 26 Mar 2019 09:55:54 -0700
Message-Id: <20190326165554.17266-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit edfc3722cfef ("HID: quirks: Fix keyboard + touchpad on
Toshiba Click Mini not working"), the Lenovo Miix 630 has a combo
keyboard/touchpad device with vid:pid of 04F3:0400, which is shared with
Elan touchpads.  The combo on the Miix 630 has an ACPI id of QTEC0001,
which is not claimed by the elan_i2c driver, so key on that similar to
what was done for the Toshiba Click Mini.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/hid/hid-quirks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 1148d8c0816a..77ffba48cc73 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -715,7 +715,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -996,6 +995,10 @@ bool hid_ignore(struct hid_device *hdev)
 		if (hdev->product == 0x0401 &&
 		    strncmp(hdev->name, "ELAN0800", 8) != 0)
 			return true;
+		/* Same with product id 0x0400 */
+		if (hdev->product == 0x0400 &&
+		    strncmp(hdev->name, "QTEC0001", 8) != 0)
+			return true;
 		break;
 	}
 
-- 
2.17.1

