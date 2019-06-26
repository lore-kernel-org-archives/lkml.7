Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C05C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFED208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGVs1bcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFZVcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:32:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39952 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:32:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so85873pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=xaNe52gTlH7uRzDXkViS1kydi/Gmc6DAN/0reN+QD/8=;
        b=HGVs1bclAbOEXXG+00ww1YiAcgPJaUDs8c6KhzZs0qSXho81TRV1hIRDYI4p3P+oS5
         wxJihsS1sEj2TMViHikFUkrsrQGyTia8SAyrkZaPBkVceiLL4rujCxA/m5LRUoCr2ZpX
         bS1Ukkj1FBQTy+QAHrTZIcv/ZmCGwUEuolewg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=xaNe52gTlH7uRzDXkViS1kydi/Gmc6DAN/0reN+QD/8=;
        b=XPkIxKdE32of8s+uygSGLWXaU5RFscadFSv7oUBPJXBgB+KzsMh7EArHmrevC/XSY6
         jzft2LjS7l/aq/J7fOlnSGcrBSvdBERLExIv+K9gA3GsCU9OmtD6I/kCs6OFAC21BmJL
         HqTWApFCHYnVRB9GvqfOcTSkHsPfG6ZCbSX1BMbL7R/x6Z/5b/azGe4EVX/Uw+N/twF3
         dIDrPXVDaXZX1wzcYcAVNauECJ3dkYrYdIpNiG4Vkj3Llz/8q6Xm7U17IQ2upntxcuBT
         CQn5bZEFUqoU/J8xKyiYpextZJJZoHaYATgZrhPb5AZAP3I86AbrqPVvffbduq24XdD3
         uPNw==
X-Gm-Message-State: APjAAAWyq0N/iQ1F+CdvKzHvGjPHJD0DEkziSEnRc+yVtozjZmPEfLQm
        zuKvuvZLmx++Vn9VbZYLK0sCwQ==
X-Google-Smtp-Source: APXvYqx1s5f135al8fvcz9ybaaaQrPCh6UykGfmm1OcWMXuY9lKQcBeG5D68heUPHZLR1mClZF5ETQ==
X-Received: by 2002:a17:90a:24e4:: with SMTP id i91mr1546271pje.9.1561584761690;
        Wed, 26 Jun 2019 14:32:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x3sm5124124pja.4.2019.06.26.14.32.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:32:41 -0700 (PDT)
Message-ID: <5d13e479.1c69fb81.dd08b.b1e4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561550047-19600-1-git-send-email-amasule@codeaurora.org>
References: <1561550047-19600-1-git-send-email-amasule@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add video nodes
To:     Aniket Masule <amasule@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mgottam@codeaurora.org,
        vgarodia@codeaurora.org, Aniket Masule <amasule@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 14:32:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aniket Masule (2019-06-26 04:54:07)
> This adds video nodes to sdm845 based on the examples
> in the bindings.
>=20
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>

There should be a From: line with this person's name in the email if
they're the author. Otherwise this sign-off chain doesn't make sense and
it should most likely have a Co-developed-by tag instead.

> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index fcb9330..ff94cfa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2437,6 +2437,36 @@
>                                 <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
>                         iommus =3D <&apps_smmu 0x0040 0x1>;
>                 };
> +
> +               video-codec@aa00000 {

This needs to be sorted by address. It doesn't come after 18800000 (the
address of the node above).

> +                       compatible =3D "qcom,sdm845-venus";
> +                       reg =3D <0x0aa00000 0xff000>;
> +                       interrupts =3D <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
