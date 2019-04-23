Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EAEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF29F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecdrJXD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfDWJtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:49:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45356 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDWJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:49:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so19291346wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MR2Y+JML+LjDqMHfpLpki88WTrS+gWZXfgXaluaArag=;
        b=ecdrJXD8XizHVXn/kqPr5CRLLswnIboaS8xrfmV9XzZiAa3gKguF6YFWg2Gbz3sTbJ
         XMipnhcTfahaNexfSkdSYUY3/HoamAgw3gLrz+LSRtB7aNBgrCc10p2yvw7AmzhSekUH
         mqWgR8kcQWB9ZywWrwkgkzSXJMrEJODvTm8hY//Y3lUplQYFq6+Q0XS3NTlbbxpOmNpp
         YtYmVFsLQroWkWxIKtkTRyuVjIh9Ilw9PJ28eUIu1sMiOvm9HLY5F/bVYMxREcy5oofZ
         VO2LW3N2x7BHCDnbIXO4QaikaDOLPI9FppLBenWCoEVzAuXylU1a/EMuxY664j/Bf9Ta
         V91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MR2Y+JML+LjDqMHfpLpki88WTrS+gWZXfgXaluaArag=;
        b=Cm4x/mxBknCUA1/njn+6gu+Na/+1IEW4YEA4Yj0P8kQNr4HtooQJB1PxxalcuGhpET
         63qhwMXOJnYyZB8YtfucgwFNvKN/UZuTQPMixs+BdXByPUeVu+8e1uNcd3FAHMrhO7OU
         thJV/qzVVHjbOure981bN+9moOMVjKHVNMg1GdxOTLPwwKW3fp0VWcLLDQEtRfEEVqYa
         CAaMtvMUU2DmkG/X55jeQn7sgw5Ox6o+af/xUmsJvgVQl1ZRLWVNN0r+cL1WGd0Pd7TG
         vTKbnytJlnZFRbu2Ivboyl4lWE0s7TVe9Tve0WP0ewMFhx6+YXfJqAPUKp0Xz0cACKw+
         Y9FA==
X-Gm-Message-State: APjAAAWf7vriQEyPVb4f9jx/9qLJFJPZdqwJ+92I9drjiCaqp5Taw+Py
        3XAQL2NuoZc7dqw4J5PWK6pRMuVAEWE=
X-Google-Smtp-Source: APXvYqyNo6KgN0w/BWFOb3SHnsx+aTjh4O+PTWobZYYeVhs60GEfOOanhHi3hx0txRXDY3gjRt3qbQ==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr2689051wrv.49.1556012958423;
        Tue, 23 Apr 2019 02:49:18 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id c6sm14661862wmb.21.2019.04.23.02.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:49:17 -0700 (PDT)
Subject: Re: Applied "regulator: core: do not report EPROBE_DEFER as error but
 as debug" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     khasim.mohammed@linaro.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418102607.88C6711279BC@debutante.sirena.org.uk>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <1f14ee5a-3ea3-9d15-d148-dadee20ddcca@linaro.org>
Date:   Tue, 23 Apr 2019 11:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190418102607.88C6711279BC@debutante.sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 12:26, Mark Brown wrote:
> The patch
> 
>    regulator: core: do not report EPROBE_DEFER as error but as debug
> 
> has been applied to the regulator tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2


hi Mark, I cant find the commit in the tree. Can you check if it was merged?



> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
>>From 317f0111220921e87a168e4e6cec275df4e9be01 Mon Sep 17 00:00:00 2001
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Date: Wed, 17 Apr 2019 21:24:43 +0200
> Subject: [PATCH] regulator: core: do not report EPROBE_DEFER as error but as
>  debug
> 
> Temporary failures to get a regulator (EPROBE_DEFER) should be logged
> as debug information instead of errors.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 5a9ebcf7fe7a..08ccabe07fe3 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4345,8 +4345,6 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
>  						      consumers[i].supply);
>  		if (IS_ERR(consumers[i].consumer)) {
>  			ret = PTR_ERR(consumers[i].consumer);
> -			dev_err(dev, "Failed to get supply '%s': %d\n",
> -				consumers[i].supply, ret);
>  			consumers[i].consumer = NULL;
>  			goto err;
>  		}
> @@ -4355,6 +4353,13 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
>  	return 0;
>  
>  err:
> +	if (ret != -EPROBE_DEFER)
> +		dev_err(dev, "Failed to get supply '%s': %d\n",
> +			consumers[i].supply, ret);
> +	else
> +		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
> +			consumers[i].supply);
> +
>  	while (--i >= 0)
>  		regulator_put(consumers[i].consumer);
>  
> 

