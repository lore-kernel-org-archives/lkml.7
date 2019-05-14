Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0465FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD7821734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT4Kgdoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfENSvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:51:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfENSvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:51:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2546810wrr.13;
        Tue, 14 May 2019 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d6lio4FUKP4hIMj/LmCQXh9/Jwu24a67v0ySJSmb6ow=;
        b=pT4KgdoiSi1Cc2C8OLXNPnPsmZvr2g3z+jcZqt5z0LqHYaRWIGmXSmv+hH70+1QPhR
         rJmUeMrlFq29bkMBHV0u1HNDGh+wtG1wJPB3LS/8QY0TuUQviRA0DDYjzfI3Ii7ISjbc
         vmVfgvKEfYCrUHw1R8XNjO8GGzUOzN7HwZ7RVRC5kRpMDIOpz0uchKrNzAwVP0RtdwzP
         0UJHP4xMC099mJCRpSj+1gaDex+vS0Sd+vRXq5FfgtPSbGPDQMOhGmj8nx0+7Aa7BRI6
         wv1IHdhh74mNdJruSSQazbhW28wfzdPNI8bN9wLjOrxgoV8O+gvNh2Pakl+jUYuQpLlR
         i0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6lio4FUKP4hIMj/LmCQXh9/Jwu24a67v0ySJSmb6ow=;
        b=JQLF+kCZL8q4Fedwe/oiUJdKd2ojqW09QdF33oIF2djdYi4Fj323ylJHaI8X4MwAz8
         jFCHF+loc1dzsGHQSTMKznrO418DDnmsSdCQI0xK8Sse+kuQeUZUnMqHSAHzgQpi9NE/
         4ExGqPkdEiLB3Y+UbBSjs+bIiH0RbLN+SZy+suTQrWk+LH4FqxpJ5ksLAPS+0OyX/iC2
         LAu04ZnaGetTCE7c4wcf/zB7a+n6dbJ1Vshi0vwMReHKPOjonlokMkSzCmjHFoNJMoeA
         hhMX5B6sAshSaw7qHdg6XdRLfLxYwSZsNIwltTxnmlNTsrKBpxBQnc2K65GpHS75xFmo
         vM1A==
X-Gm-Message-State: APjAAAVZPoFV39YdQu12gS1LyykGpyismfaKdF2C3Il9UljKAhEnOkCk
        Wk4HH+n0Ak/gfzlT9PtJ+HPfr3XG
X-Google-Smtp-Source: APXvYqzWOeFcKQIQMFm7pqGeA3nLxmR8p68Jpnm7CnQtPAVWAMMO3ceMq753pkbhsao7tUCEA+tG5A==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr1325371wrn.191.1557859893270;
        Tue, 14 May 2019 11:51:33 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id 34sm16442360wre.32.2019.05.14.11.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:51:32 -0700 (PDT)
Subject: [PATCH v4 02/13] platform/x86: asus-wmi: Fix preserving keyboard
 backlight intensity on load
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <40403d07-293a-62a1-e0e9-ad6a2ba84844@gmail.com>
Date:   Tue, 14 May 2019 20:51:25 +0200
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

The error code and return value are mixed up. The intensity is always set
to 0 on load as kbd_led_read returns either 0 or negative value. To
reproduce set backlight to maximum, reload driver and try to increase it
using keyboard hotkey, the intensity will drop as a result. Correct the
implementation.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 62567766bdfb..84d7fc6f941c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -595,8 +595,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 			goto error;
 	}
 
-	led_val = kbd_led_read(asus, NULL, NULL);
-	if (led_val >= 0) {
+	if (!kbd_led_read(asus, &led_val, NULL)) {
 		asus->kbd_led_wk = led_val;
 		asus->kbd_led.name = "asus::kbd_backlight";
 		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
-- 
2.17.1

