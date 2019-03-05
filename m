Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36342C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063E72084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVXSiItx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfCEMU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:20:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfCEMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:20:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so2355475wmj.4;
        Tue, 05 Mar 2019 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzGKN9mRN7Sys++hUYI4HR+6qh88BN0q4zlDb1Sk86c=;
        b=jVXSiItxNDDMRyUm1bOz9UAC47xNO+2IR4pvNf/HeBvu4F/SxKY38iEZu/aPl1zSYk
         w8qtl+UmOg8LHAUq4fOljjYSE4YS4ic0ze00HJccQdagkFVCVwrnjABQtW8yx63F4dX5
         m6jEpznvGoVR4OByAkZTnipYDOtnM9jorXc1eYYrbsXJjvv7Tyu3jD22E94AXcLv6DGk
         cdhZTsXa7vaAfyPw4pqgvFBF6RXex8cOngReonARC+wso8+0mvk6EV+VMwdtZCEsbo+N
         IUoWRipwnjbUqx71I0vPj2irA5+O6CqvHNJg6TQQ7/paVdmglvVRZy/C+Qap2fA9cJ5n
         g0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzGKN9mRN7Sys++hUYI4HR+6qh88BN0q4zlDb1Sk86c=;
        b=XrOlrgdo6UzUqCalZ6MB+DIYANAMouPITiaxFKvSadbqnK4lopku7DYNbEdfbQhRTi
         8TQBv4yeNV39daEZUAjEQs8XrV9i/xdRfEx6/nq//hXoaeI8lipmGTgLzfQFKbUzRPW9
         RqhTvR9J0ExCfC676HuK/U7KWSlnVnzgovY2RY/2bNj0YjmI37JgzlJDX1rx8de/n2T1
         +GK3xSyGxUSrkb1/avNVPRCs3QykzrDR17/pHQyJrkKnwrYu63WWiptagSFtTVxes9of
         coan9Lu0lnODDKaBVvABL4AhuUKX2kUL+vRdJ5HTNophJpZ2/YvZZawKSJy489BYDLlk
         jRQw==
X-Gm-Message-State: APjAAAWSWHkAg0qgIBXY8cQSSZdGpgXhlE1Hqo3SsffDFRVVfaVU+FvO
        5pIqRlNlYqLx/z88jKWfUdPcKGCV
X-Google-Smtp-Source: APXvYqzyuCQUOyJZAoWZYp3LZjwrUmGwzKfgjIfwyoCrMMkrjLzRQ1u0suJv/GEDXL5VVV6rYC/tBA==
X-Received: by 2002:a1c:dc8a:: with SMTP id t132mr2795629wmg.48.1551788453692;
        Tue, 05 Mar 2019 04:20:53 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id b17sm9688806wrt.39.2019.03.05.04.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:20:52 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:20:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tegra: avoid build error without CONFIG_PM
Message-ID: <20190305122052.GG26369@ulmo>
References: <20190304203337.1968705-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20190304203337.1968705-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:33:25PM +0100, Arnd Bergmann wrote:
> The #ifdef protection around the PM functions is wrong, leading to
> a failed reference in some configurations:
>=20
> sound/pci/hda/hda_tegra.c: In function 'hda_tegra_runtime_suspend':
> sound/pci/hda/hda_tegra.c:273:2: error: implicit declaration of function =
'hda_tegra_disable_clocks'; did you mean 'hda_tegra_enable_clocks'? [-Werro=
r=3Dimplicit-function-declaration]
>=20
> Better remove the #ifdefs entirely and rely on the compiler silently
> dropping unused functions marked __maybe_unused.
>=20
> Fixes: 707e0759f2f4 ("ALSA: hda/tegra: implement runtime suspend/resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/pci/hda/hda_tegra.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx+aaMACgkQ3SOs138+
s6H6WA//WB4N33fMs8yvZ6WJzt5fQx13eFdt+uBUbxiSVQ7R9DlGEpBImbJN1O56
ypMbJuL4K6EsgkaiYCtbJz8PKEdW3ccMFzw00LZG1F2EDCs8NwBGTKNgEPrmcip6
7rZO+wL9lmJbjQrZwGkEOi1UlZww/Xx0puMqr/fveIzjGpwFLYuG3HY/TIqmfbNP
sosgOQvvAwMoXFBXR/du8+cFkLXJTP9oDhTqJhS5wpwfkqdR4So4Rh3fcwmvLfHq
ZWm4zSDzNbmebCamq5Zx9wFUnWl2jYF1pvTTFauPJrWS4PGaO2Mvz8AtIvVK8cXU
9ziFNJTq8Fsf7t7twd/O4u+bGyVnDgYK+jFWhml/WG30VIfDCi1mrdZ32ThsTssA
5WBPTOlnzMpK8/37LMyZPkh6Zx0U7d0xlrr0BrAAs4xEueVfOKhjs90V8Y0HqAot
5wTkwhkp3bhNhgNUFtADKVleyRQYDMPj0V2J1fJnlYwtxDWLxX2gMTke+AEdng+A
5z8tubJhu3sBtlLShdB1m3SxeKyr/nBqqF3Qw7Tnc3HOGTmzE1ZJvw4u5IlauwOb
R7rJDMNF3pjP5rxMnIkNsCjq12VgOFAxigrpRKpILzem3Ay6nrW/wJSix+HABfmv
kO9fbYEhIUvwWoBCU90ot30cUF6nUbHaE1DqO6i8LOEVn6RoJrw=
=jU4C
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
