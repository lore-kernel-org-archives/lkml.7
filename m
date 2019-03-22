Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20588C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E139121902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOfrRQlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCVABK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:01:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfCVABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:01:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so188190pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mbUY1OHCeDnwyDZsP92jAEWpkbO9ni7ahbfUuhZ6LRE=;
        b=QOfrRQlX5/fxad5/FSbfrEcaOzOPUQR6+AoBWJzl1HHGBSlUApV2kj+/K6LB5w68Fn
         sjWSBu0+amGzUjv9ccCMceLxLiayUGylnkSeHmScLURvlFt++tug6Iggx2pUksVvaW5c
         DtQUZL4Q0RHqaWhrVRrlzfxM0ABJJ1PXX2PTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mbUY1OHCeDnwyDZsP92jAEWpkbO9ni7ahbfUuhZ6LRE=;
        b=hrbC+2XpooJ3eBJ6qy5yA2Wz+5ESzHSjN9995dSSOg4faVkBQxFsfmMrVpa/lHdoCe
         qLfpac9C9zxkgD/HFh2cKCcZSwwyeFFLeJweKUUyyE5GaiBRUR0Sp5lcjypZeySdcZAA
         HPekQ5pNNCHSW064rTsozj06jmogh7G9O1oUkZSCqQUF6+Bv4eeqRxeuk5hbXvBUO67/
         w9hrYMesf8AhJm/QnAvU6kaZVC8BDusPu7VNt6cZJKVFijG4LVIELR2f4MdNeQTaJkk3
         5TO02hWsu8Us88mnjho2/8ustX/nrTl2Vfte1b+NGvHiFFO1dJVpZIZ8VNaeQQpbcvrH
         tMpQ==
X-Gm-Message-State: APjAAAXxaad6LOKWW5POzjtS0NybKr/e+P1piREVv8Tx29d+j4lou9FL
        EU37UanyjhPFFvKhdXZe0GksFg==
X-Google-Smtp-Source: APXvYqws1eulgf0bY+vTEUSoo8RYFI28ZIhXFkHYCDDtLa4tURcjuzPnhg6SntBIS/oaYeLvcwAS5g==
X-Received: by 2002:a63:e813:: with SMTP id s19mr5944970pgh.12.1553212869251;
        Thu, 21 Mar 2019 17:01:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 7sm11465465pgj.64.2019.03.21.17.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 17:01:08 -0700 (PDT)
Date:   Thu, 21 Mar 2019 17:01:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Message-ID: <20190322000107.GU112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaël,

On Thu, Mar 21, 2019 at 07:10:55PM -0400, Gaël PORTAY wrote:
> Matthias,
> 
> On Wed, Mar 20, 2019 at 03:02:23PM -0700, Matthias Kaehlcke wrote:
> > Hi Gaël,
> > 
> > On Wed, Mar 20, 2019 at 05:50:13PM -0400, Gaël PORTAY wrote:
> > > Hi Matthias,
> > > 
> > > On Tue, Mar 19, 2019 at 05:33:52PM -0700, Matthias Kaehlcke wrote:
> > > > ...
> > > > > @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> > > > >  
> > > > >  	mutex_lock(&dmcfreq->lock);
> > > > >  
> > > > > +	if (target_rate >= dmcfreq->odt_dis_freq)
> > > > > +		odt_enable = true;
> > > > > +
> > > > > +	/*
> > > > > +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> > > > > +	 * timings and to enable or disable the ODT (on-die termination)
> > > > > +	 * resistors.
> > > > > +	 */
> > > > > +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> > > > > +		      dmcfreq->odt_pd_arg1,
> > > > > +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> > > > > +		      odt_enable, 0, 0, 0, &res);
> > > > 
> > > > Is it necessary/desirable to make this call for every frequency
> > > > change? IIUC it should be only needed when odt_enable changes and the
> > > > driver could track the state. If the DDR frequency doesn't change too
> > > > often and the overhead of the call is small it shouldn't be really
> > > > important though.
> > > >
> > > 
> > > I will test your solution first to make sure there is no regression to
> > > run that call for frequency change only.
> > 
> 
> Oops, I wanted to say when odt_enable changes since last call.
> 
> > If there is no frequency change the function returns at the
> > beginning. My suggestion was to only do the call when 'odt_enable'
> > changes, i.e. when a change (up or down) passes the 'odt_dis_freq'
> > threshold.
> > 
> 
> So, for a reason that I ignore, if we try to save unecessary calls to
> ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> that follows. The function arm_smccc_smc never returns and the device
> hard hang.

Thanks for giving it a try!

Did your code ensure to perform the SMC call for the first frequency
change? If not the problem could be that the DDR PD timings and ODT
resistors are not properly configured for the new frequency.

In case you already did this or it doesn't help I think it's fine to
just do the call always, we can always revisit this later.

> Thanks to your remark, I have also fixed an issue with the odt_dis_freq
> value. Its value is initialized to 0 in the probe function. Thus the
> odt_enable is always true (target_rate > 0). I moved its initialization
> after the timings are parsed from the device-tree; its value is now none
> zero (333000000 in my case).

Great!
