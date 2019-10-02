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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B37C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4269421D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prwhLR9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfJBOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:05:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43905 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfJBOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:05:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so15061649qke.10;
        Wed, 02 Oct 2019 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MPq5XvWYyG+QTyn+vm0iUraemW1tBZKA+C2/b10gM9A=;
        b=prwhLR9SfxtMz/sDh0Fm4R8ehuNjWiOg/6PaoDg1gmyjWdulJrzUCrY5oM4uE7pQ9W
         6LM6oZTz5er6MeMwkCmjC98No3bJrF+R61Ng97aAUaCQZ19rwQjVwHoslpgHCBNkorNb
         PBLsY48zcPUwpEYM5I7KU4jWJ05joBTFbdkQui3dn/9kU4O8sPFS8zxlVtKlWkaQzwYZ
         JexBoraBbkaPAd6bQOo7NDLVZVDlhD1WY+ZBKKOUE0fbi/q3yk52fqiXnL/AxCV66jsx
         CDQ7o9L7M9aTfzu4/NRWOhg1FTU568XSn2+GYW1vzkuey1OlEQsKyPobB7wMc7Pqi8kj
         qxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MPq5XvWYyG+QTyn+vm0iUraemW1tBZKA+C2/b10gM9A=;
        b=gM5XvsfxXb8s61OaGJ9nBXWPpAEVX3uKgEUfVRBdnhHDu+qUdDHCl7DMstg3xovS17
         Ns6g3nbzQVeHfgxonmidmjl7wljWRJH7pZFbuHVp+fRL/qK2ggnFQqJD0GBP/18rag4Y
         eaF5txsh4GVlsgA9clgFUoVdlwB6mVUxrJ3U/SUyh+ksVOP3xbJGfJ+vy82zvP9kmiEG
         A4njNyaTLyfjWD1dnILaSIJnPUHf2JvDySZY+gwpWuWOL2/aWEbbJJXId4O0TAsYIB5e
         5Ce1SU3iAqVan1vpwpUXkO2UhTGpEmii+AeFndbnFk6hOEuwG5UI+Gky/Yk5zeav5S7S
         9ezw==
X-Gm-Message-State: APjAAAUe2r6OHlu8X6HN1swAZdfAn22WhLQlwq5ZYmImKwqIELK403iW
        Mt49+p1mKMG5eM1m9R3yUWYDrcRe1fGH9g==
X-Google-Smtp-Source: APXvYqzOQ3sxj3tGzqUztNfd/ZTnqw3nHag6A7wTgTBddqa0WtrmSAtpghMC4A4zzCPVUzk3fte8yw==
X-Received: by 2002:a37:642:: with SMTP id 63mr3861495qkg.29.1570025118685;
        Wed, 02 Oct 2019 07:05:18 -0700 (PDT)
Received: from smtp.gmail.com ([132.205.230.13])
        by smtp.gmail.com with ESMTPSA id m125sm10075076qkd.3.2019.10.02.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:05:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:05:16 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Keith Packard <keithp@keithp.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH V6] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20191002140516.adeyj3htylimmlmg@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rl7p723dixcepzft"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rl7p723dixcepzft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For historical reasons, the function drm_wait_vblank_ioctl always return
-EINVAL if something gets wrong. This scenario limits the flexibility
for the userspace to make detailed verification of any problem and take
some action. In particular, the validation of =E2=80=9Cif (!dev->irq_enable=
d)=E2=80=9D
in the drm_wait_vblank_ioctl is responsible for checking if the driver
support vblank or not. If the driver does not support VBlank, the
function drm_wait_vblank_ioctl returns EINVAL, which does not represent
the real issue; this patch changes this behavior by return EOPNOTSUPP.
Additionally, drm_crtc_get_sequence_ioctl and
drm_crtc_queue_sequence_ioctl, also returns EINVAL if vblank is not
supported; this patch also changes the return value to EOPNOTSUPP in
these functions. Lastly, these functions are invoked by libdrm, which is
used by many compositors; because of this, it is important to check if
this change breaks any compositor. In this sense, the following projects
were examined:

* Drm-hwcomposer
* Kwin
* Sway
* Wlroots
* Wayland
* Weston
* Mutter
* Xorg (67 different drivers)

For each repository the verification happened in three steps:

* Update the main branch
* Look for any occurrence of "drmCrtcQueueSequence",
  "drmCrtcGetSequence", and "drmWaitVBlank" with the command git grep -n
  "STRING".
* Look in the git history of the project with the command
git log -S<STRING>

None of the above projects validate the use of EINVAL when using
drmWaitVBlank(), which make safe, at least for these projects, to change
the return values. On the other hand, mesa and xserver project uses
drmCrtcQueueSequence() and drmCrtcGetSequence(); this change is harmless
for both projects.

Change since V5 (Pekka Paalanen):
 - Check if the change also affects Mutter

Change since V4 (Daniel):
 - Also return EOPNOTSUPP in drm_crtc_[get|queue]_sequence_ioctl

Change since V3:
 - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)

Change since V2:
 Daniel Vetter and Chris Wilson
 - Replace ENOTTY by EOPNOTSUPP
 - Return EINVAL if the parameters are wrong

Cc: Keith Packard <keithp@keithp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 9c6899758bc9..71cf2633ac58 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1610,7 +1610,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, voi=
d *data,
 	unsigned int flags, pipe, high_pipe;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
 		return -EINVAL;
@@ -1876,7 +1876,7 @@ int drm_crtc_get_sequence_ioctl(struct drm_device *de=
v, void *data,
 		return -EOPNOTSUPP;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	crtc =3D drm_crtc_find(dev, file_priv, get_seq->crtc_id);
 	if (!crtc)
@@ -1934,7 +1934,7 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *=
dev, void *data,
 		return -EOPNOTSUPP;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	crtc =3D drm_crtc_find(dev, file_priv, queue_seq->crtc_id);
 	if (!crtc)
--=20
2.23.0

--rl7p723dixcepzft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl2UrpsACgkQWJzP/com
vP9Bgw/7B/I5MWK+6MLQD5y+0VUQythB5k6k9wovD2C56y3E0D5IOxknr7iX5xTb
nNCZCFN8Ks4Zd3lhBRxcHMbetf+CwhvaWSRBhpxfptOSCeJK18WKADoULmTfgii3
DUeQsN5Ohr79ftYn89vb8TrsoGnAYXFFaCtlfT6IE7iUYw8kAAgIKJ5ngexvwMlt
MNvluV1MJVaE6kEet73dUbcW25kCwksR+tuSk1GK5w5F1reX6n3m8FAkdMSdVyPU
DcRHEv3q3D7d3jCGmFfj16MiqxQFBhyN7rjk36kZxNysfLm/mzyfxTl7LiCkUDkI
jmfZvIww+HHuU3I9D/4yORqfcuGNVHwVdT0IgzYx+RdpOmYej7SlhW2Nur/oP0Du
vKbyKtoXFGQ2tBAAWVEyPeLeVYUgO3Yczn7qHbbnQflnDGCLhof3V64CtvXjzvCK
vMrrwTqC8lDF7l9Fm84AFX1whua8+pU7xS99NNyPzmXMLkT37kgDaAHUBzrCKoHM
mwilQUmgiDLw7n8HTmCYkomWIGK4G3sMii/df4vqQoOEeyYjG3CrzGuXYzNBYamy
bXqpI2jQUy/hYLg2l9/vgVAvBatIeWEcGsej/+NhssUB4vTMlA1YUqwobJUnnA6e
5PsyKjJus9M5WJDCfJSfn+DSYUpA2+t/MRWwiS0xZGCl4ebAc90=
=nh5K
-----END PGP SIGNATURE-----

--rl7p723dixcepzft--
