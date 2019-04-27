Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F483C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB9208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556370627;
	bh=I/ov1ipXmDgyoqQOOE8Pk2e0WRg6v9my9N08LLlUspw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2Lx1znmDwMsMEnye2hVZkoaR+8bTMtFMm+rvyaeUxjOSPMVRQCcSlWeMy26kFIRiL
	 WlZ+DCac8+UHe/FNt6AjbzlvA4lOX1lUDeFsUcx1OYHjC6VO6w6U9FXwIy8/RkBkMw
	 B5alPjN9B5LEl+nlM3K/TfxkwBbOF0ujcSXo9/8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfD0NK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0NK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:10:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B332B2146E;
        Sat, 27 Apr 2019 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556370625;
        bh=I/ov1ipXmDgyoqQOOE8Pk2e0WRg6v9my9N08LLlUspw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eqHrhqGcBidnV6RnOoR7ql0WlGs9ij1yHdOzqhNIgCr2hhKcYJgrpgJ7Grz87fR9t
         iekpGVg+xHBgbCmoqBtR1LGlyqeqlYJZG9GUNTQr101u8a2xYDFvTcSDUOhiwCe1sg
         iYFVxvN8bIIgZBAKasDFkBkcLruRrbX96XpvJjmo=
Date:   Sat, 27 Apr 2019 14:10:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: stm32-dfsdm: missing error case during
 probe
Message-ID: <20190427141019.1a526679@archlinux>
In-Reply-To: <b46f9525-53c0-d874-c88f-c6e351736b04@st.com>
References: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
        <1556110286-1526-3-git-send-email-fabien.dessenne@st.com>
        <b46f9525-53c0-d874-c88f-c6e351736b04@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 14:55:28 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 4/24/19 2:51 PM, Fabien Dessenne wrote:
> > During probe, check the devm_ioremap_resource() error value.
> > Also return the devm_clk_get() error value instead of -EINVAL.
> > 
> > Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> > ---  
> 
> 
> Hi Fabien,
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> Fabrice
> 
> >  drivers/iio/adc/stm32-dfsdm-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> > index 0a4d374..26e2011 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-core.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> > @@ -233,6 +233,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
> >  	}
> >  	priv->dfsdm.phys_base = res->start;
> >  	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv->dfsdm.base))
> > +		return PTR_ERR(priv->dfsdm.base);
> >  
> >  	/*
> >  	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
> > @@ -242,8 +244,10 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
> >  	 */
> >  	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
> >  	if (IS_ERR(priv->clk)) {
> > -		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
> > -		return -EINVAL;
> > +		ret = PTR_ERR(priv->clk);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
> > +		return ret;
> >  	}
> >  
> >  	priv->aclk = devm_clk_get(&pdev->dev, "audio");
> >   

