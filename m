Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1A7C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C217521871
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570462193;
	bh=wZpqJAVdx0OquwJReQG4DI2BbxLYhSANl3AxInjoMnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DdcqhUI+1Q4026xpU8tiiP3XN6o6XBB9RICiw62UzAitgIw+FAbMa7SWH6LfyPzX
	 TDzRu4ukepiBOCJPZmJQyuBCF9WbGRUBgpwmTUx6Tod85yTlk7mpB5nnxfc6v4HgmZ
	 CaTtije5k31VwFfmFO8xKzmXePBXrhtC9sTZK3v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJGP3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJGP3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:29:52 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F341F205C9;
        Mon,  7 Oct 2019 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570462191;
        bh=wZpqJAVdx0OquwJReQG4DI2BbxLYhSANl3AxInjoMnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dP66wmu7YyEygbX3QijQsb/3NOB4N8uBisRfCqVfuTlCpD54iqPP2wIR1l9440iF7
         r70y9nVKYTTHvXvlvP1dCgZTXmM/hrecFRaIdWWPdOZawl1Tsfo7IfkqZ5ChB4xrCS
         qSNiOlLdTjHS6i40jueGJPJ740oi6aqlOM7CO+jk=
Date:   Mon, 7 Oct 2019 17:29:48 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] bus: sunxi-rsb: Make interrupt handling
 more robust
Message-ID: <20191007152948.jgz6l4zmqjxqpzus@gilmour>
References: <20190824175013.28840-1-samuel@sholland.org>
 <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="blrzkcpgdyo7n7tb"
Content-Disposition: inline
In-Reply-To: <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--blrzkcpgdyo7n7tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Oct 07, 2019 at 11:19:06PM +0800, Chen-Yu Tsai wrote:
> On Sun, Aug 25, 2019 at 1:50 AM Samuel Holland <samuel@sholland.org> wrote:
> > The RSB controller has two registers for controlling interrupt inputs:
> > RSB_INTE, which has bits for each possible interrupt, and the global
> > interrupt enable bit in RSB_CTRL.
> >
> > Currently, we enable the bits in RSB_INTE before each transfer, but this
> > is unnecessary because we never disable them. Move the initialization of
> > RSB_INTE so it is done only once.
> >
> > We also set the global interrupt enable bit before each transfer. Unlike
> > other bits in RSB_CTRL, this bit is cleared by writing a zero. Thus, we
> > clear the bit in the post-timeout cleanup code, so note that in the
> > comment.
> >
> > However, if we do receive an interrupt, we do not clear the bit. Nor do
> > we clear interrupt statuses before starting a transfer. Thus, if some
> > other driver uses the RSB bus while Linux is suspended (as both Trusted
> > Firmware and SCP firmware do to control the PMIC), we receive spurious
> > interrupts upon resume. This causes false completion of a transfer, and
> > the next transfer starts prematurely, causing a LOAD_BSY condition. The
> > end result is that some transfers at resume fail with -EBUSY.
>
> If we are expecting the hardware to not be in the state we assume to be
> or left it in, then maybe we should also keep setting the interrupt enable
> bits on each transfer?
>
> Surely we expect to have exclusive use of the controller most of the time.
> If it's to handle suspend/resume, shouldn't we be adding power management
> callbacks instead? That would reset the controller to a known state when
> the system comes out of suspend, including clearing any pending interrupts.
>
> Maxime, anything you want to add? (BTW, Maxime switched email addresses.)

The patch looks pretty harmless, so we can merge it, but if we're
going to share the RSB between those components, we should probably
use the hardware spinlocks as well.

Maxime

--blrzkcpgdyo7n7tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZtZ7AAKCRDj7w1vZxhR
xd1bAQD5Rl4U3NuOje4WVojIJCGbADL6OKRPVUbYlOKDw+8k0wEA9tlTGx9fzbpi
x5XZIQm5HiB2QyJBU+rPQzd5Nx3+SQU=
=tZkN
-----END PGP SIGNATURE-----

--blrzkcpgdyo7n7tb--
