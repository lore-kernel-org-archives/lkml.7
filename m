Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B868C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB722083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+UmNgMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfFFWks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:40:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:40:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id r18so5570984edo.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=phnCWAxvmUCyTW6c5t2uUP0p/ctzFwDLw8hDVCeBb+I=;
        b=U+UmNgMJ383xno5xjEYhVlJgAAsmxRbAfZpqQ619BoqL7fIbXRBOjRPTaw0/j8CKKX
         VKG1i/PbbbMLuIO29fXI494Fa/qc5/KlqfV9WDEenibnqqsRUDl9J7mPNUb0K9+cC91/
         0Q8SgwIgOzNGElWxZSyyaxlBUbB4KYl9mfWXg2QU2kBqbaKN1XzKfq/G2DC0deWmyFSa
         7N1V1D6hL876838zbl30hfQ3Yy9A2sI+OfZgWKPGn222hvPhSC3A9VHujtwFDWOYIIEB
         0CM2sfEDQ4MVtWlAoI/L9oT6CJPZbXkhZK0JXQfCueZdvRlJhQ55bwcUxJ1iPcx9Bt7K
         NOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=phnCWAxvmUCyTW6c5t2uUP0p/ctzFwDLw8hDVCeBb+I=;
        b=lU4DppFfN/+O5FWW+VQn+9yUna4p7pbspFEsZ1XFDWW77ngaGrVxSscGCqkoEFZevu
         Kai3KxTkrS1Ssi4/l9/iBLy0K8yA0DQ6uO+UdnexAYspmokXrR4DT4eDi79hR4s5MiYX
         FyXYzXw7BKEl0W5kC+QIfwyJalkUaZxzVfB7TM2VyojNhgDIWo7mOHDCQ70MKdH3QlQU
         WtG5NsST3UROEC7HBDMOWkedgeczDCOIgJtdmmPYQjIpzt0R5PnPdn6fDT9ho8bilL3x
         +R3+o6KxXkvZ+sBUfRmJnHrhLHFV5zwRMqpu822w2qvzLJm6qpPcrmYFADjqreZQPY0M
         c3aw==
X-Gm-Message-State: APjAAAUBjxLApeDWI+0HylypNjNmX7PX/ITl7j0YQkoCwGQzvJd9dpat
        fMcXk81b13koQHhtbDJ3QvU=
X-Google-Smtp-Source: APXvYqwd34GV/ljRusChb3NlKnkx4KXjGhPS4IEWP75EI54kblA3z2OYq/LyXOQnMuR/LmkDu7L3MQ==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr18236138ejd.80.1559860845759;
        Thu, 06 Jun 2019 15:40:45 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id f13sm60065ejj.7.2019.06.06.15.40.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 15:40:45 -0700 (PDT)
Date:   Thu, 6 Jun 2019 19:40:38 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fku5dw5gt3ggyzpv"
Content-Disposition: inline
In-Reply-To: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fku5dw5gt3ggyzpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When vkms calls drm_universal_plane_init(), it sets 0 for the
possible_crtcs parameter which works well for a single encoder and
connector; however, this approach is not flexible and does not fit well
for vkms. This commit adds an index parameter for vkms_plane_init()
which makes code flexible and enables vkms to support other DRM features.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
 drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
 drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_dr=
v.c
index 738dd6206d85..92296bd8f623 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -92,7 +92,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.max_height =3D YRES_MAX;
 	dev->mode_config.preferred_depth =3D 24;
=20
-	return vkms_output_init(vkmsdev);
+	return vkms_output_init(vkmsdev, 0);
 }
=20
 static int __init vkms_init(void)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_dr=
v.h
index 81f1cfbeb936..e81073dea154 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -113,10 +113,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev=
, unsigned int pipe,
 			       int *max_error, ktime_t *vblank_time,
 			       bool in_vblank_irq);
=20
-int vkms_output_init(struct vkms_device *vkmsdev);
+int vkms_output_init(struct vkms_device *vkmsdev, int index);
=20
 struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				  enum drm_plane_type type);
+				  enum drm_plane_type type, int index);
=20
 /* Gem stuff */
 struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms=
_output.c
index 3b162b25312e..1442b447c707 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -36,7 +36,7 @@ static const struct drm_connector_helper_funcs vkms_conn_=
helper_funcs =3D {
 	.get_modes    =3D vkms_conn_get_modes,
 };
=20
-int vkms_output_init(struct vkms_device *vkmsdev)
+int vkms_output_init(struct vkms_device *vkmsdev, int index)
 {
 	struct vkms_output *output =3D &vkmsdev->output;
 	struct drm_device *dev =3D &vkmsdev->drm;
@@ -46,12 +46,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	struct drm_plane *primary, *cursor =3D NULL;
 	int ret;
=20
-	primary =3D vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
+	primary =3D vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
=20
 	if (enable_cursor) {
-		cursor =3D vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
+		cursor =3D vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor)) {
 			ret =3D PTR_ERR(cursor);
 			goto err_cursor;
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_=
plane.c
index 0e67d2d42f0c..20ffc52f9194 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -168,7 +168,7 @@ static const struct drm_plane_helper_funcs vkms_primary=
_helper_funcs =3D {
 };
=20
 struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				  enum drm_plane_type type)
+				  enum drm_plane_type type, int index)
 {
 	struct drm_device *dev =3D &vkmsdev->drm;
 	const struct drm_plane_helper_funcs *funcs;
@@ -190,7 +190,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *v=
kmsdev,
 		funcs =3D &vkms_primary_helper_funcs;
 	}
=20
-	ret =3D drm_universal_plane_init(dev, plane, 0,
+	ret =3D drm_universal_plane_init(dev, plane, 1 << index,
 				       &vkms_plane_funcs,
 				       formats, nformats,
 				       NULL, type, NULL);
--=20
2.21.0

--fku5dw5gt3ggyzpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlz5lmYACgkQWJzP/com
vP/GWQ//c4M1YV33fWDqKX2AI2qcXLq01JsMyc1gEebKgdNrDbmUyy0i2sXYJTAV
e0xxvdE7fsg2LFOQWhf4SHh2qggffGzIq0uN45PSxqfIcm6E4YG+6UzgjDkKzly0
5Ak4lfkbIfJHtD2U1BrkBOTYzioP8pjGTCzMuYA1PWQKFbzVtqNQ6Krd1lEkukof
ppEHX9gVSg8APh9SbyOiINQWYMGYRQcEd9LUDs1vESvgrmPCJnfHKA5N1BXGfWd1
Jp1g0YYsl/uxbbKRDcx9l7XRAmb2EWVmGQMpgJRHpW0S2dpjGwYtr4Gvznk8PfCe
9B+OecaDWabkgOYpCaDi+DaFlhV5m4/6bN0vsPwAsEbk+kkjprvjM2aBdHyg89gJ
6an8pqmNc3GTy64aJivZzqOrYsEzSB+WI2OWE7NCUAvLIjfpvcEOqZ3tRloeiqRr
ONXeMQoCSyeboUK0HhoQtI6dFri9Owb4hQzurF7KHs/N/huINE1o/jQ2nijvLWdD
oHB10VAvx3J54VFcIxg0I6Tb20UW3zkMxSspETLpuk9fbcVQMCG7BvhTvXfSmqu1
VEEhyhHA60BBg89IJtzi0jBM+mfUtGzWgBYdJ4hyTC0wFKrg1Pp10QAF9004xLsU
euJQldoAXykA8MC+Wkt1hbL7sDNcXA+FCb7kcPbM/gFShgYCLXk=
=vnl/
-----END PGP SIGNATURE-----

--fku5dw5gt3ggyzpv--
