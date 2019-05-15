Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4836C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A663520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzi7Tz62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEOSak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:30:40 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39304 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfEOSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:30:39 -0400
Received: by mail-vk1-f194.google.com with SMTP id t18so286189vkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcBF6F4zgNomYlPRQZzOJ2t4+wjtmmM8eaNQl5KRjbc=;
        b=nzi7Tz62FN/3PrAYjwJ++Zv1PALOdoOBPyJ4XX1U8AIyDcFe0i1fEKvD9H1x6Ag/2X
         1EoWcOkUtrM1ICXH7Oz33wBHzE8UdR+QGwDdXu69dg9MCw2GhPZ2xNfQlrmMzR4nd29d
         oT7q4wYBWTdMI2IrNv/Gsm55qOGS3VsmSNlco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcBF6F4zgNomYlPRQZzOJ2t4+wjtmmM8eaNQl5KRjbc=;
        b=cU0Q96RmBq2OoEuiUOl5gD5JjMdkuODzil6PlKQH3CCnaQXpHjKSvWXtxCLHl1aXF5
         Lvpj2ecSNGezVr78xgKFFb/Ze1hukKXx2/tTCu2NFF5BPtsB762fUq5pXERkRhAQNcCu
         TAOgn/h2xI1HG8mOK4afza3d/KRmAIU88BaNtF2tV8FD3CTG7y6+HhKlwzsLpzkAbKeU
         FVoJLl8Iuj829r0WhZFwqaXrY5yVMnI3Z+dzx/bncK3Vjtl3EopGLaGQuOp9Qc7k2A9D
         54FSCMoKp8a4kpGVeC9Q9Hebmz4Alaw2y9y+9tbmeAq6QvJMBq1p51KvZcpumLn8GWVu
         /q0g==
X-Gm-Message-State: APjAAAUKJ9pn8vPGcY1yVIgn6XNXa9DZtWDayetF9qnPN6+PStKnvv1+
        UObHEQBpxjtMbYkM0vygmJQFHgN4CBA=
X-Google-Smtp-Source: APXvYqyMzqa5EPkNkrZeAuElCfSIjexF4lqVxw8EboqCwjjzs2QcV7DclsVBc3iCL5dpoBXiZUkLcw==
X-Received: by 2002:a1f:6011:: with SMTP id u17mr11881677vkb.64.1557945038375;
        Wed, 15 May 2019 11:30:38 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id u37sm4759783uau.9.2019.05.15.11.30.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:30:37 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id c24so573911vsp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:30:37 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr13692401vsm.144.1557945037046;
 Wed, 15 May 2019 11:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190515153127.24626-1-mka@chromium.org>
In-Reply-To: <20190515153127.24626-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 11:30:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U19uAGkwTqg-N6_m5WYQ7yMwjQir3TYUsb3SWWOihTOg@mail.gmail.com>
Message-ID: <CAD=FV=U19uAGkwTqg-N6_m5WYQ7yMwjQir3TYUsb3SWWOihTOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: rockchip: raise GPU trip point temperature for
 veyron to 72.5 degC
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 8:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> This value matches what is used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for veyron devices.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 1252522392c7..169da06e1c09 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -446,6 +446,14 @@
>         status = "okay";
>  };
>
> +&gpu_thermal {
> +       trips {
> +               gpu_alert0: gpu_alert0 {
> +                       temperature = <72500>; /* millicelsius */
> +               };
> +       };
> +};
> +

This should be sorted alphabetically.  Thus this should sort right
after this in rk3288-veyron.dtsi

&gpu {
  mali-supply = <&vdd_gpu>;
  status = "okay";
};

Also you don't need to replicate the whole structure?  I think the
above should just be:

&gpu_alert0 {
  temperature = <72500>; /* millicelsius */
};

NOTE also that that gpu and cpu critical is 100 C downstream.  Should
we do that too?  Ah, but before we do that I guess we'd need to also
override the "rockchip,hw-tshut-temp" to 125000 to match downstream.
I guess that could be a separate series?

-Doug
