Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673FC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029C1218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGYTt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:49:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39252 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGYTt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:49:57 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqjkO-0001oe-Bz; Thu, 25 Jul 2019 21:49:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>, mturquette@baylibre.com,
        sboyd@kernel.org, andy.yan@rock-chips.com,
        zhangqing@rock-chips.com, linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] clk: rockchip: Fix -Wunused-const-variable
Date:   Thu, 25 Jul 2019 21:49:51 +0200
Message-ID: <1978058.CBpQlN27Fr@phil>
In-Reply-To: <CAKwvOd=RhoKvXzuGVe0PaQik8NEFhDkxuwv-T_s6KAtXCDVVvg@mail.gmail.com>
References: <20190627222220.89175-1-nhuck@google.com> <CAKwvOd=RhoKvXzuGVe0PaQik8NEFhDkxuwv-T_s6KAtXCDVVvg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Juni 2019, 00:32:38 CEST schrieb Nick Desaulniers:
> On Thu, Jun 27, 2019 at 3:22 PM 'Nathan Huckleberry' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Clang produces the following warning
> >
> > drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
> > 'mux_pll_src_3plls_p' [-Wunused-const-variable]
> > PNAME(mux_pll_src_3plls_p)      = { "apll", "gpll", "dpll" };
> >
> > Looks like this variable was never used. Deleting it to remove the
> > warning.
> 
> Indeed, looks like it was dead when introduced in:
> commit e44dde279492 ("clk: rockchip: add clock controller for rk1108")
> 
> I don't see a pattern between when mux_pll_src_4plls_p vs
> mux_pll_src_2plls_p is used, so it's not clear where or even if
> mux_pll_src_3plls_p should be used.

The possible sources for a clock really differ often, so there is no general
rule on when to use which sources ... except looking it up in the soc
manual. And I guess any possible conflict will turn up when someone
wants to use a clock that currently may reference the wrong sources.


