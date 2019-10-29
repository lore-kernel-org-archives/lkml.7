Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF82086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCnj9IQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfJ2NRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:17:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfJ2NRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:17:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so2384208wmd.1;
        Tue, 29 Oct 2019 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CuEYBnVldm0xxstpEXocoTVVeQepXqnFEfpZ5yvIc74=;
        b=uCnj9IQKetzW2xxLmfz0mvOzpJ3P5znjnoemHD+FPkbR+UlNxHkda98IAlQeivOb1T
         IjlL//t09B6J3vkIpfDg4RAfo3f6Tf96rQWMKHkhCvBmp3+0IxC/fFADUYbzpWBEL9Ij
         7oL9RPhK6Hsyj8FZ3Ix566bxM57jffiBQQ2A9S5Bu4t2AG8WWp1rWqMXQiPYHs6RnqtN
         JwooYazXMZZKWsnRKojFbpyiaa1DXkYxpEG+0zhWfd8Z9uqObNRLKh3cSkNZtmx/VmuS
         mGrqrxUA7Tzj+ecr61BiiFKwlWLLBvZJ3aI9NALpTOL0isuiRI857rlBArWuJ8mrBUjb
         vxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CuEYBnVldm0xxstpEXocoTVVeQepXqnFEfpZ5yvIc74=;
        b=oZ6FBmV52JWefAj26YdykJZ0iH8nIXpH4oz+6sbR56O24/rP1TSr9y7Fzo4HD1o6op
         3BZ8eLZLHWuSa3RFPAbvmCgLYgqKKui7SQoDAzSo93lyuCgzDIZ+jYzLzAbh+Vl0w74C
         o/WMeNls/UmpuqWKk1cHm/AWtk8XgQSkCYOGhE+Qv3kgVrQP2cieyT46C9tclv3C8SrZ
         05pCHSYZ6iuNmV+8rhCOnNzi2fv4Cofq7tSif8z53kXGr/ooVdK9LcCbsz3p4f1yuPax
         VTTWpaOPDvkhZ2jcJ6Pjd1oM2sf9RcnClCwuGmryBhXW/qaFPDByg5aTeeaCRvgim20K
         0ajw==
X-Gm-Message-State: APjAAAVz8ck5RQWSmfeNF8YHs3l0D2beklLmiQUDdMcCpR9eAzIV1dQp
        sBIEN2BxRy8Pv/6xpzdWqcg=
X-Google-Smtp-Source: APXvYqyQqKMqEj+7UPIGpfNmaSyAprcDG1EIjtAC+9qSZHNrW+TO51/52vOD74YphF5VSCHTy5IHQA==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr4421382wmc.150.1572355036046;
        Tue, 29 Oct 2019 06:17:16 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id t133sm3067226wmb.1.2019.10.29.06.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:17:15 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:17:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: tegra20/30: Optimize PLLX configuration restoring
Message-ID: <20191029131714.GD508460@ulmo>
References: <20190922215203.32103-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <20190922215203.32103-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 12:52:03AM +0300, Dmitry Osipenko wrote:
> There is no need to re-configure PLLX if its configuration in unchanged
> on return from suspend / cpuidle, this saves 300us if PLLX is already
> enabled (common case for cpuidle).
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 25 ++++++++++++++++---------
>  drivers/clk/tegra/clk-tegra30.c | 25 ++++++++++++++++---------
>  2 files changed, 32 insertions(+), 18 deletions(-)

Applied to for-5.5/clk, thanks.

Thierry

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24O9kACgkQ3SOs138+
s6GMDw/9GSfkmhdfZL9cfuprPRnzlzsiv7vNiAunAYdVGTo+4P1Z2dPgJLS0dvpp
ZIHYnGem1kSVNGMMG460niQbkyXSB4+xLrCVdIjyVHX13uEMOWItkB1bLKBR/8qQ
vTCCMfmJaOeir4eVpNTh3+5H2CKN8lkv4IT+YqCEsAhDZjVSLLcHf4a663WZkrHP
MFpYJCyp5/lSE1XiQfPb3FVPuLl/cU2vFquqO1zarkE4g5PnzQEmZpSUfCHM92+c
3RakZe+tsuAVOusNC38q4Hec4MTOgSu9aK+u9yjfuHokyDlo1UKoouruRZ6PvMm1
IfR/6zIJWUhDv9bQfID70rJuhHzI9VntNl8stLbcb//aPJk7xeySDKEeZkGw1MQQ
I6cxgareAOir2XcSqXxuDTRx2bsBgRj7FYODXvUaQjEL5mZ8p7hOLvmrn31ZM/Q0
sx1hZ/0lJTZd4qg+nUffxojUETrVTCOSc2K2r7dl8J1o2XJ2kxswePLBSHTimFq2
4uQEtYycToltWXl8c/Xjls87NDsypY7NAmY3Zc/8AKcUhNqfpTxiVqJ0V72y4Ic4
+i3bxOLUE6Tp9FBHbFLs4hEGJIw+gfc/JrthBFMsd2/vJzjcApOQLPIPaAiqf4a2
LSYvYetgeLoIU5SufwYnLKAOSVgj/O+AqEhdC/+rW6SS+RZhK7Y=
=wjdE
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
