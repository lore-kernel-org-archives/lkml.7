Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058AC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA1820644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfETJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:03:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51373 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfETJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:03:32 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 89B0960010;
        Mon, 20 May 2019 09:03:27 +0000 (UTC)
Date:   Mon, 20 May 2019 11:03:27 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] clk: sunxi-ng: clk parent rewrite part 1
Message-ID: <20190520090327.iejd3q7c3iwomzlz@flea>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ypype76y25ofynl"
Content-Disposition: inline
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ypype76y25ofynl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:03:56PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> This is series is the first part of a large series (I haven't done the
> rest) of patches to rewrite the clk parent relationship handling within
> the sunxi-ng clk driver. This is based on Stephen's recent work allowing
> clk drivers to specify clk parents using struct clk_hw * or parsing DT
> phandles in the clk node.
>
> This series can be split into a few major parts:
>
> 1) The first patch is a small fix for clk debugfs representation. This
>    was done before commit 1a079560b145 ("clk: Cache core in
>    clk_fetch_parent_index() without names") was posted, so it might or
>    might not be needed. Found this when checking my work using
>    clk_possible_parents.
>
> 2) A bunch of CLK_HW_INIT_* helper macros are added. These cover the
>    situations I encountered, or assume I will encounter, such as single
>    internal (struct clk_hw *) parent, single DT (struct clk_parent_data
>    .fw_name), multiple internal parents, and multiple mixed (internal +
>    DT) parents. A special variant for just an internal single parent is
>    added, CLK_HW_INIT_HWS, which lets the driver share the singular
>    list, instead of having the compiler create a compound literal every
>    time. It might even make sense to only keep this variant.
>
> 3) A bunch of CLK_FIXED_FACTOR_* helper macros are added. The rationale
>    is the same as the single parent CLK_HW_INIT_* helpers.
>
> 4) Bulk conversion of CLK_FIXED_FACTOR to use local parent references,
>    either struct clk_hw * or DT .fw_name types, whichever the hardware
>    requires.
>
> 5) The beginning of SUNXI_CCU_GATE conversion to local parent
>    references. This part is not done. They are included as justification
>    and examples for the shared list of clk parents case.

That series is pretty neat. As far as sunxi is concerned, you can add my
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> I realize this is going to be many patches every time I convert a clock
> type. Going forward would the people involved prefer I send out
> individual patches like this series, or squash them all together?

For bisection, I guess it would be good to keep the approach you've
had in this series. If this is really too much, I guess we can always
change oru mind later on.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2ypype76y25ofynl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOJtXgAKCRDj7w1vZxhR
xQfkAQDQX2OO7NWM6Uc/mv7S2HQgLu755CMRobYRqL6EDMn5twD/WlNMYOlQibvH
Kk0T6Z3CVuTDEoh9v+fpo5OUWhc1qw4=
=G/SF
-----END PGP SIGNATURE-----

--2ypype76y25ofynl--
