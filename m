Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C786222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arp3uC+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfIZJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:04:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44253 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfIZJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:04:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so1474907wru.11;
        Thu, 26 Sep 2019 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MxzDBXOVQhWsN01bv+jFsQXoBf3LnvBl8+L+Gv9bicg=;
        b=Arp3uC+oRK9kO5jHyZoJZkasVpXc4QlrjLt4EPzG4UcDuAevgnt5Ad8JEuAfDifNh1
         J5goeFNtOb7DAf7xU7hh+K0ZZLWMnny3N0MuBW7qvp4fQBTsAixLospbCkcmSLLyeB+b
         PLwF6M2WyflDzN1RW+g9KvAIuVKv0Bbs2gR8Ja/l3JbFQFcIUrwwDo+vtqa1KE1w1QL5
         bwuL2aKoP9hcjSXXfrzag7iKOmaPeU3om9TnMlvjZszOnkujNN2bDS/YpZrSO1ju8U6Y
         OG2sJA/eCp1YIdAV86d0qm5MyxWo/ziz/zm1msLoF7bOTgx9+T98wZHqz1jLPs/IWesZ
         Ck0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxzDBXOVQhWsN01bv+jFsQXoBf3LnvBl8+L+Gv9bicg=;
        b=seQtKf17LmHklSHXRU63nt+klv2sPXCj5pj8ek4ykiRYHNOwX+PrlE6Q6LQVbQPKjR
         8pOJJ77toUiPh9JFeNtZXHxTT1AaXYmeS1jSImSBjoI6zDfw2dn4rgQQGqLjGPL8ol78
         YPquLXp4NprnV8PVPRyC0455dDnhkZCxrhlnWQm39+SbysEm4gld+PzdTxw8EPbQeDxy
         RJ84eNF4Vvb5Q+5rZwCdMr8SvxVAERdwQBg0kLkRE/jh8r0qNHs6UFPHSfIwk4qO+YdW
         mg9u5mVrWxl4fRwiEEMBEwWAShg1PoP/jk6qwZ8TbpgQRN23dmv+uJldwP8F2k8L2Mne
         k3Lw==
X-Gm-Message-State: APjAAAXc9xlMNCVfkSurC6/FrxEGh0G6iFSw6DcxSN8MMwGI6+kPRahi
        f2m7vWpeRGFY/u3vJej3wnpDppT+
X-Google-Smtp-Source: APXvYqyoCHqtB58CK+5ItwbuBMjfPu1kS6bBM0yUUPWAyIepS6DHFrVUSytCbdwu/u8usyc3GihWDQ==
X-Received: by 2002:adf:e605:: with SMTP id p5mr2116793wrm.105.1569488677714;
        Thu, 26 Sep 2019 02:04:37 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id d28sm2586320wrb.95.2019.09.26.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:04:36 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:04:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V10 0/8] Tegra XUSB gadget driver support
Message-ID: <20190926090434.GA3432@ulmo>
References: <1569227152-3030-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1569227152-3030-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 01:55:44PM +0530, Nagarjuna Kristam wrote:
> Patches 1-3 are phy driver changes to add support for device
> mode.
> Patches 4-7 are changes related to XUSB device mode
> controller driver.
> Patch 8 is to enable drivers for XUDC support in defconfig
>=20
> Test Steps(USB 2.0):
> - Enable "USB Gadget precomposed configurations" in defconfig
> - Build, flash and boot Jetson TX1
> - Connect Jetson TX1 and Ubuntu device using USB A to Micro B
>   cable
> - After boot on Jetson TX1 terminal usb0 network device should be
>   enumerated
> - Assign static ip to usb0 on Jetson TX1 and corresponding net
>   device on ubuntu
> - Run ping test and transfer test(used scp) to check data transfer
>   communication
>=20
> SS mode is verified by enabling Type A port as peripheral
> ---
> v10:
> * Patches 1,2,4,5,7,8 - No changes.
> * Patch 3 has braces added to one single line else condition.
> * Patch 6 has update on compatible string as per suggestion from Chunfeng.
> ---
> v9:
> * Patches 1,2,3,4,5 - No changes.
> * Patch 6 has update on compatible string as per suggestion from Chunfeng.
> * Patch 7 has comment fixes as suggested by Chunfeng.
> * Patch 8 has CONFIG_USB_GPIO enabled as module additionally.
> ---
> v8:
> * Patches 1,2,3,4,5,8 - No changes.
> * Patch 6 has update on compatible string as per change done in [1].
> * Patch 7 has issue fix, where device mode didnot got enabled after resume
>   from suspend.
> ---
> v7:
> * Patches 1,2,3,4,5,6,8 - No changes.
> * Patch 7 - Comments from Balbi and Chunfun adrresed.
>   Added COMPILE_TEST in Kconfig and updated dependencies.
> ---
> v6:
> * Patches 1,2,3,7,8 - No changes.
> * Patch 4,5,6 - Comments from Rob addressed, updated usb connector driver
>   compatibility string.
> ---
> v5:
> * Patches 1-3 - Commit subject updated as per inputs from Thierry.
> * Patch 4 - Added reg-names used on Tegra210 in the bindings doc
> * Enabled xudc driver as module instead of part of kernel in patch 8.
> * Patched 5-8 - No changes.
> ---
> v4:
> * patch 1 - no changes.
> * corrected companion device search based on inputs from Thierry in patch=
 2.
> * removed unneeded dev variable and corrected value read in
>   tegra210_utmi_port_reset function in patch 3.
> * dt binding doc and dtb files are corrected for alignments.
>   Replaced extcon-usb-gpio with usb role switch.
> * Added support for USB role switch instead of extcon-usb-gpio and other =
minor
>   comments as suggested by Chunfeng.
> * Enabled xudc driver as module instead of part of kernel in patch 8.
> ---
> V3:
> * Rebased patch 1 to top of tree.
> * Fixed bug in patch 2, where xudc interrupts dont get generated if USB h=
ost
>   mode fails to probe. Moved fake port detection logic to generic xusb.c.=
 fake
>   usb port data is updated based on soc flag need_fake_usb3_port.
> * Added extra lines whereever necessary to make code more readable in pat=
ch 3
>   and 7.
> * dt binding doc is corrected for typos and extcon references. Also added
>   details for clocks and removed xusb_ references to clock and power-doma=
in
>   names and accordingly patch 5 is updated.
> * removed avdd-pll-utmip-supply in patch 6, as its now part of padctl dri=
ver.
> * Patch 8 has no changes.
> ---
> V2:
> * Patches 1-3 are new patches in this series, which splits unified featur=
es
>   patch to speprated features and removes need of port-fake entry in DT.
> * Patch 4 is re-arragend dt-bindings patch which incorporates previous
>   patch comments to sort DT entries alphabetically, addresses name changes
>   and PM domain details added.
> * Patch 5-6 are re-arranged DT patches with major changes - sort entries
>   alphabetically, and adds clock names.
> * Patch 7 is UDC driver tegra XUSB device mode controller with major
>   changes - remove un-used module params, lockinng for device_mode flag,
>   moving un-needed info logs to debug level, making changes feature flag
>   dependent rather than SOC based macros and other error handling in prob=
e.
> * Patch 8 has no changes.
>=20
> Nagarjuna Kristam (8):
>   phy: tegra: xusb: Add XUSB dual mode support on Tegra210
>   phy: tegra: xusb: Add usb3 port fake support on Tegra210
>   phy: tegra: xusb: Add vbus override support on Tegra210
>   dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
>   arm64: tegra: Add xudc node for Tegra210
>   arm64: tegra: Enable xudc on Jetson TX1
>   usb: gadget: Add UDC driver for tegra XUSB device mode controller
>   arm64: defconfig: Enable tegra XUDC support
>=20
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.txt  |  110 +
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   31 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   19 +
>  arch/arm64/configs/defconfig                       |    2 +
>  drivers/phy/tegra/xusb-tegra210.c                  |  134 +-
>  drivers/phy/tegra/xusb.c                           |   87 +
>  drivers/phy/tegra/xusb.h                           |    4 +
>  drivers/usb/gadget/udc/Kconfig                     |   11 +
>  drivers/usb/gadget/udc/Makefile                    |    1 +
>  drivers/usb/gadget/udc/tegra-xudc.c                | 3787 ++++++++++++++=
++++++
>  include/linux/phy/tegra/xusb.h                     |    4 +-
>  11 files changed, 4186 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xu=
dc.txt
>  create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c

Hi Felipe, Kishon,

since the DT bindings have been acked by Rob, I plan on applying the DTS
changes of the above once v5.4-rc1 is release. Do you have any remaining
concerns about the UDC or PHY patches, respectively?

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Mfx8ACgkQ3SOs138+
s6HJIxAAsf7S8QBJIk0ZSPmaCeEGHV6AE0bi7bHJecdS4ZZoyyjbsLf1YxblDgBm
/UQrgTOJcIN82mAZNQBL+dgJK5LLiBdMFYPJPfD5R48dEWtXbmZzIAliFV9MJmJ7
DfZXuu1tWKq2GqTJrI71AKcv6EfbWG81w/G5IZFoFhg0zDxLe4AkHct5NpnCI0On
6vFMrxM0Z1qRkEDFP1nSCY1v/ci0Q3gEaNwvdP+H5FYwvjGBvNu501Yjj+xWj0AS
iT8SX4OkeaN5aWbMHUNViNQP26ul04wePJXLgPYfOGLw5bvG4+cSbbUbk07IfYni
KBPzoRwHV6r5xb1/fwE/dGrpLRrrA6RU7lKK0GBOoepBKQSIecLBR0dw6B4qSIov
si/nSwOe3z3dWk8v3mWWjON7pI5My+Trf/oEjq3TCJRTp/OQIVrNz7WA6qcJT+TR
hyrIweJ6w87eqtT9htRtye1S11KGphM2NklLPflSqymREjt1li5ESSJcUNuagz94
ThXS8VQRI2ZIFpy7Vor32qdTIY0yzTwePZdRHMTg7osVj/EhucFZTTeDNdKF0UB1
LxXGgPsOrRrSr7SewHVusPrYJ4GMVU6OmFyQOli48Hd60vlPBm7hbHJGBr6+m2S7
g08c/clhteBDZYsMHMWTju4c2WWyd5NfxF+9CtP7msj8s8i/jg0=
=m6Ln
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
