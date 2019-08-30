Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E516C23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="d0pPR4ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH3Jd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:33:28 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:46263 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfH3Jd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:33:27 -0400
Date:   Fri, 30 Aug 2019 09:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1567157604;
        bh=nz1yhbjeCbxbAmzZQWi05SYwfjQwsTGBfY7/Mxb28jo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=d0pPR4cipoP4CS8PEBlKd7zCj/Px5jusbUnimhrjUrcqa5rCgVV75B/RmBeI62716
         Cd/SWpZFGMGGX9G+n3emibLsGIRYBPqZZ/beAT7mPzdG3qyrVJXQyjAZf5BEFaR8kX
         b9b+EocIouDMBVnG4VJ8zK/IdFSjWdlkSraHdmyg=
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Reply-To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Message-ID: <zQCmpTJgh3DStTAOFOYXmO44eMRsagV7uM-pCHjc3YlsFmTQuG2GNK9ELGBQZsFn44kr91MRGZ3U7z45D79XHNvCuMTuA6PltlSDx379ws0=@protonmail.ch>
In-Reply-To: <CAMuHMdVe_d6N8hhG0VNZMKAGwXm7kiOQVnqNkL9+6DbkBsKAZw@mail.gmail.com>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
 <CAMuHMdVe_d6N8hhG0VNZMKAGwXm7kiOQVnqNkL9+6DbkBsKAZw@mail.gmail.com>
Feedback-ID: nIMxuco3ul2LtVHhzi8PphYHQLjwNa0SMoiI49kuTHKENnPWKUsinAdWedFtAsi63naFGY15tCjh3_itnNk3og==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

You are correct, there is no way to distinguish between the old and new ker=
nels just by mmc ios output when the bus is down. I don't think it's an iss=
ue. I find it more helpful to have this information available.
Yes, actual_clock should only display when non-zero and it should be zero w=
hen the bus is down. I fixed this in v2.

Kind regards,
Tamas


Tam=C3=A1s Sz=C5=B1cs
tszucs@protonmail.ch

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, August 30, 2019 9:21 AM, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:

> Hi Tam=C3=A1s,
>
> On Thu, Aug 29, 2019 at 8:37 PM Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.c=
h wrote:
>
> > Save set clock in mmc_host actual_clock enabling exporting it via debug=
fs.
> > This will indicate the precise SD clock in I/O settings rather than onl=
y the
> > sometimes misleading requested clock.
> > Signed-off-by: Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.ch
>
> Thanks for the update!
>
> Reviewed-by: Geert Uytterhoeven geert+renesas@glider.be
>
> However, one question below.
>
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mm=
c_host *host,
> > sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> > sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> >
> > -         if (new_clock =3D=3D 0)
> >
> >
> >
> > -         if (new_clock =3D=3D 0) {
> >
> >
> > -                 host->mmc->actual_clock =3D 0;
> >
> >
>
> The actual clock is present in the debugfs output only when non-zero.
> Hence userspace cannot distinguish between an old kernel where the
> Renesas SDHI driver didn't fill in actual_clock, and a new kernel when
> the SDHI controller is powered down.
> Could that be an issue? Should the old value be retained?
> Probably it's OK, as this is debugfs, not an official ABI.
>
> Gr{oetje,eeting}s,
>
> Geert
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------
>
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> -- Linus Torvalds


