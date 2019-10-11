Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7473CECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D662089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfJKJRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:17:42 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35287 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:17:41 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A7857240004;
        Fri, 11 Oct 2019 09:17:39 +0000 (UTC)
Date:   Fri, 11 Oct 2019 11:17:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, parthitce@gmail.com
Subject: Re: [PATCH] rtc: rv3028: add clkout support
Message-ID: <20191011091738.GC3125@piout.net>
References: <20190927141505.640751-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927141505.640751-1-pn@denx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the patch, minor comments below.

On 27/09/2019 16:15:05+0200, Parthiban Nallathambi wrote:
> +	ret = regmap_update_bits(rv3028->regmap, RV3028_STATUS,
> +				 RV3028_STATUS_CLKF, 0);
> +	if (ret < 0)
> +		return ret;
> +

This is already done earlier and this will not be enabled again unless
CLKIE is set which should not happen. So I don't think it is necessary
to do it once again here.

> +	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++) {
> +		if (clkout_rates[i] == rate) {
> +			ret = regmap_update_bits(rv3028->regmap,
> +						 RV3028_CLKOUT,
> +						 RV3028_CLKOUT_FD_MASK, i);
> +			if (ret < 0)
> +				return ret;
> +
> +			return regmap_write(rv3028->regmap, RV3028_CLKOUT,
> +				RV3028_CLKOUT_CLKSY | RV3028_CLKOUT_CLKOE);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}


> +static int rv3028_clkout_register_clk(struct rv3028_data *rv3028,
> +				      struct i2c_client *client)
> +{
> +	int ret;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	struct device_node *node = client->dev.of_node;
> +
> +	/* disable the clkout output */
> +	ret = regmap_write(rv3028->regmap, RV3028_CLKOUT, 0x0);
> +	if (ret < 0)
> +		return ret;
> +

This is not what the user would expect and could introduce a glitch in 
the clock output every time the platform is booted. If there are no 
users of the clock, then you should probably let the core disable it 
once the boot has ended.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
