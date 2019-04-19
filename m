Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855DCC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB920643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/KTcZ4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfDSTB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34043 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDSTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so9503643wmf.1;
        Fri, 19 Apr 2019 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e43rnkErijS0HX8VnoEMm69iTL9eHGIel9JB6xut5yQ=;
        b=V/KTcZ4vKIXT5VQdeglg+jbSYX3ZxI9SIuHRgsZYIQ9t4divxvjoMLyx5BHaR1t6q8
         qEa56Jb0vXNydN//t2eQKRs/W1OSr07YKl4U04Jz0MOhlZV3W9bb4MdWIi9dKsdknJkY
         c1HLsBlRTYi7jB2ZbZLdnIPbWUdyFSCahB2zzoY1lxzAOscTsUiN9WyX/bihx/Kl3zyg
         uHlDNe3uU+6XO5Ytc3W5jfygr2mDLOYr1Tw0iiSJhq3BqtAqPyRISN6xD9NC2JsNPB5e
         Vjt49BAFzdHuiCe/SqNmL3wwBy5WX++YbBGxBE2gVJGHP0KqIDJy8O54HwuOkXNARfqb
         DUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e43rnkErijS0HX8VnoEMm69iTL9eHGIel9JB6xut5yQ=;
        b=C5Br/n1HII5G6sHowqtwnsjkysxEQdPXlIEPjL3EGanUKJomDsqBkoqgsDEj8AbYlv
         LAB2vldxuNJQwKPvFmJpjONOSliE5D5rqvltpffkE4Bv/58HEChUF7uZHEdaqPTt6DVt
         XhIsy1nSkFQQePo1dNY4NGdco2PcA7f5pixf4dvs+xaLNpcLn1n6tAQvyTFOvKnWlyXr
         jU98gKf7Xqmjf9sFw0R1+zUwQG+fBjf/Ll5epaUfGlvDEg6xIt+nO29CuMUHRnsVkQBF
         rB0oVo0/d/JoGkwrAEUxFJ40tdGmAdLrxDustjIP7Lfz5tk9ST8JqBBxiLI4Pr0VoPsq
         ohFg==
X-Gm-Message-State: APjAAAUbmiOnbh9cQAyK0ugNQnevAH6asRO5twZax71DUjM08w9bcEoM
        hRG7WfXuVsMTZNQXfcRRQ3flbMma8l8=
X-Google-Smtp-Source: APXvYqzVwNNsJ9brH0zo781KU4mRIZBQx7GHfoUAPIkiuuR/SMfY3jGRSPc6LOzkzoGaHKdHlaohTA==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr2011184wmf.77.1555668041719;
        Fri, 19 Apr 2019 03:00:41 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id r18sm7259631wme.18.2019.04.19.03.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:00:41 -0700 (PDT)
Subject: [PATCH v3 01/11] platform/x86: asus-wmi: Fix hwmon device cleanup
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <a548ce35-5bbc-1c61-2a52-808462000091@gmail.com>
Date:   Fri, 19 Apr 2019 12:00:39 +0200
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

The driver does not clean up the hwmon device on exit or error. To
reproduce the bug, repeat rmmod, insmod to verify that device number
/sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Replace
call for registering device with devm_* version that unregisters it
automatically.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ee1fa93708ec..d865eb95054c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1425,9 +1425,10 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 {
 	struct device *hwmon;
 
-	hwmon = hwmon_device_register_with_groups(&asus->platform_device->dev,
-						  "asus", asus,
-						  hwmon_attribute_groups);
+	hwmon = devm_hwmon_device_register_with_groups(
+			&asus->platform_device->dev, "asus", asus,
+			hwmon_attribute_groups);
+
 	if (IS_ERR(hwmon)) {
 		pr_err("Could not register asus hwmon device\n");
 		return PTR_ERR(hwmon);
-- 
2.17.1

