Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D3C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfvK2lpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfDRJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:34:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37384 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:34:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so2076717wmf.2;
        Thu, 18 Apr 2019 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OY+Y5/4e/0bQmElG3rhImszyAhq0oLz+g1+5d97dMhg=;
        b=RfvK2lpTeJQ76cJBoX/gY5k1dQoYvwUQjKTlYEZ5vhYoZjLghToERlT9YC62ZuZ42o
         0MknLkAzmlcxc5d9Kql7Z2d/WbTscRC7f+mksWHZuR+urso3ETaKWZO7pH8Mu69O2mM8
         bN3b04jfb6tvbGcmUFPrldDPw00LCeOG9FAqcB4DAp53S3daXf6ZG3uq55QqzJa7mzi0
         afZbkYXFnxrHcWi9cL3RN420NTeIIZgea1B0p940dGBoNFn5hsXHUnIQcQ/XxDuhaJ2W
         jxF84L46Jxh0cWu5M49bXV9t20whVyCYE2RZ/QdbxZ5Xh0bs5TFCU9qnzdkOah51a/4A
         Wfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OY+Y5/4e/0bQmElG3rhImszyAhq0oLz+g1+5d97dMhg=;
        b=Tg/DEgN0QtZblYVwxhVfj6FbO03WyO+UweHXxLa5es5m8CFVOGL6hls6iLwrnWHbrs
         ULT8jZELL+HZlLhJpxuoVttUxMCnwfKwcYagrfZ5dQDuaaBTlX23j2ZJS98vuYu9s0bj
         7xI68d29gViyOV2DjVxz6YhRTDsznk2HGXxBYzmIRbGlPg1vzZWOkc8TxW7JxofUJ5Rm
         SoHd3MCYMhILRPUwuzGhWKG7ZrN708OXPwMYpRzSgt0wE9d6ZhClqhzCd+9Wf1gx7xg/
         dA3bt4Onr0xsvEKP1FiSy1sX2Lg2vqRsY+UvMG+4iU9p8qlZQqqS2x4cmLbvnW9qdhlh
         +CHQ==
X-Gm-Message-State: APjAAAUr9bLggO5JBCP2+lJ+hpSYMRL0qVuRiN4pBAbJJ4s17mI340BT
        XNluVgawwQ+M7bOQQvyM5aE=
X-Google-Smtp-Source: APXvYqzRPQ8jz49vTmM6c+28gYNENFonicWPi8XCkG1IHhXINhDHz+JtTZUI6Co+X8pkR0RymfqTiA==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr2500962wme.48.1555580073833;
        Thu, 18 Apr 2019 02:34:33 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id n1sm1057026wmc.19.2019.04.18.02.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:34:32 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:34:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: tegra: cpuidle: Handle tick broadcasting within
 cpuidle core on Tegra20/30
Message-ID: <20190418093431.GA26909@ulmo>
References: <20190224152114.6161-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20190224152114.6161-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2019 at 06:21:14PM +0300, Dmitry Osipenko wrote:
> Tegra20/30 drivers do not handle the tick_broadcast_enter() error which
> potentially could happen when CPU timer isn't permitted to be stopped.
> Let's just move out the broadcasting to the CPUIDLE core by setting the
> respective flag in the Tegra20/30 drivers. This patch doesn't fix any
> problem because currently tick_broadcast_enter() could fail only on
> ARM64, so consider this change as a minor cleanup.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c | 11 ++---------
>  arch/arm/mach-tegra/cpuidle-tegra30.c |  9 +--------
>  2 files changed, 3 insertions(+), 17 deletions(-)

Applied to for-5.2/arm/soc, thanks.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly4RKMACgkQ3SOs138+
s6EKeRAAtsGYzZqPjid4skeUt7zmCvp5nBwtyRRn0aN1t9IxqxYQE8RczF1LgHm3
QS3vbw3DLK0QiOrdwnZwQ+WZt/xCPVqp4itoZGxxM0JuYoxebrAzjjJNKO8cdsDR
fw8ERefyVav+ZFNGq87AK/gwNC8Oreyt4SeouN18zi/5pNfqVxMAhLhefsVID+9k
xFxg0wm+QNdvGXurwztCAAiVsesDdFTJGC062dqYTWmQDFaNOkkp1L5xEJJ2/OPr
m6rINNeh11zzol77+S7Lft/WuA0ZuPnG7wtlELSqI8Ic0ekx/IXpLr8coxko8xA3
UEbBGd78ISGxFKZJM/SfvFKIyLwbytbI79WGc4ikbDXBbrTXIvF8083OFRb3iqiq
wOgdDGfppKPY9+EDsREyoPdyyLZZVWZpgjMgcezfX60A+V9AiOfBR7yOMlXx+Wzi
z5wn2dNPe2+9ne06OiEn0oPZzDXA3MnQ1z7wJAPhKvEHz/h6RPSnEDrw8ZfTLEl0
xdREBaIWxc/gouVSlzHvYUG69ZOPeh+BLFLu9a7qo6z2TZL83tvGNOBylVDLyGxl
a3Myi6GGHuVeEgooCcwdrch6oMhJdIJmRtAlp6ks1CqK3ZeN04OJaDpZ36R4WrkP
R/1cAYtx6gbf0aFRhzqc5psHfvwZ4ClWyUKHMu3h5gHCBDYazms=
=PxYd
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
