Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37195ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0607A2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkwWCU1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbfJAPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:04:17 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39043 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfJAPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:04:17 -0400
Received: by mail-wr1-f41.google.com with SMTP id r3so15981843wrj.6;
        Tue, 01 Oct 2019 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=82JevLXpiEtGmAc3CHys8cJux4GB+e9q7dCU4OqqwNA=;
        b=TkwWCU1HOyaEwaiACxq0x15vbDID7pKPA8viZni877Yi7iGnxC6M3I68GDxYNM3sNz
         PcPkG4SnLTFiLbhFVDUEDlEoZPoF4ksevciAU+w+vCaGCQwVu5E/i64j61Rpa7f9aECf
         mb1hkU0qY0I8K/PCdkq+1Xru8Npmgh5Bd6YM3KIWI+0yHIbd5RljcJO9LyT8z+JOah3m
         +yspFda/lKHcs6KogjdvziqrLVSEkWuWOi++6Psil4w4zWbiOcbvw+SLQV0BKPfk9NAC
         EVK3S85mnLBTpmjt6oOrb+FE1/N8mh6x5qfHSiFkcN3DzmJHU7d1zu1vTdGkrnILJLGd
         vRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=82JevLXpiEtGmAc3CHys8cJux4GB+e9q7dCU4OqqwNA=;
        b=N03ndwjXFM9aKbFMb42swh72wxHGJz3vNDqSoVjqnrbMLRCgV8YJ/MsYpsZhbxs3Np
         69ryAfhNBoLv7jDHJ6B2FaNG9wdUgdEe7iGKZMtBIsjmHCtjMCj2yK/fVSLacUqI09ay
         /StPJ53XUSDI6meknq1rDg1KsVMJ7iRQSm+CWaqGCisXGE8BIbEmStbiux0uY4PDPwRe
         UiL2L7H+96hjniymNp6qKK9xusTJ8nxyuKenuTBslcSwgwYfnVHkusiU5kPBEMK9AnuG
         xsi2TCeFT/vDQlJ4dFkPBfTGYXNwpU8uxtlLb8Dt5rMEwfSbjuxyMLXgFTLsx/eetPSk
         Q3Cw==
X-Gm-Message-State: APjAAAUeDOiMqa8T+rymo+TEGsuI+lEaK/qRb04asitlEyYrabZvK9N1
        jx8UtF3sE58AIpaqBkn0uRuBv/dz
X-Google-Smtp-Source: APXvYqysmRZv4fvIeB8npqusjQa8iA0BFIqVmK9AcFOwpTbIHBre6jHhDi8o++Cu1n3PH+aBr679Lw==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr1386728wrv.234.1569942255091;
        Tue, 01 Oct 2019 08:04:15 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y13sm25466006wrg.8.2019.10.01.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 08:04:13 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:04:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch V2] soc/tegra: fuse: Add fuse clock check in
 tegra_fuse_readl
Message-ID: <20191001150412.GG3566931@ulmo>
References: <1567508212-1194-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <1567508212-1194-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 04:26:52PM +0530, Nagarjuna Kristam wrote:
> tegra_fuse_readl() can be called from drivers at any time. If this API is
> called before tegra_fuse_probe(), we end up enabling clock before it is
> registered. Add check for fuse clock in tegra_fuse_readl() and return
> corresponding error if any.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
> 	- Added Null and other error checks for fuse->clk.
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to for-5.5/soc, thanks.

Thierry

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2TauwACgkQ3SOs138+
s6EqvQ//QmqQwmW5Ol+MmXGhVIp3l5MIWX0f5l5/D9v1a911yCzm9o9mPKjAlkJy
RA3+8kZJhAGmxE4GFZ/3aV1V32dqrnvNkJXEgagTnQ+kXaIfr2o67DoW5q220ftV
JT7USAUONMWTqEJrR90e+EV668kDD9ZtAcLrn40BBjM+0g0K19g+7vLXAvzuLNTb
CONTgcahroCKIf9x2YG8aUKICAeIbz/JflbaZwLyrV+WBQ8H4mg3RHbd1MPOQIha
sNv6HunEy9nJeP8kcHopFJfikHMNempXIpcB2mlmU/iubTvdvBFDm+POhivPuuqv
RCvopwwzqyxN+jyjj3SolNVAVWwzCbYYI96HBMn2j3jD0+2qCGO0WA/TQVx8IMZS
vBouimwhcWKu8HIHhTj3ZSt59bhIya9jak+1wpfmm9BgX6ifZNB4k082kB336uds
p6TlDKZAoTHVzKmRVC6nYmSMb46OKDVdqzZP9jn2aNPZio2jIhHzQNg83MPuUofQ
3jRXU0JifD15pnIG9zkXXM100k0HdnW+2rwzcVbEQRGsxd9YqQvV8gZWjtAQD9J/
jvzAaF3rcFZM8iMAUaU7VTIc6dzGJlqaqVhAr6q9VuKsrQsNVQFv3j2Z//dVhM8D
jgMlsySTFvNLZQf6K8bruE0yqY/YCG55L7JU7hJFRfdEBkmqTgs=
=XLEa
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
