Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02191C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B0218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCTVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:50:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCTVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:50:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 2DCB72817E9
Date:   Wed, 20 Mar 2019 17:50:13 -0400
From:   =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Message-ID: <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320003352.GN112750@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, Mar 19, 2019 at 05:33:52PM -0700, Matthias Kaehlcke wrote:
> ...
> > @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> >  
> >  	mutex_lock(&dmcfreq->lock);
> >  
> > +	if (target_rate >= dmcfreq->odt_dis_freq)
> > +		odt_enable = true;
> > +
> > +	/*
> > +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> > +	 * timings and to enable or disable the ODT (on-die termination)
> > +	 * resistors.
> > +	 */
> > +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> > +		      dmcfreq->odt_pd_arg1,
> > +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> > +		      odt_enable, 0, 0, 0, &res);
> 
> Is it necessary/desirable to make this call for every frequency
> change? IIUC it should be only needed when odt_enable changes and the
> driver could track the state. If the DDR frequency doesn't change too
> often and the overhead of the call is small it shouldn't be really
> important though.
>

I will test your solution first to make sure there is no regression to
run that call for frequency change only.

Also, the call takes around 300us.

> > ...
> > @@ -334,6 +357,34 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	/* Try to find the optional reference to the pmu syscon */
> > +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> > +	if (node) {
> 
> The 'optional' part doesn't seem to be accurate: according to the
> binding (https://lore.kernel.org/patchwork/patch/1052322/) the
> property is required and the code below assumes that data->regmap_pmu
> is set.
>

Indeed.

> > +		data->regmap_pmu = syscon_node_to_regmap(node);
> > +		if (IS_ERR(data->regmap_pmu))
> > +			return PTR_ERR(data->regmap_pmu);
> > +	}
> > +
> > +	/* Get DDR type */
> 
> nit: the comment doesn't add much value, thanks to good variable
> naming this is evident from the code.
> 
> > +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> > +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> > +		    RK3399_PMUGRF_DDRTYPE_MASK;
> > +
> > +	/* Get the odt_dis_freq parameter in function of the DDR type */
> 
> nit: ditto
> 
> (if you prefer to keep these comments I'm not opposed to keeping them,
> but I don't think they are needed)
>

I will remove all the comments in the v3.

> Cheers
> 
> Matthias
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Regards,
Gaël
