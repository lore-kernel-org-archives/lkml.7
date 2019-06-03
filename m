Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEDC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5BB2728F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559579920;
	bh=do4LaCsAOPTd/xXZSnOPF8r9lTDiUPMdRTL2m5faea4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lU9CGa2YM2tMyNlNg0L7t2K43C2mlHUW6/3XcTZjV5iWdQhzIaC2W+J4VZxhvgGHA
	 AaTBqZRiRicHrgqdmwhfAtCly3aIigKtyz8dzMmUqaIPxwqXE/iBst8R5zczKEVIeU
	 NN4DPjafAcVRylkBsTwcvr7TQzqQIMieI1LdKMhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfFCQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfFCQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:38:39 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BDD27290;
        Mon,  3 Jun 2019 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559579918;
        bh=do4LaCsAOPTd/xXZSnOPF8r9lTDiUPMdRTL2m5faea4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N70PghegSq3Sp1SpJr7jbTVhVknam2TQYZJLQdRm/w1+/4RPG1PxDgq1Ptja8yWvF
         O1Ek+RuJtu16YFsjFU//VyeEJQuMr6cbSPNwAg+o7/wAr9/lKPeAlxbfho7HgfcxhT
         Jsr+Sz0rNPsWOBm0Bz3ZtMK9Rr9pNLnl1Sp5D3RQ=
Received: by mail-wm1-f44.google.com with SMTP id c6so8865091wml.0;
        Mon, 03 Jun 2019 09:38:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWIkHekPIgTOVk5h3xpAdE0+XFEhWZ3I6ZPgN4P2byVda6Ku/oJ
        zAtDX9MrAVpHJN8SQHEfaa0SmvbbyAiauFCdw1I=
X-Google-Smtp-Source: APXvYqy25ZyORC+P1JYMxi3NB1dbh9LoPrE65NBWSWqDalu0KCqhu02yb8Ru6YZLqwSu8cBe8X729wUELaCmuy0rqT8=
X-Received: by 2002:a1c:c545:: with SMTP id v66mr3207828wmf.51.1559579916334;
 Mon, 03 Jun 2019 09:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190520080421.12575-1-wens@kernel.org> <20190520090327.iejd3q7c3iwomzlz@flea>
In-Reply-To: <20190520090327.iejd3q7c3iwomzlz@flea>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 4 Jun 2019 00:38:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VnzXv1-fDDM1bBFWEH7NZp=s5Uw3qRP05WiDvbyqVJA@mail.gmail.com>
Message-ID: <CAGb2v64VnzXv1-fDDM1bBFWEH7NZp=s5Uw3qRP05WiDvbyqVJA@mail.gmail.com>
Subject: Re: [PATCH 00/25] clk: sunxi-ng: clk parent rewrite part 1
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 20, 2019 at 5:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, May 20, 2019 at 04:03:56PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi everyone,
> >
> > This is series is the first part of a large series (I haven't done the
> > rest) of patches to rewrite the clk parent relationship handling within
> > the sunxi-ng clk driver. This is based on Stephen's recent work allowing
> > clk drivers to specify clk parents using struct clk_hw * or parsing DT
> > phandles in the clk node.
> >
> > This series can be split into a few major parts:
> >
> > 1) The first patch is a small fix for clk debugfs representation. This
> >    was done before commit 1a079560b145 ("clk: Cache core in
> >    clk_fetch_parent_index() without names") was posted, so it might or
> >    might not be needed. Found this when checking my work using
> >    clk_possible_parents.
> >
> > 2) A bunch of CLK_HW_INIT_* helper macros are added. These cover the
> >    situations I encountered, or assume I will encounter, such as single
> >    internal (struct clk_hw *) parent, single DT (struct clk_parent_data
> >    .fw_name), multiple internal parents, and multiple mixed (internal +
> >    DT) parents. A special variant for just an internal single parent is
> >    added, CLK_HW_INIT_HWS, which lets the driver share the singular
> >    list, instead of having the compiler create a compound literal every
> >    time. It might even make sense to only keep this variant.
> >
> > 3) A bunch of CLK_FIXED_FACTOR_* helper macros are added. The rationale
> >    is the same as the single parent CLK_HW_INIT_* helpers.
> >
> > 4) Bulk conversion of CLK_FIXED_FACTOR to use local parent references,
> >    either struct clk_hw * or DT .fw_name types, whichever the hardware
> >    requires.
> >
> > 5) The beginning of SUNXI_CCU_GATE conversion to local parent
> >    references. This part is not done. They are included as justification
> >    and examples for the shared list of clk parents case.
>
> That series is pretty neat. As far as sunxi is concerned, you can add my
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> > I realize this is going to be many patches every time I convert a clock
> > type. Going forward would the people involved prefer I send out
> > individual patches like this series, or squash them all together?
>
> For bisection, I guess it would be good to keep the approach you've
> had in this series. If this is really too much, I guess we can always
> change oru mind later on.

Any thoughts on this series and how to proceed?

Thanks
ChenYu
