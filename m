Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A93C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59752075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6PaE9tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDCQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:22:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36020 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:22:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so9080576wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3pJe4p5ewWazd+rhT7H985HWq/OFsxnSty8f8712bs=;
        b=V6PaE9txuF9x4A14Zbl9MFKP24aNmt00K96NMluEs3gSnrSvhlYxCv/l210+W4mUwV
         R9GVyQhl/znRGyGtdKA9XzcRyeHCSb+rUE8eo2M/bv8xGBihcwHyjBu6i91/l8xjVL53
         UuXvfQM80fumKDAeLBqAG6PXyAS16rM2Chp5GOnk1qv2C7g3ALeoMWmVCx37Xk84+vgR
         SGoTvTHfwd8meeCSBSI8mUqACiSIi9F+8wOwuJ+38R7vduCE+x9FJWS2xMOxdw4lK9GH
         HE1RpROtDN5ns8RBQYdV8ivjuxDS28RQniAqPfnFoHszRqBmP0UomM6rY4MzzTSXkIaB
         EMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3pJe4p5ewWazd+rhT7H985HWq/OFsxnSty8f8712bs=;
        b=PxlizwVQdtPgydR93bu72TRZScnYbzXcxSyQlOIjGF2ppfFAC6n1X7tgnei/C+hS0Q
         4sFupx5EIIzhfdnI0bfYPpZ7aEmxGpUxzIcQWk5iGlRCROsJLupTB5W7hOGUcSjYKc2k
         BSibtKe3q8/2dkXHLSRYx9qXuhvddGZZlsP99LnfsgtqVptJvggnn/dExe5CdM+RvV6r
         +AVbipfW4ZrkW3ivgp6DtgmSOJzqDG0nzkG5FF1lSjAEGsln1jD1BRSepJySKiALOhIF
         FSfeyrd1CdBSuMhhy/MCinuAJ3VAWsedzLT2mOcqLs5Qh4qBvoZwdf11wXfF7TuOLjRX
         fi0Q==
X-Gm-Message-State: APjAAAXooUjlsuSeXdDtu02rjfZvY4u5ZPLucbYwlEAg8RuRgp6IH8iw
        3ARjkw5EUJzJ1ST3S3fzNnik4ZtX
X-Google-Smtp-Source: APXvYqxWuqzKACAs/9tHNTdh+RZ5+Mrq5TIsvjxd6IrGa/jh+6OsDrGNVWx3UisaduxVFqZOtlzvcw==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr629697wmk.75.1554308548593;
        Wed, 03 Apr 2019 09:22:28 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id v190sm41763854wme.18.2019.04.03.09.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:22:27 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:22:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yannick =?utf-8?Q?Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm/panel: otm8009a: add delay at the end of
 initialization
Message-ID: <20190403162226.GO5238@ulmo>
References: <1553155445-13407-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <1553155445-13407-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:04:05AM +0100, Yannick Fertr=C3=A9 wrote:
> At the end of initialization, a delay is required by the panel.
> Without this delay, the panel could received a frame early &
> generate a crash of panel (black screen).
>=20
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. You might want to go over this panel and replace some of the
mdelay() calls with msleep(). There are some that busy loop for 120 ms,
which is somewhat rude. Even the mdelay(10) in this driver should be
safe to convert to msleep().

Thierry

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3cIACgkQ3SOs138+
s6EtVA//Z69QgKOAgOwcilMw4WqewduCjc0p/gQGzU2QXC3PpvigA8rtUpDznXP7
4TJ8GAxiQxXWR1oOxcGKM6ih1MmeLM6z3bk8TSxyndZznOLu3QUxpIsFlyBcJ67a
R3n1YUf7NSyaT4uWhuJjRCdU/Tws59019ANk/iLC+udMMSxzNHbXxq4tRFtRvcHT
YG0965BSp9Bp+Ij9qRiYeWkYcTWAS1Er1wBYrGR3jpRVa3HaKK2nRf5C6BM4CmdX
iR0Jt6u7IL0M1Qub9f2JfVGVtJxLdbrsCYT8kfERwmJLxadLtc2B7qwF7uALD/V2
WVGCSLqjLK0S8nGTJTbsaVO7w1xt3o5G5UbprzHpHIdWUU8azgDdGSVk9si9SW1t
0z3L98aGk2e/8zmFxHeL0zgl6Uo+8kk0IwupwVOLEKvq6cxjEQ2PzJOHWXlBhgpz
544no7JxlvVaqkbEO9SpzRBaqR2GtXbCbIvER/u9AiFVOPNKI90PE0MJM04s6ovz
Zb3q/mST3aw+lfoeGdmq+TScm2vRzx7VoHQHZlugUJBjQg4FMYaJsnfiD0AC2ERG
uC8YrNltVUzKDyommtMpJmQz3rB0oIl0vBuz+RbagZZEujZDwYulz/6Sfh9FclRQ
tR+5MTXzoAxHO/XVqiXh2zdH+KAhaBwAUuA9sN3r8tH5tAuEPYQ=
=FgDU
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
