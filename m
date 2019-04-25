Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55981C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEBF2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoubY30u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfDYO67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:58:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36881 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfDYO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:58:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id h126so23026lfh.4;
        Thu, 25 Apr 2019 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CH7amxcEQcNyJ00QtEHe2QWIAp9j8p1Aie5hSCLGgM0=;
        b=CoubY30u8mbsCiYzRiUqA8+a2LVD031/v6wjAXoD2Y3t9Z7XW607I9iKTStfcoTU9d
         Sym8VI9+jSulrlV8fe0sP705G7GaU9Ek+oBFND84cXhLlJtBRg7FHj5B7P/DZWottWEn
         8Fc3zN+JmoAdBWxFrRnez+q3ejKWr6bD/tam86Tp3Y5y2D49UquvoceXhQG3BhVbVoej
         5gVE/KFp8rlNmZnEK4h/FgOLc+9Aj3nDETj+a9lRE/K6GqpDWWSPByvTXgnCgdisFcVN
         PumbJ8IPoEQ6WLZbcxGr2ppY46opByn+z2xy0l4HKyFuYOJkXTnTVIbNBhF8s9/GNa/O
         zPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CH7amxcEQcNyJ00QtEHe2QWIAp9j8p1Aie5hSCLGgM0=;
        b=tTGNfDd5zkN9fwFkCAMHJWwYh8Y4ZIyOsRpC5aEtm8W6tOkD5pS/zNYbhlCYB0C5bi
         G8Sv3Ib2FOUhyXJdFPvfBOsTVrMFz8DTcb/pkuGW63sEHp8sUlOs89YaQaKM8gyMITgR
         o88dBtpizSYnGw5WszzOLDFfDNFkS/RfV0N9tNic3Mfdia26m7zXxVQdhITboiDGSwRk
         Mxfm60mDqMGJw1pDBkZ3MlEENPdpc7EWp1gYGmXlck44ukTJep98pFPPbXcen/qOR+ir
         xG378mZkwPTZhl8VFuDE7ihkIF6j3NURt6nlTo+Vxz2TIKPPbPTrXcS20AuhJoBj0B3T
         HHKQ==
X-Gm-Message-State: APjAAAX0+B9jxUrOTQJUjaUO1+pqu00RQ20WqS6HcjVT20Y8kuRyG7Mw
        vtGkDtc8d5IrQ52Dl67V6J1Tyl+j
X-Google-Smtp-Source: APXvYqxBwztIAJTd4rZeJE4AqaWVJT19j2AfCmDOeuNM7X4TSdptP0DKsOkunrTR/7FBAQs+mC/0HQ==
X-Received: by 2002:ac2:545c:: with SMTP id d28mr20890087lfn.144.1556204335875;
        Thu, 25 Apr 2019 07:58:55 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id g5sm1974902ljk.59.2019.04.25.07.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 07:58:54 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] mfd: max77620: Provide system power-off
 functionality
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190424224900.8018-1-digetx@gmail.com>
 <20190424224900.8018-7-digetx@gmail.com> <20190425112241.GA10218@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7251d025-b229-7c78-f2b8-187b833183fa@gmail.com>
Date:   Thu, 25 Apr 2019 17:58:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425112241.GA10218@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2019 14:22, Thierry Reding пишет:
> On Thu, Apr 25, 2019 at 01:49:00AM +0300, Dmitry Osipenko wrote:
>> Provide system power-off functionality that allows to turn off machine
>> gracefully.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mfd/max77620.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
>> index 9b0009c29610..e56223bde568 100644
>> --- a/drivers/mfd/max77620.c
>> +++ b/drivers/mfd/max77620.c
>> @@ -37,6 +37,8 @@
>>  #include <linux/regmap.h>
>>  #include <linux/slab.h>
>>  
>> +static struct max77620_chip *max77620_scratch;
>> +
>>  static const struct resource gpio_resources[] = {
>>  	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
>>  };
>> @@ -481,6 +483,15 @@ static int max77620_read_es_version(struct max77620_chip *chip)
>>  	return ret;
>>  }
>>  
>> +static void max77620_pm_power_off(void)
>> +{
>> +	struct max77620_chip *chip = max77620_scratch;
>> +
>> +	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
>> +			   MAX77620_ONOFFCNFG1_SFT_RST,
>> +			   MAX77620_ONOFFCNFG1_SFT_RST);
>> +}
> 
> I think this is only partially correct. See here for a driver that I had
> proposed a while back:
> 
> 	https://github.com/thierryreding/linux/commit/d0eaa77b402f62bd236d76e3edeb3ccf296cbe81
> 
> Note that that driver is part of a larger series to move away from all
> the pm_power_off hackery. There was a fair bit of discussion back when I
> proposed the original power off driver for max77620:
> 
> 	https://lkml.org/lkml/2017/1/12/470
> 
> I think I may have a more up-to-date local branch of the system-power
> branch from my github repository if you're interested in looking at some
> of that code. There wasn't a whole lot of feedback on the patches, but
> the feedback I did get was generally positive. However, since it didn't
> gain any traction I eventually abandoned that effort. It might be worth
> picking it up again, since, as far as I can tell, the situation around
> power off and restart hasn't changed in the meantime.

Hello Thierry,

Thank you very much for the feedback. IIUC, you're asking for a
comprehensive solution that nobody managed to get upstreamed for years
and thus I think it is absolutely fine to have at least a practical
minimum implemented for the start.

In yours system-power series you are saying that the restart handlers
"lack any means of locking against concurrently registering handlers or
formal definitions on what proper priorities are to order handlers", it
looks to me that it will be much easier to just fix the missing locks
and properly define the priorities.

	https://github.com/thierryreding/linux/commit/16e386d4692716c3f2423732a2181fb589421526

In the LKML discussion there is also pointer to the "poweroff handler
call chain" series from 2014 which is similar to the restart handlers
and actually looks nice, sadly it didn't got too far.

	https://lkml.org/lkml/2014/10/21/5

I may try to continue the effort of getting proper restart / poweroff
handlers into upstream at some point in the future. Meanwhile there are
much bigger and fun problems to solve in the kernel and user spaces,
let's get everything step by step on by as-needed basis.
