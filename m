Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D002087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbfCZUte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:49:34 -0400
Received: from stcim.de ([78.46.90.227]:36266 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731736AbfCZUte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:49:34 -0400
X-Greylist: delayed 1740 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 16:49:32 EDT
Received: from xdsl-89-0-91-101.nc.de ([89.0.91.101] helo=porty)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <contact@stefanchrist.eu>)
        id 1h8sYH-0005lq-Qn; Tue, 26 Mar 2019 21:20:06 +0100
Date:   Tue, 26 Mar 2019 21:20:05 +0100
From:   Stefan Lengfeld <contact@stefanchrist.eu>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Message-ID: <20190326202005.s3ktyth42lfjirx2@porty>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
X-PGP-Key: https://stefanchrist.eu/personal/Stefan_Lengfeld_0xE44A23B289092311.asc
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Sat, Mar 02, 2019 at 02:47:34PM +0100, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 

[...]

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

Here and between the function prototype of 'tegra_bpmp_i2c_xfer' and
it's function body is a unneeded blank line. Nitpick.

Kind regards,
    Stefan

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
> 
