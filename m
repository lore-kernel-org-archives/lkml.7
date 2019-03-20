Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A980C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3731D218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hv8nPb6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCTWC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:02:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41815 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCTWCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:02:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2758456pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sye9pmN9RqCau99uQ30RiaNU06AjrsbWR99rGw3iM0U=;
        b=Hv8nPb6qiPj03VRQpx7ORJNed3nv6xCW9jbA4Jn8OQOroy/FPaQY3YymqC9up2Z5xm
         ruS+fp7Afl2nYATgOPT/h+Spw3/m6RbUSDIv1LLXHYU6w5yhdcZAq3UlRFx5BFT0dWt7
         SWYAr3BIXFnjJm0+2QlpDedEVmXLJeCVjbGJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sye9pmN9RqCau99uQ30RiaNU06AjrsbWR99rGw3iM0U=;
        b=g/rOQ+VL7jEGK8rkmzRBNchjPeciLDcRzz/XClNzkYD5XjhaCbSvbT5DQ2PZs/AiSw
         IgBRWQ0ZAoKFsXzOf/vs/o3zLHSHD/aulFW4IH0xk8o3UFHHfttRXe3vTh87+iphPktx
         5FkfvBjmnA8zed5wsUrC1btC9iOxq3UH2f+LMLQpE60ULiyWKAtTLA0nCmGuhIVauPXZ
         ZHSchJ3hovgn/ys7nqLMZo6ivi3luFal/MJ/lk5PDtfE09zjkZZ8IqiY6CylNN/uX3GJ
         wR8sZz2vlTmy05T963lVbBiJzeEG+qCkxckWsy2pyNZDU1Hm/BCBrFTqSFXYdigitYaK
         ATsQ==
X-Gm-Message-State: APjAAAVfhZIhqQ+kBoItVO47/2fqMa248PjTApI9iwdo9ou4kLUaXKtu
        OjkLDRmFDr/NWNnqVGxkCvihvg==
X-Google-Smtp-Source: APXvYqwreuFe8XwtTCdQu5JasRrhCjaRRaabezu83YJ1BVjmwSWEZ2qSg/b6OO92t1tak9/BLghxsA==
X-Received: by 2002:a63:5c66:: with SMTP id n38mr221110pgm.15.1553119344714;
        Wed, 20 Mar 2019 15:02:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f15sm3222477pgd.74.2019.03.20.15.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:02:24 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:02:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
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
Message-ID: <20190320220223.GP112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaël,

On Wed, Mar 20, 2019 at 05:50:13PM -0400, Gaël PORTAY wrote:
> Hi Matthias,
> 
> On Tue, Mar 19, 2019 at 05:33:52PM -0700, Matthias Kaehlcke wrote:
> > ...
> > > @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> > >  
> > >  	mutex_lock(&dmcfreq->lock);
> > >  
> > > +	if (target_rate >= dmcfreq->odt_dis_freq)
> > > +		odt_enable = true;
> > > +
> > > +	/*
> > > +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> > > +	 * timings and to enable or disable the ODT (on-die termination)
> > > +	 * resistors.
> > > +	 */
> > > +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> > > +		      dmcfreq->odt_pd_arg1,
> > > +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> > > +		      odt_enable, 0, 0, 0, &res);
> > 
> > Is it necessary/desirable to make this call for every frequency
> > change? IIUC it should be only needed when odt_enable changes and the
> > driver could track the state. If the DDR frequency doesn't change too
> > often and the overhead of the call is small it shouldn't be really
> > important though.
> >
> 
> I will test your solution first to make sure there is no regression to
> run that call for frequency change only.

If there is no frequency change the function returns at the
beginning. My suggestion was to only do the call when 'odt_enable'
changes, i.e. when a change (up or down) passes the 'odt_dis_freq'
threshold.

> Also, the call takes around 300us.

Thanks for the info!

Matthias
