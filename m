Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC33C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7842070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkKbNyU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfHLJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:07:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfHLJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:07:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so13771292wra.6;
        Mon, 12 Aug 2019 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wmcM0NPgZ/akSKVG3AMjhXZq1lyWTGf0fhoqJw6RZHw=;
        b=LkKbNyU5R2on3UnMATz2IFHXh06x0U+tLEbFQEDTr82kMjglHV+mY8DMFJjOTkgCM5
         lFQkmnWwCiE4EC6o6HT3EJaUDqgPzkKd8Y1zhklIvR3DO0tS5pCoOjhKZ7NeS0hF85IF
         lUix+P29fiNerA7lSBJT5IK/gQACZryDF7aJpIS+gG+JlJCtg1v2bW6e0kr/mR9Ks0bu
         /Vz0PdcHuYX59puWxcRhbA5qZZw9nCLc9z+OzktnZeQJ9s2tWPfFbBjxrLzmcNCue55c
         XP2ILZWi0yxoZ0OaEwBaEu0Mvjb5P9U2OFoF2C0KjHsDSrfB5Evr1G71gysTJKOJMgo4
         CA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmcM0NPgZ/akSKVG3AMjhXZq1lyWTGf0fhoqJw6RZHw=;
        b=k1z08jMJKVgX4XfNAmdhvhWKig5+6/OLgdyrqY6x9z4W5LNSNSIM/wpl+Jo4egUcJw
         W3Geb2OpXo5fBFSwwe3u40956O3ywGP1fkFF/8KeYuPmkNVPoIiPB/2UFWKXt6Wwdodz
         DrIdTIB4pIht6qPBJfiwBWYaoYsGQ68iDU7IjTRIFjPQDXoYw+ZzCQG2IfFQN5MI6JoC
         CHyycfbr9WQbU12OOYVrLlXQ79ic2FBEpfB2HthpmnBg3yEGzDlpd85YzH+hDiMcjTdb
         z1cINNIjzhSt7eP7Bum/OrZb9+C+vBEXYYvQ/CQbGnwCjrfFXBVTbiD4kP5BrrTSCdjc
         zCmw==
X-Gm-Message-State: APjAAAUBVHl9FOLZiC4wwiTq/PAohKH122o173XBbsYI9TXv57Db0lbr
        FBl3iNIxODfxh4Ze/c1x+FI=
X-Google-Smtp-Source: APXvYqxpRXM6B5c7BzMe+AjOgE8Krsmt76TWtHKPfh2xCgdN0pLj9g/mBX6587N3BDUjx9720HuWOA==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr41015917wrl.281.1565600821820;
        Mon, 12 Aug 2019 02:07:01 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f197sm14226592wme.22.2019.08.12.02.07.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:07:00 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:06:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro()
 implementation"
Message-ID: <20190812090659.GB8903@ulmo>
References: <20190808222430.28477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20190808222430.28477-1-digetx@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 01:24:30AM +0300, Dmitry Osipenko wrote:
> The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
> WP-GPIO state need to be used instead. In a case of the GPIO absence,
> write-enable should be assumed. External SD is writable once again as
> a result of this patch because the offending commit changed behaviour for
> the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
> which is incorrect for Tegra.
>=20
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RLDMACgkQ3SOs138+
s6H/bxAAqFkZoITao90AFM94NfokMprlU0+LtNV+socSWBzYJzTPeGoAvHvaVn22
qqg8sUervEonzshVlyUr4+bTty5QfMhtn6LVPQN2nxCFz7GTiGR5ZM4sLqV+xlMu
SekWpTgeQIFeyFx/k/ZL4UUzbgAZx4BXy2VMdZmqh+ZLU5Ou3rkmhf8lUU2JxJtY
wtbFhopsxovlRE6ElAuwraN8Sqd3RepRQKBxHZJxazXY6Nvn1Ni+KUVaWow0lb1w
jL9lAgAVoDI8CfH8OemxOTKMB7BvJLAJ1VmniZuwTqpQqlrhLnCkb/Bw29jjmToj
wLVr7+m+96CQvpqgrcTg13QAZyH2gwr1DjJTH6u1XoOij0fezLmADg4eETgUxCjb
BSdPRqnH9uQq79szJ42464aRyF8Lcu+yIGT7x7F/WX5AVU0Jjtmk9khvGQOsVEvp
fv1r7GzsiQy1RyH2fyjRj9yuiyHwVAvdVupHhkcLz3lLGFBnImwM2KOO+LjJQPFq
9i11pbwAFkZbUo/mBY5Ar0nBigu7eIZ6gtk6vIF0pi5WrQDqj0EpY0M72TvbwQfh
Nlo/MNJqtQcsO7FT2uYWKHLZ/9VvONkK44tS5KGbceCGXeAaL1vrxDnZ761lc5ga
c4xiuv+/CputZ4qYunS0qDbSdpJ86SfDODhghzbdM1TaOx6JuyQ=
=5Rj9
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
