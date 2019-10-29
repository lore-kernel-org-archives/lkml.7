Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA3CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D06520862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyfI2Bbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfJ2NwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:52:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55123 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfJ2NwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:52:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so2654126wmk.4;
        Tue, 29 Oct 2019 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZGYQwf14hKZet/V1q9ny5mdIhjZ2BWooRO8zX5IoAs=;
        b=hyfI2BbhCltIGCnc3C05WqwgQbthE0YNyda/cizpRg3IC4zO8xcHM3pQFop6RtlhUC
         r5JzxnVoq4XEdf65KfxoTnOkPIsIWvbvjWUDpPmy+cYGRQiwKve2oKvuMHtIHnyYAhd7
         HLhGQURzkQYt/4eUU5SgSYp7g5sAFY0UKVx+mT8hslb5YdHeqWJBHPoW0l/Yd7gtSVwT
         gmnunxZIoEZ4muf5QI8kaycNU4UEy6LAHXItxErbUN3Q8eu0TBucVw9Q7S5Wa+fdwEJq
         ZpK2EaYqaZZ4tfZR4IMGQwjDDP9mNLkLFdDFaWtv7XyBpCoGcLYiY1x8jJSe9fi3wkZo
         L9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZGYQwf14hKZet/V1q9ny5mdIhjZ2BWooRO8zX5IoAs=;
        b=c7xeHyqf8v17AHe/Q9zGzQsIjSKz0uFq/silvIb1IcZzTL167EyUE1i9yhY+BsMjEs
         i9gOVUqyroaSwVtRGCpQXj9EhH268GZvMLFGzniVoKTiw+fQ7bzwW5P+RwVZnsysbIBz
         xZnVSfSesE3JR3+sPljfINciBiLwpC4oj5iO0LbK7bg2pRkWCNU96+hIeH3er44ZV6lT
         rt/vtJGYFlovmprf3f49ahpCDY5C6HoR2rZA8kDrux0D/gAV7/5rfWdL9lpM/WJwLUtj
         vDX8fIAiIsjWQNhZ6N8+a4t+oDXc4QdrNkwjJyTnrrg9p24osyE8vvwFeSmA9rc2fHM5
         yf6w==
X-Gm-Message-State: APjAAAUHEGE2UVzOD4GlY6ukvzuTFIRbaD3j6RMDtwc9ZnRIgqYiT1K4
        rFoyXUT42ORL+9T6LGr7W1o=
X-Google-Smtp-Source: APXvYqwwqob0oWcxcAV1a0Vd0fsoT8ZMQdgJlXVrrU+CJ35YiKg7XpAUbXeHfBKeszvuKk0Y7T+kHA==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr4184746wmb.149.1572357115633;
        Tue, 29 Oct 2019 06:51:55 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id k3sm14278833wro.77.2019.10.29.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:51:53 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:51:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/15] memory: tegra: Introduce Tegra30 EMC driver
Message-ID: <20191029135152.GJ508460@ulmo>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8tZVdKiiYitVG083"
Content-Disposition: inline
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tZVdKiiYitVG083
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 12:00:28AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This series introduces driver for the External Memory Controller (EMC)
> found on Tegra30 chips, it controls the external DRAM on the board. The
> purpose of this driver is to program memory timing for external memory on
> the EMC clock rate change. The driver was tested using the ACTMON devfreq
> driver that performs memory frequency scaling based on memory-usage load.
>=20
> Changelog:
>=20
> v10: - Addressed review comments that were made by Rob Herring to v9 by
>        dropping unnecessary reg descriptions, specifying valid ranges and
>        using boolean type where appropriate in the device-tree patches.
>=20
> v9: - Fixed memory corruption bug that was uncovered after introducing
>       some extra optimizations to the devfreq driver that allows CPU
>       to stay longer in the LP2 cpuidle state. The corruption is caused by
>       a very late AUTO-REFRESH re-enabling due to a possible schedule on
>       waiting for clk-change completion, the re-enabling is now a part of
>       "EMC exec-after-clkchange" hardware sequence.
>=20
>     - Added "type: object" to T124 MC YAML, that was missed in v8 by acci=
dent.
>=20
> v8: - Added two new patches:
>=20
>         memory: tegra20-emc: Increase handshake timeout
>         memory: tegra20-emc: wait_for_completion_timeout() doesn't return=
 error
>=20
>       Turned out that memory-clk handshake may take much more time under
>       some circumstances. The second patch is a minor cleanup. The same
>       changes are also applied to the Terga30 EMC driver addition-patch.
>=20
>       The pattern-properties of YAML bindings gained "type: object", for
>       consistency.
>=20
> v7: - Addressed review comments that were made by Rob Herring to v6 by
>       removing old Terga30 Memory Controller binding once it's converted
>       to YAML, by using explicit patterns for the sub-nodes and specifying
>       min/max clock rates in the YAML.
>=20
>     - Two patches that were added in v6 are removed from the series:
>=20
>         clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
>         ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off =
PLLP
>=20
>       Because the problem with the PLLP is resolved now, turned out it was
>       a bug in the CPU-suspend code.
>=20
>     - The "Introduce Tegra30 EMC driver" patch got a fix for the "Same Fr=
eq"
>       bit typo, it's a bit 27 and not 16.
>=20
> v6: - Tegra124 Memory Controller binding factored out into standalone
>       binding because it requires to specify MC_EMEM_ARB_MISC1 for EMEM
>       programming, which is not required for Tegra30. This makes the
>       upstream MC registers specification to match downstream exactly,
>       easing porting of boards memory timings configuration to upstream.
>=20
>     - Tegra30/124 Memory Controller binding converted to YAML.
>=20
>     - Tegra30 External Memory Controller binding now is in YAML format.
>=20
>     - Added workaround for hanging during LP2 when EMC runs off PLLP on
>       Tegra30 in this new patches:
>=20
>         clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
>         ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off =
PLLP
>=20
>     - Added info message to the Tegra20/30 EMC drivers, telling about
>       RAM code and a number of available timings:
>=20
>         memory: tegra20-emc: Print a brief info message about the timings
>=20
> v5: - Addressed review comments that were made by Thierry Reding to v4 by
>       adding appropriate copyrights to the source code headers and making
>       Tegra30 EMC driver to use common Tegra20 CLK API directly instead
>       of having a dummy-proxy functions specifically for Tegra30.
>=20
>     - Addressed review comments that were made by Stephen Boyd to v4 by
>       rewording commit message of the "Add custom EMC clock implementatio=
n"
>       patch and adding clarifying comment (to that patch as well) which
>       tells why EMC is a critical clock.
>=20
>     - Added suspend-resume to Tegra30 EMC driver to error out if EMC driv=
er
>       is in a "bad state" as it will likely cause a hang on entering susp=
end.
>=20
>     - Dropped patch "tegra20-emc: Replace clk_get_sys with devm_clk_get"
>       because the replaced clocks are actually should be removed altogeth=
er
>       in the "Drop setting EMC rate to max on probe" patch and that was
>       missed by an accident.
>=20
>     - Added "tegra20-emc: Pre-configure debug register" patch which ensur=
es
>       that inappropriate HW debug features are disabled at a probe time.
>       The same change is also made in the "Introduce Tegra30 EMC driver"
>       patch.
>=20
>     - Added ACKs to the patches from Peter De Schrijver that he gave to v4
>       since all of the v5 changes are actually very minor.
>=20
> v4: - Addressed review comments that were made by Peter De Schrijver to v3
>       by adding fence_udelay() after writes in the "Add custom EMC clock
>       implementation" patch.
>=20
>     - Added two new minor patches:
>=20
>         memory: tegra: Ensure timing control debug features are disabled
>         memory: tegra: Consolidate registers definition into one place
>=20
>       The first one is needed to ensure that EMC driver will work
>       properly regardless of hardware configuration left after boot.
>       The second patch is just a minor code cleanup.
>=20
>     - The "Introduce Tegra30 EMC driver" got also few very minor changes.
>       Now every possible error case is handled, nothing is ignored.
>       The EMC_DBG register is explicitly initialized during probe to be
>       on the safe side.
>=20
> v3: - Addressed review comments that were made by Stephen Boyd to v2 by
>       adding explicit typing for the callback variable, by including
>       "clk-provider.h" directly in the code and by dropping __clk_lookup
>       usage where possible.
>=20
>     - Added more patches into this series:
>=20
>         memory: tegra20-emc: Drop setting EMC rate to max on probe
>         memory: tegra20-emc: Adapt for clock driver changes
>         memory: tegra20-emc: Include io.h instead of iopoll.h
>         memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
>=20
>       Initially I was going to include these patches into other patchset,
>       but changed my mind after rearranging things a tad. The "Adapt for
>       clock driver changes" patch is directly related to the clock changes
>       done in the first patch of this series, the rest are minor cleanups
>       that are fine to include here as well.
>=20
>     - Added some more words to the commit message of "Add binding for NVI=
DIA
>       Tegra30 External Memory Controller" patch, clarifying why common DDR
>       timing device-tree form isn't suitable for Tegra30.
>=20
>     - The Tegra30 EMC driver now explicitly selects the registers access
>       mode (EMC_DBG mux), not relying on the setting left from bootloader.
>=20
> v2: - Added support for changing MC clock diver configuration based on
>       Memory Controller (MC) configuration which is part of the memory
>       timing.
>=20
>     - Merged the "Add custom EMC clock implementation" patch into this
>       series because the "Introduce Tegra30 EMC driver" patch directly
>       depends on it. Please note that Tegra20 EMC driver will need to be
>       adapted for the clock changes as well, I'll send out the Tegra20
>       patches after this series will be applied because of some other
>       dependencies (devfreq) and because the temporary breakage won't
>       be critical (driver will just error out on probe).
>=20
>     - EMC driver now performs MC configuration validation by checking
>       that the number of MC / EMC timings matches and that the timings
>       rate is the same.
>=20
>     - EMC driver now supports timings that want to change the MC clock
>       configuration.
>=20
>     - Other minor prettifying changes of the code.
>=20
> Dmitry Osipenko (15):
>   clk: tegra20/30: Add custom EMC clock implementation
>   memory: tegra20-emc: Drop setting EMC rate to max on probe
>   memory: tegra20-emc: Adapt for clock driver changes
>   memory: tegra20-emc: Include io.h instead of iopoll.h
>   memory: tegra20-emc: Pre-configure debug register
>   memory: tegra20-emc: Print a brief info message about the timings
>   memory: tegra20-emc: Increase handshake timeout
>   memory: tegra20-emc: wait_for_completion_timeout() doesn't return
>     error
>   dt-bindings: memory: tegra30: Convert to Tegra124 YAML
>   dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
>   dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
>     Controller
>   memory: tegra: Introduce Tegra30 EMC driver
>   memory: tegra: Ensure timing control debug features are disabled
>   memory: tegra: Consolidate registers definition into common header
>   ARM: dts: tegra30: Add External Memory Controller node

Applied these to for-5.5/clk, for-5.5/dt-bindings, for-5.5/memory and
for-5.5/arm/dt, thanks.

Thierry

--8tZVdKiiYitVG083
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24Q/YACgkQ3SOs138+
s6FSng/9GvNX2ESlUyo+ZW9xuN96/Lggg7Wh/rONstjJj8PeURp4Wyg9R+m01i9S
OKJaGKFDEcOOFC/cChD/plozuId2HBEXoVnwjExRF0MWabOWfNmFc2qp87Gq8Ucu
KGZOhHcXluq+bffxPAlKlHb0DbuPEPLDf6KXhRa77FC+8N3SwCZ/KMMtkLVqLW4F
X6t86MyVU35CoidXfzx+Y9tPbenuOJBEREFkFE/0AsveLJUd1Q1j287zR/wGdupZ
WKzH2PScDnjHSS+XRv+25mij0RN4nbHjT+1oUW6XAyf2L/PzaatT5qibcFpm1KAn
hZDQbBwt5b+wwuy7O1nSBxkAH2yv6kkq4Ll0K+potQeI7GqBtXD2wmNoXTMiklzM
SsxJpDS9orJmdH5BZDwX+g1DUHhm3WWunYR0bafrRCvxPRjGuOQ8T9SzH9rL6vuR
7Dty/TzBURBktNoVxdIzVWqmiIj9QVSH9Aze9ghGrHMaPVI3+P5jVRjSPJPlSHpX
cXEqLla2Xh+BhXjc+yNVYmpQvOTv1U0XcBUSWmEZycV1v4PYj6UAPqCYAw2xAKCz
UPeHl6MVG+cAVtWuDkPpHYccyGx99fR83okiqOGhlGkCjW4xX0YoOVMal4DqYrxx
wMKew82EmDMHh/7J1wJ81SojwUCYB0OC941Y3FlBCsIsTCGQoV8=
=zmek
-----END PGP SIGNATURE-----

--8tZVdKiiYitVG083--
