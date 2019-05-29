Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD25923A9C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqFQqfF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2Phl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:37:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34704 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfE2Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:37:41 -0400
Received: by mail-yb1-f193.google.com with SMTP id x32so963416ybh.1;
        Wed, 29 May 2019 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fio7dUlt1rGxd4N/JsSZl4I2zSSJgskybyhAabp8qBE=;
        b=aqFQqfF0W37PBUI4pUUi1s3R0B9YCG94oFaD32p1rxydRqcrlud9PXInaYEZYaQZvo
         sGsnxMSZkcqJQHGyxHxtSncB30qEXQ19+uaapDAnIrtZ73jWV6TWpLC7otcw4YN1+/hQ
         aVPrwYV1S8R6kYw1/5lTd5+TDw8enkJD/k7XJyuDJ1ZOKDpVVcc1jR42tQVdpN1N7USE
         liW+g5slJey0iv1hKBLMaYzsXOxSV1PyNDWOrwMQ8A2FLni8O0acyDBPYX6V59/whap6
         ALs+RSmpV5uc58ExJhJcDC0YqPeiH0g7u4sAGKvNsnPEKoGNDA7U2x6PC5SD/iBQouDa
         KUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fio7dUlt1rGxd4N/JsSZl4I2zSSJgskybyhAabp8qBE=;
        b=gTXUray5hoAsEWN/Ky5Lr9yH4MDAcMuHCkkeDNFa92sj+PeJdAfbr7rnafZEiC5JAY
         2J7DwUBJWOiqiGLSH3NNc/pIeGXEOAc0E1agF8DMEpohfktjEaRyqqMJWF3MiGdEMtyH
         GJUkKNHIBBOIGPzFW56rGRBx1Hnkjqs6dHtCbwlXbdgqMi5M0LJRNj9PAyfpk3X8pZ1f
         VHDeL4KcUgTL9gsMDFqkN+zpRSZ0P+ifT3Z+aaFppAYl1sDpYOChsJs/RuBqtB8wWVcQ
         /yzFzmdYqX28aesbNUDPTL1WdC7c+DNjw6yTvNEFd0fx9YyXexZC1OO8BqtS67q3RaGU
         I3+Q==
X-Gm-Message-State: APjAAAXrpwiUZOnlXazRFKQeE66AiVi1ixIeZs4iCDcomTiZcFoIolMX
        vmw7Bx2sD5lC4+MlaoycXfyt1HvCtOV74xWtoqA=
X-Google-Smtp-Source: APXvYqyBTjFLtYiS6Id21vTREplP4Km3FL3I4Q5/YF52rJ6kB/IA8HTvnF4aOQE13ZODp24lCwjl85FnzE5EtEIkwwk=
X-Received: by 2002:a25:ae22:: with SMTP id a34mr26488141ybj.438.1559144254880;
 Wed, 29 May 2019 08:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <20190529153255.40038-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20190529153255.40038-1-tomeu.vizoso@collabora.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 29 May 2019 17:37:23 +0200
Message-ID: <CAJiuCccFG1SATp7QuSOi11MmbjmgX0ZHsTv=4zuXqXMG+=-7Dw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add GPU operating points for H6
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu,

On Wed, 29 May 2019 at 17:33, Tomeu Vizoso <tomeu.vizoso@collabora.com> wro=
te:
>
> The GPU driver needs them to change the clock frequency and regulator
> voltage depending on the load.

As requested by Maxime, I have dropped these OPP table as It's taken
from vendor and untested with Panfrost.

https://lore.kernel.org/patchwork/patch/1060374/

Regards,
Cl=C3=A9ment

>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> ---
>
> Feel free to pick up this patch if you are going to keep pushing this
> series forward.
>
> Thanks,
>
> Tomeu
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 66 ++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 6aad06095c40..decf7b56e2df 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -157,6 +157,71 @@
>                         allwinner,sram =3D <&ve_sram 1>;
>                 };
>
> +               gpu_opp_table: opp-table2 {
> +                       compatible =3D "operating-points-v2";
> +
> +                       opp00 {
> +                               opp-hz =3D /bits/ 64 <756000000>;
> +                               opp-microvolt =3D <1040000>;
> +                       };
> +                       opp01 {
> +                               opp-hz =3D /bits/ 64 <624000000>;
> +                               opp-microvolt =3D <950000>;
> +                       };
> +                       opp02 {
> +                               opp-hz =3D /bits/ 64 <576000000>;
> +                               opp-microvolt =3D <930000>;
> +                       };
> +                       opp03 {
> +                               opp-hz =3D /bits/ 64 <540000000>;
> +                               opp-microvolt =3D <910000>;
> +                       };
> +                       opp04 {
> +                               opp-hz =3D /bits/ 64 <504000000>;
> +                               opp-microvolt =3D <890000>;
> +                       };
> +                       opp05 {
> +                               opp-hz =3D /bits/ 64 <456000000>;
> +                               opp-microvolt =3D <870000>;
> +                       };
> +                       opp06 {
> +                               opp-hz =3D /bits/ 64 <432000000>;
> +                               opp-microvolt =3D <860000>;
> +                       };
> +                       opp07 {
> +                               opp-hz =3D /bits/ 64 <420000000>;
> +                               opp-microvolt =3D <850000>;
> +                       };
> +                       opp08 {
> +                               opp-hz =3D /bits/ 64 <408000000>;
> +                               opp-microvolt =3D <840000>;
> +                       };
> +                       opp09 {
> +                               opp-hz =3D /bits/ 64 <384000000>;
> +                               opp-microvolt =3D <830000>;
> +                       };
> +                       opp10 {
> +                               opp-hz =3D /bits/ 64 <360000000>;
> +                               opp-microvolt =3D <820000>;
> +                       };
> +                       opp11 {
> +                               opp-hz =3D /bits/ 64 <336000000>;
> +                               opp-microvolt =3D <810000>;
> +                       };
> +                       opp12 {
> +                               opp-hz =3D /bits/ 64 <312000000>;
> +                               opp-microvolt =3D <810000>;
> +                       };
> +                       opp13 {
> +                               opp-hz =3D /bits/ 64 <264000000>;
> +                               opp-microvolt =3D <810000>;
> +                       };
> +                       opp14 {
> +                               opp-hz =3D /bits/ 64 <216000000>;
> +                               opp-microvolt =3D <810000>;
> +                       };
> +               };
> +
>                 gpu: gpu@1800000 {
>                         compatible =3D "allwinner,sun50i-h6-mali",
>                                      "arm,mali-t720";
> @@ -168,6 +233,7 @@
>                         clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
>                         clock-names =3D "core", "bus";
>                         resets =3D <&ccu RST_BUS_GPU>;
> +                       operating-points-v2 =3D <&gpu_opp_table>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.20.1
>
