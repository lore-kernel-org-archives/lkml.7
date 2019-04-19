Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2A520643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdv7JA/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfDSTDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfDSTDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so7924094wrx.9;
        Fri, 19 Apr 2019 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D5OOA2KesAQE4cCxLou/+hQFW5UG2WDyvZfR5JDwzZ8=;
        b=Wdv7JA/P/PvqD30VTsPVeHTZ99kGlcdLPHsamBmqU36Qfj9B25WWbfM9KHGVIkiNqn
         JtiyGWch+0XpldJgdIRlpZTCWRhUTg/S3sndYJm1PZofEZ+RcTIb+9wYIOZtPBrPfqQq
         ZbowP14LkHCeWT8r1ruNB0+XPG/4SmoH8Q71IMLIYHGWd0VY26QNbP98DRay4gCmfpgt
         R5KPC5HCQjx/kZhzgWbzgwReM++iTnPR1Aun9gzvEh9twpZX5BP4qdiHRS/zg1CeP6F/
         3pag1QISUUsxIgruBJKsboSLS4EbALC+MGjUVT+m6BxIwtGuNdf8coW30mwRFxgwgq1+
         I9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5OOA2KesAQE4cCxLou/+hQFW5UG2WDyvZfR5JDwzZ8=;
        b=qaPAPlPt9fxGQM+70KEI6tVpNLUSoCSISBvpuxKxh9tFEClXJBezc+gIPjMMQz7Vn7
         PGhu7jF7Yt0eBRyPWMYQ87duR2antomZrN1N3aAXZ5qM/RMHJH3IkVUoYxt0mJr9Nm0G
         fef8G9GjipywDW9r4Dwj2nKwvHd1t2jMU1mkOEU+R3fQJ4lTQBf1EqbO/S4NxprlOJoR
         RiRDUkXDuwv4PZ6ccPmDJvc9cFquprJouyFSSK2kUMp6cVGxoxchqSUxRtKyAdM6/MzQ
         crSyRa2Kt6rCSM1Hi3s7vxdpu/lLnxNREIAW/a8xbswPwS3QlOdhizpXoWo/zJMmbVKS
         867g==
X-Gm-Message-State: APjAAAVUPj2WmMFa7dmuNYpJmWY4N9ezeIFISLlKWwMQNUZRscbVtQMK
        QVVZZ/DK9k/xERMIrg7UPrlBoVCu67I=
X-Google-Smtp-Source: APXvYqw7UQCebd+9C2FW6+rrosqpCDixDfKZRM0dsvPXDnu1o1JrdkdP9ofhnUR/aN4x4NEp9xKTAQ==
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr2265479wru.290.1555668225822;
        Fri, 19 Apr 2019 03:03:45 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id t76sm6070105wmt.8.2019.04.19.03.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:03:45 -0700 (PDT)
Subject: [PATCH v3 02/11] platform/x86: asus-wmi: Fix preserving keyboard
 backlight intensity on load
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <83ca4d6b-523a-5c89-1f0e-7103e5c5923b@gmail.com>
Date:   Fri, 19 Apr 2019 12:03:43 +0200
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
index d865eb95054c..731ffd382426 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -590,8 +590,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
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

