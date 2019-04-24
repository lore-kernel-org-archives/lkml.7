Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141E020835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QedrkrSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfDXSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:17:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40468 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbfDXSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:17:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so17799013ljq.7;
        Wed, 24 Apr 2019 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wDTpkoB+jJ0/JdcVrn13ygU0s5e88S/mFeI4478JFtE=;
        b=QedrkrSC5RFMiZ+131nEb3MWbS1T3nhdYahFMgR6fTIHXH3VWueNWzGND1ffT/v3ko
         3VtqzgW1RQVMD/AU85vcOXvzBYuKq+LMIuz8/69RV2xZFFQXxCySOioHDe+8pxhTccPx
         KIieDcAo1lQLNhEG8+F8JEvBT6F5D7Zd1TluJwuDl0aH6G2QlMUL1S7vaV0jnsms0uYY
         s1f2c5vUZ/d502fG8v22VkD47elMndfV4cULiVns9r5Nknod+/MuUHJTSE8AfF3lGiTX
         nWK0NqZkh1xvKpJHM3xSYq2U6mmjFvwpigTklsajPTXYw3AAK1bGM1Oab5GJ81RX3OxO
         eJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wDTpkoB+jJ0/JdcVrn13ygU0s5e88S/mFeI4478JFtE=;
        b=mpE+hzVSfYHjcJJtos6KqQrZpxg1aiS+BybHjuonBKy0azymGa0eSzHHefmDX0RsVk
         kycSVgheGMqEzGg0OahPwNq0FyBucd5dKt1iwlLFIfSzVUvWZS7ug48iuxi00eQ7hFWR
         saFAcE/z7IptzsfQY9/S1dwTxy44meZjnGQFtq2ctZIvaO72sW3n91H2J0/SvUsj6lxl
         77hh5qVLhub86M7ZMq2+Ef0jek5+XtdRv+enpG4jZ1MpIYcMHpCdtLIzZVcq0BSDK/QL
         nDpIvsUqHQfElbjXx8KQanpL/GWgjHrYLbTkzbFhKkAvVIsz3vaNPnRM2tileDaWbof2
         8UGg==
X-Gm-Message-State: APjAAAWybwqK2eSUhMyuQl9uzsHfHdyGsMflaw4jg/XB7OpIWeNYJBg9
        9isr96xqzMshFgOWj1xrLYfx9mkU
X-Google-Smtp-Source: APXvYqw0fhbMAr6H6WkaoDHs/+8Yf7qf/k3smk2g6ioWoYahhTlm3NK+ZVaRtLTsiwhpxyJmH7/qoQ==
X-Received: by 2002:a2e:9f14:: with SMTP id u20mr3802839ljk.108.1556129818056;
        Wed, 24 Apr 2019 11:16:58 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id f12sm655226lfk.6.2019.04.24.11.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:16:57 -0700 (PDT)
Subject: Re: [PATCH v4 20/26] leds: aat1290: Use generic support for composing
 LED names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-21-jacek.anaszewski@gmail.com>
 <20190424135719.GC14360@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <713cd359-4c93-7841-c3b7-bbf3d3ceec45@gmail.com>
Date:   Wed, 24 Apr 2019 20:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424135719.GC14360@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 3:57 PM, Pavel Machek wrote:
> Hi!
> 
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> 
>> @@ -257,9 +257,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
>>   		return -EINVAL;
>>   	}
>>   
>> -	led_cdev->name = of_get_property(child_node, "label", NULL) ? :
>> -						child_node->name;
>> -
>>   	ret = of_property_read_u32(child_node, "led-max-microamp",
>>   				&cfg->max_mm_current);
>>   	/*
>> @@ -469,6 +466,7 @@ static int aat1290_led_probe(struct platform_device *pdev)
>>   	struct aat1290_led *led;
>>   	struct led_classdev *led_cdev;
>>   	struct led_classdev_flash *fled_cdev;
>> +	struct led_init_data init_data = {};
> 
> You can do directly = { .devicename = ...; }, at least for the name.

In previous versions I applied similar approach in few places but
later figured out it will be more consistent if all assignments are
next to each other.

> Anyway, that's a detail.
> 
> 8, 10, 12, 14, 16, 18, 20: Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!

-- 
Best regards,
Jacek Anaszewski
