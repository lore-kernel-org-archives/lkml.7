Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E9FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36420879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ofVraa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfENTDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:03:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44610 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:03:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so20371410wrs.11;
        Tue, 14 May 2019 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BK+hMQZhbc01flr8GR70aSzxt77OZF9p21PsIdL24yQ=;
        b=Y1ofVraaip9a2gjL9BqnHJ5ZBKJEU70Pu4axWdX0F7QOTlWl7Uq8HgRnVn3Dli4Z0K
         7ZNmeq6FMC/bZxJPQqR4zVw6lzJKDfAljqqDWdMh4IZafU/gjmBRJJuFHHn4R7KPYBjU
         1XdqD7IocbNWLut35NzgF5NoRtkC4IZLcAEVASsYEIFXMJX3bXf1n8zc8efxZ8WT6zCI
         E0qh1P1lU8Q7EHmQRVbaJ0boruY+0wOvN8T+hns4nAMmR/6UtM/+wPuhtMwF9VESaeLY
         Xisw6dE2kGcj0ThixD3UzRdlMBW2k6nowE5IGs8LfaAQcNEYcUMt2zWu6ncFErxq8N8b
         iRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BK+hMQZhbc01flr8GR70aSzxt77OZF9p21PsIdL24yQ=;
        b=CZv8iab8/QVat+7tuFgi7qEeKiHIhPeh4Mb8Q3lwHfhvCWDUj7TQ08X1qLG3dLcB6A
         czEa0IrfGHpy1+q7rnzpGNjb4QoOgr/5NZmQW9wN9rb//tmAalnwrXnaiTH8x7dqMkza
         BLi1Wq+d7b75FqeUv94dUhJnoWtc/7siadkxuC71SbJbATucwhbMZ6I6wmY68ZdXkRxM
         7BMD8uyCSbGBcWhs5QKZlmEWHx5i8/ObcDIbyM/h+In8YdVt4Yg8t8wAU81+BjT7jOMR
         NDHEvrLgtTtQ1n20wR/eDqWWhqULaqwIq3ItXpdlyMVq85qzcbhFnnVyfyi9fSNJXSOz
         ZRRw==
X-Gm-Message-State: APjAAAUS2NetfXGMjZOC2sesCr8tG9DDVCzsK2WRKPwdP7W4jCMdaz+K
        bZzPxwf1jjRGor7f4NmVIFJllYFp
X-Google-Smtp-Source: APXvYqxXcfcnla7n8+Hj+Aa1XQSznK4g6YR6aBmJXl+hY3aYW7XYrHTGEPxJ6gvsBNCl1XRsTuf+fw==
X-Received: by 2002:adf:8043:: with SMTP id 61mr13618256wrk.47.1557860580863;
        Tue, 14 May 2019 12:03:00 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id u9sm4967312wmd.14.2019.05.14.12.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:03:00 -0700 (PDT)
Subject: [PATCH v4 08/13] platform/x86: asus-nb-wmi: Add microphone mute key
 code
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <a396a7f7-c3b3-f09b-5a14-33acf3a141d7@gmail.com>
Date:   Tue, 14 May 2019 21:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone mute key is missing from sparse keymap. It is present on
FX505GM and possibly other laptops. Add the missing code.

Also, comment on the fan mode switch key, which has the same code as the
already used key.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b6f2ff95c3ed..d2399ce0b3cd 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -468,6 +468,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
 	{ KE_KEY, 0x82, { KEY_CAMERA } },
@@ -482,7 +483,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x92, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + DVI */
 	{ KE_KEY, 0x93, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + DVI */
 	{ KE_KEY, 0x95, { KEY_MEDIA } },
-	{ KE_KEY, 0x99, { KEY_PHONE } },
+	{ KE_KEY, 0x99, { KEY_PHONE } }, /* Conflicts with fan mode switch */
 	{ KE_KEY, 0xA0, { KEY_SWITCHVIDEOMODE } }, /* SDSP HDMI only */
 	{ KE_KEY, 0xA1, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + HDMI */
 	{ KE_KEY, 0xA2, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + HDMI */
-- 
2.17.1

