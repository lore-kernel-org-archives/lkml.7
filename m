Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724BDC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459E521721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzFVJ5u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfHNWMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:12:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44852 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfHNWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:12:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id k22so284558oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyqtiLbzf0B7EEuufXwlvVGQQuhpbnOj2sCLQecaeOA=;
        b=BzFVJ5u6T9n90c7pBUGG2W/PYxhbxig7Uj4ekhFiygJPJOXLLgkQH0CnbSKqfH/8ZC
         UE2W5h8jX9oSA377C53B1im+o74UWsm+XKOxd6726LqaaWGPDBgxwNhE3mUHX1w1qIC9
         /nkyM1FFI7mtW+uuEV4QB8p74qCRBZmjT9lb375mw15aVkMx9MqLgfyohNQSZdNXfLzY
         /lT7HKO0DymhH/Oazl37LYmfVMDy+mAlM3PXmUlF93mCJrk1GCVE92gUFRfHzZnqz4DS
         PwNk5o/PjFLJHddu4yEUrroPsJC1TR4CVCsGF9vx1u09TgKO+44P+IHGrenLVd9rsZPu
         Xkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyqtiLbzf0B7EEuufXwlvVGQQuhpbnOj2sCLQecaeOA=;
        b=EpvHKwZyYiJ9Cl9QCC9/uandbK+ctcmto5XcQVtdrDDvlImAtYGVzwqvOn7Apk6Lf2
         cR73RkUNiIgthVIiFloUOzpn2dx9APg/g6k2EwZRpI4owSfRBPc5DYanBvzFicZXqtYJ
         IsHKwLTcefHrrzTMdLPyWap8Di8MvmkEqBa1J/ELj5EvzZEvTW/sGankF52jnE2km22U
         Soso/Iisn8WYA4OWWv2RNUGBEg2BLKAzIZboML8HZ39BttDnjg4sR5b7maBlRRj3Ypbb
         nkdVLjjUZqJhLKrZHEH14mwCdLPbR4SXtaAt4FhhxVzGP/Ec+UQM43XKHDdLjOfcqxLh
         OhTg==
X-Gm-Message-State: APjAAAWrPmvgOmmml4h2tXkiUXJ7KlWWxuUnGOvEqcmVYEeX2LTcgrQr
        L060zCpNnHta1m2ZmVLLvRPh4/l14C5pxu7Rgw8=
X-Google-Smtp-Source: APXvYqwlvuw12f5lw9fJpzGHCs9IjxCkWVfv0r3UGHD3THhT3ik9lOmV+44RtNITkDQKYXIEMzjTe97zwNxCpTzDqYc=
X-Received: by 2002:a02:9981:: with SMTP id a1mr1736754jal.17.1565820764529;
 Wed, 14 Aug 2019 15:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190814193536.15088-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190814193536.15088-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 14 Aug 2019 15:12:32 -0700
Message-ID: <CAFXsbZoRhy1OtsybHJQDef09gS1UGBhU8a+ZrF31O1THBGgeCA@mail.gmail.com>
Subject: Re: [PATCH] ARM: vf610-zii-cfu1: Add node for switch watchdog
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Cory Tusar <cory.tusar@zii.aero>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Chris Healy <cphealy@gmail.com>


On Wed, Aug 14, 2019 at 12:35 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add I2C child node for switch watchdog present on CFU1.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Cory Tusar <cory.tusar@zii.aero>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index 7267873b5369..18c19c092dd1 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -239,6 +239,18 @@
>         };
>  };
>
> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       watchdog@38 {
> +               compatible = "zii,rave-wdt";
> +               reg = <0x38>;
> +       };
> +};
> +
>  &snvsrtc {
>         status = "disabled";
>  };
> @@ -324,6 +336,13 @@
>                 >;
>         };
>
> +       pinctrl_i2c1: i2c1grp {
> +               fsl,pins = <
> +                       VF610_PAD_PTB16__I2C1_SCL               0x37ff
> +                       VF610_PAD_PTB17__I2C1_SDA               0x37ff
> +               >;
> +       };
> +
>         pinctrl_leds_debug: pinctrl-leds-debug {
>                 fsl,pins = <
>                         VF610_PAD_PTD3__GPIO_82                 0x31c2
> --
> 2.21.0
>
