Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D84C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968F20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfDWOki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:40:38 -0400
Received: from muru.com ([72.249.23.125]:46880 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDWOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:40:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6B78780AE;
        Tue, 23 Apr 2019 14:40:52 +0000 (UTC)
Date:   Tue, 23 Apr 2019 07:40:28 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>, broonie@kernel.org,
        enric.balletbo@collabora.com, guillaume.tucker@collabora.com,
        khilman@baylibre.com, matthew.hart@linaro.org,
        mgalka@collabora.com, tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
Message-ID: <20190423144028.GA8007@atomide.com>
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
 <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Boyd <sboyd@kernel.org> [691231 23:00]:
> Quoting kernelci.org bot (2019-04-22 17:16:44)
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > 
> > clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
> > 
> > Summary:
> >   Start:      a55b079c961b Merge branch 'clk-hisi' into clk-next
> >   Details:    https://kernelci.org/boot/id/5cbe3cdb59b514fd22fe6025
> >   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.txt
> >   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.html
> >   Result:     ecbf3f1795fd clk: fixed-factor: Let clk framework find parent
> > 
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> > 
> > Parameters:
> >   Tree:       clk
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
> >   Branch:     clk-next
> >   Target:     panda
> >   CPU arch:   arm
> >   Lab:        lab-baylibre
> >   Compiler:   gcc-7
> >   Config:     omap2plus_defconfig
> >   Test suite: boot
> > 
> > Breaking commit found:
> 
> Awesome! I LOVE IT!!!

This is great, thanks a lot!

Hmm do you guys have some index page of all the found "boot bisection"
issues that I can check every morning while drinking coffee? :)

> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > index 241b3f8c61a9..5b09f2cdb7de 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -64,12 +64,14 @@ const struct clk_ops clk_fixed_factor_ops = {
> >  };
> >  EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
> >  
> > -struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
> > -               const char *name, const char *parent_name, unsigned long flags,
> > -               unsigned int mult, unsigned int div)
> > +static struct clk_hw *
> > +__clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
> > +               const char *name, const char *parent_name, int index,
> > +               unsigned long flags, unsigned int mult, unsigned int div)
> >  {
> >         struct clk_fixed_factor *fix;
> >         struct clk_init_data init;
> > +       struct clk_parent_data pdata = { .index = index };
> >         struct clk_hw *hw;
> >         int ret;
> >  
> > @@ -85,11 +87,17 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
> >         init.name = name;
> >         init.ops = &clk_fixed_factor_ops;
> >         init.flags = flags | CLK_IS_BASIC;
> > -       init.parent_names = &parent_name;
> > +       if (parent_name)
> > +               init.parent_names = &parent_name;
> > +       else
> > +               init.parent_data = &pdata;
> 
> Ick. I realized that 'init.parent_names' here can be full of junk! Let's
> initialize it properly. Maybe that makes this all better?

Tested-by: Tony Lindgren <tony@atomide.com>

> ----8<----
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 5b09f2cdb7de..2d988a7585d5 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -70,7 +70,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
>  		unsigned long flags, unsigned int mult, unsigned int div)
>  {
>  	struct clk_fixed_factor *fix;
> -	struct clk_init_data init;
> +	struct clk_init_data init = { };
>  	struct clk_parent_data pdata = { .index = index };
>  	struct clk_hw *hw;
>  	int ret;
