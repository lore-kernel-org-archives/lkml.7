Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7999C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED7421835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="jMwyMSB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgACARR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:17:17 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:35505 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACARQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:17:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3EFB33F43C;
        Fri,  3 Jan 2020 01:17:13 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=jMwyMSB7;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8N7kFaLmKTmI; Fri,  3 Jan 2020 01:17:12 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B9E123F41D;
        Fri,  3 Jan 2020 01:17:11 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id B260667D; Fri,  3 Jan 2020 01:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1578010630; bh=cww1rlemj26bNhUf55QD0U0OYjSzwgFpv3Sw4ih5L0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMwyMSB7CTvZNiQwtvqVov7mg685304CLerqF2sLJedx5OcW5rNpjk93NczStb9gP
         dk6ND1hAxtrmi9K01J7CWXycv3f9MEU/5Aj7fowNlPPWyaX2siDc/Zen+xZcbzJh6Y
         3pW5dpXYxUhBefGcCsNeAzQ9/YAQbKsDwlt82Nr0=
Date:   Fri, 3 Jan 2020 01:17:10 +0100
From:   Niklas Cassel <nks@flawful.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] clk: Use parent node pointer during registration if
 necessary
Message-ID: <20200103001710.indj23ajryzj77bf@flawful.org>
References: <20191230190455.141339-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230190455.141339-1-sboyd@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:04:55AM -0800, Stephen Boyd wrote:
> Sometimes clk drivers are attached to devices which are children of a
> parent device that is connected to a node in DT. This happens when
> devices are MFD-ish and the parent device driver mostly registers child
> devices to match against drivers placed in their respective subsystem
> directories like drivers/clk, drivers/regulator, etc. When the clk
> driver calls clk_register() with a device pointer, that struct device
> pointer won't have a device_node associated with it because it was
> created purely in software as a way to partition logic to a subsystem.
> 
> This causes problems for the way we find parent clks for the clks
> registered by these child devices because we look at the registering
> device's device_node pointer to lookup 'clocks' and 'clock-names'
> properties. Let's use the parent device's device_node pointer if the
> registering device doesn't have a device_node but the parent does. This
> simplifies clk registration code by avoiding the need to assign some
> device_node to the device registering the clk.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> I decided to introduce a new function instead of trying to jam it all
> in the one line where we assign np. This way the function gets the 
> true 'np' as an argument all the time.
> 
>  drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> 
> base-commit: e42617b825f8073569da76dc4510bfa019b1c35a
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b68e200829f2..a743fffe8e46 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3719,6 +3719,28 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * dev_or_parent_of_node - Get device node of @dev or @dev's parent
> + * @dev: Device to get device node of
> + *
> + * Returns: device node pointer of @dev, or the device node pointer of
> + * @dev->parent if dev doesn't have a device node, or NULL if neither
> + * @dev or @dev->parent have a device node.
> + */
> +static struct device_node *dev_or_parent_of_node(struct device *dev)
> +{
> +	struct device_node *np;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	np = dev_of_node(dev);
> +	if (!np)
> +		np = dev_of_node(dev->parent);
> +
> +	return np;
> +}
> +
>  /**
>   * clk_register - allocate a new clock, register it and return an opaque cookie
>   * @dev: device that is registering this clock
> @@ -3734,7 +3756,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>   */
>  struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>  {
> -	return __clk_register(dev, dev_of_node(dev), hw);
> +	return __clk_register(dev, dev_or_parent_of_node(dev), hw);
>  }
>  EXPORT_SYMBOL_GPL(clk_register);
>  
> @@ -3750,7 +3772,8 @@ EXPORT_SYMBOL_GPL(clk_register);
>   */
>  int clk_hw_register(struct device *dev, struct clk_hw *hw)
>  {
> -	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_of_node(dev), hw));
> +	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_or_parent_of_node(dev),
> +			       hw));
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_register);
>  

Reviewed-by: Niklas Cassel <nks@flawful.org>
