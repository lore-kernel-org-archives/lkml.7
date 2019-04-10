Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445F8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D088217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I383xd53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDJU0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:26:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39062 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJU0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:26:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so4462675wrn.6;
        Wed, 10 Apr 2019 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c74an1N8vqjPR+tBHKM9QsMZCuPGywpJNb17jah04RY=;
        b=I383xd53gF1HGUKsFkdVLss6GTwdle2eBElhsy4gpwUnQXMA4GQad1tlsY9WD5GDFG
         cHmzqQHtjelTd2STdHvmrqoFVIUoNWCoscay/aiguSiIS++fRIL42D4kD78aTSHRD714
         iwOPK3lML9u+JedTcK7SQShEXA4GXiHlCQyVRXagTV48K1r86wxVh1U9rihDTt/1djgP
         JbWHj5BgJwTZutFSjG41ID+9Y24iJxQ8puBGBpXLAtW61NC9j9ZyHDClPH7A+Htl8bdl
         BABzMd9ySR6OAud6mtaXV5V1o8EdR07HPqYXNke9PbVFPZejvk1RyBNXwnPLXiGyEyTP
         Krsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c74an1N8vqjPR+tBHKM9QsMZCuPGywpJNb17jah04RY=;
        b=ZSCSAjNsEp3cEMgTv6UaAVI9xWmkhaxKPQLTt+UNa967ytYojMqbRge+EEY4jyo4N0
         eng4LgZE11Hs48yYG7Rah49xGaIRGz+MZrAi+x9hr8uYHVCJjEkEBFIPEDgEE0dVnu0n
         Se3jkIw2YovaGdBkh8Rt8RJZHFgiSG+ctk558XapGX6QCLyo96RHolYhw9uKZP1SjEhh
         /DBFedDs/lOmAprmvKunuZi3o+HAvvRB1zvptMoy6JPOsUxo/TOjy3ZIFHw9lWflvOk0
         csGhfKzyRz+hN8e90j2cDBIu1XyQGM6TrWEA+VYHDKne1z0YgQkBj6e/ubrh+ZYEn0x1
         cOoA==
X-Gm-Message-State: APjAAAVjoH1d0knnziwTwylWyyINNZtxMwjZmtCdp5eK9qemqGRMa1Ag
        E/QuW8mXpXGyFwCvtN1hTk6KZNLNE3E=
X-Google-Smtp-Source: APXvYqz/ewPlOSuzw9yeytKJ/vWCS0xBg0ZYw79iCwjZmUIqIB3rkyAsBJehuA97JnvNFLPDC2hyrQ==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr9636261wrn.60.1554927966222;
        Wed, 10 Apr 2019 13:26:06 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id f1sm2352905wml.28.2019.04.10.13.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:26:05 -0700 (PDT)
Subject: [PATCH 02/11] platform/x86: asus-wmi: Fix preserving keyboard,
 backlight intensity on load
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <93e5f5b1-1453-54da-2183-2c846397d928@gmail.com>
Date:   Wed, 10 Apr 2019 22:26:02 +0200
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
index 6b736a9375ef..0fbb947b07c4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -591,8 +591,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
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

