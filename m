Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91BAC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9573A21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577958339;
	bh=pFQfRfXztEXOH5foxPF7dzTzYmSabPmRdx1wkI4s8tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1VaZknf+unacbCEVcJJbXQvMMM2ZzRK13FQntGx/LNLUMhXOqQyLMdjsdePEreTJ1
	 xqfiT7vVa/GjlTfGTedjxmiskUGMNvX9Od3d9vDf8P5s4BWg8SYZMmS3DbADzcAKFM
	 afBBKTnPiSaC3Ar8Ajx2GGv+Ja++ZxDO16qXEn70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgABJpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgABJpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:45:36 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023262085B;
        Thu,  2 Jan 2020 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577958335;
        bh=pFQfRfXztEXOH5foxPF7dzTzYmSabPmRdx1wkI4s8tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJqjjjmv5K/NBn2bnJhXsWfZClg3JIz2UGiUSyDvSy3ZcqyrK/N0pe2dZ8+JPjI/N
         PBDdvt/naiZaY10T1FCDHHN3o+R8V/bnQBW+RBHa1i9jJhSFrN4SuPVmR2xfrMgVzh
         NgoJJ3dg/EQw7sol1AyrTc1PRF9L2iJYtMKT5D9I=
Date:   Thu, 2 Jan 2020 10:45:32 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] clk: Implement protected-clocks for all OF clock
 providers
Message-ID: <20200102094532.jhgqe6cj4dvronig@gilmour.lan>
References: <20191230193127.8803-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="utzsvzqdwq2morkc"
Content-Disposition: inline
In-Reply-To: <20191230193127.8803-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utzsvzqdwq2morkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

(Thanks for that good commit log)

On Mon, Dec 30, 2019 at 01:31:27PM -0600, Samuel Holland wrote:
> This is a generic implementation of the "protected-clocks" property from
> the common clock binding. It comes with some caveats:
>
> 1) Clocks that have CLK_IS_CRITICAL in their init data are prepared/
> enabled before they are attached to the clock tree. protected-clocks are
> only protected once the clock provider is added, which is generally
> after all of the clocks it provides have been registered. This leaves a
> window of opportunity where something could disable or modify the clock,
> such as a driver running on another CPU, or the clock core itself. There
> is a comment to this effect in __clk_core_init():
>
>   /*
>    * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>    * don't get accidentally disabled when walking the orphan tree and
>    * reparenting clocks
>    */
>
> Similarly, these clocks will be enabled after they are first reparented,
> unlike other CLK_IS_CRITICAL clocks. See the comment in
> clk_core_reparent_orphans_nolock():
>
>   /*
>    * We need to use __clk_set_parent_before() and _after() to
>    * to properly migrate any prepare/enable count of the orphan
>    * clock. This is important for CLK_IS_CRITICAL clocks, which
>    * are enabled during init but might not have a parent yet.
>    */
>
> Ideally we could detect protected clocks before they are reparented, but
> there are two problems with that:
>
>   i)  From the clock core's perspective, hw->init is const.
>
>   ii) The clock core doesn't see the device_node until __clk_register is
>       called on the first clock.
>
> So the only race-free way to detect protected-clocks is to do it in the
> middle of __clk_register, between when core->flags is initialized and
> calling __clk_core_init(). That requires scanning the device tree again
> for each clock, which is part of why I didn't do it that way.
>
> 2) __clk_protect needs to be idempotent, for two reasons:
>
>   i)  Clocks with CLK_IS_CRITICAL in their init data are already
>       prepared/enabled, and we don't want to prepare/enable them again.
>       Note that if the clock did not have CLK_SET_RATE_GATE in its init
>       data, it was *not* rate protected during the initial call to
>       clk_core_prepare().  As far as I can tell, none of the other flags
>       affect the internal state of the clock, so they don't need any
>       "parallel reconstruction".
>
>   ii) of_clk_set_defaults() is called twice for (at least some) clock
>       controllers registered with CLK_OF_DECLARE. It is called first in
>       of_clk_add_provider()/of_clk_add_hw_provider() inside clk_init_cb,
>       and again afterward in of_clk_init(). I think that the second call
>       in of_clk_init() should be removed, but that would require
>       auditing all users of CLK_OF_DECLARE to ensure they called one of
>       the of_clk_add{,_hw}_provider functions.
>
> 3) It is not clear specifically which flags should be implied by being
> in protected-clocks. I took it to mean "this clock is outside of OS
> control, so don't modify it, and assume it can change at any time".
>
> For that reason, I added the following flags:
>   - CLK_SET_RATE_GATE: prevents clk_set_rate() once prepared
>   - CLK_SET_PARENT_GATE: prevents clk_set_parent() once prepared

I'm not sure the reasoning about the fact that the clock is outside of
OS control and therefore cannot change rate is correct.

Using crust as an example, if you were to all the PRCM clocks handling
code in it, you would have already a number of cases where we would
need to change the rate. I2C bus rate and IR comes to my mind. CPUFreq
is another common example of a setup where the clock itself is outside
of the OS control, but still the OS initiates the rate change.

The RPi also has a PLL to control the whole display block that needs
to be configured depending on the resolution being displayed (and
other things), and is handled by the videocore firmware.

Of course, once the OS has asked for that new rate, the firmware is
entirely free to ignore it as long as it's properly reported to the
clock framework. But completely disabling the rates changes seems a
bit overkill.

>   - CLK_GET_RATE_NOCACHE: allows the rate to change behind the OS's back
>   - CLK_GET_ACCURACY_NOCACHE: ditto for the accuracy

So I was part of the discussions of the protected-clocks stuff a few
years ago and IIRC the discussions were only about the OS not
disabling the clocks.

I guess the arguments are sound though, but at the same time it's
pretty easy (and cheap) to do it at the driver level, and that would
make sense too. So I don't really know what to think here :)

Thanks for starting that discussion!
Maxime

--utzsvzqdwq2morkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg27vAAKCRDj7w1vZxhR
xb5VAQCXGpScw6S6VBLVmiyEvcirMgplwPMbVZNVMiraKWHvuAEAri+JFn6KyE9k
7tBQ75kGQD2q8mUlVMY1jlwjAQ3DzQY=
=dt2M
-----END PGP SIGNATURE-----

--utzsvzqdwq2morkc--
