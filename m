Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C8CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27852083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB6Lf8iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDKPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:37:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDKPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:37:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so7244666wmk.4;
        Thu, 11 Apr 2019 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0So01Pry3YdL2r7Mdo9RFJrZmUA+PyyXGaj77JHEnSU=;
        b=iB6Lf8iLaAEV2wXY7TnHXOqjK76bFxIr09IYIheCheJeof7doBSZM0L4mSR41s08vm
         6fzRS/Y1dm1HdwizNsjtL/WBLTE3kKe7fuSp/h90zlaP25Y5I/48vKBbDReinKVP84jv
         hH5qjw+RrEsOlN+81W6sXsjGHNrahjwW9gohYwXG2kEE3PTGNnp7NUwcK1YKZww9Jb4w
         czWiwanxG0U0Dj1Ma6tcLpyE04DyFpmmqqYEOZRdq7YZ9jRNshSQCqsy3znVSlh5NkI0
         UCZ/V8543JqAMOfc9wFFd2WAuZjjHrMQW7/2h5NTaFZc8OdtQveozl+vEa8J88kNZGCP
         9A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0So01Pry3YdL2r7Mdo9RFJrZmUA+PyyXGaj77JHEnSU=;
        b=BZdavXcRdJsfxoCYCz4vimNaPhcY2hgBmkng7/0IEInRQC9V7aYfaWjiPxbG7/Mdvb
         +l3Yn56+g8Yf6wsvFJOH5kn9kvCMExi81B0rLF81RWiniGbkHxmIcs3gE25Lz27VNdUf
         cuF8uDPNsruFgV3r1rhH3Fhw0kXvsxj84Mywf0jRLG893M5vm3OQqCzC7bVb8Aefp+H1
         cWCyyUTph4c5d0Bl+UUSlbpDKsbmXcnVGF1j3EQsyI/StAyR14sv6UOi349GlOevGzjp
         3+3Czs0N4vltG57KtVNCDejcTyJuN0rXztaGyqH0FUeGGODWT3nLMFpAbifFYNL8i2e+
         F9UQ==
X-Gm-Message-State: APjAAAWZ7AeauOS7m+YbxhY7Jj5U/e9zrf43GxlZa+s2T5m4yN6Dq6Uy
        ZJCJyFcnXmW3gzz+5won8ik=
X-Google-Smtp-Source: APXvYqy/rThEauCEFiHYh4Xw1aTUn3vj5y4Bznj4zPe5IYZqcCqkc4Dn/psIrdzbQhM6mox1h+AmkA==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr7208364wmd.109.1554997023110;
        Thu, 11 Apr 2019 08:37:03 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id y132sm6922583wmg.38.2019.04.11.08.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 08:37:02 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:37:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: fix compile error when IOMMU API is not
 available
Message-ID: <20190411153701.GA30800@ulmo>
References: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
 <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
 <20190411083017.GB4633@ulmo>
 <c73bb650-7175-150b-a678-c707e5f0e7e7@kapsi.fi>
 <ff7e06b6-587c-6098-92ab-ff2fbab6e651@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <ff7e06b6-587c-6098-92ab-ff2fbab6e651@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 02:31:48PM +0300, Dmitry Osipenko wrote:
> 11.04.2019 13:06, Mikko Perttunen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 11.4.2019 11.30, Thierry Reding wrote:
> >> On Thu, Apr 11, 2019 at 09:23:13AM +0100, Ben Dooks wrote:
> >>>
> >>>
> >>> On 2019-04-10 23:47, Stefan Agner wrote:
> >>>> In case the IOMMU API is not available compiling host1x fails with
> >>>> the following error:
> >>>> =C2=A0=C2=A0 In file included from drivers/gpu/host1x/hw/host1x06.c:=
27:
> >>>> =C2=A0=C2=A0 drivers/gpu/host1x/hw/channel_hw.c: In function
> >>>> =E2=80=98host1x_channel_set_streamid=E2=80=99:
> >>>> =C2=A0=C2=A0 drivers/gpu/host1x/hw/channel_hw.c:118:30: error: impli=
cit
> >>>> declaration of function
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=98dev_iommu_fwspec_get=E2=80=99; did=
 you mean =E2=80=98iommu_fwspec_free=E2=80=99?
> >>>> [-Werror=3Dimplicit-function-declaration]
> >>>> =C2=A0=C2=A0 struct iommu_fwspec *spec =3D
> >>>> dev_iommu_fwspec_get(channel->dev->parent);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu_fwspec_free
> >>>>
> >>>> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
> >>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>>
> >>> would it be better to provide something like this i nthe header that
> >>> defines dev_iommu_fwspec_get() to be:
> >>>
> >>> static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device=
 *dev)
> >>> { return NULL; }
> >>>
> >>> although returning an PTR_ERR would have been better.
> >>
> >> I don't think there's really a large number of failures here. Either
> >> your device has an IOMMU fwspec or it doesn't.
> >>
> >> But yes, I think it'd be better to have the above static inline dummy =
in
> >> iommu.h, but I'll apply this for now in the hopes of getting it in
> >> before v5.1 final.
> >=20
> > A similar patch was already sent before by someone. That one also progr=
ams the bypass stream ID (0x7f) even if IOMMU is disabled. We should pick t=
hat patch instead.
>=20
> For the record.. here is that patch https://patchwork.ozlabs.org/patch/10=
52364/

Ugh... too late. I'll apply Arnd's patch on top of this one.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyvXxgACgkQ3SOs138+
s6HqaQ/+L1ZIgrilwmTjL3NoeC6kmTLKTR22Ea8RlW9yfbEnsSCuByBSTuVEaaPt
QiivsmNnlTlqFNnuMtPZ8j9QlXUbYfN2Fa7s0PmFdsoGhOnRpPiWGDn1t0xFm2hi
m/1tRxnn2GCywrltgq/wMrC2QQPhuaYbRH3FjthkejILM2+42TT6w7YC3xR73jvS
qLtOfQAb3Jf1Ovd+pzJgE05s7hcoPg+GTujHnidYx8+I30w4MJSTObWYeqLRvPBb
/BchKKgw4jpz+L9GhI5S5iO47wD0xjGX726d/PAPfKxQCgTyjmUQVr23zwaUaPgH
wFcwmV2B18ZrHfBaviM+2KY+HWgBGVkH29nEiaaKOpUGPTl2lDvTY+J4eafIydpZ
TB21wQF22F5v/PNJ083GAMksQszwVweY4FrqyFJFvQ6r+DaVg6ad7qtznpBcOFJn
ve5jKPAR5cUrP+aI2iiaSkpU8jMS801/EIvt5xYeAl3i1t4JOq4YUz0OX3b5+Fph
7IKwAeVECxabQolH208X8yaOJSvCDB2ZszS39sA+IKz66EK5tgy8fcrwj6FLmbtN
EtfVs6FZIxcaN5ZvocNyR0zmLStVU7Tnqz71Rh6m1qJK0Ma4tQtcemJ41MrsoRD1
BgX5l+ZSzbScWwiY5avMi6msVgIpTBjXnns3lIBvoz3sTOPNQFI=
=4M++
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
