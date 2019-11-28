Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDC12158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egldvRzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1M0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:26:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38210 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1M0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:26:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so11500397wmk.3;
        Thu, 28 Nov 2019 04:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNtNQSJoXReaL9F+1LGmXBLVnXjdF+OKDcjgSRFQYLk=;
        b=egldvRzmJpJk1L16vv+WT4Onemk/HdxM90OYelOLpUjMZONtQUaFSxxR5QuCiwHLcC
         FUneyYbCukcdoWEIBsLfV2SKKx7CZToXnzuikMfbwjo4ZexkQV8ExOnkpgyPf6BjGDud
         XOMo5xoNqaN/b+GjRwOy2rFKYyPxi1gKjeWukeHK0cgKqpCB3096LYpJm+XK/K5DIbDF
         k0Ap9cuZhN9HAoCnEe+e9PYAmKy5SMKki+DNnKoohzEgy97MqbJQO71IVDabZ2O1cRCQ
         L1ovPdZa57fghEG5R6aqFNxL9Exu1ROD5dOB0fiorEjYGGX5wfkyRDbmBeWNZyfWNcx3
         L/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNtNQSJoXReaL9F+1LGmXBLVnXjdF+OKDcjgSRFQYLk=;
        b=DtPpeWmifHeAtdYauDu6EN+DkKPnFNK6Xo/Qr7DN6fF3vdTseVoi0upg5jBmveYbW5
         kB/UV+sWIqYvX3c2T9IB9TAmKGT+1faEBGe2/Zl89ed4nRxlcqvrC/cDXiQqLdaGMleD
         vJxof/0Du4vA4KxnHT2ACNoLx+jBLDteGHFdE8ATHQpVPLTCCTqFjqUcHZPiUp9JazDd
         fJdGkaLRRfGE9E/UERyZhe4dGW6FPp6lOeGmA+wdOyyT8peeDgXCiecWC0paFjQZHLXc
         P/WY8G/whqtlrR7KUbT7cFk+i+BG99ZaCgQp1HCb7LraXcIlMalGIRIz2eNtljvdW4+q
         TFKw==
X-Gm-Message-State: APjAAAVUI+BL2B+5wljHLkV3MihL2SXEikpraBLAjYL3zpI2ZIKJSsTt
        lO1s1g5xfreVeoq0uAuVtPA=
X-Google-Smtp-Source: APXvYqzgvmXa0v2lqDnPFS9KeI5Xi9Sm2WKXbo+YdgiP1GqpfGb56dHe7OkvOhbckXhyOe+7IGUmcg==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr9455696wmj.126.1574943981451;
        Thu, 28 Nov 2019 04:26:21 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id s8sm9720978wmc.39.2019.11.28.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:26:20 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:26:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
Message-ID: <20191128122619.GB2300319@ulmo>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 05:31:34PM +0300, Dmitry Osipenko wrote:
> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
> > are currently registered by Tegra clock driver using clk_regiser_mux and
> > clk_register_gate which performs direct Tegra PMC register access.
> >=20
> > When Tegra PMC is in secure mode, any access from non-secure world will
> > not go through.
> >=20
> > This patch series adds these Tegra PMC clocks and blink controls to Teg=
ra
> > PMC driver with PMC as clock provider and removed them from Tegra clock
> > driver. This also adds PMC specific clock id's to use in device tree and
> > removed clock ids of PMC clock from Tegra clock driver.
> >=20
> > This series also includes patch to update clock provider from tegra_car
> > to pmc in the device tree tegra210-smaug.dts that uses clk_out_2 from P=
MC.
> >=20
> > [v2]:	Changes between v1 and v2 are
> > 	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
> > 	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
> > 	- feedback related to pmc clocks in Tegra PMC driver from v1
> > 	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
> > 	  by the clock driver using helper functions from Tegra PMC.
> >=20
> >  	  Note:
> > 	  To use helper functions from PMC driver, PMC early init need to
> > 	  happen prior to using helper functions and these helper functions are
> > 	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
> > 	  clock registration which happen in clock_init prior to Tegra PMC
> > 	  probe.
> > 	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
> > 	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
> > 	  tegra_mc_init.
> > 	  This implementation of configuring PMC registers thru helper
> > 	  functions in clock driver needs proper changes across PMC, Clock,
> > 	  EMC and MC inits to have it work across all Tegra platforms.
> >=20
> > 	  Currently PLLM Override is not enabled in the bootloader so proper
> > 	  patches for this fix will be taken care separately.
>=20
> Hello Sowjanya,
>=20
> Could you please clarify what do you mean by "PLLM Override not enabled
> in bootloader"?
>=20
> There is T124 Nyan Big Chromebook which is supported in upstream kernel,
> it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
> which has the PLLM Override set by bootloader as well. It's not clear to
> me whether this patch series is supposed to break these devices. If the
> breakage is the case here, then I'm afraid you can't postpone supporting
> the PLLM Override and a full-featured implementation is needed.

For some more background on why we chose to take this shortcut for now:
Sowjanya was looking at the full-featured implementation and that ended
up being a can of worms. The problem is that there are various inter-
dependencies between the PLLM override and the MC/EMC clocks.

Unfortunately we depend a lot on the explicit ordering of driver probe,
especially during early boot, so this started to get very complicated,
very quickly.

The bottom line was basically that we would need to move a whole bunch
of clocks to register at a very late point in time and support deferred
probe throughout in order to make it all work together nicely. Sowjanya
had a crack at that, and while the system ended up booting, there were a
number of errors from the MC and IOMMU drivers.

At the end, we decided to take a look at that separately because, as was
mentioned earlier, the PLLM override is not used on platforms where the
PMC is locked down, so the existing PLLM override code is going to
continue to work fine on the platforms where it's currently used.

Thierry

> I briefly tried to test this series on T30 and this time it doesn't hang
> on boot, but somehow WiFi MMC card detection is broken. AFAIK, the WiFi
> chip uses the Blink clock source and the clock should be enabled by the
> MMC core because this is how DT part looks like:
>=20
> brcm_wifi_pwrseq: wifi-pwrseq {
> 	compatible =3D "mmc-pwrseq-simple";
> 	clocks =3D <&pmc TEGRA_PMC_CLK_BLINK>;
> 	clock-names =3D "ext_clock";
> 	reset-gpios =3D  <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_LOW>;
> 	post-power-on-delay-ms =3D <300>;
> 	power-off-delay-us =3D <300>;
> };
>=20
> BTW, I  tried this series on a T20 device which also uses the Blink
> clock for WiFi card and it works. So looks like this patchset has some
> problem in regards to the T30 PMC clocks implementation.
>=20
> [snip]

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3fvOoACgkQ3SOs138+
s6HnKxAAiP/ptewNZPFdwkeIP6ryrTtGjqvq9RkOsabalTkoA3Q//UTWk0IUAQAj
OVnDfKgHvg5ikCLUgWa6f9ZXnthJwpdpf+5mkbZECXQh8uFZnG8FxzxFsqOFK7SI
zdwhq/1EM2pFsO2EJ6g8hmUIfpTODexjedQJ0KP/bxIy7VStg8gci6TyFq7gSuLi
UxjW8XroG1hcYYVLABlc1JZ4/02o9mIYbDKCvA1aNzOLOww9jcKjlb5/lbR49vdf
ZbDJk6KZ5zunsJ3x/mdsBz9o7DhoE78MC7UjQwMvFYTGFauRU6/+UMfVqvn129sE
Yg1zd3rIvSvZdqK62z2iwiAm/VNHo0Ux+MK5I2IFxlwasEomH0hOK2H7z+YC/y+6
EWdBCwC7F8jEIKb1ABe9e9S4FBd7TqZAzV6SGlh9b+DFD1jo+y2ad0omf/eYCxZt
bDWafqOhoC2NZ9ogAMqxJreppRKPgYetlFxw12LKjJr2EY7axuRMT88v+kFETk+N
QW7rMqLniHoqjDWXjKs8qlVALmUlOii8nvPujOskaV4R2UgYMGLRXF127WmGFQfE
d8/PHdiOy2Of4g34epz8tH/uiUpZD799EWY1BxqEgNw/lseceVWseSMvLh48Hcg+
uUIZaMpE+zxLtf+RBy/1IL21DPjtv48rKzYCTmd3SVmo5znr8hI=
=S8i5
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
