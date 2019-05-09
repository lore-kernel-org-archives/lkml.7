Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32FC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2D221744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:02:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50696 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfEIJC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:02:28 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hOewa-00026i-Bs; Thu, 09 May 2019 11:02:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 02/16] treewide: rename match_string() -> __match_string()
Date:   Thu, 09 May 2019 11:02:23 +0200
Message-ID: <7309540.OPNIuQxnsW@phil>
In-Reply-To: <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com> <20190508112842.11654-4-alexandru.ardelean@analog.com> <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Mai 2019, 19:00:06 CEST schrieb Stephen Boyd:
> (Trimming the lists but keeping lkml)
> 
> Quoting Alexandru Ardelean (2019-05-08 04:28:28)
> > This change does a rename of match_string() -> __match_string().
> > 
> > There are a few parts to the intention here (with this change):
> > 1. Align with sysfs_match_string()/__sysfs_match_string()
> > 2. This helps to group users of `match_string()` into simple users:
> >    a. those that use ARRAY_SIZE(_a) to specify the number of elements
> >    b. those that use -1 to pass a NULL terminated array of strings
> >    c. special users, which (after eliminating 1 & 2) are not that many
> > 3. The final intent is to fix match_string()/__match_string() which is
> >    slightly broken, in the sense that passing -1 or a positive value does
> >    not make any difference: the iteration will stop at the first NULL
> >    element.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> [...]
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 96053a96fe2f..0b6c3d300411 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2305,8 +2305,8 @@ bool clk_has_parent(struct clk *clk, struct clk *parent)
> >         if (core->parent == parent_core)
> >                 return true;
> >  
> > -       return match_string(core->parent_names, core->num_parents,
> > -                           parent_core->name) >= 0;
> > +       return __match_string(core->parent_names, core->num_parents,
> > +                             parent_core->name) >= 0;
> 
> This is essentially ARRAY_SIZE(core->parent_names) so it should be fine
> to put this back to match_string() later in the series.
> 
> >  }
> >  EXPORT_SYMBOL_GPL(clk_has_parent);
> >  
> > diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> > index c3ad92965823..373f13e9cd83 100644
> > --- a/drivers/clk/rockchip/clk.c
> > +++ b/drivers/clk/rockchip/clk.c
> > @@ -276,8 +276,8 @@ static struct clk *rockchip_clk_register_frac_branch(
> >                 struct clk *mux_clk;
> >                 int ret;
> >  
> > -               frac->mux_frac_idx = match_string(child->parent_names,
> > -                                                 child->num_parents, name);
> > +               frac->mux_frac_idx = __match_string(child->parent_names,
> > +                                                   child->num_parents, name);
> 
> I suspect this is the same as above, but Heiko can ack/confirm.

Right now, clock-driver do carry the parent_names in static arrays,
but that isn't necessarily guaranteed. So only in the driver declaring
the array do we use ARRAY_SIZE to determine the number of elements
(from inside the helper-macros in drivers/clk/rockchip/clk.h), but the
rest of the code does explicitly carry around the real number of elements
so later clocks could in theory also do that dynamically.


Heiko


