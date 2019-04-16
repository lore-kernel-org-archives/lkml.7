Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4332EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vduQ+Kmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfDPPvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:51:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41053 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:51:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so16403018lfd.8;
        Tue, 16 Apr 2019 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/loTdEy9LgGARdyuJihAtsvawopkPFAfby50yyqa5MQ=;
        b=vduQ+KmkLdwqMdcr5VX+HBHcCp4q8objqUYk3gelk/9WPWp0MSdDj6OYZN83zfhCzZ
         yLq4heV3ldZ2mu31uOCorNeNpDj751U4cu/tdVf9YaBGnaij1E7ipTQlVQz+T3kauQog
         XhVbz2tMxcEuAewRN/l4MQQ5gMPdXrpSfnN4DTl25q9pIDI+7jbDKXrC3WuuzI6Ak8N1
         pF2mor4tcvJxoqJQJfmjyVzDMRBvuinLfE7QN8MMFATW8aEG6JYseFejw5hF5Q/+azFp
         enwl1U9tbd2D7Gu1GmMtak2NjzT43aY0ZheSPxg877XjjWKOVNobT/w8ibFbIJ+55C77
         X70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/loTdEy9LgGARdyuJihAtsvawopkPFAfby50yyqa5MQ=;
        b=iA1Moh+MUSguGUb7kepCz79gzEfOOIO2a81nx/fLYicgCcbHIqi0yn5w1vSPUyJNlv
         PIrxol/FsV1CtOzjk7Q5z1eOcYqZ2sg60A8T7nA/H6diZ+W/opUapV8fZoSWGFVSyv5O
         hkK6+hzsUl7BWhl/UduBeh0QqKBr9ELibpJjnNvhUV2t7jJ9CFFy8RWdev0AeiadioWJ
         /bX/9owgDFsIqEbxxC/z8uCnxmXU8UpCiQIEOqnQ7QokqR/I9VFXzwtZQdeOByLUuq42
         8MKlPGtjIDAeDhgXzoSJEoi+obuuUHURYGA/xdaXHzYKp4MyIb8s3wT3gIkcM1Kujk+N
         MlkQ==
X-Gm-Message-State: APjAAAUf0vMLQBv5Eflu8HOWOBNd4WU6a8Tqjf/6MZhcR81xG0hqbIWy
        mTQAkVBOytz8qlQoRC+PspUHjgSc
X-Google-Smtp-Source: APXvYqxqqMltDYDwWtCpIY7IqFY5WW6niiiGzO1CTIm/oCvYgJe9RiKp4uvQSaF8NYszFMGtLhkQAw==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr42619177lfi.84.1555429889173;
        Tue, 16 Apr 2019 08:51:29 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id f18sm2349634lfh.39.2019.04.16.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:51:28 -0700 (PDT)
Subject: Re: [PATCH v2 17/19] PM / devfreq: tegra: Support Tegra30
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f@epcas3p2.samsung.com>
 <20190415145505.18397-18-digetx@gmail.com>
 <203f3cbf-d825-0597-b64a-dc876743ae86@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53d0ead1-3a82-01d3-3b8a-094c1e6e34e0@gmail.com>
Date:   Tue, 16 Apr 2019 18:49:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <203f3cbf-d825-0597-b64a-dc876743ae86@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 10:48, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>> The devfreq driver can be used on Tegra30 without any code change and
>> it works perfectly fine, the default Tegra124 parameters are good enough
>> for Tegra30.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig         | 4 ++--
>>  drivers/devfreq/tegra-devfreq.c | 1 +
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index a78dffe603c1..78c33ddd4eea 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>  	  This does not yet operate with optimal voltages.
>>  
>>  config ARM_TEGRA_DEVFREQ
>> -	tristate "Tegra DEVFREQ Driver"
>> -	depends on ARCH_TEGRA_124_SOC
>> +	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
> 
> Looks good to me. But, I have a question.
> 
> 'Tegra30+' expression is enough in order to indicate
> the support for both tegra30 and tegra124?
> 
> In my case, it is difficult to catch the meaning
> of which tegra30+ support the kind of tegra124.

The ACTMON serves Tegra30, Tegra124 and Tegra210 SoC's. The later Tegra generations also have the ACTMON hardware unit, but most of actual drivers have been moved into firmware on the later gens, including the ACTMON driver. I'll change the wording to "Tegra30/124/210" for clarity. Note that Tegra210 support isn't implemented at the moment by the driver, but that may change in the future.

>> +	depends on ARCH_TEGRA
>>  	select PM_OPP
>>  	help
>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index f0711d5ad27d..0a2465a58cf5 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>>  }
>>  
>>  static const struct of_device_id tegra_devfreq_of_match[] = {
>> +	{ .compatible = "nvidia,tegra30-actmon" },
>>  	{ .compatible = "nvidia,tegra124-actmon" },
>>  	{ },
>>  };
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Thanks.
