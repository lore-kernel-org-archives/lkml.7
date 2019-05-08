Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431E5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FEE21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRvJQ6aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEHKvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:51:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40440 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfEHKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:51:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so7308770wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y8VN0Vi6CpqQOnZi4UqZkgCmBi+7eeFUzbOG8vHxp/A=;
        b=eRvJQ6aZJxIlKJQbUSyAO+/bVK7SPC19yXSYwj6ICNlqzizHzm5eKm2HsfeYkoGf6+
         bwr2lhvncqZwNsH0uc31grQ7Z/98bihRTiHZwicf4SlJwztdbdSYj1gsPs0ox+U57Nln
         RtwXVauuDMH8QPXwh2Z6jciUDa6fXmwg+WY3Sr1fePMX/hVjPA7wHbJ+wpOMJCnYfyK0
         tzqjQN0QMiZvz9S3+LvGMrRzmvm0hQD05o7DC5RTJAP+HXL/5N6dNMoWog7BbVoYB95U
         p8bKLehkxQIKD+PEOuStwCvb8x+htPDFMvuwMiM1nM/3UJ52u+3ujiALtxYxVniXfLVt
         LiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y8VN0Vi6CpqQOnZi4UqZkgCmBi+7eeFUzbOG8vHxp/A=;
        b=eRT/Ok1c9Plo0iIyisOyeqnTbMn6C3Jw/IOYZdwNN398LJlvq3MSdQ3Zk36y8CysXV
         tyofQNcU9rt2ApUNyEKRL2EbWcZ6AF025jH1KxklyFcc5tkM4ZmzahxdLoAaAXUKKNTy
         ZkHh9DPGhpfehFCNkJI5wfftWKxsZYjat8pQ7ZUT2G7S5fyqEA1PgccS5FGWJd41MeLb
         Lg/zBLmwyPtszmV5l6huitSACqwWn1i2rbc0SSmsAOuAMv57KnuCxbcU0dMQTfNQKia5
         waQINhFjfEXPmTE5W/JBu7jJK26tgTjrAdRRoML4nVyV/YmuprNqUaCfzNUUFcZ8te9u
         o1/A==
X-Gm-Message-State: APjAAAWDLSKvQq6m3E69eq7uyNtysvktYk102piqTKbW3+VpjBIDqbXW
        I+janDTCvPdxPUjiiedTXji7UA==
X-Google-Smtp-Source: APXvYqwWdHYr63SNNae1/1sfK0Q7qpPib6h0WQ3orqE4uvt7cMScNp/lhITtexVmCsHi3NBx6H2lvw==
X-Received: by 2002:a5d:53c6:: with SMTP id a6mr3706990wrw.232.1557312667265;
        Wed, 08 May 2019 03:51:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o13sm30073683wrg.40.2019.05.08.03.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:51:06 -0700 (PDT)
Date:   Wed, 8 May 2019 11:51:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: Applied "dt-bindings: mfd: atmel-usart: add DMA bindings for
 USART in SPI mode" to the spi tree
Message-ID: <20190508105105.GN3995@dell>
References: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
 <20190508090857.B7CB344003F@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508090857.B7CB344003F@finisterre.sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Mark Brown wrote:

> The patch
> 
>    dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3
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
> From f7b99e5948e6be8b850eecbb2de1986d26a76b36 Mon Sep 17 00:00:00 2001
> From: Radu Pirea <radu_nicolae.pirea@upb.ro>
> Date: Sun, 5 May 2019 21:06:45 +0300
> Subject: [PATCH] dt-bindings: mfd: atmel-usart: add DMA bindings for USART in
>  SPI mode
> 
> The bindings for DMA are now common for both drivers of the USART
> IP.
> 
> The node given as an example for USART in SPI mode has been updated in
> order to include DMA bindings.
> 
> Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----

Interesting!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
