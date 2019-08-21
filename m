Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35962C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013F122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKUk6eMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfHUQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:46:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36737 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHUQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:46:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so2698830wrt.3;
        Wed, 21 Aug 2019 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLVvXyvgXB6Ocn+szDhvQ/g84MWsWYjn4vzDej1qGVo=;
        b=SKUk6eMqTMq1/i5AqIDWbmfilcH0myvGVJaYn5H2fjL7t85w6H0SuEUBvR/QDp0caB
         mv3oH7WMaRrQljjgkKIYwJBmuvPcgwfs9GS5iLim7qaoWIe8eLdgtPKDxgLP5JGD3c0D
         yG1/v8X9xF9HWOWRGKOsD5cqHA4UICTIo+A4grQ4LoJkPKuv5WCmtAHs8kmM5n1yvBQm
         +uUlGGn/IXqRiG54kYAWeuBSDOnUXtuYhkiLVnJDL/bC20KpRi8TLrk+A2MuVizLsJRm
         MUxvgeg+fO0+LS0UxHzP/ydLCzYzC7G5BZlcefAzqC/R1Znr0W0iD6egaVdyRyc6CjOe
         H/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLVvXyvgXB6Ocn+szDhvQ/g84MWsWYjn4vzDej1qGVo=;
        b=WTfrl5zLrNRZG9UCd3Rp4uaJThUVBvS2yJsgda90NwvkIJ8qIwRLCpkjE7UqMb5Ilk
         hIZYmU2n4VMMAypdagIPQgRtexdAYQCsh97UPKSaBM9mjGESGtD9f0ukFQcCr3Vlut2E
         bAXERoq4K+bBRP6gs3HPs4NqjG/AAYnRI7ymhq19mFfUQyXVYfkb/WbO/b0uHuTDr9tk
         CFu8E6YLanLc33LGbUi81Xw9WS+fb3EVAuwjogEjQVGOVgAj81Lh5Y5fbM4d7qDziAPB
         slwsrn2+RanLpBrsBSVhlxG9oC0D4PNoBAZ1FiuZ+nnQYsRo8h9orTdYD7UUE0HkCuV9
         VgvQ==
X-Gm-Message-State: APjAAAU/4vATlLRyLcXXz90txxsUQOBqp00Dax+qYZVQXaURmmKG34tl
        3i209J8bBZHYmrVw4Z6OFdg=
X-Google-Smtp-Source: APXvYqxodKNIKoQwnEnC2ZcZhLe1lTiEUtStwmw0bPl3BZ3tfKUugVkE2YhWNYsG9v3IlkjXjrSn4g==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr41943965wrx.50.1566405968082;
        Wed, 21 Aug 2019 09:46:08 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id k13sm19246411wro.97.2019.08.21.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 09:46:06 -0700 (PDT)
Date:   Wed, 21 Aug 2019 18:46:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgsKgTWlyb3PFgmF3?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh-dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/15] clk: tegra20/30: Add custom EMC clock
 implementation
Message-ID: <20190821164605.GA31425@ulmo>
References: <20190811210043.20122-1-digetx@gmail.com>
 <20190811210043.20122-2-digetx@gmail.com>
 <20190812231258.GA31836@qmqm.qmqm.pl>
 <8369884e-1bd7-063f-e053-5152378078e9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <8369884e-1bd7-063f-e053-5152378078e9@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 05:36:41AM +0300, Dmitry Osipenko wrote:
> 13.08.2019 2:12, Micha=C5=82=C2=A0Miros=C5=82aw =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > On Mon, Aug 12, 2019 at 12:00:29AM +0300, Dmitry Osipenko wrote:
> >> A proper External Memory Controller clock rounding and parent selection
> >> functionality is required by the EMC drivers, it is not available using
> >> the generic clock implementation because only the Memory Controller dr=
iver
> >> is aware of what clock rates are actually available for a particular
> >> device. EMC drivers will have to register a Tegra-specific CLK-API
> >> callback which will perform rounding of a requested rate. EMC clock us=
ers
> >> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
> >> driver is probed and the callback is set up.
> > [...]
> >> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> >> index 4812e45c2214..df966ca06788 100644
> >> --- a/drivers/clk/tegra/Makefile
> >> +++ b/drivers/clk/tegra/Makefile
> >> @@ -17,7 +17,9 @@ obj-y					+=3D clk-tegra-fixed.o
> >>  obj-y					+=3D clk-tegra-super-gen4.o
> >>  obj-$(CONFIG_TEGRA_CLK_EMC)		+=3D clk-emc.o
> >>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         +=3D clk-tegra20.o
> >> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+=3D clk-tegra20-emc.o
> >>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         +=3D clk-tegra30.o
> >> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+=3D clk-tegra20-emc.o
> >>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D clk-tegra114.o
> >>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124.o
> >>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+=3D clk-tegra124-dfll-fcpu.o
> >=20
> > Doesn't it complain when both CONFIG_ARCH_TEGRA_2x_SOC and
> > CONFIG_ARCH_TEGRA_3x_SOC are enabled at the same time?
>=20
> No, at least not with my toolchain setup. Are you getting some warning?

Kbuild actually filters out duplicates to facilitate this kind of
construct.

Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ddUcACgkQ3SOs138+
s6E9BA//Xc4iJjeuJwcEDaXEv4kRmc52uoWzk8G3rIeI5nT1pnoejRqiJ9w+F53Q
gAnGlW+EWJ87KTlnnFixhrgAPfdV8SiipLgzU4ZMUAgEkkzhH4Szs85AwW0tFBGy
crYvsCqQ7i7xGA+1MotmZvOtKLQ22nvIMBR8QEF3dllDxd2w2MIXcYSgWJI6KcC+
cVt3pUGGoHIPwV1U2qrcr0LXcazHw4CJZ18OZsm/Z8pgy91ztfSgwKmu9trvfKk+
ipcFOaLShCDcDg3/1fkDHTXEoOLxiUA6HOnCJGTBW6jE01dqW6oX9p330cuwdw0U
FGFTkwc23pHU86AdgSkJkqrNLLKHOtCotcTH/zeJRR8Z9yLG7VvMzVjBVOR/RPLs
zMcJDvn1w4y2I76YBDbs6fhg13sJgmI2yzbsNyJMpSDSxoVUWIJHdhWdNcczHF7f
o4C/gqwQd2yQzv/lVJH/4ZZ/QXymh3JCb3DnVSB2cnwxbSuLBszMgxnZWqVia3Jr
32yumWP5a6rcW7krC2hnUpNC8ynIP9JC4yKa3fn1kng96rMFntAYuCwZ5XuZCycY
hB0JR1K+qSB7ns8VcXaWqwookBC0wEQoKEc2PwOwAluvkp3IYX9bGNsiEw82sFEH
/GiZeFmVA3wKVgEayu/gDsgfCcAJoFtt3zOZNmfBiX2XSfjSKzQ=
=E+B6
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
