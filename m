Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE496C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A34206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckz+TG9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKMRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:51:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39243 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:51:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so3025380wmi.4;
        Wed, 13 Nov 2019 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=qzzDBOvLkhrbh494Qc4Z0VlfmRg1EJQ03rXnO9Mftjk=;
        b=Ckz+TG9tYlw0m9OttsGTs9nJCH7TOKM4uTw+Sa1nNydaUzRdKKXD1V4Buf42LHGqAe
         iE2FkSfzKvj6vYGAsui4uPedXV0/g94qdd492aWhhMIzPyzugnvALXv1DN8sIbGJGBC0
         NE51Ne1wBWIhu/FNZzS1s/P0BEwbdzrbtplWTY5NWzVYN/edYprM9kjqpWWTXpbXY9EV
         8LVPC6CrfzSPdoHCDXkSdds9fr8i5ZaBAG6Bjmcpp7s9sNDUVW5+ZrR6lquD8xI8KXjm
         5z6P9t72BlMdlR1dqIZChQbDAqLKh3ZSGLHTEO9eGCi6DtcaQ+TPM7kzHPgabJj7Qhlk
         eYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=qzzDBOvLkhrbh494Qc4Z0VlfmRg1EJQ03rXnO9Mftjk=;
        b=UOpFx6Ivet3P38D/y1lwd9pB+/XCqI9AJtp7a5U7u1GJ6u7+tmCotNtoWsWyig+fsY
         IbkSzl9qC4UNRpLoLToN/VbNQfe1QLVZKvOS21KZGOdgEi8DV96ydygkLY8Q8Agnzm/P
         8+hdD0vLZ533oCxTVwLX7y+Q18KzY9zQzAPxYm3NEKssj+Osleyi1du7GQ6h4jrby973
         bFV8QRcLSdx0rnnASaS6Eqb52md0KkUCUW1/roox7Se5posj4B+lFsg50e/rk+7V3vqk
         1ABpK4Db5nTcrtSnzHoJVn7wzExLVrWvyuPgzXs4FqhEeqQ/aZy/YpX4AEl7Pg2c8BLE
         BfKQ==
X-Gm-Message-State: APjAAAXI/P7H8KPhmVp/u6UUFZDJEnqq6ZCccrJAtitLtbmxkZvqZOaM
        txDiBrSmkEBQmvX5kU2yxbI=
X-Google-Smtp-Source: APXvYqxY92gjSsnH0FK0MObe+RVUZHrJMUlsHR/YtNeM6aP9bJMWxET2pTpHVRrEZmpw+lSUgwKswg==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr3554877wmc.123.1573667461198;
        Wed, 13 Nov 2019 09:51:01 -0800 (PST)
Received: from localhost ([94.73.41.211])
        by smtp.gmail.com with ESMTPSA id m187sm391448wmf.35.2019.11.13.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:51:00 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     <heiko@sntech.de>, <linux-rockchip@lists.infradead.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?utf-8?B?QW5kcml1cyDFoHRpa29uYXM=?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>,
        Vivek Unune <npcomplete13@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for =?iso-8859-1?Q?vdd=5Flog?=
Date:   Wed, 13 Nov 2019 18:50:57 +0100
MIME-Version: 1.0
Message-ID: <977a15a9-8469-4821-ba13-8c2c59a145e7@gmail.com>
In-Reply-To: <20191111005158.25070-3-kever.yang@rock-chips.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 11, 2019 1:51:58 AM CET, Kever Yang wrote:
> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
> will be 'enable' with the dts node at a default PWM state with high or low
> output. Both too high or too low for vdd_log is not good for the board,
> add init voltage for driver to make the regulator get into a know output.
>
> Note that this will be used by U-Boot for init voltage output, and this
> is very important for it may get system hang somewhere during system
> boot up with regulator enable and without this init value.

Hi, just for reference: doing the math based on the Sapphire board
schematic, the values for vdd_log are:
|------|-------|
| PWM  | Volts |
|------|-------|
| Hi-Z | 1.136 |
|   0% | 1.356 |
| 100% | .9167 |
|------|-------|
The datasheet states that the acceptable range for vdd_log is 0.8 .. 1.0
So, an option could be to configure GPIO1_C3 as output high and vdd_log
would be at the range's center.

Aside from math on paper, it has been tested. Setting GPIO1_C3 as output
high gives a vdd_log of 0.922 measured volts and the board, so far, works
fine.

Regards,
  Vicente.

> CC: Elaine Zhang <zhangqing@rock-chips.com>
> CC: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
>  9 files changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> index 77008dca45bc..fa241aeb11b0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -65,6 +65,7 @@
>  =09=09regulator-name =3D "vdd_center";
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09regulator-always-on;
>  =09=09regulator-boot-on;
>  =09=09status =3D "okay";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> index 92de83dd4dbc..4e45269fcdff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> @@ -208,6 +208,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <430000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc_sys>;
>  =09};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> index c133e8d64b2a..692f3154edc3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> @@ -100,6 +100,7 @@
>  =09=09regulator-name =3D "vdd_log";
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09regulator-always-on;
>  =09=09regulator-boot-on;
>  =09};
> diff --git=20
> a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi=20
> b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> index 4944d78a0a1c..c2ac80d99301 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -79,6 +79,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vsys_3v3>;
>  =09};
> =20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
> index 73be38a53796..c32abcc4ddc1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
> @@ -101,6 +101,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc5v0_sys>;
>  =09};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> index 0541dfce924d..9d674c51f025 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> @@ -164,6 +164,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc_sys>;
>  =09};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> index 19f7732d728c..7d856ce1d156 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -129,6 +129,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc3v3_sys>;
>  =09};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index e544deb61d28..8fbccbc8bf47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -174,6 +174,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1700000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc5v0_sys>;
>  =09};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi=20
> b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> index 1bc1579674e5..f8e2cb8c0624 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> @@ -133,6 +133,7 @@
>  =09=09regulator-boot-on;
>  =09=09regulator-min-microvolt =3D <800000>;
>  =09=09regulator-max-microvolt =3D <1400000>;
> +=09=09regulator-init-microvolt =3D <950000>;
>  =09=09vin-supply =3D <&vcc_sys>;
>  =09};
>  };

