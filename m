Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7226420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8TL2KYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDJUab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:30:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDJUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:30:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so4498187wrd.3;
        Wed, 10 Apr 2019 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4uFFVBqY+BLq6hdKHC/8AnbyjQkZjE6sJfMEtU4xltw=;
        b=R8TL2KYFAdLZnOvrC7PrR14OtdFzwYPa6JvG2Z+89kXW8n9IefTsZFo2+CHyLqwyBw
         L9HIeTu+tYPUg7jWvoLgIPZHixO2J6yq4t/VmHkD2TlfjQmgQDPsnCxsrP1/NCCr612D
         BEaM297XPIN5xr4OGvaLOF+59SGa1phsbuvjZ14Q0s+q9VF1pqAbMAhlpxoNJcA0Vxdp
         vs6nIHjAEmy9UBebwjh+wOiofaNW6dsqctQ2fxlN52zr4cZ4N5m2NxpKV4i/xaxU82hd
         XaMKaoSSOOcyvT1wnXCsd2PM0gQq64ii/ZlxwaaP/kKUAGvsj3Z/o7UOzMfX4OVuUvSy
         Zu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4uFFVBqY+BLq6hdKHC/8AnbyjQkZjE6sJfMEtU4xltw=;
        b=EX1jxZDc/a11KuH5EXmQbF/Lg1jjcmWT0LrCZ/zbDJDylGHN8ApVKwxRnR+mnxm/Su
         yCGj0w+iFVvb5HFgTuB0qxfPt2bh9kA/QG166Dki/fS7It0KWnlcoaHo9DglTR/h7tle
         3nSbah02/7GXIO+DOnqpeGpV4hydZ7h0q271SUFKttdqtJAsbMkfuh+9YlL2rcn0LyIK
         X8B6AfUKg1qnyhuI/jc6RhyE+9vtgYOEZ2Rt3oCpbpn3h5m3gV7dyYRn0AaQrr6iVWNL
         cbXa40LgT7YlYSPA//ym4PxkuekndYEeFRuiewb6YSbnMT/NN7z1cdHD0MbgqFHTwxu6
         WqEQ==
X-Gm-Message-State: APjAAAWYk0nuRAleUbmIy0Uw8gOqdfTvG/a/cshbwKXM1jmsOI66W0Gt
        SuFTuoqJIJ0ukXRzWbFJaXiFM1/dnpE=
X-Google-Smtp-Source: APXvYqzE7azqAU/LTA13tcnscNfx9PbZyGafp4jOazNDTsEy9ewKohAX7WHFUF9737a72ha2P4tlSw==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr27481524wrp.31.1554928228644;
        Wed, 10 Apr 2019 13:30:28 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id i18sm33749662wrm.7.2019.04.10.13.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:30:28 -0700 (PDT)
Subject: [PATCH 06/11] platform/x86: asus-nb-wmi: Add microphone mute key code
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <cf8d19d8-3e1c-fd10-35cf-c8f19ad18a6f@gmail.com>
Date:   Wed, 10 Apr 2019 22:30:26 +0200
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

The microphone mute key that is present on FX505GM laptop and possibly
others is missing from sparse keymap. Add the missing code.

Also comment on the fan mode switch key that has the same code as the
already used key.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 357d273ed336..39cf447198a9 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -474,6 +474,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
 	{ KE_KEY, 0x82, { KEY_CAMERA } },
@@ -488,7 +489,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
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

