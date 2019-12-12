Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB2D206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GhgvB6ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfLLOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:18:05 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59414 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfLLOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sLQKwGit9wLSgboUFNJSj0UuCKgTnkxAwBeCTVETGRM=; b=GhgvB6chdyHnUTDYNs015+Il8
        ODfPi+ysABPUR4KShO40i06LpIl6SBFQORMDqrMTR2tk5o9ZI4455WH50RipoykJ1xN3AByQhnkoY
        dK1yzNt/9Cm8gLK5xHxLNl9YrHfV11g+xYZc5E+Wdvq8tOtiJ95XTSBZjhbWdPWrdT1wAYh7wmQG3
        VPtn/nhGUpV8RfBYROZuyzUlnJqqLnN67O6ObAMclAoC6p/SvxZbtn9G51pm6njYYhfJzBIVFiFfH
        w6nnd0FpE80ItbAT2Lw49ekjdFa7nK5rR0F+0ojdBOAKnMwyMA4etvo75JUcURB7dc/eHzZiMMXCA
        Jyx/ehTkw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40348)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ifPHr-000791-JH; Thu, 12 Dec 2019 14:17:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ifPHn-0006sN-Ar; Thu, 12 Dec 2019 14:17:47 +0000
Date:   Thu, 12 Dec 2019 14:17:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191212141747.GI25745@shell.armlinux.org.uk>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga>
 <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:53:40PM +0100, Marc Gonzalez wrote:
> On 11/12/2019 23:28, Dmitry Torokhov wrote:
> 
> > On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
> >
> >> What is the rationale for the devm_add_action API?
> > 
> > For one-off and maybe complex unwind actions in drivers that wish to use
> > devm API (as mixing devm and manual release is verboten). Also is often
> > used when some core subsystem does not provide enough devm APIs.
> 
> Thanks for the insight, Dmitry. Thanks to Robin too.
> 
> This is what I understand so far:
> 
> devm_add_action() is nice because it hides/factorizes the complexity
> of the devres API, but it incurs a small storage overhead of one
> pointer per call, which makes it unfit for frequently used actions,
> such as clk_get.
> 
> Is that correct?
> 
> My question is: why not design the API without the small overhead?
> 
> Proof of concept below:
> 
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 0bbb328bd17f..76392dd6273b 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
>  }
>  EXPORT_SYMBOL_GPL(devres_release_group);
>  
> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> +{
> +	void *data = devres_alloc(func, size, GFP_KERNEL);
> +
> +	if (data) {
> +		memcpy(data, arg, size);
> +		devres_add(dev, data);
> +	} else
> +		func(dev, arg);
> +
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(devm_add);
> +
>  /*
>   * Custom devres actions allow inserting a simple function call
>   * into the teadown sequence.
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index be160764911b..8db671823126 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -4,6 +4,11 @@
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  
> +static void __clk_put(struct device *dev, void *data)
> +{
> +	clk_put(*(struct clk **)data);
> +}
> +
>  static void devm_clk_release(struct device *dev, void *res)
>  {
>  	clk_put(*(struct clk **)res);
> @@ -11,19 +16,11 @@ static void devm_clk_release(struct device *dev, void *res)
>  
>  struct clk *devm_clk_get(struct device *dev, const char *id)
>  {
> -	struct clk **ptr, *clk;
> -
> -	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct clk *clk = clk_get(dev, id);
>  
> -	clk = clk_get(dev, id);
> -	if (!IS_ERR(clk)) {
> -		*ptr = clk;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (!IS_ERR(clk))
> +		if (!devm_add(dev, __clk_put, &clk, sizeof(clk)))
> +			clk = ERR_PTR(-ENOMEM);

You leak clk here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
