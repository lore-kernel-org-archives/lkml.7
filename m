Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E2C17442
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLqkOMy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfKKARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:17:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40087 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKKARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:17:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id m15so9852508otq.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 16:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhsOaebOhYHxMqV94r7kcc7AguzKN+Auyp31Rb0JoVw=;
        b=VLqkOMy2tquWHF8n6MZVAyJAvFHR0phqMcphKQflrGGjpZIOOMR1yBz1OFjChXHI08
         LOOF0UBMVw5bh3yyxo1H0G6j0qq+FCiK+BHRqoFh0AVkGS4xuOUs9QvI+zhdvSSJFQU+
         sexHjtR9jcULiSuImK3zbEdSPqs0rWuHD4Af/CrAuevFmjuKp+8S2QV9rSt+mMUwyCuA
         YwC7xjT8znKBbbIVHWk5TFFDHvftedEqKxf3b5KumvKRwGiaQlNPdl4tA9UNVtOSnL2o
         OvzHWnjaVU7U3UEKq3OHVHyNbEFvo9PFDfwwR330hH1mKfxLMdED7OdK+CrDqM9LCFY4
         eiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhsOaebOhYHxMqV94r7kcc7AguzKN+Auyp31Rb0JoVw=;
        b=VKTVa3T677IRuObMNwtaBdlOlXu/13r8F14lg9AFq86Ouv0B5t2y3FpcTTUqlZ/KKq
         YxZ2yGK+a0hylbaxx1NEHLEklbtAYNvodYqpuJldUxB2sRhd+DoETH63V66lXkNRT1E3
         LotMr8cnk9HL3wVgiix/2rl+4aJySA6Pe5/gMIBKBInLJYofBRJbY6orVz11QNdyY6Ii
         juCazzqZHQ2VjgOkXUAJ6f2E5PAuzpaa+FhN73htbUmeXpdfJQNiTE7pac1Wp4vXtx1M
         h1iu1/jYCwdhGVpl6eZACskN4ESKNKgXHBTM7643Z3dboPAFFNYnyB/IKfmz2mlUVreA
         OXxQ==
X-Gm-Message-State: APjAAAX7bikeMhYtBieMT/Q4D8+abBQipI3IajrmySHAchvpBF14Oyq+
        2vBKhFouHsO/phyRdH3u+sB1ph9xvA/r8N4CLEQvjOKN
X-Google-Smtp-Source: APXvYqxomRIDMbxqMNubEdeNxZm86L5SYvCuTsFQa329n7usrb8jndKJc4nwmJinhIsr7BKQK5hy3XbrWXUiVrMroM0=
X-Received: by 2002:a9d:4b86:: with SMTP id k6mr18409215otf.353.1573431448777;
 Sun, 10 Nov 2019 16:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
In-Reply-To: <20190907174833.19957-1-katsuhiro@katsuster.net>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 10 Nov 2019 16:17:02 -0800
Message-ID: <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on rk3399-rockpro64
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch adds audio codec (Everest ES8316) and I2S audio nodes for
> RK3399 RockPro64.

Hi Katsuhiro,

I tested your patch with my rockpro64 on 5.4-rc6 which has your other
patches to es8316 driver, but apparently it doesn't work.

'alsamixer' complains 'cannot load mixer controls: No such device or
address' and if I try to play audio with mpg123 it pretends that it
plays something but there's no sound.

Any idea what can be wrong?

Regards,
Vasily

> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 0401d4ec1f45..8b1e6382b140 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -81,6 +81,12 @@
>                 reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>         };
>
> +       sound {
> +               compatible = "audio-graph-card";
> +               label = "rockchip,rk3399";
> +               dais = <&i2s1_p0>;
> +       };
> +
>         vcc12v_dcin: vcc12v-dcin {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc12v_dcin";
> @@ -470,6 +476,20 @@
>         i2c-scl-rising-time-ns = <300>;
>         i2c-scl-falling-time-ns = <15>;
>         status = "okay";
> +
> +       es8316: codec@11 {
> +               compatible = "everest,es8316";
> +               reg = <0x11>;
> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
> +               clock-names = "mclk";
> +               #sound-dai-cells = <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint = <&i2s1_p0_0>;
> +                       };
> +               };
> +       };
>  };
>
>  &i2c3 {
> @@ -505,6 +525,14 @@
>         rockchip,playback-channels = <2>;
>         rockchip,capture-channels = <2>;
>         status = "okay";
> +
> +       i2s1_p0: port {
> +               i2s1_p0_0: endpoint {
> +                       dai-format = "i2s";
> +                       mclk-fs = <256>;
> +                       remote-endpoint = <&es8316_p0_0>;
> +               };
> +       };
>  };
>
>  &i2s2 {
> --
> 2.23.0.rc1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
