Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMSKiMkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfEOR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:59:39 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40762 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:59:38 -0400
Received: by mail-ua1-f66.google.com with SMTP id d4so198678uaj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYGv5m3AMILz51Spmrt6yHEEOb39aK0Gg2jo/Bu5BT8=;
        b=eMSKiMkGDiPhEV6MfHv/8lqxI0ZIJwgTFHaLe+9m7kHkPBaae8ncl6ySq7O3M6a5pL
         mh4fcV39mHessqaqiXbT86R8AQRmrn+GjnwD1D4DsYF3IXresr7LwJhlyrk7UX9qQFsq
         yb4nLY9TjQf6qjO/OLDuqrTfslgVfMW0QzmSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYGv5m3AMILz51Spmrt6yHEEOb39aK0Gg2jo/Bu5BT8=;
        b=aCHc5wT+Nv5/zSd9cvQ9/lzVkjBlqAzp1MSG1u0KHwqQF9tjgUrmcTDy6MHF546OyJ
         EQLB/jTRwFEe3AG/jphX9ahFwD5H/9lHhKs7SRmcTgxk0Rn9KVq37rgdGYI5fZi4llSC
         BtgMqV/P4HW8XDl/W8X1ML0HdsCYt5feDK4FuJ3cKVlio1OzA7/qXa00ZMJ/PYXDChHv
         BacSBNViTeSuXRPGkY5lnMRzIUh20rGD+2q3SnJPNQSc8F9HJ18yDmWirDfY+OfWaAiQ
         aJ3U4h6dp54TznwfaMTshBMrKwvMNU+rob3zos8IL10C4SgjxijStuQCWWn2Av6cRleB
         mA+A==
X-Gm-Message-State: APjAAAUZAX3vhNsWST4gUYAdebTZc0psOs0QSjKXbDJekPH1GEAj8Cc2
        7pxxzqf7juPMpuDuSrqrzUsoylVSsVE=
X-Google-Smtp-Source: APXvYqzgHrJ9QpIXLgMXO5f69HfbB4UyU+4fcMv5/98BZiEXxtf1OqejZDY9vZe06CFr1XQ7EqOSFg==
X-Received: by 2002:ab0:4893:: with SMTP id x19mr21257946uac.5.1557943177839;
        Wed, 15 May 2019 10:59:37 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id d9sm4202391uab.20.2019.05.15.10.59.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 10:59:36 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id t18so258779vkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:59:36 -0700 (PDT)
X-Received: by 2002:a1f:d884:: with SMTP id p126mr20080140vkg.70.1557943175846;
 Wed, 15 May 2019 10:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190424162827.5297-1-mka@chromium.org>
In-Reply-To: <20190424162827.5297-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 10:59:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+QGLmhEaqGc-=wNFzmaCr_f4rb5e8KQ4ZmeRaNi_xCw@mail.gmail.com>
Message-ID: <CAD=FV=W+QGLmhEaqGc-=wNFzmaCr_f4rb5e8KQ4ZmeRaNi_xCw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
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

On Wed, Apr 24, 2019 at 9:28 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> The Mali GPU of the rk3288 can be used as cooling device, add
> a #cooling-cells entry for it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index ca7d52daa8fb..767e62908a6e 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1275,6 +1275,7 @@
>                 interrupt-names = "job", "mmu", "gpu";
>                 clocks = <&cru ACLK_GPU>;
>                 operating-points-v2 = <&gpu_opp_table>;
> +               #cooling-cells = <2>; /* min followed by max */
>                 power-domains = <&power RK3288_PD_GPU>;
>                 status = "disabled";
>         };

Seems like a good idea to me.  Presumably we should also add this to
the bindings?

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
