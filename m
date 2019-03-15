Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE11C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD320854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="OAbRmnHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfCOMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:42:38 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36164 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCOMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:42:37 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 00AC025B76D;
        Fri, 15 Mar 2019 23:42:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552653754; bh=EW5CAcSLgHJFcqVHgVRva4BMAD/q2CMvtB+gftJX9pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAbRmnHuzyepA0vwjm2fkgJA4KWlMVtX6Ut2FtXYrqzSOykx+9KbTEmiW5C8FouyB
         1m2krwjf/+B5yiG3+5K/Y108vArvlZc7eO5Km5CuwlDMZlOv0kT6HLAQItE2YoVlF8
         Z0PH/eTTE/QuaC0ypnFzp+uxWw03jqJEP03GlP7E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6DB9E9403F2; Fri, 15 Mar 2019 13:42:32 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:42:32 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Message-ID: <20190315124232.duwhdbjrcg3z5qd6@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:34PM +0100, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra-bpmp.c b/drivers/i2c/busses/i2c-tegra-bpmp.c
> index f6cd35d0a2ac..02b78ba5b23b 100644
> --- a/drivers/i2c/busses/i2c-tegra-bpmp.c
> +++ b/drivers/i2c/busses/i2c-tegra-bpmp.c
> @@ -207,7 +207,8 @@ static int tegra_bpmp_i2c_msg_len_check(struct i2c_msg *msgs, unsigned int num)
>  
>  static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>  				   struct mrq_i2c_request *request,
> -				   struct mrq_i2c_response *response)
> +				   struct mrq_i2c_response *response,
> +				   bool atomic)
>  {
>  	struct tegra_bpmp_message msg;
>  	int err;
> @@ -222,7 +223,7 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>  	msg.rx.data = response;
>  	msg.rx.size = sizeof(*response);
>  
> -	if (irqs_disabled())
> +	if (atomic)
>  		err = tegra_bpmp_transfer_atomic(i2c->bpmp, &msg);
>  	else
>  		err = tegra_bpmp_transfer(i2c->bpmp, &msg);
> @@ -230,8 +231,9 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>  	return err;
>  }
>  
> -static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> -			       struct i2c_msg *msgs, int num)
> +static int tegra_bpmp_i2c_xfer_common(struct i2c_adapter *adapter,
> +				      struct i2c_msg *msgs, int num,
> +				      bool atomic)
>  {
>  	struct tegra_bpmp_i2c *i2c = i2c_get_adapdata(adapter);
>  	struct mrq_i2c_response response;
> @@ -253,7 +255,7 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
>  		return err;
>  	}
>  
> -	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response);
> +	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response, atomic);
>  	if (err < 0) {
>  		dev_err(i2c->dev, "failed to transfer message: %d\n", err);
>  		return err;
> @@ -268,6 +270,20 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
>  	return num;
>  }
>  
> +static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> +			       struct i2c_msg *msgs, int num)
> +
> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, false);
> +}
> +
> +static int tegra_bpmp_i2c_xfer_atomic(struct i2c_adapter *adapter,
> +				      struct i2c_msg *msgs, int num)
> +
> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, true);
> +}
> +
>  static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
> @@ -276,6 +292,7 @@ static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>  
>  static const struct i2c_algorithm tegra_bpmp_i2c_algo = {
>  	.master_xfer = tegra_bpmp_i2c_xfer,
> +	.master_xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
>  	.functionality = tegra_bpmp_i2c_func,
>  };
>  
> -- 
> 2.11.0
> 
