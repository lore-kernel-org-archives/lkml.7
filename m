Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697B5C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01E20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfLOKwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 05:52:00 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51337 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfLOKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 05:51:59 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2EAAD240003;
        Sun, 15 Dec 2019 10:51:55 +0000 (UTC)
Date:   Sun, 15 Dec 2019 12:00:20 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: pll: Fix by 0 division in
 __pll_params_to_rate()
Message-ID: <20191215110020.GA7304@voidbox>
References: <20191208212206.16808-1-repk@triplefau.lt>
 <1jo8whesj2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jo8whesj2.fsf@starbuckisacylon.baylibre.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:51:13AM +0100, Jerome Brunet wrote:
> 
> On Sun 08 Dec 2019 at 22:22, Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > Some meson pll registers can be initialized with 0 as N value, introducing
> > the following division by 0 when computing rate :
> >
> >   UBSAN: Undefined behaviour in drivers/clk/meson/clk-pll.c:75:9
> >   division by zero
> >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc3-608075-g86c9af8630e1-dirty #400
> >   Call trace:
> >    dump_backtrace+0x0/0x1c0
> >    show_stack+0x14/0x20
> >    dump_stack+0xc4/0x100
> >    ubsan_epilogue+0x14/0x68
> >    __ubsan_handle_divrem_overflow+0x98/0xb8
> >    __pll_params_to_rate+0xdc/0x140
> >    meson_clk_pll_recalc_rate+0x278/0x3a0
> >    __clk_register+0x7c8/0xbb0
> >    devm_clk_hw_register+0x54/0xc0
> >    meson_eeclkc_probe+0xf4/0x1a0
> >    platform_drv_probe+0x54/0xd8
> >    really_probe+0x16c/0x438
> >    driver_probe_device+0xb0/0xf0
> >    device_driver_attach+0x94/0xa0
> >    __driver_attach+0x70/0x108
> >    bus_for_each_dev+0xd8/0x128
> >    driver_attach+0x30/0x40
> >    bus_add_driver+0x1b0/0x2d8
> >    driver_register+0xbc/0x1d0
> >    __platform_driver_register+0x78/0x88
> >    axg_driver_init+0x18/0x20
> >    do_one_initcall+0xc8/0x24c
> >    kernel_init_freeable+0x2b0/0x344
> >    kernel_init+0x10/0x128
> >    ret_from_fork+0x10/0x18
> >
> > This checks if N is null before doing the division.
> 
> Thanks for reporting this
> 
> >
> > Fixes: 8289aafa4f36 ("clk: meson: improve pll driver results with
> > frac")
> 
> In mainline, the commit above went in with sha1 3c4fe763d64d.
> 
> Also, this commit is not really responsible for the problem. Having HW
> initialized with N = 0 would have failed since the beginning, I believe.
> 
> In this case the correct fixes would be:
> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
> 
> 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  drivers/clk/meson/clk-pll.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> > index ddb1e5634739..6649659f216a 100644
> > --- a/drivers/clk/meson/clk-pll.c
> > +++ b/drivers/clk/meson/clk-pll.c
> > @@ -66,6 +66,10 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
> >  					 (1 << pll->frac.width));
> >  	}
> >  
> > +	/* Avoid by zero division */
> > +	if (n == 0)
> > +		return 0;
> 
> This can only really happen after init, in recalc() rate.
> 
> I would much prefer if you could check the n value right after it is
> read (meson_parm_read()) in .recalc_rate() and add a comment explaining
> that some HW may have this parameter set 0 on init.
> 

Sure will do.

Thanks for reviewing this.

-- 
Remi

> > +
> >  	return DIV_ROUND_UP_ULL(rate, n);
> >  }
> 
