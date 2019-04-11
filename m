Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2A9218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzNrVb7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKFoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:44:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33898 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKFoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:44:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so1100213wmf.1;
        Wed, 10 Apr 2019 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4uFFVBqY+BLq6hdKHC/8AnbyjQkZjE6sJfMEtU4xltw=;
        b=EzNrVb7nfu8zkfDNqW18F+GjBT5aa8oJwiXDSM04MQ3fbcUEQPu3V26agtYVB3Wso1
         juJpMGU1p5oFQqWIIVmXz8l99YxmyUxG5Lem/NDfsahDheZXEM34YHFe4nTJiFm3IDYx
         y3TRtkETAcsV1x5CAYx4J+2vukkA40Yn1aXBeGPuYPHyC5MjsNOrCAK40X3lV6BmvIxw
         M62aqRTT0xXtjaMz5vj+gmb6bmL+ruCpi9ue0ngFUnPuuPhG98si06ckpvav6vwPUDsT
         m2cNRN1YW7BECeOXnRQ/rh2YBJlA0UY+oFAWQKs3jPiulh8qvPMohbDdhtcvXv1J9XzS
         m4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4uFFVBqY+BLq6hdKHC/8AnbyjQkZjE6sJfMEtU4xltw=;
        b=UFRhKeNJ2oOT22v5aqYxtKbun19ALO2EotW8n3QgDX0yfCQyDTZzQGIs0O6nHBeXL5
         SJd5Tbsd39DnwF6ZWBjkS0gvgkMOO1gc2YZ2X3H0tSVHH8PokaAybb0GOwXjYRtRnqqf
         Px0bqjZVHCb8kRLZyRFgcpI1N2Nt/C+gVqvdHjqgHsh1+tSuFVeZXSXruy6jooM9GSej
         UsY9D+wXEj1+hs9nTD4KSQom/rwDUnAg4yfdNw4RTX3DnqR8Li91qYRyq3MvTBhBDtxy
         0COv863eeY6P8tXc+dio3PLiyp6Te6CHQCRQQTA+BfgEoa5mhHmFQbJ7y9N3mKALxbEM
         dorg==
X-Gm-Message-State: APjAAAWswlI9uHxHkPDHiiY/RRdkrVIjhVwxTXfzfGNMKLOZpSvXzp3x
        NH4N0P/Ey5IxpuD8xLwfEou3mBKPDDQ=
X-Google-Smtp-Source: APXvYqyH5IdmvFe1emBpF5q0iM3ScSrSJtS8uhsSX9cjNT2Piz3GWUTs1eN0vdeQQFXcXUIzgNnJxQ==
X-Received: by 2002:a1c:9d46:: with SMTP id g67mr4840675wme.99.1554961476866;
        Wed, 10 Apr 2019 22:44:36 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id r30sm120500551wrr.46.2019.04.10.22.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:44:36 -0700 (PDT)
Subject: [PATCH v2 06/11] platform/x86: asus-nb-wmi: Add microphone mute key
 code
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <cf8d19d8-3e1c-fd10-35cf-c8f19ad18a6f@gmail.com>
Message-ID: <0a14ebbd-fb8d-6af5-a3d9-6d92f8c086b3@gmail.com>
Date:   Thu, 11 Apr 2019 07:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf8d19d8-3e1c-fd10-35cf-c8f19ad18a6f@gmail.com>
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

