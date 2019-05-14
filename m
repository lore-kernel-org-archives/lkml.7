Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322A82168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raj+jxF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfENTHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:07:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39663 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:07:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so3711wrl.6;
        Tue, 14 May 2019 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qn66etOm0a5xQIu8htrI+8Q6SfvX5qKGBW8UZZdluKk=;
        b=raj+jxF5DpoWv0GMlZ/X5zUnAPvykosrsBJkIlHOqdz4SUaPZBnm6lBXUKaRUh4Bcx
         lOZJfQG6N659pdZCfUEt+Yj/LpBw437H8sDocWFs3AQmWR9v/FawHzhYfUzs/ElLqk24
         AmN9AR8dCVTjIuGwjGC7wfOJi83TF9QfpyOlYO6f6tTX43kaOj70okkEHc8saNDaXGZE
         FMFAqum02glaCx+RahB1Szcsc9rlMuvVWzfHPPsaprdup8HaSjcxbBXXOtatFYYUIS67
         6YEfQm8N8tMZtnMIcBaelFo9Oup8a14RKFB3Y8NFL3tUfOiI5drO1CpDtBx0iUV9e4Zj
         +ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qn66etOm0a5xQIu8htrI+8Q6SfvX5qKGBW8UZZdluKk=;
        b=YFarpzPzI7sk5Zw11b1FMEssJ9Vrs6NAXcvccmxEzUcFn91L5Yhv4kyrpxd+OWZL3u
         +xaHdR5rJFr0BxbpNji+GdFA1hO3V0QAWM0nrQl2UptwQOX/PKJncMOV9/jLYTYCtua1
         LoVz6NLMMVzP1M8VBfQpWnT5jiBufJGiFR44QsuASWeXZ+nn+tS6d5+oLVElocIC7ERT
         oEkxPc5G+FDKjZUL0SfjsiPsZ+5wC5tknfXlnA3xrgnfCbNT/S1OqfqusVFjFwFG5oAi
         e6VPJd4mNlaRmhhBtyxRkHXFI6pjVIpHcTBJ6c4UKg0WYbzPa/ZM1+zvGrtx3Z5L5hRL
         drJQ==
X-Gm-Message-State: APjAAAVbzWawOxUwkOxljQ/7fjbey0SC0mEp1jfV5t8rE0YrZoceNJRT
        03gzliZNc75M0eQe85gqh03SUszC
X-Google-Smtp-Source: APXvYqz9xlF4iNQcDCI1K1xUJwfzrXCi5cK9zKh/z3ZFsrO0zb/o14rfJTi4oRzv1JsDJRRkXAA74A==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr10350000wro.253.1557860868811;
        Tue, 14 May 2019 12:07:48 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id o4sm5650291wmo.20.2019.05.14.12.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:07:48 -0700 (PDT)
Subject: [PATCH v4 13/13] platform/x86: asus-wmi: Do not disable keyboard
 backlight on unloading
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <8b24b62b-4271-1010-ca5f-2974088b1857@gmail.com>
Date:   Tue, 14 May 2019 21:07:46 +0200
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

The keyboard backlight is automatically disabled when the module is
unloaded as it is exposed as a ledclass device. Change this behavior to
ignore setting brightness when the device is in unloading state.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index feb8d72fc3c5..0c330d6a5871 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -471,6 +471,10 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
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

