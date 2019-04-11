Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337ACC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED232184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhhasY+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDKFsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:48:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40334 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:48:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so5540407wre.7;
        Wed, 10 Apr 2019 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HEDFtZPjLhuw6ilImkRaRAXhlx/SXG1tE/jQF3qj854=;
        b=NhhasY+7nb2KxTeHpUsr/miI+LxNjwoykgV6pQuhCDJnCw6GMlhSDYmNix+tS9+IYS
         n84ocOPzGi4NXyMq6MN6AiZbC73qftZ5IKsvYvCv8XiIWz0IqEXsH2pyHdRuTQqKn2Cg
         h7hOsFUhKO94tl2GY3SuHq5vukuW1/lb1MARNx8zBS1LeM/9PC+3wW3cq5nZKUhrT5kx
         ok0bUAhkMljI+WhZqEfO524Lrsd2roEGTFGJaIIrMafnxtwJlI4954bp5r7aviWypNCR
         4xCE9kSZu5QIdilh2rn4wwnJAEpqZYGgz5Sb6DqvXdnFkeDWZVe7yirvVzZ6Aswl8zYm
         1h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEDFtZPjLhuw6ilImkRaRAXhlx/SXG1tE/jQF3qj854=;
        b=BJ0DIKUgPmihs+lhtDH879a3IpqDO8d7DyWXERa/kVs58rxXkOrcRWMSvmT8ZnDOB0
         Ql+92RgdUkHzkYo/B/tKfUtzFHxXMb3jGg1ChWb5t4rIR5utraBrGaKspa95zzUidiYs
         MTbNUEo4R2TrxGzlsA21GpMTH70MSKbT/QnzFsFUS651Zrz3iKsYkz5I5bRCnhh9X2R/
         M0wox9P0Cq1lKINxRaeRuEquRipoXrf147tJLOs8E7iEip1oxUsd0EQ4NZniFYcQDl6m
         4VcckEp92jE5kaTl+ynhb+Lg/qqvUPPFoKt4PkNOsHsKeG4aOwfHTaK8NeSrytlQpaT1
         ARTw==
X-Gm-Message-State: APjAAAVoCkJ/eyo4MJmY0AIobmSHOS+qm6oAycw5+uUWdlf1JzLyUBJ6
        maIbYuo3Rf1IEp+DmQS2lc5u1/ycLsI=
X-Google-Smtp-Source: APXvYqwUOfnuPo5Rfwmkj51+fKixfMF2dKHajg5sfwku2kR7OzhIrxOe7EIwFzzzkmMnbm/+z0Dtyw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr30487884wrl.185.1554961701991;
        Wed, 10 Apr 2019 22:48:21 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id e7sm5079056wme.37.2019.04.10.22.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:48:21 -0700 (PDT)
Subject: [PATCH v2 11/11] platform/x86: asus-wmi: Do not disable keyboard
 backlight on unload
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <2b130755-87bb-b7a5-939b-4d0ebd69af68@gmail.com>
Message-ID: <00efe227-9db9-8709-2de2-d863166c5437@gmail.com>
Date:   Thu, 11 Apr 2019 07:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2b130755-87bb-b7a5-939b-4d0ebd69af68@gmail.com>
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
index f0e506feb924..f49992fa87b3 100644
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

