Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344AF21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxYmsFSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfDRKAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:00:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:00:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so2229404wrn.2;
        Thu, 18 Apr 2019 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qaMF7dhcxfn2T6ooA/+7LOpgDwP2eJd/QecljDbgB8=;
        b=IxYmsFScF17wUmygiMHB+aeRp8JO1cpit9Lwuoe2Em6TWg+2rkTS9+BHxreifo7IaR
         NnYF1BjA1CHMc6OF6he0f+NO168dzr8qW5ogWGD/5+fZ+CyoO3k0AtJbgowA/dQ2X0V8
         mbbxGavcmoXGcl0KP/YfXj3ZtGcCO2Q9JthYjmZl/yASrfS/Vcagte2O3TU1LOgr91jg
         KHCH+3bnR3UGIqQvCfeXkqhV2OWt96gd/1ijsbOfU8JeXKW309vF+UV429o4q5DUoV9O
         ii0syw+3i2C3z51mTA5tjyz7HK0Q1avJwJNgcWqwu0frOC7wMGC+CXfHmWG87Bdkakia
         swuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qaMF7dhcxfn2T6ooA/+7LOpgDwP2eJd/QecljDbgB8=;
        b=lTB56FPUmRZlmmvJWtbgTg+RawLlmOYgTpsmn7xg1Jxpk0el9mCLJHY6C95oupZniK
         VLbTzOWpvAsQDBh1Inj0hUUkh7lxEOI18uVDJvhzj6Qtvf15xWZDCDX02+MjuF8pjPTD
         tk+E1sffXfyzuaBVa8ZSpPl/G2H3t2DpTt8HB3IbKlzKCXuQZ0dx0fvy3I0f7Ahfh7jS
         mHIFiZYTxU+il88Q/dJ2HQvwUZDBFyCCnqhtyhGcN6ZKCvh/mrNOrKBgTIeFBgqchbw3
         QXMuv9jIfEeJOabp67sw5yPd9q5Eqnk2gkGsYOKivYnPmmXe3uth+YGbgBPWGwAetpVJ
         gD4g==
X-Gm-Message-State: APjAAAWBLHfGTAoeRJGmD+8C7NqcJ1+6KNMTkJfEQk3ZO1daukFD7YNK
        VHA62LbuGZZf8Ys0jsIrrIlslaph
X-Google-Smtp-Source: APXvYqxRqKYvNQMlJuZY2eaeLM6Y5vmSN2HqKveXhvHjWj9LQJlebLCyXOSd9k6bu58+eAiFlDgoUQ==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr11476894wrx.32.1555581649856;
        Thu, 18 Apr 2019 03:00:49 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id h10sm1819902wrs.27.2019.04.18.03.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 03:00:48 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:00:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/tegra: gem: Fix CPU-cache maintenance for BO's
 allocated using get_pages()
Message-ID: <20190418100048.GE26909@ulmo>
References: <20190306225519.4538-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20190306225519.4538-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:55:19AM +0300, Dmitry Osipenko wrote:
> The allocated pages need to be invalidated in CPU caches. On ARM32 the
> DMA_BIDIRECTIONAL flag only ensures that data is written-back to DRAM and
> the data stays in CPU cache lines. While the DMA_FROM_DEVICE flag ensures
> that the corresponding CPU cache lines are getting invalidated and nothing
> more, that's exactly what is needed for a newly allocated pages.
>=20
> This fixes randomly failing rendercheck tests on Tegra30 using the
> Opentegra driver for tests that use small-sized pixmaps (10x10 and less,
> i.e. 1-2 memory pages) because apparently CPU reads out stale data from
> caches and/or that data is getting evicted to DRAM at the time of HW job
> execution.
>=20
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly4Ss8ACgkQ3SOs138+
s6H/pA/+PnAiqF8BhsLe/ca70FozOtJ2QQSCeaOEIHTZZh1O1igrR7pyLdRdOG3k
iHz9bjdIpXEwb5Bh0H6QvnS0RUs/LF/q2wnrYl/oy3CkqfmrAwAUc0KS9rhHxyy5
gm7EAiCwYr7WEwDEMkUwtgkibfBolvOfHe7wdmnPyPIXjsdkfea8/GynrFZ7FT0C
eAXi4aMqfSNHvq4Ns6ixR9huXWPuzZOsR1HFWG4TBMUnfE+R/jeNa65O2r/2JbGH
gDHxp6fXlvkY2294AQWcPFB+tWRkxxQmkWmHLFP7C1VGJ4BE/G0E2LQxxgzZxPky
96Lewz4/r5CItiUjDM/F9EjyhfqzLI35mFl2npbfESPmyc36NBsEVxLmi6lbvQES
WkuX54Of1LL/D6hHG7fIW524Q5QKBM2WxZZ7phNA4I2C5boJUARDYD9u/8u/AbeQ
dAGfyqkJ/BFgwFJ2JzBZj5WEZSh2W3JTCbCRYKMBRHijVYr9MiCw7UNJW7aEYaje
yP8rv/gZk0aQVKiLTiIpdA/m2XbGuGEvOY/mhNkY4ajKvMt+ESDHJN4HuPNCwees
Nx2dC0pkduqoiwLwFhxwRyFQp8ZolCLWnc83U4eDwjcn38U5RvIjGxek8UU0WTcB
rBW3ICwawPTQt9aj43bEDSzscO9/M9DbpGs8pH9aWrpALMWSQOU=
=fPhS
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
