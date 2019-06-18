Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F401C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHaYMj1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFRMVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:21:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:21:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so13748624wre.7;
        Tue, 18 Jun 2019 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QOzO3vXe9mjQtVEE+7Hd0tbKU0ism9ijyqET3O81VSE=;
        b=jHaYMj1Mos6eVknDtjGGsGJsINRMx9kgJqBgEd0J4QbMLp7hj11aecRZahOepzZWYd
         ANPIe0RIQg7j6LXVk+qnPtDXSCgnRCD2RB0WWzwJko0UzVzU79ZiArGnHYEySlJ3q0KO
         ZsK9yWaEMr95yH9k6Bvu+uWnVrYwILAnxK1xcAF6pdEMzR9ecT0CA1u0CfJ28MoJX7c2
         4XBRMaWND0T4pyAWDrqeSpQ5ZpoE5zhA6cEgIrY+JZmZJyz2xZn6cGYmC7wvkt0ZzNKQ
         7ZintUPAF1HVjh91KeUJWFsFuQ2Z0XK2UyMPfnBJSt/O+04IR0dJg1Ri99SnZhR0wnZb
         uRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOzO3vXe9mjQtVEE+7Hd0tbKU0ism9ijyqET3O81VSE=;
        b=Sl2BG/Nech+y1eFt6O4tt/xSwL06LvplW+IlgAEAyUxopQv2R1a1VYvcvkiZh7ZaFM
         A4JreSORl4K5TlqLr0LIyesod5vhD/Z5T4bicjLkjWxZ114w8MfiOCEddUeKFNY8WdiV
         cEiZijzjLlPSV8I5JI4cQUQZkSoB9oC6nHBoXiQRIx5AZt2qXLiC+gvVdNF0ITgewuEn
         7okJPctvc3X5tmRg4wqp3bgFprooWUO/YelgH2oNUzOQTUGZV0SjyrpVXon7LReB5mSA
         HZHYGPaoAb/iJIesuzuWFdxDxyPOWGW+bC7oMBjlQ1JxgUY74Wbyy5b4FYabXA5XJ00u
         hI4Q==
X-Gm-Message-State: APjAAAWne35Ay1YFeLA38ZoWO4iWOwfrcjTyQ9VoXP3m5teFbwDuV0VD
        qjCIOPAVGGSsCoDAgN/J3EI=
X-Google-Smtp-Source: APXvYqzGfNVMzR1nsfggFLjk4ZAhEDEl8ZZ04tA2tEkmTWgrWn3aWy9z6G6LrVHkxBxQkPIYZnhFZg==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr27572224wrm.87.1560860471196;
        Tue, 18 Jun 2019 05:21:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id g11sm12188587wru.24.2019.06.18.05.21.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 05:21:09 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:21:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock
 implementation
Message-ID: <20190618122108.GO28892@ulmo>
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190616233551.6838-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1SVgZ+3xbDF9VW5n"
Content-Disposition: inline
In-Reply-To: <20190616233551.6838-2-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1SVgZ+3xbDF9VW5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 02:35:42AM +0300, Dmitry Osipenko wrote:
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers. It is not available using
> the generic clock implementation, hence add a custom one. The clock rate
> rounding shall be done by the EMC drivers because they have information
> about available memory timings, so the drivers will have to register a
> callback that will round the requested rate. EMC clock users won't be able
> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
> and the callback is set up. The functionality is somewhat similar to the
> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
> more parent clock sources and the HW configuration and integration with
> the EMC drivers differs a tad from the older gens, hence it's not really
> worth to try to squash everything into a single source file.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Makefile          |   2 +
>  drivers/clk/tegra/clk-tegra20-emc.c | 305 ++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
>  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
>  drivers/clk/tegra/clk.h             |   6 +
>  include/linux/clk/tegra.h           |  14 ++
>  6 files changed, 368 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c

Hi Mike, Stephen,

The remaining patches of this series have a build-time dependency on
this clock driver patch. Would you mind if I pick this up into the Tegra
tree, so that I can resolve the dependency there? I can send a pull
request of the stable branch with this one patch if we need to resolve a
conflict between the clk and Tegra trees.

Thierry

--1SVgZ+3xbDF9VW5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0I1zQACgkQ3SOs138+
s6GmNxAAh2/FHVRpd1T/DtfRNWMm4FuJgUZNxY4iWXI2BBihdTriaHoryReZxM5J
jbMpjbFEF7O8luXOxjT8N9msBIUKeIEGSMssD42yuz0YQ0qFAi5R8JJCk9ZEhP37
S8Mucfsuc3W4y+E1k6TcYAyCANyVbnYVQKP2JW/cTsP8kTpg6kTwSOVC3zqSSiFM
VwxqF/e3WFbvH/YjQFExotAB2JrTlgcdLOwwBEFI/pbgW6QwlHXNCQS59x10bqVa
VqanvlQQusiu6F1CFJRQgy2VzJZHOIv1mtj0RjoM1WF+aNSFBrRr9FMlniQrFedj
mvH72ES60Ely+A11pjdTL3h5n2ckubGHREU6d0q+Qd29G7IP+II1NRbHWXi0A6Gp
p3m/SUHGdKLltA8mSH6si9trqXevmKfM3lz3lF3OUVzyVmwk7q2o3l4BoluVvOtE
s41nMWBNqWhaVw7HWcyAeAXbjnTsUcM19ZuLpe+gJw0El/yPU5gJ95/KPFapEVxw
1NVYt4F4mSgT2jqEdP06w2aoh9N+sW8lBY4vMaHoAxn10ysSR4UT3aPj3228SnXK
gRZIq1XpQvruxfowMHuMuxllWjADW8HCTBw605/M9S+E0jArFo831tDm27tp3bv/
b882fe4FQ96z/KNDIdRTm1URKHPWz6ZsBGjptfhBBj0cm9KNI4o=
=XtZc
-----END PGP SIGNATURE-----

--1SVgZ+3xbDF9VW5n--
