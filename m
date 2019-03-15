Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5262FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160B921871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="W+dbXr1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfCOMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:32:54 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36062 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCOMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:32:54 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8C98325B7E0;
        Fri, 15 Mar 2019 23:32:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552653171; bh=eAOA9wgX2tC8+Yvdiy9bXZJTOSSpCDUueoutCAodaS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+dbXr1SQvseFjmMjPRNnvCEQTJmGIA+yIkJiCVVcWponw3NQqiby24fwRsuR7xsr
         4+VVsQQcHrYr3kIHtwE00PHEc9/gP1ItaoEPQpBC3vKARKB07IfONQ28pQdfm2nhUD
         TF71cZdHjbAeIuKeBquUngnQ1YadR0bJCE/QqXzw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id F15279403F2; Fri, 15 Mar 2019 13:32:49 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:32:49 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Phil Reid <preid@electromag.com.au>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/7] i2c: demux: WIP: handle the new atomic
 callbacks
Message-ID: <20190315123249.mlymbgwi3rxtt4d3@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:32PM +0100, Wolfram Sang wrote:
> If the parent has an atomic callback, we need to translate it the same
> way as the non-atomic callback.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> index 035032e20327..5d00adfbe578 100644
> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -99,6 +99,9 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
>  
>  	/* Now fill out current adapter structure. cur_chan must be up to date */
>  	priv->algo.master_xfer = i2c_demux_master_xfer;
> +	/* FIXME: regular muxes need proper handling, too! */
> +	if (adap->algo->master_xfer_atomic)
> +		priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
>  	priv->algo.functionality = i2c_demux_functionality;
>  
>  	snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
