Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2C2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZM2dYrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfDJUgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:36:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39939 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:36:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so4036949wmi.5;
        Wed, 10 Apr 2019 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pGlr5Dlh1tSgxgSU4dDk/Ypsv74j1Q+Y8/FEbJrbcgg=;
        b=PZM2dYrFi598aOf60gQg+zDRoJTpXvrT/0VOSz5WkInLLq0d9aCOwpk8aZoA/eMMbf
         vyfKOeAcTBai9ij9BfiFsJiT3mFduMq1sLn85SJPcCBpLd/MpsXXpgVRFkpYq+URvqtu
         cTQz3DxuK3ry0YtxVVkZQmUsny/yubKwYTVhDUHjyp6UH7OTMUGIWHwy0dY5Im+Y39qJ
         W8iQZMGZ89VL1ozLoJZZUz8suHAJN5fZM1NzWbHJSYSiQel5tBOMLK0Qmqplk9wzLEIy
         iqygP7q9MseN2/PIdpgjjgeZzD7rJp81LXmKt/n/S6S12V/4Gypeex0ZgVLPv9fij0Hz
         PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGlr5Dlh1tSgxgSU4dDk/Ypsv74j1Q+Y8/FEbJrbcgg=;
        b=ayl7ncwXpq0aWgyIX7OMNB6ukMVUXU2BAWIROCnshMXH8HGDK6Esz8GTPnZgZo6NCF
         jeV/T6jShbFlda795hl79871UuocHBSIxb2gJSI8pXf8dGTnlPtc71Dvd65/RGZD2bJc
         5RXZ/TZcKjXed+bL6jPC9qqc9ISMvB/T0brI4D5b07prsF7UVCmMnrgRJ5EkDsYAwRPi
         4yYyh38nsQQ/tdhh7bZe6wxTjDPQB6g7F2tYg0oDm0neep9a2qTQ3C1shO6lLE1CFX2e
         UOpn96TISXxwVsm/gx1XZNsryj6J6uzxttl0U8qf9J71jpDbn8qllPhS43EOo/+sSXhx
         G57A==
X-Gm-Message-State: APjAAAU4QWyVMIxQmgc8BooWSER/TltfCV+RsB+KbwrR3V4Z+uU8aNYz
        urMI44vLTBd/D2GU0o50cj69YSVRTL0=
X-Google-Smtp-Source: APXvYqwG3BUw8uM1I53XMiF/TClXiQD++LP8AIEbCln84W42PMi5ZyHfvGnnhxD99S68x2yhMexN9Q==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr4248632wmm.80.1554928582643;
        Wed, 10 Apr 2019 13:36:22 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id b204sm4974956wmh.29.2019.04.10.13.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:36:22 -0700 (PDT)
Subject: [PATCH 11/11] platform/x86: asus-wmi: Do not disable keyboard
 backlight on unload
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <2b130755-87bb-b7a5-939b-4d0ebd69af68@gmail.com>
Date:   Wed, 10 Apr 2019 22:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keyboard backlight is disabled when module is unloaded as it is
exposed as LED device. Change this behavior to ignore setting 0 brightness
when the ledclass device is unloading.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 941c628945ac..a0ffdd99eae2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -475,6 +475,10 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 static void kbd_led_set(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
+	/* Prevent disabling keyboard backlight on module unregister */
+	if (led_cdev->flags & LED_UNREGISTERING)
+		return;
+
 	do_kbd_led_set(led_cdev, value);
 }
 
-- 
2.17.1

