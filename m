Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8730C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D121721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XmxtZ/RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDMQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:39:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40706 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfDMQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:39:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so9831087lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqQQjxlwy5s4k0pOdM4r1SzrqLbFpvl1fvNdiYMAO2M=;
        b=XmxtZ/RJ3uEon5LcxKWuTGNZqwGwW9JpyTqI3i2q4f5x8GA/gO9YWdpY8WKts5sd5j
         q1lh3qzEZA1FqphCx8kXgG16NrGW9PK4UWQxzF6XhrtAYQZCqbeojXY2P3GkXgaatPlh
         0hFNETg7LYtx6P97YMBc8hRjCx5etAfa4yRgg7Ekq2ZAfSrim64Qn2uhWug6AACRCBxR
         ZwfloAgHzIbrven7C+C7jQcJ6pnyKwWEQ1K7NJPSJK9EIq2dsG19E0WJnEkz8xFdq+PQ
         nVM6RJMIif9q9ZkiCF0gIMx00NPjoGBuQBlDHVawWL3zKspIcPWswF+3DtUgb4qtMnTZ
         z+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lqQQjxlwy5s4k0pOdM4r1SzrqLbFpvl1fvNdiYMAO2M=;
        b=r01W6A+5tP41lHUwOWtjehgx+yV+bOWBq83IR/6SUWMRENjv9bvwD0OILupHHHeOmt
         wQQA6O46f8oJUSJJe4AhQOzwPZ1yUeqXSeU7ATTsnQfACOclgGlraFH/aq6VVOrU5H/g
         upsEmhstQD9kbdxK0OkuUWVND8uELp+Irs7CdXwsWCOVWfIloVYV9fphdep2B0VQLZgH
         d10xiY/Hre7vZ5zMyb5SNSrNOQWPNqtn7Mkz8g9+X6f0q9rD9C7WbGh/430C4Fx92ery
         DmQg0CDmsY03RJXDShWTiBJbgyjyhST+Hhwe2L6lfvyew7B16Qs0qo/zZ6thtFbGqmC3
         Sf/g==
X-Gm-Message-State: APjAAAWeDnFlnZKRoE6bCtoFOFRCST6FREfI3uJdFOK/HpQGzkmRwhJP
        AqCkf1GGKy/w4wMflKsE1l/Jdg==
X-Google-Smtp-Source: APXvYqyUCjC7TPk4faI89BkwaoYfCTZv+IVuLNIViSvu+F6qAAypK30dSWChJ5r09RoGJl48oObM5w==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr24144454lfp.51.1555173587224;
        Sat, 13 Apr 2019 09:39:47 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.44])
        by smtp.gmail.com with ESMTPSA id v21sm8843680lfg.26.2019.04.13.09.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:39:46 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
Date:   Sat, 13 Apr 2019 19:39:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2019 07:38 PM, Sergei Shtylyov wrote:

>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
>> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> new file mode 100644
>> index 0000000..037f273
>> --- /dev/null
>> +++ b/drivers/spi/spi-renesas-rpc.c
> [...]
>> +static int rpc_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr;
>> +	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> +	struct rpc_spi *rpc;
>> +	int ret;
>> +
>> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> +	if (!ctlr)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ctlr);
>> +
>> +	rpc = spi_controller_get_devdata(ctlr);
>> +
>> +	ctlr->dev.of_node = pdev->dev.of_node;
> [...]
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +	ctlr->auto_runtime_pm = true;
> 
>    I think this line no longer works as expected with the new probing scheme.
> Have you tested reading? v8 patch still works while v9 patches hang on doing:
> 
> $ cat /dev/mtd<n>...

   Sorry, 'od -x', not 'cat'.

WBR, Sergei
