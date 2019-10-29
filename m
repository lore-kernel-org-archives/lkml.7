Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE5F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/mdrYqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbfJ2NdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:33:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33113 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfJ2NdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:33:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so13702365wro.0;
        Tue, 29 Oct 2019 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUOdrvVXqhiPmXu5DftcsGiFCDGB+RbHtFoNpKa4ysw=;
        b=V/mdrYqGmqnhydWlB5LpxMfm3gI794N2F8fExAObjJL3LRBrcSsv1oLLk5iVjJiOIm
         mJUCpU/kFnZbaLgzfQnVSdMiAtW2/4+X/K80WECzd6+FNzpb2EnYGd08N1iqMPV5inv3
         tny6/IZpHkkFwIA0ovfKHwGiU24vgZoqR/2kqAN3SEXSz0kmhohQBsG6Xj4pcozzPn4m
         75i8WfQ1hQEqgCS7Q6t2QH1cE86paFaTUb69fkdH+o4H0dryB8QmGMrUHzsllTKkeUHP
         A6rP++/8A+Vj7qtX4b+G6P4zB9PtvqjRnEg2g07ouQFpZi2Kdn+vzdD9djZJnwXIBZwd
         D8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUOdrvVXqhiPmXu5DftcsGiFCDGB+RbHtFoNpKa4ysw=;
        b=ZChuQj4YzrTm0PWDnpbB5vdQ2tdjIIsM6G1TjqkYxYTfK8NluVICWiQLHzzNdM9ZDr
         6PvT97edE62F813OyoxCo8kH+S2+Fx4d3lNKfrdW8BNEHSYBokhAjuN3lL8v8gXxG8OH
         nbu/MpGzy9fTSMfuDSFOKdwcUgAcSHFkPn2yIaICJTOBWzOHZDRJv9/3PUi8Ykp0tanA
         n0n6TgwqemNto9OYB+9+ZvZISrAcif+ZzVWjLrRq2NrTOqNaJHEiqeEnLJAWosofMLbU
         CiqfuNqOV+yvh8pjq+HgM+joEzN3F0JG9HQNhkyi5JRIZb9gYxtkmFow2yoO6z0NJWLH
         16pA==
X-Gm-Message-State: APjAAAVTIlSHlINT5Vh895FFAidG2uXQBVSVhaoj2Cg7Z4wrSS+25gNV
        2SKSxFU8UNNcZnccUPLnSZI=
X-Google-Smtp-Source: APXvYqwAGbPumI+jLSMDTumFzX1A6jETiibkW+lFp33Oi92Qk4MXCH9qLl3oOtOEhkYAvmVYqeOdyw==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr20902373wrp.185.1572355987745;
        Tue, 29 Oct 2019 06:33:07 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id d199sm2945496wmd.35.2019.10.29.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:33:06 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:33:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Tegra30+ CPU suspend-resume bug-fixes
Message-ID: <20191029133305.GG508460@ulmo>
References: <20190730172340.14037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
In-Reply-To: <20190730172340.14037-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 08:23:38PM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This small series addresses two suspend-resume bugs: one affects Tegra30+
> due to a typo in the code, other fixes CPU hang on Tegra30 specifically.
>=20
> Changelog:
>=20
> v2: Reworded comment to the code to make it sound better in the patch
>     "Use WFE for power-gating on Tegra30".
>=20
> Dmitry Osipenko (2):
>   ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
>   ARM: tegra: Use WFE for power-gating on Tegra30

Applied to for-5.5/arm/core, thanks.

Thierry

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24P5EACgkQ3SOs138+
s6G5Sw//S0grOxV9TM8J+h8JsMlBe3IItRZfnQw0WAcovTCfk3BVoEEMvR08zuGd
lu3KKJSPyvf0tISCn/gFgrhNlBtwytO9Mv0gJRNB846UU3vedB6qzm026oQKkvRR
rFcYkuWXOt1rFofXbQGuXsT5cN/WlrgCmNbGCJBTkLAYnNVG9ASPrwD0Y2teidRU
dT/fzKNQlpvFNqBoRhXJtUY8T5cYULd0QVqWhqEY9X33LL0rR9fR4X0Bm3awgMsm
F2L9/7/mLl+BysnvIvVkQ+SbNwwks2diaxIEWlOogb8JM7uo5rzqacfTtVBd88Qp
xUAfpZ2iZBJw2FqbZ4R+v27K3f8OG+DgT2grxqiWaWkHtjma8Lfn8KwOwwIrpE4d
drdB5MjUJJNLBJ/Ki4fvONLwgcTYHCw1sZbaZydmDvYAh2RBG5esrFjU0IDCVQqE
D6FidCp0Xk+tQtKECZ8gGPEYIpMJw9eImm6iVRdV+YoS8w8WHjh8zLULciHyWx6b
a/jGGo835Xkv5EVv5LdH+tVIhR3IwOADjHTuWSNTYtXCijLOTgvhszvr3IChjw9Z
ejRuN7ZVDllPLBxmZ/dpx+M+bVLy1Ymm1LdnYjXBZg8UzE/N8cyagkaVpQ4vzN3e
X7SfNXDS0c9kE/SvJVkTlsMBucxua7Nc3lab70p3M+qKdhWwRn4=
=vR6p
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
