Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49374C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172FE214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="MExKrc+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfDMQig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:38:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45619 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDMQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:38:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so5331813lfl.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3eZamVOu4Wm133g8UISHM+uXmD28PZPTS8JGzZskcDg=;
        b=MExKrc+HvH3pYbYzbOVOFdU+90NqNgenNUy1XYNNQleECMVticeWXaw9oh76HOdIJy
         890AXYj9JTu02oja6LRNoIg8yGn+AfhQz5y4BS10rafu76xYJMBANsFj1pvrN9oRDmmV
         iu6t/+TIML6F9oIjVLKiy35AypS88K0qjEZojKPS98kWdrpdhPPgbhp6PeNHvPlFv6o4
         xp57QDwDWSdpqAm0AP9mjLEzXhMKZQ02xJ2KHgtUrr8zNiSPbEEJ0nqETooa0XUsYQAA
         LGqFARlD6yzmreyjN8iCiwjp/aPQ4zxtKW2RiUOhgVgZONBR0piw1pljDU4v7rRFucPU
         nMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3eZamVOu4Wm133g8UISHM+uXmD28PZPTS8JGzZskcDg=;
        b=JvAq9xPC9va9rISQnnx6hyusAb9b9kp8+7lh3zr57Ixe2TgjQkxmLNWJFulNXJlUuh
         Upaf4ArBTqqkfKSGHAhzQn2xOVcF1MXOWYyj9Wn1qdlF2F9uBp2LHMpZhgZoy46tsW6D
         0tLNTnlMZIPFwm7L/JsN8njLS+DRtf1326Kss3ze0ZU2xFGGDkPP/rRyoQ5XgBsjtKeL
         5lpGZnoMinJXDZfyhjRqj6k7zgZRQhOWqwtBXp8IMgUdsmAXJDwIfxDhWZP3xprv3NiS
         xAeCO5u/JrEoUxkA5s71Dti/O/imaX/N4eoenZWHz7gzg64iW5VKRyzyf7yVoEWgQZXP
         00YQ==
X-Gm-Message-State: APjAAAWCN80GLHc1WztjTbwb6HLaLzu08KewSIwLlT9m0Oo+4xTr7++k
        k7Xwy3usWsXGSlzkB3j4SGsp+A==
X-Google-Smtp-Source: APXvYqwH9x5DZlXXB9c24Tgh0KXIGahYCsia3BYAzHLKGV2o+XLF5Mtz508/cUZyV/TRNKjMGvbpkQ==
X-Received: by 2002:ac2:4850:: with SMTP id 16mr16546244lfy.18.1555173513967;
        Sat, 13 Apr 2019 09:38:33 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.44])
        by smtp.gmail.com with ESMTPSA id q29sm8936691ljc.8.2019.04.13.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:38:33 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
Date:   Sat, 13 Apr 2019 19:38:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..037f273
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
> +	struct rpc_spi *rpc;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ctlr);
> +
> +	rpc = spi_controller_get_devdata(ctlr);
> +
> +	ctlr->dev.of_node = pdev->dev.of_node;
[...]
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ctlr->auto_runtime_pm = true;

   I think this line no longer works as expected with the new probing scheme.
Have you tested reading? v8 patch still works while v9 patches hang on doing:

$ cat /dev/mtd<n>...

[...]
