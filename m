Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A06C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A78C20700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF8zd6/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJBJoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:44:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfJBJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:44:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so18862003wrs.0;
        Wed, 02 Oct 2019 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yEK1h7IYbfQJseSegx/hs1/itUbfwIPwjoFbuHMumRA=;
        b=VF8zd6/E8hdk6Eh64RiuH7DydBCN7C7RanPE7EYiKKi/SbOmdBROvyuS59Nv5XnkHz
         5lOIK0tFsSxf8I4uhHUvGHBmuCT4isyWoaLLd6GoVETz+5tKD4nLd/Bt2HnkOwd2CAjS
         q9FejombVEG4NF7dEP0tlFWtEW5akOsEiusNQqN3HPusgMSvRXRAcwDxH2qEkvVVDntm
         TWG3/QaH92GOIVQLddjyczv9rF3gkOiSeccZyaJ0O89iqLj+Z5CIqx2tkOB06NZJDjMi
         j1VY0licW+vD4I1D1tQ3/Aw8KD1Q6rknvAvRalFUD7P7D9hT0dhyRJLZcih7VZA/DxcY
         XV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yEK1h7IYbfQJseSegx/hs1/itUbfwIPwjoFbuHMumRA=;
        b=Y7L00A4kx82KseAKXSA03/rCLiBTBVtO2AaRkVCXVNfeye/QuwuErRF5McCFYf9iRx
         qCzkSiSAunNHbbcOxq+f/SVxxOa+S+VIfsz6lOQqBPdnstHO1T9+XQPDHMX8Bt9rDZUJ
         AlzN82niwS9nkk4Ud/S5Rhg3LZKCBCsHWVRpbLgRNAUtCrxyBfth9FqwBfOXj5oNQQka
         CZmbgpUGp7eWKWzWKz69Mq7IdNJFKyKEUnAdn6zNyrB+pKKdp1kZsOO0HRTwU46Plnlr
         vvgr5IvScB5RbFhCIHkG7QzD3emlzh394CULzeh561rDU2aWaWUasaLUSzY+WlJ5Stg7
         g67g==
X-Gm-Message-State: APjAAAWF2dFEZKt1hhARn4T9ZXI56gYe/x1mdmB7AWU5Uc4ImMmVXUH+
        7LXhnzWE2wX1hmMFRjvVQHz4o/gV
X-Google-Smtp-Source: APXvYqxiXTl0UJowt3FqupWT1DaWrIVW4iRfFdDMfhxesHLHHYDRxn/fkylcENSksTK282y+EHkK6g==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr1904218wru.349.1570009480805;
        Wed, 02 Oct 2019 02:44:40 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id u22sm24556048wru.72.2019.10.02.02.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:44:39 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:44:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 4/6] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20191002094438.GD3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-5-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-5-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:49PM +0800, JC Kuo wrote:
> Extend the bindings to cover the set of features found in Tegra194.
> Note that, technically, there are four more supplies connected to the
> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
> , but the power sequencing requirements of Tegra194 require these to be
> under the control of the PMIC.
>=20
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
> possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. To deal with
> this, a new device node property "nvidia,disable-gen2" was added to
> Tegra194 that be used to specifically disable Gen 2 speed for a
> particular USB 3.0 port so that the port can be limited to Gen 1 speed
> and avoid the instability.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-p=
adctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padc=
tl.txt
> index 9fb682e47c29..3bef37e7c365 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> @@ -37,6 +37,7 @@ Required properties:
>    - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padct=
l"
>    - Tegra210: "nvidia,tegra210-xusb-padctl"
>    - Tegra186: "nvidia,tegra186-xusb-padctl"
> +  - Tegra194: "nvidia,tegra194-xusb-padctl"
>  - reg: Physical base address and length of the controller's registers.
>  - resets: Must contain an entry for each entry in reset-names.
>  - reset-names: Must include the following entries:
> @@ -62,6 +63,10 @@ For Tegra186:
>  - vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
>  - vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
> =20
> +For Tegra194:
> +- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must su=
pply
> +  3.3 V.
> +- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
> =20
>  Pad nodes:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -154,6 +159,11 @@ For Tegra210, the list of valid PHY nodes is given b=
elow:
>  - sata: sata-0
>    - functions: "usb3-ss", "sata"
> =20
> +For Tegra194, the list of valid PHY nodes is given below:
> +- usb2: usb2-0, usb2-1, usb2-2, usb2-3
> +  - functions: "xusb"
> +- usb3: usb3-0, usb3-1, usb3-2, usb3-3
> +  - functions: "xusb"
> =20
>  Port nodes:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -221,6 +231,9 @@ Optional properties:
>    is internal. In the absence of this property the port is considered to=
 be
>    external.
> =20
> +- nvidia,disable-gen2: A boolean property whose presence determines that=
 a port
> +  should be limited to USB 3.1 Gen 1. This properlty is only for Tegra19=
4.

s/properlty/property/

With that:

Acked-by: Thierry Reding <treding@nvidia.com>

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UcYUACgkQ3SOs138+
s6GoPA/+JMIwA9BAlwTjZUJ+GX5F2ueO+KNypGWxfrXY9bbnQce4zE0lBjJsFduQ
+SC45V+BO7PzxeiWbY9tabxMQSccdHIkZmg+JeKvV+WlRr+GsMh8w+EDc6uCff6F
+Uo8DWLuST621FBNAgKHHO5HUMYa+tKG0j/c5QlPC7OJJGcYX0gFiM+7UG2WFrm5
kNUOEQTQk6FqwdV7YquWeoyDAP2uPvUgkfghrfZrqpQbgA1j9Kwqrfmt3povSTSr
4ptWP5rYGR8a68t+K0KrtRUfWEo95pr2bjD55IdZIzoqy3hDuoOPPRgZE8b0ETBu
LJVMnKqAPixVZvNZXQXyLYtHQ+k0b5jHQ5f5tNvH9usdLDvnbMcOISW1kTIWtEBI
lPLuXPmThDqxtWEA7eikS8MrmHXmSLe+SMR938X0ba6fU6zGUXBxrPvLPQZXZcPB
tUp7RkAVmF0kfsFyElb1fAqpMcIWPAHeTFrp+5Tn3QOI3gMQ/N9cXLuF+KVvt+CW
PnnwDVNSWJNglB44SOo03L25SRH/n9X/QAY31ip8ddKaseFGngXLXdgN1GyXpdPb
y8Vnm8lliPhUbRAPVC/m5l9YTYKIQ3vHlLz8AZcLif04Z8+K2be9ccjHvucSYTwY
kv57JVC70eEEAlidTyGlaXTc3F2KVjV4P/Fzr2JE8stAMMz9ekE=
=HWX1
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
