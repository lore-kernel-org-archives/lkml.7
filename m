Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935FC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6E21881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="e4vIQB3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfIQJfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:35:22 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:51051 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfIQJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:35:21 -0400
Date:   Tue, 17 Sep 2019 09:35:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568712918;
        bh=7al/T7V+BY7NjSZ3yvHA/yYuZG9e2Bk22StX9CKMVk4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=e4vIQB3/ek87t2wke2ANUNusBnbTVWIcoFZ38xRO+RsNAgqHQ68bwGUxW3I0+pC1U
         SMgWFisYL4+sGAEvTxGuN9NccZR0KxyyuH8QeIMgofR2/BbX3YYcCIcq9IF9iDTf6p
         kXNBD093B6RmoIhtrR97jSvg6zLsYtVf8moUxBNM=
To:     Palmer Dabbelt <palmer@sifive.com>
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: RE: [RFC] buildtar: add case for riscv architecture
Message-ID: <lMUhcsewB9GAKeZH2cH-zl3vFME8u2z5IzCqDBFhtT2IbG71vhHnjrlHKbhyxFee5XFe1X1gRllNJBR9e9dQlC0vbIpSffL_y0pLb46VddQ=@aurabindo.in>
In-Reply-To: <mhng-4e30fb12-057c-425c-a867-ecf93e080ed9@palmer-si-x1e>
References: <mhng-4e30fb12-057c-425c-a867-ecf93e080ed9@palmer-si-x1e>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, September 15, 2019 12:57 AM, Palmer Dabbelt <palmer@sifive.com> =
wrote:

> On Sat, 14 Sep 2019 06:05:59 PDT (-0700), Anup Patel wrote:
>
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Palmer Dabbelt
> > > Sent: Saturday, September 14, 2019 6:30 PM
> > > To: mail@aurabindo.in
> > > Cc: Troy Benjegerdes troy.benjegerdes@sifive.com; Paul Walmsley
> > > paul.walmsley@sifive.com; aou@eecs.berkeley.edu; linux-
> > > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > kbuild@vger.kernel.org
> > > Subject: Re: [RFC] buildtar: add case for riscv architecture
> > > On Wed, 11 Sep 2019 05:54:07 PDT (-0700), mail@aurabindo.in wrote:
> > >
> > > > > None of the available RiscV platforms that I=E2=80=99m aware of u=
se compressed
> > > > > images, unless there are some new bootloaders I haven=E2=80=99t s=
een yet.
> > > >
> > > > >
> > > >
> > > > I noticed that default build image is Image.gz, which is why I thou=
ght its a
> > > > good idea to copy it into the tarball. Does such a copy not make se=
nse at this
> > > > point ?
> > >
> > > Image.gz can't be booted directly: it's just Image that's been compre=
ssed
> > > with the standard gzip command. A bootloader would have to decompress
> > > that image before loading it into memory, which requires extra bootlo=
ader
> > > support.
> > > Contrast that with the zImage style images (which are vmlinuz on x86)=
, which
> > > are self-extracting and therefor require no bootloader support. The
> > > examples for u-boot all use the "booti" command, which expects
> > > uncompressed images.
> > > Poking around I couldn't figure out a way to have u-boot decompress t=
he
> > > images, but that applies to arm64 as well so I'm not sure if I'm miss=
ing
> > > something.
> > > If I was doing this, I'd copy over arch/riscv/boot/Image and call it
> > > "/boot/image-${KERNELRELEASE}", as calling it vmlinuz is a bit confus=
ing to
> > > me because I'd expect vmlinuz to be a self-extracting compressed
> > > executable and not a raw gzip file.
> >
> > On the contrary, it is indeed possible to boot Image.gz directly using
> > U-Boot booti command so this patch would be useful.
> > Atish had got it working on U-Boot but he has deferred booti Image.gz
> > support due to few more dependent changes. May be he can share
> > more info.
>
> Oh, great. I guess it makes sense to just put both in the tarball, then, =
as
> users will still need to use the Image format for now.
>

Uncompressed vmlinux is already copied by default. This patch just adds the
Image.gz into the archive as vmlinuz. But as you said, since the name vmlin=
uz is
reserved for self extracting archives, should I keep the original name Imag=
e.gz ?

