Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3ADC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2339217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQG3Tb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfF0CYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:24:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41283 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfF0CYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:24:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so437676qkk.8;
        Wed, 26 Jun 2019 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CwXiTfKdRBSuqmsWvDSj+CcpjrFT7bp9Wdj7/SDDQQM=;
        b=gPQG3Tb3BAqDKCYjknMDPN8Has7WknTuhjx9Onc73ZUttwxlJS7RWqDjI5WjJDKqkc
         YY0RK5D22jP62x5APzLIRXcBvSFXLswLi4euPI89GtJchEdGEWOPBYk7T17cPaTGW46H
         sAo8DxxOoYjPy6+1z+q1WEbPEdrVUfARGuO8gIpfkQm/jY6bdXCtERiVrjIUzzLhT5wu
         JhbqCoKWvAqrcBijMt9eZDrw50UGcpoeAgHrrkL1BGyMLhqEmAhNHqRrMaZNvMT4lGBA
         iermO0Uahq8pbAds3Hg6SLY1nGxws43CAmQui1woxsrDG9KY5fUaR5PhV4HhUFW5WLuv
         uewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CwXiTfKdRBSuqmsWvDSj+CcpjrFT7bp9Wdj7/SDDQQM=;
        b=FlqO9w4rRTVJYIznJmJ2wGw3uv8qeFV8rwXfGZYDjtAYhPBFGy+MqU6vcjy4eiVdmc
         11pWTLmUijcFCEbOery9V9yx4hL5IosSs9lzJ0KtKhV/QlCjk7td3LIK4u1UtXDTyIsI
         YVQqXBS+j9mW1fzGu0+MYMp48XjLGcOonh/nYvfcYG4kzZsXDZpuqaHAlmFXs1hgQIBt
         aAKF5oioegr0AqdCnxc25J1+l4Acs1XYSWd3YODcCQiL17P4bA4TLrIGzU45x52fNtfQ
         Bs9/vFoEpUivD7bve0DrADwbStC2iszvQFNpTDyBXovqGSqYoyDtkq4oDQvlHyP4kAGg
         rsuw==
X-Gm-Message-State: APjAAAVYh5e4fk+IlZ9E5tOVyzXrKfgviUQEhqBUluagvQT0Z89sOMfK
        x79nUWAPPe04xrkAvM4Tt1YU7gJMGXM=
X-Google-Smtp-Source: APXvYqwILC8Qzl3XDYRopJbpc3veonxZ8pt1ecsAMrdQ8LngY2Fyk6ZNJJGcWZTk1ps0EoHJAC0k6A==
X-Received: by 2002:a37:a86:: with SMTP id 128mr1164611qkk.169.1561602293573;
        Wed, 26 Jun 2019 19:24:53 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id y10sm290769qkf.82.2019.06.26.19.24.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 19:24:52 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:24:46 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Keith Packard <keithp@keithp.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH V5] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190627022446.fkuomcgiuu3bj3kb@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ygl3ejqndwnzekz3"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ygl3ejqndwnzekz3
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
* Wayland-core
* Weston
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
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 603ab105125d..bd4ac834d3ef 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, voi=
d *data,
 	unsigned int flags, pipe, high_pipe;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
 		return -EINVAL;
@@ -1823,7 +1823,7 @@ int drm_crtc_get_sequence_ioctl(struct drm_device *de=
v, void *data,
 		return -EOPNOTSUPP;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	crtc =3D drm_crtc_find(dev, file_priv, get_seq->crtc_id);
 	if (!crtc)
@@ -1881,7 +1881,7 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *=
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
2.21.0

--ygl3ejqndwnzekz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0UKO0ACgkQWJzP/com
vP9DYBAAl3K8kqqVa/P2GDZvxDrE3XCKPipZhDER9QiBIHjjIeEFvMavxBEVvm+T
4fmVKfta/9xYLDcoBvzk8ZxJhpsB8xSrbEZbRcBHKQ+VtF2JU6ArKbqU5TnNBHyZ
HY4eL0Ju6v9E0A8HmutOfIPZPgJT4DFihHhT2hqqjNldkB2CvfOnny6msf7FytGI
piD1wPcYwYNN03ZRcXEW5ocyWByA0mY1aTGCVS1ogYkdDtgz/t7+r9I+Yx6oCWOL
uwhgYCMskG2/PAHm/4xx+qPjwnrN/2TCAW07udDI3Mz0BpxTXlKH+iXC6K5Frt7g
IK/kN6PHk7JCzsz+1uQMOcH+hJJHfgrLSEyUZtpE02vCe1KYHiE7FpY2D5kHj4s1
4l5fButamxNI6mHkg1uBigkfF3R06OSuBJE+q3np0EDf7TE4LsLu91KENCdEa1SF
r3FzrFyW/IZRNWFgNs2ZxbYysUHwogDFkWjvRIxCKnUGGe5Gdg3g2pOsPfJ+yGal
8Bk0OsTgvVn0J9wwS+R8ldOu/Z6Qdd4wwaQpAESYQnogjAA3U5Hy0dMHV46WlycY
6+rWBgr6AdiHKuRgXa2Ga3XphXBZCGD/2AtQmm3M8Jl51GdgPErONbMalazsl5Pb
cTJ7rX4j+lYzlvL+saFge2VhXsi8IV6JICcrQ3eDzrjJnBzPdVY=
=t8eI
-----END PGP SIGNATURE-----

--ygl3ejqndwnzekz3--
