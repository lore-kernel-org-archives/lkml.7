Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F8C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A0C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OYjpxqmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfDVScw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:32:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43253 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfDVScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:32:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so11103017lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUCt3VnNVSlsRuUbpNRCWirIHICmh5VTYp71WQCjflY=;
        b=OYjpxqmZHh9QYZgokxG4SH7GIicpDksstNVoefMHs5PWuZdKiayYLFxNuNasKqLjjr
         DhzRoaYlmiNLPRz6MMj45e+8ELMBoHmII+ikNYTCoaARIoU9UglrGr+7gNVIulGhrEM7
         yGLSAFjOWYUFdn9ip5eiDa4J50XsevboEFpsVupm7eM1nIbhtBypPIM8RYIIPWItfpdD
         ysIntXew5y9zIMWUAN24tKTjtKyax4Wb+pVxYBmdDmKai2Rm/WsawNge8PzNWODZB6D8
         XYZfJ3MAxYPpGXypHl6Wbf9f/KABTTuOg5ba+PI4NfeFLPIFoJ9KOLe9Pm2exyDihUQO
         gqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RUCt3VnNVSlsRuUbpNRCWirIHICmh5VTYp71WQCjflY=;
        b=mdYSxovB9jbsyT7ny0Ms4T0ogvyHCI+d+cwKCIwr28dpO3riJlQyBOrugYrjGRGVbG
         PdcN2tJoJG4xEVPGH1w0MNxxUjS9GHo5sEG/VRqqo17amUlAGopw14uGQQ2hEVfNQgdA
         cvM5OtI5ykHNOewgRYX4doQdx1uRpYRxM7LxR0xu7678xW5qgMWADNqL7+B42EQfuu/0
         0kCkP3Xk42+oe1JNyCPJCTotsYLA94ayDHr3VO2tKf12xEsvugftxoZqH5CouOnMFPjo
         LYOdJpG2R1VY6n8AN05fI6tGNugYpjAU8xH2fqh3rlctAjtWNj2d9SKm3Dl5LH8hAUMK
         81lQ==
X-Gm-Message-State: APjAAAXiWeW3K3jOr21Qm22ZzlsDuTGd0JU+oHV14KmdLEm6DBg4tWc5
        Lrg04JNDuYtvvLQtn4bi+oF7Eg==
X-Google-Smtp-Source: APXvYqzRa33fVbEdzoDY5qMP2l8YrBxVxcUbXvxn9OdGollupqDKx+w+vF2BAV4KOAlOzJl0Op+jfA==
X-Received: by 2002:a2e:292:: with SMTP id y18mr11146906lje.52.1555957968898;
        Mon, 22 Apr 2019 11:32:48 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.98])
        by smtp.gmail.com with ESMTPSA id l22sm2813750lja.97.2019.04.22.11.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 11:32:47 -0700 (PDT)
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
Date:   Mon, 22 Apr 2019 21:32:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/2019 06:32 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

  Do dote that I'm opposed to the driver separation as it's presented in
this patches, and I have a large patch reworking both MFD and SPI drivers
in the works.

> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..634222d
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,571 @@
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
> +	rpc->mfd = rpc_mfd;
> +	ctlr->dev.of_node = pdev->dev.parent->of_node;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ctlr->auto_runtime_pm = true;
> +
> +	ctlr->num_chipselect = 1;
> +	ctlr->mem_ops = &rpc_spi_mem_ops;
> +	ctlr->transfer_one_message = rpc_spi_transfer_one_message;
> +
> +	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	rpc_spi_hw_init(rpc);
> +	pm_runtime_put(&pdev->dev);
> +
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto err_put_ctlr;
> +	}
> +
> +	return 0;

   Previous formatting was better, shouldn't have moved the empty line above
*return*...

> +err_put_ctlr:
> +	spi_controller_put(ctlr);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
[...]

MBR, Sergei

