Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04619C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD4B2085B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578208034;
	bh=0lUYrloB+zV0FkXyKfuZPMuMZUbqhgY43nJHRPwyOGY=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=LuW8/wkHK2g5imoqkTD/7qtpRs22LKO/TKhrSrGkIVv2uwMfoyeYKCFIiO86/d99y
	 BKJssDp4hxzYW5IEz28rKG2LtHBeQRWgvJgnIFe4qcn7Qi0HWWH9ZKcGez46h6eoAy
	 M2ZOwIoaVSDoY7U5Wt87B0T1E1THJ+rG/P7SuxBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgAEHHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:07:13 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7012085B;
        Sun,  5 Jan 2020 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578208032;
        bh=0lUYrloB+zV0FkXyKfuZPMuMZUbqhgY43nJHRPwyOGY=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=p4F83HXsr9t4oo2TcmhliRogenShbTBF+gsdoRAIMoKYRRLJGbS6NJBvvQ/TvtYA+
         NIQ/l9xjYwlUIZ9xazBdpm2lGIFb2/LIEIA8ZyyvdJx2gbkA006yIZDE/dCmSzhPbE
         aFR4zRfTxD+SoxPHXFpEtp1VLyxei57IqltmHrsg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200103073926.GM988120@minitux>
References: <20191230190455.141339-1-sboyd@kernel.org> <20200103073926.GM988120@minitux>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] clk: Use parent node pointer during registration if necessary
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:07:11 -0800
Message-Id: <20200105070712.6C7012085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-01-02 23:39:26)
> On Mon 30 Dec 11:04 PST 2019, Stephen Boyd wrote:
>=20
> > Sometimes clk drivers are attached to devices which are children of a
> > parent device that is connected to a node in DT. This happens when
> > devices are MFD-ish and the parent device driver mostly registers child
> > devices to match against drivers placed in their respective subsystem
> > directories like drivers/clk, drivers/regulator, etc. When the clk
> > driver calls clk_register() with a device pointer, that struct device
> > pointer won't have a device_node associated with it because it was
> > created purely in software as a way to partition logic to a subsystem.
> >=20
> > This causes problems for the way we find parent clks for the clks
> > registered by these child devices because we look at the registering
> > device's device_node pointer to lookup 'clocks' and 'clock-names'
> > properties. Let's use the parent device's device_node pointer if the
> > registering device doesn't have a device_node but the parent does. This
> > simplifies clk registration code by avoiding the need to assign some
> > device_node to the device registering the clk.
> >=20
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >=20
> > I decided to introduce a new function instead of trying to jam it all
> > in the one line where we assign np. This way the function gets the=20
> > true 'np' as an argument all the time.
> >=20
>=20
> Looks better.
>=20
> >  drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index b68e200829f2..a743fffe8e46 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3719,6 +3719,28 @@ __clk_register(struct device *dev, struct device=
_node *np, struct clk_hw *hw)
> >       return ERR_PTR(ret);
> >  }
> > =20
> > +/**
> > + * dev_or_parent_of_node - Get device node of @dev or @dev's parent
>=20
> ()

This has been left out historically in this file. I'll add it but I
guess I should really take a pass at updating the docs in the whole
file!

>=20
> > + * @dev: Device to get device node of
> > + *
> > + * Returns: device node pointer of @dev, or the device node pointer of
>=20
> Return: (no 's')

Thanks.

>=20
>=20
> With that,
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
