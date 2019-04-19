Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F7DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D2320643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ta9g6Ppv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfDSTAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50961 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDSTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so7193034wmi.0;
        Fri, 19 Apr 2019 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wY7FVhtjfagAidOrJm9x0WSuPKmvLohsMLLrTTn97gI=;
        b=ta9g6PpvMoZqw2BBFCY5VJd/jbckvzV6Mz4KtmWqrMei5MZXSTndvZEV5s7R9oAGdZ
         u3Q0OPLV/xaQVCNUHAEDEsNBlBq/76snot7CHy1rCpxcqa1k2QWiNChazhLb40D8xPXm
         omSQR3hTrk1OsUERfDgjOwgfoeiBoQ67GFEd+Y4xwfub/sEeJAjmDW/n0mDQNs29ZcxH
         1QsDEZcl9WbInna5uOAr6oFVfDyuvdsHNJM4N7n+z3KjetfpwXHqOckvwG1cqyo17xy3
         qIV4auvl2NQBNmYezxhLApVjIwQCGhy+JsOP4ndQKsVmiLbYhYD188w9VIoMhrNKYCTp
         fM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wY7FVhtjfagAidOrJm9x0WSuPKmvLohsMLLrTTn97gI=;
        b=QHt5sOBEVt2zl+/ObtI03M+nARxcAKwKFHxDm0h2WNDNM31Yxik1AXfUvuXUDFDIEw
         Vwpmr5hk4+THbtgHkHjn6Eo+JuhVjxsRS0kQdYVx8gSieDPEsKQKBkIwX2TbhnKX5OPv
         GReMjV6DHkDY/MzH2KYgcoPm4eoG5wcJZ1Gc4bCB78PDihs/Hd8VDIy/1XpczKEyzgMK
         R+0y4Ew3uFPmdhjJw99Sj1ErdPfFTuxeNdM2rgIoCS3GGXe2L116za/WeC2zJpt5SYVD
         zkzWfn6Bcvrq3qBem6JTclRopcmFdSILY0wpJ+2VOitAjy+EdjC4hqNHj3+6iUoc4KGb
         C0PQ==
X-Gm-Message-State: APjAAAW79AM99ek7FrraIU4cUTwvKNhQ4FQ0XfmqyZMbjgmH29iKwAWH
        DUnk1lb2eydk62/RGuhg+9jF5uBzIFU=
X-Google-Smtp-Source: APXvYqx2pLCoKh2KSmlGbzzBTINR5OjkrDAttKAH7VuU6MWKYlKDKSDYPlTUup6RvCmqc+VrpnzEKw==
X-Received: by 2002:a1c:6356:: with SMTP id x83mr2084900wmb.147.1555668996331;
        Fri, 19 Apr 2019 03:16:36 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id y17sm3008773wma.8.2019.04.19.03.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:16:35 -0700 (PDT)
Subject: [PATCH v3 11/11] platform/x86: asus-wmi: Do not disable keyboard
 backlight on unloading
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <e97ae7b4-1d55-a7d0-f401-120316224a54@gmail.com>
Date:   Fri, 19 Apr 2019 12:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
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
index 7974283b7b12..02c9639bf54f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -483,6 +483,10 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
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

