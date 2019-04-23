Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A47C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C603C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kilf12o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfDWNS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:18:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:18:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so15881wmc.3;
        Tue, 23 Apr 2019 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0W/ieVXTDACKJD5/u7Zzc0Cn4JWl8Yl/jAASWVNhDI=;
        b=Kilf12o9zqLuCwvNDvGQhYPzs2yBloa06oYltl4ioofz/JpVZ6RJHCQ0cxhrtPfc4w
         arwNdnEVxEb3oxt+KVV4Wtcd1ix+mfn/2jh9n2S5QliUOvR6Urr33p+6eHIQGCZyVra3
         WnN3hjIXIrF5ZnItr8bHV/ktE2hTAo2KFC3VnGakxcYKzstBsfVJbR+7qSH+NZm4U9AD
         IPiMFTjL0LQpWUAmpSiFgYYWLl7S+Ml6wROcwACqeCdQRr2q0W2ajNsIAyZK7pZcaqEp
         snhkK8dtYDSBs4agoIX0tGLT2tVAPahGOmpIIoyLaoJaUBypKJHKz//XtZh35kbNhnHH
         lGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0W/ieVXTDACKJD5/u7Zzc0Cn4JWl8Yl/jAASWVNhDI=;
        b=rkXwgdbM7i5E6biNeeDQ/iB3iYLw1rChVa6miDGDxZXDXzHuHeXmZpmFqzpjel9cjM
         1K0f0Gzb1BpHUOfg7MnjByltce9SCEWET4ciiIlfClxZtIYdIngmkO2OyEALXf+zAtiK
         Wyv+aaWONJcAPCCH5+Lq4Plg0KoD6U/6iS10jfbFNDQwSL0wMFFA6n1wokJnCHZiMJh4
         rXR0r7oenEjnDrNmX+YHHGf8IUuGm0A3q0atLFQhgL5ed4xsKEZDzzVvOIhcvYh1f2sp
         G+Cs+URRVW7suFskjqvTbZHo/q6MLN5/SPCcb14O1cc/EvQtFM8BlTOW6PprbVhliKAT
         sjjQ==
X-Gm-Message-State: APjAAAU8/KUOoMjBdW4mZZCUhZ7jljkGA4yCsw8TNjVM2XnTj8ScnNWc
        hEir+WngeIRe28ohH/k1R0Q=
X-Google-Smtp-Source: APXvYqykuK5KPdfhpeIjqFYT0aQvK78KX7WmfXjlBBOgYmgw+aNA7g8+ApQoI5KYZqpJ8IxefTxRBQ==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr2478395wmm.80.1556025535671;
        Tue, 23 Apr 2019 06:18:55 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id e16sm19913184wrs.0.2019.04.23.06.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 06:18:54 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:18:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tomi.valkeinen@ti.com, sam@ravnborg.org
Subject: Re: [PATCH v3 0/4] drm/panel: Support for OSD101T2045-53TS and
 OSD101T2587-53TS
Message-ID: <20190423131853.GP23448@ulmo>
References: <20190226075523.28997-1-peter.ujfalusi@ti.com>
 <20190423115506.GE23448@ulmo>
 <c25a9364-f69f-17b4-34d6-ec29e68118d3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssZxAlvqSOvXAj81"
Content-Disposition: inline
In-Reply-To: <c25a9364-f69f-17b4-34d6-ec29e68118d3@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ssZxAlvqSOvXAj81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 04:00:26PM +0300, Peter Ujfalusi wrote:
> Hi Thierry,
>=20
> On 23/04/2019 14.55, Thierry Reding wrote:
> > On Tue, Feb 26, 2019 at 09:55:19AM +0200, Peter Ujfalusi wrote:
> >> Hi,
> >>
> >> Changes since v2:
> >> - Added Reviewed-by from Rob to the binding patches
> >> - Added help text to Kconfig (osd101t2587-53ts)
> >> - Print the error values in dev_err/warn
> >> - Added Reviewed-by from Sam to the osd101t2587-53ts patch
> >>
> >> Changes since v1 (only panel-osd-osd101t2587-53ts changed):
> >> - Removed unused members from struct osd101t2587_panel
> >> - Use backlight_enable/backlight_disable
> >> - Use devm_of_find_backlight()
> >> - osd101t2587_of_match table standardized=20
> >> - osd101t2587_panel_unprepare() added to shutdown and remove callbacks=
 to turn
> >>   power off
> >> - Fix probe in case mipi_dsi_attach() would fail
> >>
> >> Add support for OSD101T2045-53TS and OSD101T2587-53TS from One Stop Di=
splays.
> >>
> >> The two panel is similar with one big difference: OSD101T2587-53TS req=
uires the
> >> MIPI_DSI_TURN_ON_PERIPHERAL message, thus can not be handled by panel-=
simple.
> >>
> >> Regards,
> >> Peter
> >> ---
> >> Peter Ujfalusi (4):
> >>   dt-bindings: display: Add bindings for OSD101T2045-53TS
> >>   drm/panel: simple: Add support for OSD101T2045-53TS
> >>   dt-bindings: display: Add bindings for OSD101T2587-53TS panel
> >>   drm/panel: Add OSD101T2587-53TS driver
> >>
> >>  .../display/panel/osd,osd101t2045-53ts.txt    |  11 +
> >>  .../display/panel/osd,osd101t2587-53ts.txt    |  14 +
> >>  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >>  drivers/gpu/drm/panel/Makefile                |   1 +
> >>  .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
> >>  drivers/gpu/drm/panel/panel-simple.c          |  34 +++
> >>  6 files changed, 323 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/display/panel/os=
d,osd101t2045-53ts.txt
> >>  create mode 100644 Documentation/devicetree/bindings/display/panel/os=
d,osd101t2587-53ts.txt
> >>  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> >=20
> > Applied all four patches. Note that I had to change the osd vendor
> > string to osddisplays, which is the one that is documented in
> > vendor-prefixes.txt.
>=20
> I recall checking the vendor-prefixes.txt and not finding OSD in there.
> Odd, as it is indeed there.
>=20
> > I'm assuming that this is the same vendor, based on the model names. If
> > this is a different vendor, do let me know.
>=20
> Yes it is the same one.
>=20
> Thank you and sorry for missing it,

No worries, it was merged (March 18) after you sent out your series
(February 26).

Thierry

--ssZxAlvqSOvXAj81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly/ELoACgkQ3SOs138+
s6FHLA//Z+8DwLFrB4bWhdcg9OxhdrF8C2hXzDH0yE1a1rPgcxuAEu/MQvivhvTc
S2RSk1C+epMUDsHM5eqgSPgGGU4P0vU8tcLWui/ZV1vYIGNgQy0BXFW8jXv5j9E3
Tj6Hi0fJDeVmUHGo9zr//NBwNSpMFsvNpuhT9nLxXeqFVg1iS9m0grfy6KkX3xUG
ECfXmSnIKzZQnVeOfvPSNpCzcVJ/6AggRCYsrdX/yQOUMbwqwop3KIBjRm9CmMpa
gIJj98Ji2U6DOOksNYoSYvBioyWBZ9oZeMepNYHK5iKH8s7BQfT+0TVTEVXXw5EJ
ide+e4l7JqFtx/Rmb00DytsthMwLsDrv+e542ojPGsAkjkDpNQrEECK3JgEWS50a
VOujE7LRGrLMglA8iAEjyUKlbbU6Pg1MSj963NN5gSgdO7elOyFtFVFXZVn3B8n+
KZLhGQxOjoG5RnBY4hJo5CQWirsfQ55VfewxLOeIGLKHwCd0WmrLcFopdakioZ3L
c7+vmOYir2tHNckW/phpqnoOhW7HiWO1aNn0Bl3GGcUHauoYGUDHMkjCamJYjBSp
xRhgVZZDWIQBEwIlBhdwFuziebK+95paaXek9At+OHOfibLuAiW1/5CZFqm5DrHW
hIG0lT9CNfs5gso9qJlHezKcZ5oF+ZS+REmRqbecbTOknTXpzuU=
=/ZJs
-----END PGP SIGNATURE-----

--ssZxAlvqSOvXAj81--
