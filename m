Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EDCC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA26E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STnYbrir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfG3SB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:01:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35023 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfG3SB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:01:57 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so130245300ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcAR3GqqxpAusQVog8Fhc1feuDH351bpfQTCcdx/nxs=;
        b=STnYbrirbKr1yAmc2nPF92sj0DFq3tq71Bs1c1x0ibWy4hdKDtZ8Tq4VPh1Kn85/6B
         w6lcKTR8uT01woEtqCg9jLmTWvC64bWHDataDtPgVlKtQQaaffkWMeVo4I/xwBfioTRL
         EcR2XKnbW3Nia+1xvzACV2DzMbUJEtS9EKIhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcAR3GqqxpAusQVog8Fhc1feuDH351bpfQTCcdx/nxs=;
        b=jfxFdt40sXMtHcxZEGQuTmHXCBRxxtvdfAqhiJkWpcPxNCQBXPWfwpc7ArHsfEnrcF
         G5IW06NAO82MkIwLte9gBw6yX1p4A0RA2EYvGQnQDAh+o2DY9J+tvoybr976h4xUlqzi
         NtdDXnAT5nRCOyrOhsNmdYruPbWWZasuMHnFbZeGTYgnrruJr6UFWSpsIej2scZrmNN0
         ISV5k+JgTCO6CgVXnklkS3cTSN2g+4XPGmtNbxVoqEgOd7P2Hkazkr61TZSb+4lE3UoS
         VvF6ja4NZ611YmfbtpSyh6h489bcPBgREjHwMOTrXYZZvsjXga+eCVEVXBTJl6+3IHir
         8VeA==
X-Gm-Message-State: APjAAAUA2oLGphDipHKw6uM90HXBmMzHR32f7pxF6STyxWLFxHm8bQ8g
        OsDc0/okb2xGGoBGjj1rgmceFOq+26o=
X-Google-Smtp-Source: APXvYqxIqoRuiHLLcGKnBahSPUOJF6C5DU2Hbo29rzmy7JD4c4gC643Kfj8XGG+Js1EOwMWWcDg/kA==
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr3657309iog.266.1564509715609;
        Tue, 30 Jul 2019 11:01:55 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id l5sm118829382ioq.83.2019.07.30.11.01.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:01:54 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id k8so130266059iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:01:54 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr103345503iob.142.1564509714317;
 Tue, 30 Jul 2019 11:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190730173444.56741-1-mka@chromium.org>
In-Reply-To: <20190730173444.56741-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Jul 2019 11:01:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wub9Wkc5t4iQRjBK8R_d_oh4PoHPwLHb4T5+Meij7sSg@mail.gmail.com>
Message-ID: <CAD=FV=Wub9Wkc5t4iQRjBK8R_d_oh4PoHPwLHb4T5+Meij7sSg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: A few fixes for veyron-{fievel,tiger}
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 30, 2019 at 10:34 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> @@ -130,12 +138,13 @@
>                         regulator-max-microvolt = <1800000>;
>                         regulator-name = "vdd18_lcdt";
>                         regulator-state-mem {
> -                               regulator-on-in-suspend;
> +                               regulator-off-in-suspend;
>                                 regulator-suspend-microvolt = <1800000>;

Please remove "regulator-suspend-microvolt = <1800000>;" which doesn't
make sense once you have "regulator-off-in-suspend".


>                         };
>                 };
>
> -               /* This is not a pwren anymore, but the real power supply,
> +               /*
> +                * This is not a pwren anymore, but the real power supply,
>                  * vdd10_lcd for HDMI_AVDD_1V0
>                  */
>                 vdd10_lcd: LDO_REG7 {
> @@ -145,7 +154,7 @@
>                         regulator-max-microvolt = <1000000>;
>                         regulator-name = "vdd10_lcd";
>                         regulator-state-mem {
> -                               regulator-on-in-suspend;
> +                               regulator-off-in-suspend;
>                                 regulator-suspend-microvolt = <1000000>;

Please remove "regulator-suspend-microvolt = <1000000>;" which doesn't
make sense once you have "regulator-off-in-suspend".


>                         };
>
> @@ -159,7 +168,7 @@
>                         regulator-max-microvolt = <3300000>;
>                         regulator-name = "vcc33_ccd";
>                         regulator-state-mem {
> -                               regulator-on-in-suspend;
> +                               regulator-off-in-suspend;
>                                 regulator-suspend-microvolt = <3300000>;

Please remove "regulator-suspend-microvolt = <3300000>;" which doesn't
make sense once you have "regulator-off-in-suspend".


Other than those things, this patch looks good to me and feel free to
add my Reviewed-by.  NOTE: when I tried applying this to my tree git
complained and I had to apply manually.  Could you try sending this
patch atop Heiko's for-next tree?  The yell I got:

error: sha1 information is lacking or useless
(arch/arm/boot/dts/rk3288-veyron-fievel.dts).
error: could not build fake ancestor


-Doug
