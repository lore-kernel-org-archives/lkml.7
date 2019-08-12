Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D999C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FC42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfHLETb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:19:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35121 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:19:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so102527491edd.2;
        Sun, 11 Aug 2019 21:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4s3JUibN+WGVLqaHsLHxXIi1D8VvPq6c/60ITp5nIA=;
        b=Cg9ho7/QtclAWMDb+MkWwr7n4WkOcYWYeBfHiq4Zw4e/Tv2KtwmX3tSbu7LzSpFvw5
         0NUmtnYWYQvyrPsSUBrLPyYeDOaWR3Rp02CA1fEYrI2/6HweNXliGC1jMd2IXU2+UTz3
         b9xsGM2Jq/eFkkLC9lzBqii1DkPQad8xs0+0mkEvQPQawNFQu5bCsXOhCmfvxmOVz4nP
         oWzZSy/z0eQd7pABb4PrOsxt8JMn+ipLZT5/we6mwBKRViA76hRddwI4evg5yWbUb53f
         i+QT2u4EhHpZr66Eafz/OVrMudd9zzDCf/JTKsykaC6L6DjU6O1biqo62fVycokIhpwp
         y4NA==
X-Gm-Message-State: APjAAAWRCaRZ7eYYrrWtNwEoO+bY8+KF5N79+MHdnyKiJgehE/mwQEzW
        IjwitIYn7Nvm2oq9DTshWNTLGF8dUbM=
X-Google-Smtp-Source: APXvYqxZJnhll1tRCxYh3xf+rl1GwrSNd94Ccz7IddVgvBJBriUzifQMYmth/jbyGUjZxna+9EDP5A==
X-Received: by 2002:a17:906:eb8d:: with SMTP id mh13mr18211724ejb.98.1565583569223;
        Sun, 11 Aug 2019 21:19:29 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id y12sm16978775ejq.40.2019.08.11.21.19.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 21:19:28 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id e8so9733490wme.1;
        Sun, 11 Aug 2019 21:19:28 -0700 (PDT)
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr25156704wmk.51.1565583568180;
 Sun, 11 Aug 2019 21:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190811090503.32396-1-bshah@kde.org> <20190811090503.32396-3-bshah@kde.org>
In-Reply-To: <20190811090503.32396-3-bshah@kde.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 12 Aug 2019 12:19:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xDCNywexZGW=EBrsJwm-KwANxpdCv-AM2sgVNbz6qQQ@mail.gmail.com>
Message-ID: <CAGb2v65xDCNywexZGW=EBrsJwm-KwANxpdCv-AM2sgVNbz6qQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: h6: enable i2c0 in PineH64
To:     Bhushan Shah <bshah@kde.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 5:05 PM Bhushan Shah <bshah@kde.org> wrote:
>
> i2c0 bus is exposed by PI-2 BUS in the PineH64, model B.
>
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 684d1daa3081..a184361bc10d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -160,6 +160,14 @@
>         vcc-pg-supply = <&reg_aldo1>;
>  };
>
> +&i2c0 {
> +       status = "okay";

We don't enable interfaces that are exposed on the extension headers
by default. Instead we let the users enable it themselves, by modifying
the device tree either with overlays or through U-boot commands.

Please set this to "disabled", and add a comment mentioning that it is
on the PI-2 BUS. Having it explicitly listed in the source serves as a
pointer to people looking at how to enable stuff.

ChenYu

> +};
> +
> +&i2c0_pins {
> +       bias-pull-up;
> +};
> +
>  &r_i2c {
>         status = "okay";
>
> --
> 2.17.1
>
