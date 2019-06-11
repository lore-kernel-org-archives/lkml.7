Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A07AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F4120896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560231283;
	bh=xeIfb6Sa8fR5KV0lFC7utDBMZgDzjP9QTSwAJEd5VM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wIa971mXz791W1t39xwwCI0+zXKea+WgrBGmtb2O5J9mhJO0BaipjgfynVQKzI7ju
	 K+Bpqi7kUG/0XM2Gwpmb4k3mL2KszIHKIf3MW67gpJ2GdBN2ypdezg+/FAay9N1ODd
	 SVrJMc76cZnSM813T9QYpDb5mhhmcxpOFiR3S/Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbfFKFem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390492AbfFKFel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:34:41 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428E1212F5;
        Tue, 11 Jun 2019 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560231280;
        bh=xeIfb6Sa8fR5KV0lFC7utDBMZgDzjP9QTSwAJEd5VM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mD8CoED0taYtnsyHoi8+sE6VqobrS/wTnxOvcfGtd8Z4CadjNhE3/P1zZcyAXUa7d
         KQ4xvmmc+vCHnMlfXzwxbPovJve68U+aybhiZO/IGwW2La/UVdQFWXa/uDRHpvGDbc
         z7ZVTwmXgl1oNDt75OU3DyGVIvlh6+eF7eBDK4bQ=
Received: by mail-wr1-f54.google.com with SMTP id p11so11415272wre.7;
        Mon, 10 Jun 2019 22:34:40 -0700 (PDT)
X-Gm-Message-State: APjAAAU/42/NqxPZkxo8uL2mW+GcKmsJgx3OU96YBHPGTzZ7DovekAzf
        A6+s9HrnKJXpYWcVGI/BK7g3JBbpDznJFtpfgDg=
X-Google-Smtp-Source: APXvYqwv/LNlXWtcpF7Lorp2/yNYqYQ6FH2ipCH0ThQ3EW8WsmPijvPvzW5pI5PspawGCO4bJWuXFG5nwsKrLw2n/DE=
X-Received: by 2002:adf:f946:: with SMTP id q6mr27730732wrr.109.1560231278797;
 Mon, 10 Jun 2019 22:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190520080421.12575-1-wens@kernel.org> <20190520090327.iejd3q7c3iwomzlz@flea>
 <CAGb2v64VnzXv1-fDDM1bBFWEH7NZp=s5Uw3qRP05WiDvbyqVJA@mail.gmail.com> <20190607184621.D5C3F212F5@mail.kernel.org>
In-Reply-To: <20190607184621.D5C3F212F5@mail.kernel.org>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 11 Jun 2019 13:34:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Y8u=EGfrgs5Km8tiT7QYiJpf8LTJH1QnVrDmPPRng8A@mail.gmail.com>
Message-ID: <CAGb2v65Y8u=EGfrgs5Km8tiT7QYiJpf8LTJH1QnVrDmPPRng8A@mail.gmail.com>
Subject: Re: [PATCH 00/25] clk: sunxi-ng: clk parent rewrite part 1
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 8, 2019 at 2:46 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chen-Yu Tsai (2019-06-03 09:38:22)
> > Hi Stephen,
> >
> > On Mon, May 20, 2019 at 5:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, May 20, 2019 at 04:03:56PM +0800, Chen-Yu Tsai wrote:
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > Hi everyone,
> > > >
> > > > This is series is the first part of a large series (I haven't done the
> > > > rest) of patches to rewrite the clk parent relationship handling within
> > > > the sunxi-ng clk driver. This is based on Stephen's recent work allowing
> > > > clk drivers to specify clk parents using struct clk_hw * or parsing DT
> > > > phandles in the clk node.
> > > >
> > > > This series can be split into a few major parts:
> > > >
> > > > 1) The first patch is a small fix for clk debugfs representation. This
> > > >    was done before commit 1a079560b145 ("clk: Cache core in
> > > >    clk_fetch_parent_index() without names") was posted, so it might or
> > > >    might not be needed. Found this when checking my work using
> > > >    clk_possible_parents.
> > > >
> > > > 2) A bunch of CLK_HW_INIT_* helper macros are added. These cover the
> > > >    situations I encountered, or assume I will encounter, such as single
> > > >    internal (struct clk_hw *) parent, single DT (struct clk_parent_data
> > > >    .fw_name), multiple internal parents, and multiple mixed (internal +
> > > >    DT) parents. A special variant for just an internal single parent is
> > > >    added, CLK_HW_INIT_HWS, which lets the driver share the singular
> > > >    list, instead of having the compiler create a compound literal every
> > > >    time. It might even make sense to only keep this variant.
> > > >
> > > > 3) A bunch of CLK_FIXED_FACTOR_* helper macros are added. The rationale
> > > >    is the same as the single parent CLK_HW_INIT_* helpers.
> > > >
> > > > 4) Bulk conversion of CLK_FIXED_FACTOR to use local parent references,
> > > >    either struct clk_hw * or DT .fw_name types, whichever the hardware
> > > >    requires.
> > > >
> > > > 5) The beginning of SUNXI_CCU_GATE conversion to local parent
> > > >    references. This part is not done. They are included as justification
> > > >    and examples for the shared list of clk parents case.
> > >
> > > That series is pretty neat. As far as sunxi is concerned, you can add my
> > > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > >
> > > > I realize this is going to be many patches every time I convert a clock
> > > > type. Going forward would the people involved prefer I send out
> > > > individual patches like this series, or squash them all together?
> > >
> > > For bisection, I guess it would be good to keep the approach you've
> > > had in this series. If this is really too much, I guess we can always
> > > change oru mind later on.
> >
> > Any thoughts on this series and how to proceed?
> >
>
> I have a few minor nitpicks but otherwise the series looks good to me.
> I'm perfectly happy to see the individual patches unless you want to
> squash them into one big patch. I can review the conversions either way.

OK. Based on your and Maxime's response, I'll send them individually.

> Did you need me to apply any patches here? Or can I assume you'll resend
> with a pull request so it can be merged into clk-next?

I can send them as part of our normal pull request. Or did you want this
as a separate topic?

I'll still send out a v2 to cover your review comments.

> BTW, did you have to update any DT bindings or documentation? I didn't
> see anything, so I'm a little surprised that all that stuff was already
> in place.

The bindings had the clocks / clock-names all defined, and the DT all had
the properties, because we had already gone through one rewrite. It's just
the driver didn't follow them properly, because the parents were cross
node / driver, and we had these statically initialized parent name arrays.

I had started work on having the driver rewrite the parents lists based on
fetching clock names via DT, but it was far from elegant. Then this came
up. :)


Regards
ChenYu
