Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5582168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKmnvzEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfENTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:05:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:05:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so30407wrx.0;
        Tue, 14 May 2019 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9pfI3srMSByRODiYcZr4ZtqF03RJNVK9yMTlRMMaTfQ=;
        b=pKmnvzEB/YevalzL3D4GOPHycFYANAZx8DsdP7qscjQC8l9kIKvTzSREC8owpzMwcW
         viucoLH1r0jh/MncSEpmVVSQSPJqar1kPsVer1xylbvQQRxdaVrmiea+A5oasrcEjlBf
         WyuxhM9ej+EflZqlGtHl8Fme1VoVdoAwRABgHaoAqNGzqRda0pkk+CODW4/OJmFBUVbW
         aqYmMut1d4Hv/xV4L2VYVKuNu7WQ55BfoK0PfSjudxhSD5zC1TJ//saw3c4I8Bh07VnU
         sf+HBQs0y0cqQUQRiva1yYWsvN/Om8XMdaiwRLzIyI7IgcMxZiu2VSIFNldqMEZQNaQ9
         71HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9pfI3srMSByRODiYcZr4ZtqF03RJNVK9yMTlRMMaTfQ=;
        b=rhw63wD+EyXWhQcGt7NPXhXastXfDm3QZ2+0YUbOo1QbQ/zDshk9EVv51U6rohJg/a
         ud3HGfxY2eaFtB9Hgsh9DdqkaQdJEcyLB9Rkoy6YLCqRjrLEQKSpNxi1z1wd/8hkCkBG
         3Vq/nKdgCr8FX1PoK/AjSuIc4VE9k4TiXB7LZDqsiEC2wvR+3LNrnjhdY1SV3sfsBUzI
         0+4kFe1WuqSHqRVA6Af1GqS6gT3oA43dDEprOE3bFCnjvTAOHtzVKz/y8Td3wNlTFsyg
         Yz43b/Q/T1R5vH42EjWBvYGq/emsk4Vh3o+VqVoPTL4S9L1pa3klY7S1LbGLGiUquhCT
         ipGQ==
X-Gm-Message-State: APjAAAWPqxguxC2Dr5cjYy+QxOw7yL9fLwlP0f45EfyIDCEnROdINh9c
        aqXdi2+9UhaN91vMoUypmue3NnVW
X-Google-Smtp-Source: APXvYqwwaILkvlFnNKLGMYnZtPK7bU9k+Ym3LnugsCnNJ/JoamOttTiPRE49z/Ea9+psKnWxXW4Adw==
X-Received: by 2002:a5d:53c6:: with SMTP id a6mr21892400wrw.232.1557860749292;
        Tue, 14 May 2019 12:05:49 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id n2sm30109774wra.89.2019.05.14.12.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:05:48 -0700 (PDT)
Subject: [PATCH v4 11/13] platform/x86: asus-wmi: Enhance detection of thermal
 data
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <f6fe0ba2-309f-0d64-3fc8-8bc8727a40b5@gmail.com>
Date:   Tue, 14 May 2019 21:05:46 +0200
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

The obviously wrong value 1 for temperature device ID in this driver is
returned by at least some devices, including TUF Gaming series laptops,
instead of 0 as expected previously. Observable effect is that a
temp1_input in hwmon reads temperature near absolute zero.

Consider 0.1 K an erroneous value in addition to 0 K.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index bd9eb00f3a27..ffb4e2530ea4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1428,8 +1428,11 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 		else
 			ok = fan_attr <= asus->asus_hwmon_num_fans;
 	} else if (dev_id == ASUS_WMI_DEVID_THERMAL_CTRL) {
-		/* If value is zero, something is clearly wrong */
-		if (!value)
+		/*
+		 * If the temperature value in deci-Kelvin is near the absolute
+		 * zero temperature, something is clearly wrong
+		 */
+		if (value == 0 || value == 1)
 			ok = false;
 	} else if (fan_attr <= asus->asus_hwmon_num_fans && fan_attr != -1) {
 		ok = true;
-- 
2.17.1

