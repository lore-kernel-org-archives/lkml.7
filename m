Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B165C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AC02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM020o81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDLPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:37:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:37:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so12489878wrx.9;
        Fri, 12 Apr 2019 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElXle+eADIRz3EBMmMcLyCtORPRQhAKuVrkbpHYvZ+w=;
        b=IM020o81/7sOpX+9oxR6E6G68NAVjgFBnWYC9RoAxuFUqvjMgbpLgTkxEN1bKsorQB
         FRYEAYzZADg4TkcKfDVnlW0WxVUiq64K0E31D5cGoLehKzAN9mp/63gITAiMhra+NwRh
         TQpRrA4GIV1edblW2PMI5S16ZNucOrk2d6bu1VosuddA6zqgM4/4M4EByrzjz96D8Vtj
         HP1iKZZgD1bdgHfkLKXmIMCMetyIW5knaNimEj1TU5GeuWea/5JWhvMj3/N0VZAah9l/
         bqDJAIaZJY2sur0KavHy6ZzQj4W1OP6D6FNYsYTLV2WdjYvyqebx35tBkaBjD6w4vnKs
         SAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElXle+eADIRz3EBMmMcLyCtORPRQhAKuVrkbpHYvZ+w=;
        b=IiVNp1e6ZKeeB/06Dx2RD/NuX7GOM9FCJsK3g0yQYw7LesA/KHne4B8S1lIryn4E9p
         0WctTwSfC/7M/pCi2+V/aaWwcptv+8vsrA4dH4mGWczu4rSrUiYc+uHxS/zCZUS9hYGu
         q/oYpsJKtA41w2zbugbNVYfaI2/oOc1q+Tj64x8LckeRRCjv2UP/HWqfAF3d/Xh4WpZ1
         2wjDnOSOrNflYeRkYxygYaehYzzA73S4y1O3u2YSxDqxcQEiVINONQcXgBMaYMZKUGka
         s7mQXy0QFhRGzE84kcux93IglafAnua2P6CqXXIXYHDseNt9/f1Reize8EHKnFvkdRCw
         ZDqw==
X-Gm-Message-State: APjAAAWXpKK7TOf3hwUJbxgp4GLdt49kNrxQySrvHAe9ZAlIe6WqQJ8W
        wFexorT5r7xPfeWjR2fOCMU=
X-Google-Smtp-Source: APXvYqxapE9Sf+tg/4TZUQejyL92O4xLVZZX2T4FJvQAajGu2QZuLbFiL071QFh2L/hKRHBUuJjYKg==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr35432112wro.170.1555083427044;
        Fri, 12 Apr 2019 08:37:07 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id z7sm40547200wrt.10.2019.04.12.08.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:37:06 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:37:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, riteshh@codeaurora.org, jonathanh@nvidia.com,
        anrao@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V1 1/2] arm64: tegra: fix default tap and trim values
Message-ID: <20190412153703.GA21159@ulmo>
References: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 12:37:53PM -0700, Sowjanya Komatineni wrote:
> Default tap and trim values are incorrect for Tegra186 SDMMC4.
> This patch fixes it.
>=20
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlywsJsACgkQ3SOs138+
s6E6Mw//WDz1hmJP1EYdChf14F9QRTs2GQTtCBtMxETTnnXyy2UK8OBXD1evPufF
aGhnAsAUt/T54d+yclfb0u3eN6htIslO3OR/uxX/QQH0rptJEB3xEqbq4dQB66lf
6V2a03V/U41cM4UrXy0/pcYbMY04TlDejqV52inpt5I1wQEehCcFT8pqKGCd/MdH
4H2Vyoo4ffcosaa8WHsYZJnOb3lye3IH5UOeAMMihywH0LU7B5ZT9KZ0phC16dmm
V6SG67mV2MwWpELHCtYrzADJoR/CFjlvVSFipbFqUTthWPCxScQh5A6YIjEb7LZk
ZsGB0AoZH+XV5iignr3mnoj4K8xccp50vhGXuXKYUBMvzInJLyXc/L5vK5kfljeJ
ffwOq5AOnyvSqN+t5OdwnYlS0yKTQyOrfalEo+dXNjCX8W8UgnLaY0JeHFkBR4kE
HIRNBDh9uzt9wJkOJuXrR05UEsIbbeX21Ag0EXNdZ4E4G96gbypiBgtupSQmG6XN
Awj5P54XIv/XLC0mBDEU8X+k1rnoFTWUvL5P4X5toEATvGDxIH9So6cud7luAxQI
BQC7hpEk9uRY05DSVzU1mdTYQpg/kMJU6l6djdJ67dVTLespiYyo9VcEDc19miNP
+DQpVYLW9eZeCZPA1ca1EUjDLpqQZ7Ojfz39e0+JjNqnix8Oyw8=
=L8ba
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
