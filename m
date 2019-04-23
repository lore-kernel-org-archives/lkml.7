Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5481120811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZtao0tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfDWLzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:55:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33219 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:55:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3so10219382wrx.0;
        Tue, 23 Apr 2019 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U98ru5cBSjh1C1hTH4dGSod1DpEwjZgC4DjIDobLwp0=;
        b=bZtao0tpRYhqFBmMtPu/S9BKaWNui2Zb5UngMuOlI52jJ+19LxNnBSAso7I4S3RQ9C
         RzCzUugrflzeM2pT0LAVv0rqXuFE5v/hIvih8uDKvANm8975QoetPzYthM42vt2NOxxy
         4yPSKvqcNxQ+TD3FYLA0bbaDKS5LP8snSm8Cj5vrSpqvyUnFug2Ljj1hh+mzf/EEcQXL
         JBROPbn50mJVizItdsiPYApFY9QW/akrXvZPtv/y3TvqP8jNxGpvn+9ahi6D6A1+wZye
         W1iAEjaiAserX0d0funx/x4aTlp9YH3Wyw7pJEXGdYNsysHABunnU2DHk5+uXJWs9A0O
         axvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U98ru5cBSjh1C1hTH4dGSod1DpEwjZgC4DjIDobLwp0=;
        b=QsTUuxLfWvKpqycglVoSGSqmNg03UZWKn/C3cw2fNycoU/SOM4LDZGMUwYAkzxBAVF
         b5ulIXPgNxe5TAUTDfrax6qCjINQzu7ldfoWRG4wjN4Sp/Fw672JECg9WCuSlnRrOFFQ
         dCX/L7S4lMdX2mMh2h24YXkfmX4a06h8KwBpmBay4i+zN03cJTXdkKxJ9RT408QMl/qa
         3IUBqKFh+pydPZI5m7KCHa/XNnnqgX9c5k78h3H7XYqR56IXGeflDQ3OWX0aQaf+buBF
         WIEId3FAD4Ez1Xxxf5kqTd4EM/YNW7CMTR1KXDLykb+6D2IYh+LAEpNECy9kewsTYcbe
         17IA==
X-Gm-Message-State: APjAAAUsL5hfDpT4KAyjQx9ZG/rw+5gpTkLU5poaC5tIBNVOkO68D8Sv
        GVeOWH4GjpvBZlzXEt7nzLQ=
X-Google-Smtp-Source: APXvYqzxIr8ENtvQr8+pI/IrzP4bN6foe7cafwOf85tzalXOoLaAovTM5FIVGXT79dKcW8NNLQMgGQ==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr16679082wru.306.1556020508940;
        Tue, 23 Apr 2019 04:55:08 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n4sm1383339wmk.24.2019.04.23.04.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 04:55:07 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:55:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tomi.valkeinen@ti.com, sam@ravnborg.org
Subject: Re: [PATCH v3 0/4] drm/panel: Support for OSD101T2045-53TS and
 OSD101T2587-53TS
Message-ID: <20190423115506.GE23448@ulmo>
References: <20190226075523.28997-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <20190226075523.28997-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 09:55:19AM +0200, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v2:
> - Added Reviewed-by from Rob to the binding patches
> - Added help text to Kconfig (osd101t2587-53ts)
> - Print the error values in dev_err/warn
> - Added Reviewed-by from Sam to the osd101t2587-53ts patch
>=20
> Changes since v1 (only panel-osd-osd101t2587-53ts changed):
> - Removed unused members from struct osd101t2587_panel
> - Use backlight_enable/backlight_disable
> - Use devm_of_find_backlight()
> - osd101t2587_of_match table standardized=20
> - osd101t2587_panel_unprepare() added to shutdown and remove callbacks to=
 turn
>   power off
> - Fix probe in case mipi_dsi_attach() would fail
>=20
> Add support for OSD101T2045-53TS and OSD101T2587-53TS from One Stop Displ=
ays.
>=20
> The two panel is similar with one big difference: OSD101T2587-53TS requir=
es the
> MIPI_DSI_TURN_ON_PERIPHERAL message, thus can not be handled by panel-sim=
ple.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (4):
>   dt-bindings: display: Add bindings for OSD101T2045-53TS
>   drm/panel: simple: Add support for OSD101T2045-53TS
>   dt-bindings: display: Add bindings for OSD101T2587-53TS panel
>   drm/panel: Add OSD101T2587-53TS driver
>=20
>  .../display/panel/osd,osd101t2045-53ts.txt    |  11 +
>  .../display/panel/osd,osd101t2587-53ts.txt    |  14 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c          |  34 +++
>  6 files changed, 323 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,o=
sd101t2045-53ts.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,o=
sd101t2587-53ts.txt
>  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c

Applied all four patches. Note that I had to change the osd vendor
string to osddisplays, which is the one that is documented in
vendor-prefixes.txt.

I'm assuming that this is the same vendor, based on the model names. If
this is a different vendor, do let me know.

Thierry

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly+/RgACgkQ3SOs138+
s6HwjxAApkyuZ5z3LbF0DqxwC4GvLYSGatYuIbmcjw9GIOXVz64h1/hcQyUPpnNa
Rgkk1YY895dSEKjtUeCMEC20AcCN4HajqeGwcTMghbYQu6IJQPDyZEqHzi4UIVer
B5YfKHNVvbKeLvcP9Ec+d+CCMnXUhcyVyJPCDJ1IdIpSVsNfD9RHL2y+9gPZoWVk
UTjaW4dP31vcXHYz+6ogDnLqBUmyx60r4g+QwGfyUEv67qCEkSdJhwJekj3FrS8w
OKD9WNFtAmATC/0V/5f3XB32xWPqRsnOyoxkwkKihUYiFmFPYMuzoNnjPWSh9ltp
MoOxqGQQwrYfEKQJ1BlSonrRYYF6UTnIHOlXHlZPvsXL0aKJfOyrLwGWQl7j9VuD
Dq5cJvILcasds3u79/gasiDHr4jUFyXrpo+tJPEDMu8aU1+8jHOaGprFwgdrEkl9
7dALPzjTNq0TpbFybE9j5GAt9GZ4mrGReeyltP5J9tn98JeLGWkNjB2tmtcstQUO
GKdOMyxsvu3/YviwkXnB6ZJ4+p3PslJgUJWLhFtYoyAFmqrXEa6DZtrkBRkNhC2U
k2lLxl6V48v48D/Aih42eIBYqfN9B627VZklfns3WAA6cr2I4kqkt3vVPGoAuWX5
SnxEZRZCJhoBrWK/JZHxCJ9BPLP8yariwchttuXeTFviucpqX6g=
=5YDH
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
