Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF624C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F022175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OixlN/PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCTAdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:33:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46004 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCTAdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:33:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so372900pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pIAmozdrbTOLwLNGIyetO2St2qeMD1RsIRur82uuJek=;
        b=OixlN/PXRwQFCJpfng9mAz+ykI8+BrgxciXQKA2qqI40KgUxB1ta/9IYGKVJVgmgVj
         bRt5LIhFdpdZJsHlRJTNEBBT4zf+7FyYP5kr7bZsuY28b3xh9NDZxw81XTHaTnnG5tlc
         wpMQwz+nxJdj7dTo+kiMxK/FQaKjOdZmx0R2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pIAmozdrbTOLwLNGIyetO2St2qeMD1RsIRur82uuJek=;
        b=MZACr9ek3VJeeFpRyp/sJm22b2L9ycsPzxT63iHoWHG2lHv4qhwI4OIqU9/RwCPOEM
         TXfzlzqL6XFrCGVXZaBmt/yjqX3NDUmHNyk4M9cGWVYNZX1yIjaQtAsiE5KxJBMAcS6I
         jW1f0wbhMCtfVwFva1Ucg9aHK577+pXWj/qduKliwNYX3WIRPHgwiFn/palXlRizG/eA
         2+Qgy4bI6/zxQDnkapXCBtlWOTsz+xLhQmjLcRZLvNTR96bt0q33SSzHovErfD6MCiXJ
         DuZBMCqAm5x3Enuw6HiuN4yhIPDOQPgRe4yQ0HMrgqv31UL7XXxbVvk6P9EX1GeGTOtH
         wQGg==
X-Gm-Message-State: APjAAAUTtrv+WJW5URLHS6TkiD/pGUxpvqJ5ibxDxDFC8AMNCOdsToEM
        1Np+DosX1SpXvaA5WW/bPY/xPQ==
X-Google-Smtp-Source: APXvYqzbgiE7aJ+ThgbRlljjuMjnoZuOAv0b7hZqNDkCC+iqTxIpTIQ/lgi4xeLM/4yfWMSOPjH/+A==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr4679354plt.275.1553042033947;
        Tue, 19 Mar 2019 17:33:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p14sm216333pgn.34.2019.03.19.17.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:33:53 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:33:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Message-ID: <20190320003352.GN112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319181323.22804-4-gael.portay@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaël,

On Tue, Mar 19, 2019 at 02:13:21PM -0400, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v2: None
> 
> Changes in v1:
> - [RFC 3/10] Add an explanation for platform SIP calls.
> - [RFC 3/10] Change if statement for a switch.
> - [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
> 
>  drivers/devfreq/rk3399_dmc.c        | 74 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> ...
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long old_clk_rate = dmcfreq->rate;
>  	unsigned long target_volt, target_rate;
> +	struct arm_smccc_res res;
> +	bool odt_enable = false;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		odt_enable = true;
> +
> +	/*
> +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination)
> +	 * resistors.
> +	 */
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      odt_enable, 0, 0, 0, &res);

Is it necessary/desirable to make this call for every frequency
change? IIUC it should be only needed when odt_enable changes and the
driver could track the state. If the DDR frequency doesn't change too
often and the overhead of the call is small it shouldn't be really
important though.

> @@ -294,11 +315,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.of_node, *node;
>  	struct rk3399_dmcfreq *data;
>  	int ret, index, size;
>  	uint32_t *timing;
>  	struct dev_pm_opp *opp;
> +	u32 ddr_type;
> +	u32 val;
>  
>  	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
>  	if (!data)
> @@ -334,6 +357,34 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Try to find the optional reference to the pmu syscon */
> +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> +	if (node) {

The 'optional' part doesn't seem to be accurate: according to the
binding (https://lore.kernel.org/patchwork/patch/1052322/) the
property is required and the code below assumes that data->regmap_pmu
is set.

> +		data->regmap_pmu = syscon_node_to_regmap(node);
> +		if (IS_ERR(data->regmap_pmu))
> +			return PTR_ERR(data->regmap_pmu);
> +	}
> +
> +	/* Get DDR type */

nit: the comment doesn't add much value, thanks to good variable
naming this is evident from the code.

> +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	/* Get the odt_dis_freq parameter in function of the DDR type */

nit: ditto

(if you prefer to keep these comments I'm not opposed to keeping them,
but I don't think they are needed)

Cheers

Matthias
