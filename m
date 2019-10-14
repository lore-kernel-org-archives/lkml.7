Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C192ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0654520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKQcwAm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfJNNMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:12:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42651 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJNNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:12:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so19644689wrw.9;
        Mon, 14 Oct 2019 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJI3ujzhj44ZLvbKjedR8UxQ13QODqV/gLRFRQ2ma60=;
        b=rKQcwAm3qc7p942EYdxuq9VHdHdGCW160B6ZUX6xqZtOCA41ne6z/xdm4fXOhPVTym
         piPvQGQEjighdZCZ3wW1K5pvEEsF3yLnYfa+6iEeJlq2F3u8+C5hye9iqnUsdNHAG+v2
         EQ/5hzt7118hjdO5ebwtqQGlN5opSI8Wc4SfB9s3HFlBW+IIAiE955kVUQ2Gg0M8ZSg+
         cGj1zYpnZRWTTN+UQgs1eLFErWXno/QJwne5Xp6dctTBxEyHj53dcl5o4O7zmgJv1Z3i
         0oVMWX9aK1hom4ejy3cDUHuTemgPmwFVbwCSvnTtoNk4UA8jkkZqBE3ILedyoBpizcam
         oiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJI3ujzhj44ZLvbKjedR8UxQ13QODqV/gLRFRQ2ma60=;
        b=qNolaImaO5oVnOEXubQqPDwUec8syGud9MygBWdB+Tv7LNI2MIy+xHMs0eTqfWBg5U
         KbSdwagrF0QueLr9N+8sov/FNJiVV+a8HTX6BfcUp8X0Rif8wRnNTj3G4PIBl8vUGTUl
         fJqtwJKss/CWujIBpBu7lr9zsW5c/Hx4YdpbzrXqZa8pn6pIszUQfINLesMuOYPvSp73
         wfpwZdz67StJ9uxgqGtxncz7bMrrk5ykOYjEhuFraQpxzwRb7141CVf47DPV4ZoHjNaj
         jBdLVRmt4+1uWOSReEdyBe4HNPL8NTuxi3WMloZeRXdv9P1Dn6hgEAceLd9s61XVFRAB
         vJSg==
X-Gm-Message-State: APjAAAV8dVIdcCFFcywltfaCUH8azGiDEdVN7RtLrfeXDI6BFpwTG9ie
        ul1yH7QZrcrIj1nQkzGorzMpM/cc
X-Google-Smtp-Source: APXvYqz7g41GBdlUzuilDunX++cAxKLTowlaOmTVpaHCLOPid+cN7H4QOW5g3qaPbrSzY4NQCpOUGA==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr24320383wrn.97.1571058747866;
        Mon, 14 Oct 2019 06:12:27 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r10sm20196680wml.46.2019.10.14.06.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:12:26 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:12:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com, kishon@ti.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com
Subject: Re: [PATCH v4 2/5] phy: tegra: xusb: Add Tegra194 support
Message-ID: <20191014131225.GE422231@ulmo>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-3-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <20191009024343.30218-3-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 10:43:40AM +0800, JC Kuo wrote:
> Add support for the XUSB pad controller found on Tegra194 SoCs. It is
> mostly similar to the same IP found on Tegra186, but the number of
> pads exposed differs, as do the programming sequences. Because most of
> the Tegra194 XUSB PADCTL registers definition and programming sequence
> are the same as Tegra186, Tegra194 XUSB PADCTL can share the same
> driver, xusb-tegra186.c, with Tegra186 XUSB PADCTL.
>=20
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
> is possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. This patch
> introduce a new device node property "nvidia,disable-gen2" that can
> be used to specifically disable Gen 2 speed for a particular USB 3.0
> port so that the port can be limited to Gen 1 speed and avoid the
> instability.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
> - removed unnecessary #if/#endif pairs
> - introduce new soc->supports_gen2 flag which indicate whether or not
>   a soc supports USB 3.1 Gen 2 speed
>=20
>  drivers/phy/tegra/Makefile        |  1 +
>  drivers/phy/tegra/xusb-tegra186.c | 74 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.c          |  7 +++
>  drivers/phy/tegra/xusb.h          |  6 +++
>  4 files changed, 88 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kdDkACgkQ3SOs138+
s6HmyBAAuA9yYTCpqDsfbICoS5AwmWxkyiNCMD/+fgNqJV2XVKdmNaVhQ9XOZRMZ
l3IeKSV0xhPbaWRCBsTZftOdYUYgF4dMXJ2G5TAf5tGsJF693fPakF+AvXvazcwj
1+1FBw8z9V6C+jcZ74/bOtUmgAW9BWTxjd4wJE7VQtGflFEYiLfiA3kjMs2S1nMU
J600wdV6v9RH7wwQVUIm8FMiTlwC48QkCNQfoBc0Nzg4kMv+16+dgR1TM7TRAa3z
uon24QnKx2/Kx3d4CRxzCs51OEDwdAvuhfsRUYVJVvEWPu1fOHwTLxBSuaML1hxC
XtKtZNsyKU3b56yhDX2QCvST1r8lAyXXgt+l7lFxVgBvDv3qFMZxK9b7o1o9YXqO
JPvbmjHvjIF9RcLFH+beAhXTHxQVyhSgcwCFHLB2wa2TP6tdU5J9MF+PV70tj8fv
UVJwkb77jsdRr+taovr03j8k6wsysrzr/2WUCrbjuLdxtptTjYxmiMmclKxz2eEp
N8sSvSPBeizdxeH3wUvHjvH8bU8YlyjIMCw3qRzlx1vNgWD/NFm+QcUmudPq2Jn5
BfYtYwSpSD6yoUspOXgqs4GbiS3gXB3q2JzZG6d4ayq33HVZoIRqyQwi2CZ1f+QS
iBhZwtetGAhEgLhD+DXPcyAjBcCs0hqP0UiA6v1HQjUHZooXWo4=
=EPIq
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
