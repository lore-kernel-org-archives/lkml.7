Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33886C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38D321582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3M3HqwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:07:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41597 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfLSHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:07:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so2662781pfw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fm+w6iomcjuXCL8fauWtHgK7waEj6ZumdluEW3weLEo=;
        b=r3M3HqwWGDHXJkn+/B3N+HIx9K4alkicLq5wXf4pwfxInFuBgNoIrLLzH8GU+7rifv
         ExT6eL7+5mQnp7eqwVEenErdKk2oI+kR4wv/UhIpVSWND3R7u/RHcy6QOcMxJ0EBAgcf
         FQ4APK7Gb7mzk2wNVT/BhU+5cW5vm0CDW91MWBRAWspq2jGlfrwNpP/xh31AfzV7pnKo
         kQ868nBQiwwk3dx4ZC1mwOMXLN8u8aRs3P4q/hrR7URj1Sl976Mm+k0lQNW9+HBb+oqZ
         rNPYfrJkwd/vsPNFmrIinL3izYGRmGXPv7wI4Aj0+9wXSDXOd1lLZsnEfK2r7M3OJ6k3
         dOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fm+w6iomcjuXCL8fauWtHgK7waEj6ZumdluEW3weLEo=;
        b=Gab0TN13NSlfMw2enUA7vAxcjGS2QFjnPmI93IZA82RcgExZVn88eUWpx8ntjvi2B7
         koKdKwgVObVSw6NPv7NA7Rc+mqd5cSM/3q+NxAUVu7/DeBbGHXsHZ6yv0ZmutDNtSB+a
         usg83zc+m/PH/moTpfeoU77OH56DiDdUokG2oP/Pbd85QuE7bNNY7PSjIEfQZLr3SfLT
         OYaL0W6eFBxNE6tPabWyn9oApDRQZpg1RQpo/A9ve4iImx1Z8T33fXJOdZXK4KW70DoT
         sBa9C0DilzXSyLgSQe3UpBc7bysJ9szDnDx4Yc2WD96Ecf5AoaybzhvgYzTpv9jsgWeb
         l3gw==
X-Gm-Message-State: APjAAAXuuLzNtnuc2axVV8ti2S49J/cB+mGZKVIGk5CZqOaLF1Iol4Pv
        axnA+37L6VFBGDVraDA8xG1s3Q==
X-Google-Smtp-Source: APXvYqxUxu7IoSGnaMb1R6YodG3fNsxk/So/wu5Hx35rfBLQvcUPgZkuAWdrltM/xiI4H0ih+4erTQ==
X-Received: by 2002:a65:5608:: with SMTP id l8mr7727226pgs.210.1576739221708;
        Wed, 18 Dec 2019 23:07:01 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r30sm2812990pfl.162.2019.12.18.23.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 23:07:01 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:06:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qcom-qmp: Add MSM8996 UFS QMP support
Message-ID: <20191219070658.GG448416@yoga>
References: <20191207202147.2314248-1-bjorn.andersson@linaro.org>
 <20191207202147.2314248-2-bjorn.andersson@linaro.org>
 <20191219042047.GT2536@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219042047.GT2536@vkoul-mobl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Dec 20:20 PST 2019, Vinod Koul wrote:

> On 07-12-19, 12:21, Bjorn Andersson wrote:
> > The support for the 14nm MSM8996 UFS PHY is currently handled by the
> > UFS-specific 14nm QMP driver, due to the earlier need for additional
> > operations beyond the standard PHY API.
> > 
> > Add support for this PHY to the common QMP driver, to allow us to remove
> > the old driver.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 106 ++++++++++++++++++
> >  2 files changed, 111 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > index eac9ad3cbbc8..5b99cf081817 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >   - compatible: compatible list, contains:
> >  	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
> >  	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
> > +	       "qcom,msm8996-qmp-ufs-phy" for 14nm UFS phy on msm8996,
> >  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> >  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
> >  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> > @@ -44,6 +45,8 @@ Required properties:
> >  		For "qcom,ipq8074-qmp-pcie-phy": no clocks are listed.
> >  		For "qcom,msm8996-qmp-pcie-phy" must contain:
> >  			"aux", "cfg_ahb", "ref".
> > +		For "qcom,msm8996-qmp-ufs-phy" must contain:
> > +			"ref".
> >  		For "qcom,msm8996-qmp-usb3-phy" must contain:
> >  			"aux", "cfg_ahb", "ref".
> >  		For "qcom,msm8998-qmp-usb3-phy" must contain:
> > @@ -72,6 +75,8 @@ Required properties:
> >  			"phy", "common".
> >  		For "qcom,msm8996-qmp-pcie-phy" must contain:
> >  			"phy", "common", "cfg".
> > +		For "qcom,msm8996-qmp-ufs-phy": must contain:
> > +			"ufsphy".
> >  		For "qcom,msm8996-qmp-usb3-phy" must contain
> >  			"phy", "common".
> >  		For "qcom,msm8998-qmp-usb3-phy" must contain
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > index a6b8fc5798e2..d81516c4d747 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -121,6 +121,11 @@ enum qphy_reg_layout {
> >  	QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
> >  };
> >  
> > +static const unsigned int msm8996_ufsphy_regs_layout[] = {
> > +	[QPHY_START_CTRL]		= 0x00,
> > +	[QPHY_PCS_READY_STATUS]		= 0x168,
> > +};
> > +
> >  static const unsigned int pciephy_regs_layout[] = {
> >  	[QPHY_COM_SW_RESET]		= 0x400,
> >  	[QPHY_COM_POWER_DOWN_CONTROL]	= 0x404,
> > @@ -330,6 +335,75 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
> >  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
> >  };
> >  
> > +static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QPHY_POWER_DOWN_CONTROL, 0x01),
> 
> Can you check this after adding the reset for ufs, I suspect you might
> run into same issue as I am seeing on 8150, power down here does not
> seem correct.
> 

I'm not sure why we need to tickle POWER_DOWN here, but it's documented
as such, done in the old driver and without it the PHY does not come up.

Regards,
Bjorn
