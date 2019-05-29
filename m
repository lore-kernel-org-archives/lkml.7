Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6703923F61
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfE2Spj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:45:39 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:38670 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbfE2Spj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:45:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 984F9100E86C2;
        Wed, 29 May 2019 18:45:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mark05_4ddac67b04548
X-Filterd-Recvd-Size: 3252
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 May 2019 18:45:34 +0000 (UTC)
Message-ID: <bcd12350374533ef090ae911be444e702e85134b.camel@perches.com>
Subject: Re: [PATCH v2] drivers/media/dvb-frontends: Implement probe/remove
 for stv6110x
From:   Joe Perches <joe@perches.com>
To:     Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, sean@mess.org
Date:   Wed, 29 May 2019 11:45:33 -0700
In-Reply-To: <20190529165633.8779-1-tobias.johannes.klausmann@mni.thm.de>
References: <20190509195118.23027-1-tobias.johannes.klausmann@mni.thm.de>
         <20190529165633.8779-1-tobias.johannes.klausmann@mni.thm.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-29 at 18:56 +0200, Tobias Klausmann wrote:
> Refactor out the common parts of stv6110x_probe() and stv6110x_attach()
> into separate functions.
> 
> This provides the needed functionality to use dvb_module_probe() instead
> of dvb_attach()!
> 
> v2:
> - Impovments based on comments by Sean Young
> - Fix checkpatch.pl --strict errors

trivia:

> diff --git a/drivers/media/dvb-frontends/stv6110x.c b/drivers/media/dvb-frontends/stv6110x.c
[]
> @@ -333,6 +333,41 @@ static void stv6110x_release(struct dvb_frontend *fe)
>  	kfree(stv6110x);
>  }
>  
> +void st6110x_init_regs(struct stv6110x_state *stv6110x)
> +{
> +	u8 default_regs[] = {0x07, 0x11, 0xdc, 0x85, 0x17, 0x01, 0xe6, 0x1e};

static const u8...

> +
> +	memcpy(stv6110x->regs, default_regs, 8);

	memcpy(stv6110x->regs, default_regs, ARRAY_SIZE(default_regs));

> +}
> +
> +void stv6110x_setup_divider(struct stv6110x_state *stv6110x)
> +{
> +	switch (stv6110x->config->clk_div) {
> +	default:
> +	case 1:
> +		STV6110x_SETFIELD(stv6110x->regs[STV6110x_CTRL2],
> +				  CTRL2_CO_DIV,
> +				  0);
> +		break;
> +	case 2:
> +		STV6110x_SETFIELD(stv6110x->regs[STV6110x_CTRL2],
> +				  CTRL2_CO_DIV,
> +				  1);
> +		break;
> +	case 4:
> +		STV6110x_SETFIELD(stv6110x->regs[STV6110x_CTRL2],
> +				  CTRL2_CO_DIV,
> +				  2);
> +		break;
> +	case 8:
> +	case 0:
> +		STV6110x_SETFIELD(stv6110x->regs[STV6110x_CTRL2],
> +				  CTRL2_CO_DIV,
> +				  3);
> +		break;
> +	}
> +}

Probably more sensible (and smaller object code) written using
an automatic like:

{
	int div;

	switch (stv6110x->config->clk_div) {
	case 8:
		div = 3;
		break;
	case 4:
		div = 2;
		break;
	case 2:
		div = 1;
		break;
	case 1:
	default:
		div = 0;
		break;
	}
	STV6110x_SETFIELD(stv6110x->regs[STV6110x_CTRL2], CTRL2_CO_DIV, div);
}

> diff --git a/drivers/media/dvb-frontends/stv6110x_priv.h b/drivers/media/dvb-frontends/stv6110x_priv.h
[]
> @@ -54,11 +54,12 @@
>  #define REFCLOCK_MHz				(stv6110x->config->refclk / 1000000)
>  
>  struct stv6110x_state {
> +	struct dvb_frontend		*frontend;
>  	struct i2c_adapter		*i2c;
>  	const struct stv6110x_config	*config;
>  	u8				regs[8];

Perhaps this 8 should be a define?


