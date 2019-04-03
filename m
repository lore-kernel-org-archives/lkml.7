Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89101206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCRW4V3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCQRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:17:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34484 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:17:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so22226000wrq.1;
        Wed, 03 Apr 2019 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Mq2cY1QVk7joDEDTkrPeDb4wMZpGgJLQPvzLVIElhE=;
        b=DCRW4V3fLJFNlfFyZmOSkwOBFZT6Cl7Th4vprBNExXgWm/UzUK8t8rEYKh4LT2G6jW
         TJnqbddzvQtqpg/ufS1jRLRsV9ecy19zeLhspV29Z6xqnzMTHyfZOWAklFDbxaWVYG2q
         VPIqIUV6+eU65Q/K0eVfs1fvI9JEvynVB5Xh8p/YS1aX60ZJpJaVGae//V423bKmFHaV
         gd7hc7h3ScHIOkKtHUeQsq3QxTL7KohG7/q6QYLCVj8cdeA16eRzVEbGB+V/cY8+4HIw
         Ha1MltLIMXaFBzYQM6kwltXIIt6HN/8THykNCpIyzJPOPBny//32+OnceRJVcYNoLB0H
         SKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Mq2cY1QVk7joDEDTkrPeDb4wMZpGgJLQPvzLVIElhE=;
        b=JHefEQZEEpVl73+4CASkBFhCd3aveCjPGu3aN9qFl04m2qF0lGiY2IxMPruH0LbbMJ
         StHQVCobaTMuJCVkORSh5PN8Z0Am9G57J1cJcYZj0qzWX1BJnItI9X+SmK4S/2A13MLZ
         ny0UWZVMxoDQzePyyL05cCgnpdtc81A1QF4QiTvjONYbON21xP5aaduR7poIZU4YJKjJ
         HmFQ2POV/7fH9Zgxc92U0Itix+L1CJT6J9okbE4tP5UZByC3p4lPHPJ6JPL9r/0CMVH0
         87SyglKZy9p/nfPORMNBk25MUdze9OIbUPZLhIyAiamQqfEN7q3RoYZ2S2HpUvfXTw9c
         MddQ==
X-Gm-Message-State: APjAAAVlvfbiNuwlkllqlmDs5EnaGhXtadG7+/kPCroRvw1mh8KMQbUF
        Jx/LTL0SUyer8YCr/dxemlc=
X-Google-Smtp-Source: APXvYqzDrWvjlsuVFsbu1tbGuRc8TEbDMwxbqCYyyit6V6ogaVCugdZxH4VEMA/Sk7cdBgAvbvgpCA==
X-Received: by 2002:adf:c60e:: with SMTP id n14mr287765wrg.127.1554308257216;
        Wed, 03 Apr 2019 09:17:37 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id i17sm14895872wrs.44.2019.04.03.09.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:17:36 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:17:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Message-ID: <20190403161735.GN5238@ulmo>
References: <cover.1554114302.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline
In-Reply-To: <cover.1554114302.git.agx@sigxcpu.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 12:35:32PM +0200, Guido G=C3=BCnther wrote:
> v4 fixes up the DT binding example and uses a wider cc list since I
> failed to extend that when touching more files.
>=20
> The panel is a 5.5" 720x1440 TFT LCD MIPI DSI panel with built in
> touchscreen and backlight as found in the Librem 5 devkit.
>=20
> These patches are against linux next as of 2019-03-22. v3 got acked by Sam
> Ravnborg:
>=20
>   https://lists.freedesktop.org/archives/dri-devel/2019-March/209326.html
>=20
> Changes from v4
> * As per review comments from Fabio Estevam
>   * Add missing unit name in dt binding docs
>=20
> Changes from v3
> * Forward to next-20190322
> * Add MAINTAINERS entry
>=20
> Changes from v2
> * As per review comments from Sam Ravnborg
>   * Lowercase sentinel
>   * Drop '_panel' postfix
>   * DRM_DEV_ logging instead of plain DRM_
> * Add Reviewed-by:
> * Add "panel-rocktech-" to the driver name following
>   the pattern from other drm panel drivers.
>=20
> Changes from v1
> * As per review comments from Sam Ravnborg
>   * Make SPDX-License-Identifier match MODULE_LICENSE
>   * Sort include files alphabetically
>   * Drop drmP.h and use individual includes
>   * Drop superfuous 'x' in mode printout on error path
>   * Allpixelson_set: Add proper space around '*'
>   * Drop superfluous put_device(&ctx->backlight->dev);
>   * Add /* Sentinel */ in jh057n_of_match
>   * Drop jh057n->enabled
>   * Drop drm_display_info_set_bus_formats
> * Kconfig: Depend on BACKLIGHT_CLASS_DEVICE which somehow got lost
> * Move jh057n_enable close to jh057n_disable
>=20
> Guido G=C3=BCnther (3):
>   dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
>   dt-bindings: Add Rocktech jh057n00900 panel bindings
>   drm/panel: Add Rocktech jh057n00900 panel driver
>=20
>  .../display/panel/rocktech,jh057n00900.txt    |  18 +
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/panel/Kconfig                 |  13 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-rocktech-jh057n00900.c    | 386 ++++++++++++++++++
>  6 files changed, 425 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rockt=
ech,jh057n00900.txt
>  create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

Applied, thanks.

checkpatch does complain about the dsi_generic_write_seq() macro
definition, because it uses flow control statements, but there are
already similar macros in other drivers, so I let this slide. We may
want to eventually come up with something better and then replace these
macros for the other drivers as well.

Thierry

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3J8ACgkQ3SOs138+
s6GjLhAAnlOcK7nVdxLerCVp6PbKYuFKj+kqR4AJLx5c6Yt4kPZa5WOI2auCCMzb
eutooizMPZ4mmA7WVjk+hWlSoAysJBA9Os0WLqweEOCNG744AAavSDkg8tG8lBNM
/yGo9FmB19EMnjaYZyGyhJfLqR9j3LzIj1rFICtDAip9SDqS1elHR6C4TsykvF3O
Twk3UQP6Hs8oSq6ltaVJo2MV2bKx5Jq4pqs/JjNV62zsFX7tawJH9RdQYWqXeK/g
/39tOV+U/kyZTWHoQXuYJo4XaakbQxmf0wXHulaXke9mGjANMPvIRdz8rOFn7i4S
q7PrdSVkc/zhb2zI6QqUzwmcp/kDl0hYKB+QtxcOtSYCopBr2zAUen2tdRHburRK
UTJcLknCaMO1V9ALMGdwkFZoM/aHqbyq+Sb97cWkxMzZEg/Y/6OWj29R//jEHeOs
p26fsQIvUTiH+NrNA5J4wFX+alGcm+YuGF9kYdo9Hu7WfK+8r0tDC2823klwC9lc
QBLTb4DrWAk+u0Lxu3KDNAaj7J1GGWFtMUx6zdZhRm+hJE4bcJH266gPhZ7XE4Sw
vWbfF6+9Izj5EUAM8p1/W9wRgNkg+8xASjiaFKpfa++HZXnkSJ2GKcSgxHWOdEks
AsoSbXg92quaf7DhctKysF9dOVKfEVoUa73QAdxt6D85OATPwlA=
=jk8g
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
