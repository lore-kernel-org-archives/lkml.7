Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF86B214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NELtG8K2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfLECVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:21:20 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40265 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLECVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:21:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so615846pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 18:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JumaJpJPhmNfSvvvkz61jNW5BTSsDPkTym99dI21cw8=;
        b=NELtG8K2dfx3apc8E7BMQrUJfvTeRmPJjo/179dWN+u9bqC92MWHpqsHkTkdG9+tHF
         PkWc/QCeImujLtQRnf/3RUcmQEnVe0z/zZelOft28FusJuB78yRG3LRkTYee+U4vXvo0
         NOuCfiPqqDj241vOAHnEz9QUHIUElAqGuk4tPIXgcXhGQsbAcwCMKuyXfO4G9iUzkhvy
         UTtHcjNRw6czLtFkee5AzGgRcgr0EqkDnDvkpAdDOAeVjUChbuY7qAN8a2sBD91Sf5QU
         ZesxB54dEpcVcp16enpBExvDge265f35e/qjqs09wM/u8CM3orqeE+B/i4ZhyxRsnyhH
         CvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JumaJpJPhmNfSvvvkz61jNW5BTSsDPkTym99dI21cw8=;
        b=NORq4EE+KjtJE3N8fFZKbUr6Bx3UQf1+Iw3z1KqQWbXdLAqAWxVvhxeX7K4dGggQKR
         Xw4JW+tx6RLTj82a4epXKNVgbDNUpvuTrBPsT4dn1HEOTdzcaWE/0xiMhxBnSaQ/ym/Z
         uqlmuSUXHWrYk4esyCBYyoES4caCap3V6EnhXKKzyXwUsU2jtoTyMUnlmX8GGK5RHdwn
         IXy0XsmmPlXliRXgpctI+Pt5zMqW5kzOYHW8ktg8RIdDPIcpJkmoQZ0onVAPH6RAtXo8
         Nm/58GmwGlFrVkRphMrDY8D/VNMEvPq0A8qXvmeGl65lcNJ3QY/HkhiuLwVZ4Os9Dtc2
         +mTQ==
X-Gm-Message-State: APjAAAUNV2tVkNLzekYIziiGE5Odc4fTL5suegtVXUFHCQchZN1Ho++2
        K4tZzIGq9jyVd2cFM2Jqtn+8vuLF
X-Google-Smtp-Source: APXvYqwb6wYTzOOyWbUQwbCr44Sh1Uouiz0Kb5BZ0Mc3ApMcrfMMebihBJVtLLPa9b3XOn+09sXF8w==
X-Received: by 2002:a17:90a:6484:: with SMTP id h4mr4335560pjj.84.1575512479426;
        Wed, 04 Dec 2019 18:21:19 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y38sm9041215pgk.33.2019.12.04.18.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 18:21:19 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:17:57 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
Message-ID: <20191205021756.GA1122@Asurada-Nvidia.nvidia.com>
References: <20191128223802.18228-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128223802.18228-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:38:02PM +0100, Michael Walle wrote:
> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
> IRQF_SHARED to be able to use these SAIs simultaneously.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b517e4bc1b87..8c3ea7300972 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -958,7 +958,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
> +	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, IRQF_SHARED,
> +			       np->name, sai);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
>  		return ret;
> -- 
> 2.20.1
> 
