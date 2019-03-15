Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25544218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJa8tiKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfCOQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:11:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46589 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbfCOQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:11:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id i5so5789594qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tCc9YmCqBXseqllLK8H0jcvmWjOIz2VmRnsOAQJiAPw=;
        b=bJa8tiKwetJ8iOchB8k1ywdgBrruhO4gMMEQ9PagUAqU+P1rI/WOEisOm+JK328BCM
         XV1f/VHGcv9RMQggk8Vk0B2qP9xelV46hhztJaCwpRnnq36+8o+XI8UuHiN6hTXQn8H5
         Fg3aD7VoHY0XrF1g6f35QuK3yirNm8CmnnXiOw77nKF9iaa/62qnmeLPTWOQKYi0fpzT
         3k1lURloSkHrcQ9zhBpymV0Se7AhHDwSmN1plJy/p1zrhqdyIh3unjklSpUj2bPZTrAt
         h7eqz9tbdwUCFz2VzFiGUf8I7C4W1nEKctMfF3ZUlY34i/KXRwkPh5a0P1RYQfDrHKOs
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tCc9YmCqBXseqllLK8H0jcvmWjOIz2VmRnsOAQJiAPw=;
        b=NHICoQ2A+G4UjYl5Ku+IZE2PyqMjtC5Pvq2hYQUwb+TahVZAJFM4ohBzSxGSmrJ2I1
         sXV6l6U1GGqB0l4tIhnuXl8wVqkR8L1U0fCehCmg9MJ3QYDgRE5GMVR6orvDuyeBtnGT
         E3slBhjb4NVVjwELKgVzIm4y4RG1DTltCMfaZe64u+8O9FryB3usIofYi5K0bvZqYgxe
         0vSmExzzkVzBxN1eV+voEuH3usZ+Zew80xPVfkK2qM/hl/FOFMedgCpZDKrCGA2xasv5
         wUZ3aZ0UxbD+NwkRRAkHHxw1sdLOBfHF37BRIuXXNyUmaaVCSokVOvU0zh6pD5BxqcUT
         dHhg==
X-Gm-Message-State: APjAAAXBf6hOuKrco/zZ8T8kQ82yRySap3OSBfZAkPlOznwCNcU8zJz6
        wgvLwhdUmddcElE98y3BRf4=
X-Google-Smtp-Source: APXvYqySWlvKFQGyTFkDdkQY5K/Raot1pWpHRIlvu4aeBi8FKZ2uAZhyecMhCrrDKYdBKWiFH/DPbA==
X-Received: by 2002:a37:5f47:: with SMTP id t68mr3372962qkb.108.1552666305824;
        Fri, 15 Mar 2019 09:11:45 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t55sm1706603qtt.57.2019.03.15.09.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:11:45 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:11:42 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/vkms: Remove useless call to
 drm_connector_register/unregister()
Message-ID: <20190315161142.23gfu32lueyqrmyq@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6zpjs27vvyos4tq"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6zpjs27vvyos4tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function vkms_output_init() is invoked during the module
initialization, and it handles the creation/configuration of the vkms
essential elements (e.g., connectors, encoder, etc). Among the
initializations, this function tries to initialize a connector and
register it by calling drm_connector_register(). However, inside the
drm_connector_register(), at the beginning of this function there is the
following validation:

 if (!connector->dev->registered)
   return 0;

In this sense, invoke drm_connector_register() after initializing the
connector has no effect because the register field is false. The
connector register happens when drm_dev_register() is invoked; the same
issue exists with drm_connector_unregister(). Therefore, this commit
removes the unnecessary call to drm_connector_register() and
drm_connector_unregister().

Changes since v2:
* Remove unnecessary call to drm_connector_unregister()
* Remove unused label

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/vkms/vkms_output.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms=
_output.c
index 3b162b25312e..56fb5c2a2315 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -6,7 +6,6 @@
=20
 static void vkms_connector_destroy(struct drm_connector *connector)
 {
-	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
=20
@@ -71,12 +70,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
=20
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
=20
-	ret =3D drm_connector_register(connector);
-	if (ret) {
-		DRM_ERROR("Failed to register connector\n");
-		goto err_connector_register;
-	}
-
 	ret =3D drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
 			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
@@ -99,9 +92,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	drm_encoder_cleanup(encoder);
=20
 err_encoder:
-	drm_connector_unregister(connector);
-
-err_connector_register:
 	drm_connector_cleanup(connector);
=20
 err_connector:
--=20
2.21.0

--q6zpjs27vvyos4tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyLzr4ACgkQWJzP/com
vP97YA//YwyytXmEED5Igsv5gqUGohF/w/yPPrQ2dcNitTXr7XiWHM5xn931rwLb
8xt0wq1pqS1zjWbGmVij53zXApd+ZeJN82/sv6xfsK3Xy9sOSmKab9lV/i14a9kX
KcYE9WMx9xa9yZjdmw/AOPZgQ5ZzBm16l++n+xYleNiOEju0I8Jjskwdq/xalvRu
Ww5bbsr0eOt2M5oIGlQslyPWz5WbIla5oN9kxa3DrK2GK3q1w2OfuZ0QvQq2fVoy
wkOcnHH1HW+Ha9h6MtXvd38Upjv5dhUYFwt+g4S+IIaLBC2qYD2oO9+KMtuz/p2j
Y94xAkM7e7Q3xiqjn39OJ6CrYvdjMTdKAnFhmMEbH2V6LepJxwaBRWvvllj29LdH
XHfTO2Yd+2rW0dwj3IYFiqqNF3iF0kLQ71FHr1gk4Ak44n3PYe++UxR7deHnBq1Q
NBlJtGmXq4CsUc/Or0cb+n52PhCwEB2fTvCnQo/EyTS++e1yaYMRthyfyexIrb5O
4oXlRVoXG0MLl5udwC8NX2rqj2Bd488PWkC+V23G6enVAB5BNdlkLQVgtQ/aroIG
seB9CFBHMTbLU07XywPED8hokv4b1gTgf1vPfOAcjX23vrTIi2XAIrj4XkVD4hGw
F7Pn0/okJi81/FnrAIyD/ZDJKS4AxwlLeaU/ZdnwlI4cHDu7a7s=
=e/lU
-----END PGP SIGNATURE-----

--q6zpjs27vvyos4tq--
