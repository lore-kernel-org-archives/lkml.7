Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445DF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p11LdXDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfG3Sdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:33:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3Sdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:33:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so30292633pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDPYNtNZJ8yMTUdTAjpzX/W7EtPR+4qG3lY6BbMAYq8=;
        b=p11LdXDyKKeh447fOhCgRaMAzsyR7+b+4r3QdcFMXX4YPeQgAV63+1jBgYOJ83lIR9
         FFLsZZVo8bcU/RJL1X8uCSQn/s9e6IOwqi/MkrlRliLbPpW2K03D3YjXNkPlg7UudIOE
         EUVifs1wywLHbhfkzvtG+f6MLjAPS302FxSzgtMpKy4Ot0k/b63rbsKenGiedxcbEVo/
         kfRtudPNat2bnfXPhqCn4YRxyzWJbj6cVJSJHSKN9AZpztgC2c8Aflv73rh/Yz/k4aCF
         r0sXBoGB050cWx6tMzXuJ316g/gJqzqOUgMKhrucaAa07SmaLgpYoD2uHccZls1FoDNU
         o24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDPYNtNZJ8yMTUdTAjpzX/W7EtPR+4qG3lY6BbMAYq8=;
        b=EHstGlYAvltW/kk8WBm+VgSrhO0mANtE2E/22dbY5Dsn6+GJIxZ2SJUx1zPHfm2BjZ
         km0axM2vfyIApINMo+HFG1/DuukeuNVRIbYkl+EJyZlntZ410o2ZnbVAgHLJBip2mt70
         nIMvugPsjwTvlV5MTwDK1UObytQ/nDfJVNtgs4UJezBRqpPIp3QgX+6a6b1DUj4Ec6rJ
         YAUfeq84oqxAkbDaYVjUMgAgTUPwilQnY9c3Z1jrcZYRyH6banXIvMA7JiFkfcOdegL8
         qUe4AXAWRVjCRQxWzAlHNYapxy+fRLVKTiUdCLCpt/Cg/4wcFEjj8h4SBUpO5lTieauU
         sWmQ==
X-Gm-Message-State: APjAAAVVRkNM+pPD6hjiXufk4PVaW2XKlj43YJFHMKDwca/JV/fQL1CI
        0AOdMxtCqhgT35lHgEEB4lKY8w==
X-Google-Smtp-Source: APXvYqzfgBI4iXsr5pRAAwelL8b2mO0Nt8hSO3ORfYNg0MQq3HCpHPBL0sK+W4Js31d42EuVrD7Xmw==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr118759494pjt.33.1564511615883;
        Tue, 30 Jul 2019 11:33:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j15sm76958349pfe.3.2019.07.30.11.33.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:33:35 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:35:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 40/57] soc: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190730183503.GX7234@tuxbook-pro>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-41-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-41-swboyd@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Jul 11:15 PDT 2019, Stephen Boyd wrote:

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/soc/fsl/qbman/bman_portal.c | 4 +---
>  drivers/soc/fsl/qbman/qman_portal.c | 4 +---
>  drivers/soc/qcom/smp2p.c            | 4 +---

If you had split this in a fsl and a qcom patch I would have just merged
the latter.

I don't see a problem with Li taking this patch through the Freescale
tree though (or vise versa).

Regards,
Bjorn

>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index cf4f10d6f590..e4ef35abb508 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -135,10 +135,8 @@ static int bman_portal_probe(struct platform_device *pdev)
>  	pcfg->cpu = -1;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "Can't get %pOF IRQ'\n", node);
> +	if (irq <= 0)
>  		goto err_ioremap1;
> -	}
>  	pcfg->irq = irq;
>  
>  	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index e2186b681d87..991c35a72e00 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -275,10 +275,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>  	pcfg->channel = val;
>  	pcfg->cpu = -1;
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "Can't get %pOF IRQ\n", node);
> +	if (irq <= 0)
>  		goto err_ioremap1;
> -	}
>  	pcfg->irq = irq;
>  
>  	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index c7300d54e444..07183d731d74 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
>  		goto report_read_failure;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	smp2p->mbox_client.dev = &pdev->dev;
>  	smp2p->mbox_client.knows_txdone = true;
> -- 
> Sent by a computer through tubes
> 
