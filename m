Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14081C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE32085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="E4yuGYMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfKGTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:10:31 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:32931 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:10:31 -0500
Received: by mail-il1-f193.google.com with SMTP id m5so2852943ilq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pkb5jMFuLCEWCYW/JsNLSSIWv1a87ksEuR1XT2B21OU=;
        b=E4yuGYMS1pq9v1+WF35EsKgSb9HtDZWkJ3jNVKnVOGnXkuxGKERzeomvsq61IKZ+BS
         5vDnyoe59CafR7ujung+DFAh5VrxhyezrfAPIK46pLKEGDol4nS0bHrghLG1+x8cP+Tz
         XWUXgXGAWb8K+OefOWhoAmQ6PtfilZ7rpXyTKa4SB3qk0/4cnIWvk218Qha95C9QUZdP
         awkOnTqUy+AocpO/EOWrjgGMutNupXwNBRObdnRnLCRIkg5KqEFN18PnhUM/IkRgjdT0
         9bDxLZtA6buuUF4XI8ScG6JyWq3De1yqQKC53DMhnvo4wkyS+H61eoKPf70b+0N44EcV
         lLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pkb5jMFuLCEWCYW/JsNLSSIWv1a87ksEuR1XT2B21OU=;
        b=cJK4tqjPzsMb9oXYtRu1syq6Lk2HOQErbcySdKt0Bou6UWx9NiSbAPHPFsyCJImr3a
         ga5jeB/RJHG9JSJcoBIXVfLIWdO+2uOsIoytcICLVrnZtVF0LHsj5VRkBzzy1LnRw/q9
         IjahZV8niPjV1oA0Wt8IQ/o3CcDLDfIp+COyIHjmSQ4hI3k19PGODdzjtJqLZEkVxV4r
         87PSQyemduw/m+k7mZ1zsubiaCZiu6nlhOK9k1kvmSY85Ru+Dz92hrWmvYAEVENVhIGZ
         0vt4bhwZlmgPG0xGBwzdm7cKW10NJoVfyG4iDCFtz6fdF8KZnq+sq+hUd3uV2PG+I9Pd
         CuJQ==
X-Gm-Message-State: APjAAAUl4bnxHVJ2HM8Gh2vRLvkfA1ETNeza7hCylCV7rIKqpYAjgbcT
        Yb/J1dViAythns2tUjiHwhkY11pk2eCs3+YN7y5MoA==
X-Google-Smtp-Source: APXvYqwHrMqf0QGsixAbdr9YO/brEv5lOHVZjAT153yUV3MxVGAnMIC9SdFTs2dZJSNR204F/AOxPhvAJj2cdqQv4XA=
X-Received: by 2002:a92:3b04:: with SMTP id i4mr6543252ila.211.1573153830610;
 Thu, 07 Nov 2019 11:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20191021205426.28825-1-rjones@gateworks.com>
In-Reply-To: <20191021205426.28825-1-rjones@gateworks.com>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Thu, 7 Nov 2019 11:10:19 -0800
Message-ID: <CALAE=UAEFobA2SXOTJWAqexg+VNN_VTXGLGH+VwqqjKkuFwddg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

I just wanted to follow up with this and see if you had a chance to
look at this. I submitted this after responding to Marco on my initial
submission but haven't heard anything since and didn't want it to fall
through the cracks. It may be worth mentioning that both the bindings
for the fxos8700 and lsm9ds1 have been accepted by iio.

In addition to this submission I have the following that I'd like to
check in on as well:

[PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio imu/magn support
[PATCH] ARM: dts: imx: Add GW5907
[PATCH] ARM: dts: imx: Add GW5912
[PATCH] ARM: dts: imx: Add GW5913
[PATCH] ARM: dts: imx: Add GW5910

Please let me know if there's anything I can do. Thanks!

Regards,
Bobby




On Mon, Oct 21, 2019 at 1:54 PM Robert Jones <rjones@gateworks.com> wrote:
>
> Add fxos8700 iio imu entries for Gateworks ventana SBCs.
>
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 1a9a9d9..2d7d01e 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -313,6 +313,11 @@
>                 interrupts = <12 2>;
>                 wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>         };
> +
> +       fxos8700@1e {
> +               compatible = "nxp,fxos8700";
> +               reg = <0x1e>;
> +       };
>  };
>
>  &ldb {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index 54b2bea..bf1a2c6 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -304,6 +304,11 @@
>                 interrupts = <11 2>;
>                 wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
>         };
> +
> +       fxos8700@1e {
> +               compatible = "nxp,fxos8700";
> +               reg = <0x1e>;
> +       };
>  };
>
>  &ldb {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 1b6c133..d9e09a9 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -361,6 +361,11 @@
>                 interrupts = <12 2>;
>                 wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>         };
> +
> +       fxos8700@1e {
> +               compatible = "nxp,fxos8700";
> +               reg = <0x1e>;
> +       };
>  };
>
>  &ldb {
> --
> 2.9.2
>
