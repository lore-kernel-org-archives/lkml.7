Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0D22184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="eAkzqdRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfHSCEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:04:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41351 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSCEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:04:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id i4so309435qtj.8;
        Sun, 18 Aug 2019 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdqGTZilsvAWJPaR0r/39oQNhzP+xm4M+Hqj2f46Le4=;
        b=eAkzqdRHxj7xl3kdMzG92M7hwnZCYFCErUC8N9g4vwMUz9x7GxI8gB6LRTI7evg9r7
         GxsfBoyyVf9vAUgqjNSxcW/qJZySMptuMHbrE2T1o6VOrFU0Z0z+5aGIgMSQM9pKFObO
         5dQU4vqa82LdalDmFhWSJIc8Eiw5uU/RjebCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdqGTZilsvAWJPaR0r/39oQNhzP+xm4M+Hqj2f46Le4=;
        b=jNC9iApJGl8HyAkpiYe2tK13qC9VI3byyxOkZuJZXalbuGS9Cw4/ormE243eDwrCMg
         B0H+sl2Z/NblPfjyP1JXnIYNPk/1VT/d1Q+MO8QxZRdDXvyoWHsIGeNNf7QjVhuuTb9H
         zXnVU2ld6cvMI8MTJB9ecYnMKm1bVgDSv2bfjuMKF7mMAhOn2B3ZXccehBtc/MOx0DXV
         qGGYMgjxQbymjSRG7u0EMOc/WDx5lRNMl4qStZ6i51WNmxDMWGsOwsMXOfOqz0iuPxI/
         c1w8kJXh/R7HToqkg7nrzkHQ4DkcxiVo/2XjZENK4Pbc2HXCJMXKmT03zgOuHwMo8HbR
         j0tA==
X-Gm-Message-State: APjAAAVd1MbKO21BrIrXIGBbctbdvgBCjs56XCEPRzsRSTntoJ75fLcD
        3b1ZXgF0pb1muRQlDQs9xlr+Okj337I0/jbTJiw=
X-Google-Smtp-Source: APXvYqwaqW1bDbSfWZoN/blgOOuB7rbNcyl7kFtP95yF52dZJtwbw4h7rCAX8fzCnG8TYPmCF1JZE9109RjBT+A7qVI=
X-Received: by 2002:ac8:24b4:: with SMTP id s49mr18690956qts.255.1566180246129;
 Sun, 18 Aug 2019 19:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190816155806.22869-1-joel@jms.id.au> <20190816155806.22869-3-joel@jms.id.au>
 <20190816171441.3B8F720665@mail.kernel.org>
In-Reply-To: <20190816171441.3B8F720665@mail.kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Aug 2019 02:03:54 +0000
Message-ID: <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: Add support for AST2600 SoC
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 at 17:14, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Joel Stanley (2019-08-16 08:58:06)
> > diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> > new file mode 100644
> > index 000000000000..083d5299238c
> > --- /dev/null
> > +++ b/drivers/clk/clk-ast2600.c
> > @@ -0,0 +1,701 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright IBM Corp
> > +// Copyright ASPEED Technology
> > +
> [...]
> > +#define ASPEED_DPLL_PARAM              0x260
> > +
> > +#define ASPEED_G6_STRAP1               0x500
> > +
> > +/* Globally visible clocks */
> > +static DEFINE_SPINLOCK(aspeed_clk_lock);
>
> I guess we can be guaranteed that the two drivers aren't compiled into
> the same image? Otherwise this will alias with clk-aspeed.c and make
> kallsyms annoying to use.

I will change the name.

>
> > +
> > +/* Keeps track of all clocks */
> > +static struct clk_hw_onecell_data *aspeed_g6_clk_data;
> > +
> > +static void __iomem *scu_g6_base;
> > +
> > +static const struct aspeed_gate_data aspeed_g6_gates[] = {
> > +       /*                                  clk rst  name               parent   flags */
> > +       [ASPEED_CLK_GATE_MCLK]          = {  0, -1, "mclk-gate",        "mpll",  CLK_IS_CRITICAL }, /* SDRAM */
>
> Please document CLK_IS_CRITICAL usage. I guess it's memory so never turn
> it off?

Yes.

I added some comments and removed some uses that I didn't know the
reason for. We can add them back later if required, with the
reasoning.

> > +static const char * const vclk_parent_names[] = {
>
> Can you use the new way of specifying clk parents instead of just using
> strings?

How does this work? I had a browse of the APIs in clk-provider.h and
it appeared the functions all take char *s still.

> > +       hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, axi_div * ahb_div);
>
> There aren't checks for if these things fail. I guess it doesn't matter
> and just let it fail hard?

I think that's sensible here. If the system has run out of memory this
early on then there's not going to be much that works.

Thanks for the review. I've fixed all of the style issues you
mentioned, but would appreciate some guidance on the parent API.

Cheers,

Joel
