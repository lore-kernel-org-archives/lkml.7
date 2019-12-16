Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507CCC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28616206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576504830;
	bh=jdFxBKgT93c3jWBHm8m4ZNJqE+g91z3/HhdnxSdPqNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sOgwQdAhjMOIe0AH5ZDwHcNaRwtWQpDeYft21ATbSV2iahIAqpLvlI2BEV8L1HtRm
	 OeKJqsbk53ICEcYnBJRTrz+5R8GTm70SmF+UdMqxq4uGiCH9RUdmpssESvWmQh0gZX
	 3SfAD9FA25MJrhtOZQB3hPR1kzOQdbfwQ/u3ZBeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfLPOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfLPOA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:00:29 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FF220684;
        Mon, 16 Dec 2019 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576504828;
        bh=jdFxBKgT93c3jWBHm8m4ZNJqE+g91z3/HhdnxSdPqNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MtKvPzn98o3Zde83TLKGVd+xDbArRelFftBwc4hJgoFOq4ZUxwNBRDKkPUuUB/9G
         c2GG1mAcpt/gchMK2fkzpckK2B1hcMkqg/W2NL/BoDoZTjZPpkfBaWosvLXSyWaS4O
         nJcWWO3X8ePpccLyO9K5a+audJq7aT6i7koZLXsA=
Date:   Mon, 16 Dec 2019 15:00:25 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 1/8] clk: sunxi-ng: Mark msgbox clocks as critical
Message-ID: <20191216140025.6sfmqneiyxjqe6v7@gilmour.lan>
References: <20191215042455.51001-1-samuel@sholland.org>
 <20191215042455.51001-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="orhnilvx6yyc5lzw"
Content-Disposition: inline
In-Reply-To: <20191215042455.51001-2-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orhnilvx6yyc5lzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 14, 2019 at 10:24:48PM -0600, Samuel Holland wrote:
> The msgbox clock is critical because the hardware it controls is shared
> between Linux and system firmware. The message box may be used by the
> EL3 secure monitor's PSCI implementation. On 64-bit sunxi SoCs, this is
> provided by ARM TF-A; 32-bit SoCs use a different implementation. The
> secure monitor uses the message box to forward requests to power
> management firmware running on a separate CPU.
>
> It is not enough for the secure monitor to enable the clock each time
> Linux performs a SMC into EL3, as both the firmware and Linux can run
> concurrently on separate CPUs. So it is never safe for Linux to turn
> this clock off, and it should be marked as critical.
>
> At this time, such power management firmware only exists for the A64 and
> H5 SoCs.  However, it makes sense to take care of all CCU drivers now
> for consistency, and to ease the transition in the future once firmware
> is ported to the other SoCs.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

This is pretty much the same case than for the AR100 clock though,
right?

I'm still not sure about why we should enable it that clock all the
time, even if you're not using the ARISC.

Maxime

--orhnilvx6yyc5lzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfeN+QAKCRDj7w1vZxhR
xZBuAP9Ia+0yr/oIdBQG1t+E3BzWwHMnlV5Sjd2kxueCGpo/HQD/bOzlGVC7h/lX
e+NB4e8WsigEdVU31jCtR+QPP4lVzQo=
=bWXY
-----END PGP SIGNATURE-----

--orhnilvx6yyc5lzw--
