Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25301C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDKKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:39:33 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:38411 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfDKKjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:39:32 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 8FEF75C29C8; Thu, 11 Apr 2019 12:38:44 +0200 (CEST)
Date:   Thu, 11 Apr 2019 12:38:44 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Nicholas Mc Guire <hofrat@opentech.at>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] clk: ux500: add range to usleep_range
Message-ID: <20190411103844.GA8267@osadl.at>
References: <1554606804-29453-1-git-send-email-hofrat@opentech.at>
 <CAPDyKFp2yC88O3q6kO+tNVwzkJVySQW7PA0Cm5xjHEX31x275w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFp2yC88O3q6kO+tNVwzkJVySQW7PA0Cm5xjHEX31x275w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:36:45AM +0200, Ulf Hansson wrote:
> On Sun, 7 Apr 2019 at 05:13, Nicholas Mc Guire <hofrat@opentech.at> wrote:
> >
> > Providing a range for usleep_range() allows the hrtimer subsystem to
> > coalesce timers - the delay is runtime configurable so a factor 2
> > is taken to provide the range.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
> > ---
> >
> > Problem located with an experimental coccinelle script
> >
> > Q: Basically usleep_range() with min == max never makes much sense notably
> >    in non-atomic context. If the factor of 2 is tolerable or a fixed
> >    offset of e.g. 1000 would be more suitable is not clear to me - maybe
> >    someone familiar with that driver can clarify this.
> >
> > Patch was compile tested with: u8500_defconfig (implies COMMON_CLK=y)
> > (with some sparse warnings about not implemented system calls)
> >
> > Patch is against 5.1-rc3 (localversion-next is next=20190405)
> >
> >  drivers/clk/ux500/clk-sysctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> > index 7c0403b..a1fa3fb 100644
> > --- a/drivers/clk/ux500/clk-sysctrl.c
> > +++ b/drivers/clk/ux500/clk-sysctrl.c
> > @@ -42,7 +42,7 @@ static int clk_sysctrl_prepare(struct clk_hw *hw)
> >                                 clk->reg_bits[0]);
> >
> >         if (!ret && clk->enable_delay_us)
> > -               usleep_range(clk->enable_delay_us, clk->enable_delay_us);
> > +               usleep_range(clk->enable_delay_us, clk->enable_delay_us*2);
> 
> The range being used is actually in ms, so not sure we actually need
> to double it for the range.
> 
> How about adding ~25% instead, along the lines of below:
> usleep_range(clk->enable_delay_us, clk->enable_delay_us +
> (clk->enable_delay_us >> 2));
>
that would be perfectly sufficient for hrtimers - if the range is
in ms - so I´ll send out a V2 shortly.

thx!
hofrat 
