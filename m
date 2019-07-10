Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C456C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3F2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejFKPXzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfGJByM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:54:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46606 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfGJByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:54:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so716673qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rl/l0lv/RtftyGXlBncrpuyucSyNxpAjwoNFIcH2g3s=;
        b=ejFKPXzvn1phIqms4yYo1HxB+xY6s8QiTpK9ZIM9O57fTojLMYHr/DRRFzDGTZ6WRr
         AfHD/+bLrnMSON1NNIFDBkrmigmXylIQs5w6oZMKtm6KatMB/VhnG0YdC1yrMZxSyxPz
         563vtMNEkXSXr/+cvyhEZTIwSSa7d6Hzps4Sx6wGLO+75TAysv2hPme8AWIC852GRMoj
         1P4K6TstYvbDRr91qonIYHaO1qCMF4pxk3FpIisyVcXK7iYJ4gZHomtRJawJfCuwaKGB
         mbYE4Kmc/j8BrNLum2hJwSB2zrSguVLEFdOd53KuH3R17Oj64eVTkggetf1le5Q3pnTU
         88Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rl/l0lv/RtftyGXlBncrpuyucSyNxpAjwoNFIcH2g3s=;
        b=i/v1cXvsZJVTCOThTzliualXNWijz71P2IQ+stgRpNs50QbNsiT7DUJHkLds3k0nWS
         0Xs8nB5SDxiehp9OhkYRWIIqIkYoqjqbs1HiKmR/y9cBuaOt9+psRu8+jP8iSF/e0zYM
         maGaI9hF9x3v6IvB6JQs2kNhlWf/cBQCq2PcOAqJdHzBeAXJoRMfXOLjw3rLiiK4Tt6l
         SyPpjZiKyLViF0w8hJVM2wzfiN9uOrGMchalnr29tNcHht4o+MUWlE4k2CwI2VkMXnT2
         Sp7RKO7qDnxxuE4e7G7N6nRwU5R/W7YgWsVxMFoOgwqz1dWK3ySDKqvKN7nov8r/5Hdt
         9DZA==
X-Gm-Message-State: APjAAAWFT19EEt9QIn/G/PFAUWd7C/SpYtCXRUy9Oe1qSILe3wP5rB8n
        x9ISlILAGQhXgUKMhY6q+F4=
X-Google-Smtp-Source: APXvYqwdGvebD5uoi6JfsmmnbR3yoS0xb1kwNdhLQ2mb7mTC91DvgkA4fuimynlpMDk6de4G6s28wg==
X-Received: by 2002:ac8:2c17:: with SMTP id d23mr21131594qta.385.1562723651223;
        Tue, 09 Jul 2019 18:54:11 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id i22sm348098qti.30.2019.07.09.18.54.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:54:10 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:54:05 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/vkms: Use alpha channel for blending cursor with
 primary
Message-ID: <f09271656e9b29cb56e63c0bbf864060e5974cad.1562695974.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpslhh6j4fs42obw"
Content-Disposition: inline
In-Reply-To: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpslhh6j4fs42obw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, the blend function overwriting the cursor value into the
primary plane. This patch utilizes the alpha value for a fully
transparent blend of the cursor (vaddr_src) with primary (vaddr_dst)
instead of overwriting it in blend().

Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Mamta Shukla <mamtashukla555@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vk=
ms_composer.c
index fb106964d8bf..bb758a5131a4 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -26,6 +26,17 @@ static void set_pixel(int x, int y, u8 *buffer,
 	*dst =3D value;
 }
=20
+static u32 apply_alpha(u32 src, u32 dst)
+{
+	u8 alpha;
+	u32 k;
+
+	alpha =3D src >> 24;
+	alpha =3D (alpha + 1) >> 8;
+	k =3D (alpha << 24) - alpha;
+	return (k & src) | (~k & dst);
+}
+
 /**
  * compute_crc - Compute CRC value on output frame
  *
@@ -89,15 +100,19 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 	int y_limit =3D y_src + h_dst;
 	int x_limit =3D x_src + w_dst;
=20
-	u32 pixel_src;
+	u32 pixel_src, pixel_dst, new_pixel;
=20
 	for (y =3D y_src, i_dst =3D y_dst; y < y_limit; ++y) {
 		for (x =3D x_src, j_dst =3D x_dst; x < x_limit; ++x) {
 			pixel_src =3D get_pixel_from_buffer(x, y,
 							  vaddr_src,
 							  src_composer);
-			set_pixel(j_dst, i_dst, vaddr_dst, dest_composer,
-				  pixel_src);
+			pixel_dst =3D get_pixel_from_buffer(j_dst, i_dst,
+							  vaddr_dst,
+							  dst_composer);
+			new_pixel =3D apply_alpha(pixel_src, pixel_dst);
+			set_pixel(j_dst, i_dst, vaddr_dst, dst_composer,
+				  new_pixel);
 			j_dst++;
 		}
 		i_dst++;
--=20
2.21.0

--fpslhh6j4fs42obw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0lRTwACgkQWJzP/com
vP8IwA/9GS6vppNEv2BszWYSS5mPf/m5tf+g31Bh+IaaNJIrV4enswcymuGGJFI+
X1YkTtk+PklMFKEvnIS8GEKaMcPGJ5z6xpZ2OsdI5kgoa+OphTUaxAtj5+BCTPH3
hOtUilhl+tPxcQH+wZXFPMRuF+kZcr57rZ9UPSk9ti/C5N+tdMEB1JkZ24QOCLAj
cLse0oMFv1CdN6uMMm3NsjohpE2vWPQFERoduABGWXhV6kL0Rc1Il/REUo60dnP6
rJxA+ZPK29p+Gsleb+t+kdjk5YmwbzzuOxaC5dfpqPBgL0bRzS7hqZA9tgYCPQWj
YpJAChHw1OgIEKsXvibM4dpb2a6BrBDj5QtqjtgZqsiBramBhCcGkB4hujH8YSdC
lcfP5t59EEcuynn6vlq0bW2PJp0EE35OuvuAmyHyMXXnCxgMXCrsVkfgFJIWI0nt
Af++PQJzPIv26bEq5fEP7d7BKtCe7V43uVb/MYQeGTFWIzOuir0hSuDzfLHX4QTY
9M8Bko7certhVdjZLDHHOPBYazRlvWiOrWngi5gIsNIjr6K9QxLQVrXaLtcmcJg6
u5N88kD+4FR/1NrVsh/yowXhhvOllgoSeG3jkRR9WdUBCAjhMIMWnrftXli0NvJ4
2Kwg5pKrClwP2ajZ5apbJgekqV2MhnoGms0CITk/32V9aRJaUvE=
=JUlX
-----END PGP SIGNATURE-----

--fpslhh6j4fs42obw--
