Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA71C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4402053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="dKpZCWP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfEFV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:27:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEFV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:27:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so19201728wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2IPjvXS9ovmHMp9QDNvfJjrdnqj8PLY/VSE8ERdo3T0=;
        b=dKpZCWP9myNRHzdWXZ6L33Bb73ivM+YgfGeA+BpqzEeVQa3KbVgnpyyVHRTymnmIa6
         6W+nlMthTqFhKi3/9zP/3qY5BeWB0mLQA/H+v/PPkf4DOaxCj+bJUKaRc15R4PkfiaQG
         bHp0hSwK/M7MOQW8PKMv+/PBTVdsrPcAO2yY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2IPjvXS9ovmHMp9QDNvfJjrdnqj8PLY/VSE8ERdo3T0=;
        b=GCP+WDVCnmt23qvvT44yV3mPrX527HjIS/GKtyCfibV/c4wQppMxLsytH8DxFLKlg7
         9RXQlfFzL64RHe+FpCZVNoU6qUREVW2S9pYH2in7GPcvz1KEg580g5HJNTn0e7AcB5ii
         sNvrhHXph3JS25s5sRElGDhdGbUKJ6VtQjlKzenz+14KJ6A++tmfZcAc0kQucRj9Y3aw
         jIj6i3UHh97K+vsRTXqb2nY58Th+hFBTvYBZ0go8dcy7oW+WpLGNrJBFZ4HOieuFOGie
         3tXQnwhooJKs/UNQ4/WIpfaXTT6lvnqrRkEvux9IRPB5B24CnKa7gI/WYT9E6RnFDXjg
         wb/A==
X-Gm-Message-State: APjAAAUpwRXEVD1nklHr5ZJGpVnqI3WbiXhjjhnuZdZQO2OemyTReI0m
        ENxzL7rDVngLKNXL/iriCF4hsw==
X-Google-Smtp-Source: APXvYqyOtk3Rqom23UwLgtBVc+ZvknnqAUBdzMotGRsBa6ozNAIpwlohAeAAzm8RjF7k21eMmadFVQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr12592644wri.180.1557178038670;
        Mon, 06 May 2019 14:27:18 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-141-147.ec.res.rr.com. [65.184.141.147])
        by smtp.gmail.com with ESMTPSA id a22sm9808162wmb.47.2019.05.06.14.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:27:14 -0700 (PDT)
Date:   Mon, 6 May 2019 17:27:09 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Karsten Merker <merker@debian.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
Subject: Re: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
Message-ID: <20190506212709.GD31207@bill-the-cat>
References: <20190506181134.9575-1-atish.patra@wdc.com>
 <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
 <20190506203956.ty6gkmhm4dlylld4@excalibur.cnev.de>
 <d1c63af6-e1e0-4ec3-e97a-4c3e9ec11623@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8MGw1ILlV46eIqUv"
Content-Disposition: inline
In-Reply-To: <d1c63af6-e1e0-4ec3-e97a-4c3e9ec11623@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8MGw1ILlV46eIqUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 11:10:57PM +0200, Heinrich Schuchardt wrote:
> On 5/6/19 10:39 PM, Karsten Merker wrote:
> >On Mon, May 06, 2019 at 10:06:39PM +0200, Heinrich Schuchardt wrote:
> >>On 5/6/19 8:11 PM, Atish Patra wrote:
> >>>This patch adds booti support for RISC-V Linux kernel. The existing
> >>>bootm method will also continue to work as it is.
> >[...]
> >>>+	"boot arm64/riscv Linux Image image from memory", booti_help_text
> >>
> >>%s/Image image/image/
> >>
> >>"arm64/riscv" is distracting. If I am on RISC-V I cannot boot an ARM64
> >>image here. Remove the reference to the architecture, please.
> >
> >Hello,
> >
> >I'm not sure about the last point - ISTR (please correct me if my
> >memory betrays me here) that an arm64 U-Boot can in principle be
> >used to boot either an arm64 or an armv7 kernel, but the commands
> >are different in those cases (booti for an arm64 "Image" format
> >kernel and bootz for an armv7 "zImage" format kernel), so having
> >the information which kernel format is supported by the
> >respective commands appears useful to me.  If the arm64 kernel
> >image format would have a distinctive name (like "zImage" on
> >armv7 or "bzImage" on x86) that would be less problematic, but
> >with the confusion potential of "boot a Linux Image" (as in the
> >arm64/riscv-specific "Image" format) vs "boot a Linux image" (as
> >in generally some form of kernel image), I think explicitly
> >mentioning the supported architectures makes sense.
>=20
> In this case you have to ensure that only the *supported* architectures
> are mentioned. RISC-V is not supported on ARM64.

The help should be re-worded to be both architecture agnostic and clear
that it is for the Linux Kernel 'Image' format images.

--=20
Tom

--8MGw1ILlV46eIqUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJc0KatAAoJEIf59jXTHXZS06wQAMJiT+a5vv3S5ScRWpC2NcYp
Zr1k+ddMgy31YS8htCujzgmgKJkxK3ZjdLMiDbzeRC/4r6FZ/E2r8jeU8wRo+39c
wdiC60MqLuQ2Z33KpZyox1JRniBra0nmVZwdItoUG1SXFcC50DWryhGH8pTBMja4
5moE9rBAo2W/cTQ+rCnYK32IRfTu17hhhJxu3ufv/aNkS4ofvnad/fw7nz38vE+4
HxQeNSvo0O411C2ZUlFo/i97Okv7BFwf1I2orfQhKusfpNZxOFl0QPayhDf1/BRV
RpYf3U742omDpH4nX07WFRP6wsa8hTY+n6rHPagAP0/M3aj4/LqxowMuWlV+2rp7
YFx9cwuxO8OxgBpF5YFdUMed/79OXwIZmvCTxYoY7dLetsMXmj7yBV7gXSRthzFt
TMgPIQDMfGhSk+Xn6EWMvID41okr4aeseIcWs5OGVYZJcVfuDGxiNwU7OKqE1wco
WGbLKuL8e4wlH/JBI6ZHlTPxIDgOUyHODE+FFejLfRmaF4AvmQOw6RT/Tuc6Qzqm
DYFaALNELpL4CUr6/yV8TqCJ6YyBSjT3W9VSwrWh/e3HH7/sjtp6fGcWI3puQa18
M70ZdZZrhl05LqPsyLS4Qv/gFpcGiqa3bBU195fKOjK6pghsZ+5MXG+vtOCgHw6n
fUu6+6tNKfSw1n6iEJfz
=cbu5
-----END PGP SIGNATURE-----

--8MGw1ILlV46eIqUv--
