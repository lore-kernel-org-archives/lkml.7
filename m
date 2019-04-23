Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D0A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loaLlLyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfDWNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:52:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfDWNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:52:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so7637829pgk.12;
        Tue, 23 Apr 2019 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbbEBOKapPJio4LlPk/W8tDU6nFQsIipcob0IALlUJ4=;
        b=loaLlLyihUZva1yPtx+l6dEw4rDWSKC5hNGhAAWRqpSsiBA9zknCmGU9oS6X+N+8BB
         joZ2bDV44+e5McIX+w5JpW6KLZC5yErEOmEWbuM11heOxt63iw/+hoqq8Uh4zDdSMGV1
         uXXWYi0gd+BYm3xnDPbU6A8HKRbKrPcGXymghbtKVpOMldxT5EnhjZmJmiz+LBFPXBiu
         j7u6wB0fBwhEM00+LDH3xTL2Hm18gUOv5DiKiNdFGWgUBWn5U5n8NGMVHs87ojBOIHUl
         SKjdAoSlocFymB1iek9ydmabYObcz2m7DK1U+sJfugJmr0zruIFpmGDGCeN1ZeifDtLf
         jMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbbEBOKapPJio4LlPk/W8tDU6nFQsIipcob0IALlUJ4=;
        b=d7gg1LUqKguSoV9D/wS3+oI/CaZxTzElw/V/dJZcYm1XEtnCP72Pz+K09XpFeUW0xL
         55wTkc4vnQZnuaGfvETIo1CPFlF1j8s0LdoDUgUysdDVOoljJuU3LcFx/Yg1nRCH/CDu
         W6ewnmuZW5D91Faj4mqYkflymQqkS+66Sumgp6SRvYHUPhTf44e9NNo9CUrpna/MIhPg
         CDMGcjlprcQ+MFMiklJaaZhoDuqmdfbJMUVWIcDfamGSnHpREbFtaxE09g+cvGLxdu+d
         0my+yD/9B73ZKSnmhAL4GjjQDpBQVw59+MJF9cv5cuMQIpVbnOV4ksL6M7iUNPgivvcf
         1P3w==
X-Gm-Message-State: APjAAAWnWatr4uuJloNbdwJv7TQAgAiv6QK1r4gP7Zf4553M7IvJZ4Lo
        Z/ofwEf0UvzxNzDjZfcbJZ10qCTA
X-Google-Smtp-Source: APXvYqym7xex5UEhU9S9xgwKUp6RZgjiMk836emlCNewpZBMq0DSYkdnjKLq5qiUsJUgqqGsxIUdqA==
X-Received: by 2002:a63:330e:: with SMTP id z14mr24604367pgz.4.1556027528824;
        Tue, 23 Apr 2019 06:52:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm4494380pgs.28.2019.04.23.06.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 06:52:08 -0700 (PDT)
Subject: Re: Fwd: [PATCH 1/2] hwmon: (lm75) Add support for TMP75B
To:     Iker Perez del Palomar <iker.perez@codethink.co.uk>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <2904a750-c6e9-719b-7523-0f45e0bc82cc@codethink.co.uk>
 <2effcb0e-03c6-0f7e-b154-62cbc9ad415a@codethink.co.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <655fa0d3-1b76-96c7-4c04-9f258a3305bc@roeck-us.net>
Date:   Tue, 23 Apr 2019 06:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2effcb0e-03c6-0f7e-b154-62cbc9ad415a@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 3:11 AM, Iker Perez del Palomar wrote:
> The TMP75B has a different control register, supports 12-bit
> resolution and the default conversion rate is 37 Hz.
> 
> Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>

This patch is corrupted. It replaces tabs with spaces, and there are line wraps.

> ---
>   Documentation/hwmon/lm75 |  5 +++--
>   drivers/hwmon/lm75.c     | 13 +++++++++++++
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
> index 010583608f12..baf052935761 100644
> --- a/Documentation/hwmon/lm75
> +++ b/Documentation/hwmon/lm75
> @@ -47,8 +47,8 @@ Supported chips:
>       Addresses scanned: none
>       Datasheet: Publicly available at the ST website
>              https://www.st.com/resource/en/datasheet/stlm75.pdf
> -  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75C, TMP175, TMP275
> -    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75c', 'tmp275'
> +  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B, TMP75C, TMP175, TMP275
> +    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75b', 'tmp75c', 'tmp275'
>       Addresses scanned: none
>       Datasheet: Publicly available at the Texas Instruments website
>                  http://www.ti.com/product/tmp100
> @@ -56,6 +56,7 @@ Supported chips:
>                  http://www.ti.com/product/tmp105
>                  http://www.ti.com/product/tmp112
>                  http://www.ti.com/product/tmp75
> +               http://www.ti.com/product/tmp75b
>                  http://www.ti.com/product/tmp75c
>                  http://www.ti.com/product/tmp175
>                  http://www.ti.com/product/tmp275
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 62acb9f16ec5..1b5c32cbdc62 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -32,6 +32,7 @@
>   #include "lm75.h"
> 
> 
> +

I don't mind if you'd remove one of the two empty lines above, but add yet another one ?
Please don't.

>   /*
>    * This driver handles the LM75 and compatible digital temperature sensors.
>    */
> @@ -59,6 +60,7 @@ enum lm75_type {        /* keep sorted in alphabetical order */
>       tmp175,
>       tmp275,
>       tmp75,
> +    tmp75b,
>       tmp75c,
>   };
> 
> @@ -378,6 +380,12 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>           data->resolution = 12;
>           data->sample_time = MSEC_PER_SEC / 2;
>           break;
> +    case tmp75b:
> +        clr_mask |= 1 << 15;        /* not one-shot mode */
> +        data->resolution = 12;
> +        data->sample_time = MSEC_PER_SEC / 32;
> +        break;
> +
>       case tmp75c:
>           clr_mask |= 1 << 5;        /* not one-shot mode */
>           data->resolution = 12;
> @@ -438,6 +446,7 @@ static const struct i2c_device_id lm75_ids[] = {
>       { "tmp175", tmp175, },
>       { "tmp275", tmp275, },
>       { "tmp75", tmp75, },
> +    { "tmp75b", tmp75b,},
>       { "tmp75c", tmp75c, },
>       { /* LIST END */ }
>   };
> @@ -537,6 +546,10 @@ static const struct of_device_id lm75_of_match[] = {
>           .data = (void *)tmp75
>       },
>       {
> +        .compatible = "ti,tmp75b",
> +        .data = (void *)tmp75b
> +    },
> +    {
>           .compatible = "ti,tmp75c",
>           .data = (void *)tmp75c
>       },
> 

