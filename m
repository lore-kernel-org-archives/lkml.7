Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3268EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090EC20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdpx8GZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfJNNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:11:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:11:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so16703424wmc.2;
        Mon, 14 Oct 2019 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UHKBGIwICn0kPJdi1qlZKSx8IaVYirF5sZG0fskSVfQ=;
        b=Rdpx8GZ80EdQOCT3GfSkiJep76Ap1nizK0m9sOun4I1bbUd78wNv8bB9wQZu/SbICZ
         /7WxdPNEiSHnIL7N95z9yzBk0QOaCG0CbdUcDVH9Yfk1eKK4PCOCqzzdT9a0XETq/Z5O
         97BRKb17XZk3rsJa7JhM7YZAtES1tCg7vu5MFVTrkZp6cb3xEgxqOMjm8wHGCOwTb6+s
         N7RuoNgAAealTeL9Oe3jDVeo8EmFUzIpawgTbGgwu9XL8bp+KnNQPI4dcK+xhh8x9fhp
         JJi7/QNXiDm46ctocJjho+pmBV2lSzZE3Vw28ZkbjDauA9lhG5Q86HNLXziSwWa1938J
         117w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UHKBGIwICn0kPJdi1qlZKSx8IaVYirF5sZG0fskSVfQ=;
        b=ecwXgdkymAQ2TyJKHousE/jZa4aiFGdWpkmqbaJVjpe+scof5yb12VlCGvYQKXFDLW
         oFlnYuVSEjsLab28IPYgYZFNSx/JILMIni5SZEKN04gm7xQ3F0axLIT9aq9/OhALMfDr
         23NucUoVX8M1Q38+p0/qr6azI7bYa5zr9n/g6sx2qLVOHgkkp56F2VlAsQqn6UEdML3/
         jctjAWWS2a1dmktyDU3Ehng+R8v1sMOxgilDMKqJlFr/ziizbVEdAK8j0V3CKU9JVM0R
         GGYlKPiE0IJ80R/ykZHPHPtlWRJD2cM+58sLbjpJ5BhuwJpOyvPRlWrzft7IfK61LU4E
         FoQQ==
X-Gm-Message-State: APjAAAXOcHf8SUtlDv/Nfqi0UUfciogRTV4zktPP51FKPPflx5/f1L2F
        utWlE/PZOn24yhxm6yv2k+k=
X-Google-Smtp-Source: APXvYqyFelidxzgHe2WauzzxwjHTCC9LWHS2ioOlPQAHY9XZN088SjvFpFpiErX7Oj2MhhoI6tqPYg==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr14568666wml.83.1571058691758;
        Mon, 14 Oct 2019 06:11:31 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a13sm49716341wrf.73.2019.10.14.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:11:30 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:11:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com, kishon@ti.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com
Subject: Re: [PATCH v4 1/5] phy: tegra: xusb: Protect Tegra186 soc with config
Message-ID: <20191014131129.GD422231@ulmo>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-2-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20191009024343.30218-2-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 10:43:39AM +0800, JC Kuo wrote:
> As xusb-tegra186.c will be reused for Tegra194, it would be good to
> protect Tegra186 soc data with CONFIG_ARCH_TEGRA_186_SOC. This commit
> also reshuffles Tegra186 soc data single CONFIG_ARCH_TEGRA_186_SOC
> will be sufficient.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
> - new patch to protect Tegra186 soc data with config
>=20
>  drivers/phy/tegra/xusb-tegra186.c | 70 ++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 34 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kdAEACgkQ3SOs138+
s6ENixAAwT1uDw7S/gb/XqpdKkQQys43Yphllfc3nDJpIKo/3ALvyR/5zy0vs2eY
XXgRaMTbrwGk24LX9W6LaVy3J/yHDU3rGwtbMVhumATQ/XuoUzOOQK3jgmgNlEGl
RqqHgFUM1zxsANjl+UpnJI0m0ba1ZeAfFqDl72OE9TaQOYdNoxq3Hc9nDiPYTZRh
CWKJwtku6U65v9kpWMSMdZ1P18ZkYDNPzFLD/QHy8LdBz/4Vxtf4QuTdWYZWwEqD
XdzddtF47QmKvPhMry4vpR3AYdknLnRG6dFEevqBKoVU3kgNmjg1d+CIWTLI/BUx
AyDUmbFmgqQyCg+Af3RL2UZ4TaWUYMyY9tfDgmrRskwcgIkklP030Hw9Foua7gHK
EDS5vc/7Uuj+8TF7fa9gHIpSDZ+bfhKjO+mvIZHP51vnQwbpj6ZU1syZHZ3bMq0A
09HHUflkmEj+IJF/gp0/Zqh6pnHaxGEKVSBDsaDjKJ5n6du0ZMReH7xI9i04f0dr
KKahgPpmppYykkJLnInFCOJCPFMtYPRh4qUSs9Z2xJM5zuEU5b+2deznAZvzHmu3
Juf4eAGf1F8rGKYL6f0S9yJqikyg7+F2NqB/sUoT70CpZlup3Y788sSuh9dBb7uW
gmkL0vUTFP5R+4OhEnbK+3SiFRdJZNbnDcYeU/WEaoUFHk/+On4=
=jsyo
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
