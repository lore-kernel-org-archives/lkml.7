Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270AC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCE20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHT8uHWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLSNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:13:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55675 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:13:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so5383480wmj.5;
        Thu, 19 Dec 2019 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30R4i+eh2J89uoscLSPeK2Vr51YPAn+dxaXVrzkfTok=;
        b=rHT8uHWuF7uDqMjuhM4LcwCROZK0wbgQNLPrFloVqZcfJXR9vn2W6dka3yHyoFWlSc
         ceRHwub1HBeA7Q4LXL3thRs4s2c6fVRPERL38lhsiHaQIZEdgRJMvvlaiyPSkpT+Vauq
         b6cQOc6+50kN/PSsO0Ksg3JP9igvfde6bPMgXtSIQD2KhJcBggEb7SXCGYGRb9GM+oKK
         GNRAgQJBGPZPkuqB7262xVVZ2rBYgdgARgXwf14HPcyokwZMUw2Re3FmBc31jtBjQ7tU
         DgACcSNtTbGrrePNyvLbnXwRACw9UHV+RylA4Q/Hg85cRwrfOIHgbobX7hdkO56gkIiO
         GKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30R4i+eh2J89uoscLSPeK2Vr51YPAn+dxaXVrzkfTok=;
        b=r6ZCMbdOFjoWLtpXDCBHDGWxY7d+5znKD6VVQng89PfyWBhQFyUzQsxX8KX/PUZJz0
         MzAqejc3DsA7dAzDvJ6q06GeQ0lZ7jsJmQlHYa4ufR8P21kI1ddIpavwFg496pJjzRlR
         WYQXXXAHdVZZCPtSn//JrwpSlwvmOXNMqFxzqD87PHQYk1BgcvtyIjDQCNQkhDiBaw2g
         pBPta5eqUVl3HPA50k8LMcSphGVjt8cxe6Rx08TLOGFjkPYJFrXK3dpwh8mV01SB4ZvW
         8M+6oZj7AbJUboZPY6i/dWdWp+yw/jJNXWHseR+gpYa1C3uq2Yfyyhn/Nk6uWDk3yKXU
         29uA==
X-Gm-Message-State: APjAAAUQWxTqH+zNRnvdYH9MRd/5cFlgy694IRGjj7qxF/wdmaQBNR5b
        xHC7BPjMi4AxAZMTv60zsIo=
X-Google-Smtp-Source: APXvYqxFt/j8Nd0py8kCGIHPPC0m9nro9zdbl3jOq/YkNA4zx9U1YwIP6XsuI5PzZw0OskmDRzNLSg==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr9836342wmi.37.1576761231485;
        Thu, 19 Dec 2019 05:13:51 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id j2sm6212161wmk.23.2019.12.19.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:13:50 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:13:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 00/18] Tegra XUSB OTG support
Message-ID: <20191219131349.GI1440537@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:46:13PM +0530, Nagarjuna Kristam wrote:
> This patch series adds OTG support on XUSB hardware used in Tegra210 and
> Tegra186 SoCs.
>=20
> This patchset is composed with :
>  - dt bindings of XUSB Pad Controller
>  - dt bindings for XUSB device Driver
>  - Tegra PHY driver for usb-role-switch and usb-phy
>  - Tegra XUSB host mode driver to support OTG mode
>  - Tegra XUSB device mode driver to use usb-phy and multi device mode
>  - dts for XUSB pad controller
>  - dts for xudc
>=20
> Tegra Pad controller driver register for role switch updates for
> OTG/peripheral capable USB ports and adds usb-phy for that corresponding
> USB ports.
>=20
> Host and Device mode drivers gets usb-phy from USB2's phy and registers
> notifier for role changes to perform corresponding role tasks.
>=20
> Tests done:
>  - device mode support using micro-B USB cable connection between ubuntu
>    host and DUT on micro-B port
>  - host mode support by connecting pen-drive to micro USB port on DUT
>    using micro-B OTG cable.
>  - toggling between these 2 modes by hot plugging corresponding cables.

Are there any tests we can run without manual intervention? Can we force
the device into peripheral mode and then setup a configuration using
configfs? I'm not sure how useful that would be since it doesn't really
exercise the driver code very much and doesn't tell whether it's
actually working.

Any other way how we can test this?

Thierry

>=20
> DUT: Jetson-tx1, Jetson tx2.
>=20
> V2:
>  - Updated usb-role-switch documentation for Padctl driver.
>  - Update XUDC bindings doc as suggested by Rob.
>  - Used standard error codes for error return.
>  - Added of_platform_depopulate during error and driver removal.
>  - Updated error variable during phy initialization in XUDC driver.
>  - Updated Tegra210 soc dtb file as per changes to binding doc.
>=20
> Nagarjuna Kristam (18):
>   dt-bindings: phy: tegra-xusb: Add usb-role-switch
>   dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
>   phy: tegra: xusb: Add usb-role-switch support
>   phy: tegra: xusb: Add usb-phy support
>   phy: tegra: xusb: Add support to get companion USB 3 port
>   phy: tegra: xusb: Add set_mode support for USB 2 phy on Tegra210
>   phy: tegra: xusb: Add set_mode support for utmi phy on Tegra186
>   usb: xhci-tegra: Add OTG support
>   usb: gadget: tegra-xudc: Remove usb-role-switch support
>   usb: gadget: tegra-xudc: Add usb-phy support
>   usb: gadget: tegra-xudc: use phy_set_mode to set/unset device mode
>   usb: gadget: tegra-xudc: support multiple device modes
>   arm64: tegra: update OTG port entries for jetson-tx1
>   arm64: tegra: update OTG port entries for jetson-tx2
>   arm64: tegra: Add xudc node for Tegra210
>   arm64: tegra: Enable xudc on Jetson TX1
>   arm64: tegra: Add xudc node for Tegra186
>   arm64: tegra: Enable xudc node on Jetson TX2
>=20
>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   6 +
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 ++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  23 +-
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  19 ++
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  34 ++-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  19 ++
>  drivers/phy/tegra/Kconfig                          |   1 +
>  drivers/phy/tegra/xusb-tegra186.c                  | 109 ++++++--
>  drivers/phy/tegra/xusb-tegra210.c                  | 126 ++++++++--
>  drivers/phy/tegra/xusb.c                           | 134 ++++++++++
>  drivers/phy/tegra/xusb.h                           |   5 +
>  drivers/usb/gadget/udc/tegra-xudc.c                | 276 ++++++++++++++-=
------
>  drivers/usb/host/xhci-tegra.c                      | 225 +++++++++++++++=
+-
>  include/linux/phy/tegra/xusb.h                     |   2 +
>  14 files changed, 1031 insertions(+), 138 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xu=
dc.yaml
>=20
> --=20
> 2.7.4
>=20

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37d40ACgkQ3SOs138+
s6GmMQ//UeIXKC8LonKqcjeF4FAXBH0H7fV5IRwdnm8zsRqWRZ18gzLd4ewLz6p3
ETMQBEkzqmxtPsRsWnreMp1lSG8afpBTSjmfRKLqO56+Ch6LB2NRJWU8W+VzHi/m
dMswAhZtjs++/jAPZX/EeME8EBEK60LoSk0XXLCZP51X20OJyJ49IN3SjZUrURP3
DDR2ZGJzL+1gg6PZVRoGFW0qgXyfbK85X189EKCKkG3YnBpXEVOE00HvCOupMdkM
9b8C8JvLP5kDpIVQafyrEphVMdleHNSkXkEYZgyE/TDUG6ypTgUebDxuHLaQu8sq
iZy0bRS3P/uKBHZPxTeURW/EQURY8hBZf8j45Jqq/Qp7LXS6KXaFRFC28d9FealH
bSTUIC2ji+QYuPqyZUj8KwtNXL3pcvOLvUeU7HesM1JRVtA91Qmgy/x1qFqseDGu
fHawy4TE6CFdnaMK+SnmlYgEqH6DtyWCEDq7X8n0RC+IfBd3jTz4JfOKGt2VwLQW
y6t5vP/TSC2eaKRdJIBjEERiqzPEkHGO4Q/7Qm7jrgMx8Uwq8QafMx9Qu5CvSFsV
KZP6nGzhIA32VJAOfn9RdzYpVn7LYvQEZWZ5/vruMvlzJyEbg0vKTtx78akBR73q
6bOLf2kCC3LeSUn/9oTGF63t59L1+9fN7s49eGt/ku91XTG/aN4=
=9laO
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
