Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D5BC73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FF92064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir1ZXekj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGJBxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:53:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34605 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGJBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:53:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so714885qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FKfKo9B1CRcLmq9txqUh+s6WgoiWvagwqjoqjlaktJU=;
        b=Ir1ZXekjheKQ6toSOnazwLGOvTBSlwDXx8BzQTcnNzWqkj1klkMDDPjRiG1Ahlgtl3
         jQPJEWcO+vtuySDBjAO6ffP7pg6ge85idG5UlKT6GWr2Ufa++K0UJ++76BoyxVvyCiEc
         IWeU0AqvzWTlqPQzhbaOZ4jiEkfIKrgv3r3WI46sLu4pPTorgswp4fh0XzdkJsrFmZSf
         G+6wcLqi11dlqMa/6W/ytbQO3lvCgrG7mNoGczFNW4BsQM2KllSsXEzUZAhhHQ8a6HCK
         syvttwtUXn4VTJL01gLUKBsPBXOjOowQSlUr5f0WN9PPW6T4i7XMabpHcGuxmthum5dE
         slww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FKfKo9B1CRcLmq9txqUh+s6WgoiWvagwqjoqjlaktJU=;
        b=AmC74oVyXs+cfDoSxXrBKHY1W/ZeU+bhkylk+TlLaWDnZIa+AROKOtXEKcL87w8lbI
         /RAJaNVGRMhKqpMt4sHmyo0d++CQtgTkgPLITrsYkZe7aKw2ywqsngySJnehw9fJ5/JF
         1PZfl0oaQ9yhTxl+ZM4GkyzdWc7pPk8vQXdby9GnRZSihalX/ZBwrHN9NZmOCT9pvKjV
         b9/EODiZNGMZmxwJn5KTh2sRIPOjhwSF3WYKOX3+h9IROMnVk8ozpMXMNpnyp0pSIVWZ
         WDLoO1MG0VtlHsMht60eoFAMCO4ibCYj0I9rDHQL91Qz+YH+fWf8TBFm7o5/XfSbRN1m
         uolQ==
X-Gm-Message-State: APjAAAWK0ncvuPDfRyvn1xDLAas1wPVV+kAFlud4AYslvzO1b6iw2TKB
        1JBTVRDaqhqDuk8HJ58wVTan8zp2TxQ=
X-Google-Smtp-Source: APXvYqyZjtPAFXEGx7q45BTzK4GpDZO61jVLHi6J+VWw6K/jS1ABqei5HrMR7yozVU/yyBtdt5MQYg==
X-Received: by 2002:a37:6a87:: with SMTP id f129mr21369566qkc.183.1562723592266;
        Tue, 09 Jul 2019 18:53:12 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id q9sm374109qkm.63.2019.07.09.18.53.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:53:11 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:53:06 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/vkms: Rework blend function
Message-ID: <c5fc1e8ae57cc3a2818a92e74b5eda5becaa1cf3.1562695974.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5lmqct4xe5d662r5"
Content-Disposition: inline
In-Reply-To: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5lmqct4xe5d662r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For combining the cursor into the primary plane, vkms invokes a function
named blend which iterates in both buffers and ends up by copying the
cursor into the primary buffer. This patch, rework part of the blend
function to prepare it for using the alpha channel for blending.

Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Mamta Shukla <mamtashukla555@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 39 +++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vk=
ms_composer.c
index 2317803e7320..fb106964d8bf 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -15,6 +15,17 @@ static u32 get_pixel_from_buffer(int x, int y, const u8 =
*buffer,
 	return *(u32 *)&buffer[src_offset];
 }
=20
+static void set_pixel(int x, int y, u8 *buffer,
+		      const struct vkms_composer *composer, const u32 value)
+{
+	int offset =3D composer->offset + (y * composer->pitch)
+				      + (x * composer->cpp);
+	u32 *dst;
+
+	dst =3D (u32 *)&buffer[offset];
+	*dst =3D value;
+}
+
 /**
  * compute_crc - Compute CRC value on output frame
  *
@@ -50,7 +61,7 @@ static uint32_t compute_crc(const u8 *vaddr,
  * blend - belnd value at vaddr_src with value at vaddr_dst
  * @vaddr_dst: destination address
  * @vaddr_src: source address
- * @dest_composer: destination framebuffer's metadata
+ * @dst_composer: destination framebuffer's metadata
  * @src_composer: source framebuffer's metadata
  *
  * Blend value at vaddr_src with value at vaddr_dst.
@@ -62,11 +73,10 @@ static uint32_t compute_crc(const u8 *vaddr,
  *	 instead of overwriting it.
  */
 static void blend(void *vaddr_dst, void *vaddr_src,
-		  struct vkms_composer *dest_composer,
+		  struct vkms_composer *dst_composer,
 		  struct vkms_composer *src_composer)
 {
-	int i, j, j_dst, i_dst;
-	int offset_src, offset_dst;
+	int y, x, j_dst, i_dst;
=20
 	int x_src =3D src_composer->src.x1 >> 16;
 	int y_src =3D src_composer->src.y1 >> 16;
@@ -79,17 +89,16 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 	int y_limit =3D y_src + h_dst;
 	int x_limit =3D x_src + w_dst;
=20
-	for (i =3D y_src, i_dst =3D y_dst; i < y_limit; ++i) {
-		for (j =3D x_src, j_dst =3D x_dst; j < x_limit; ++j) {
-			offset_dst =3D dest_composer->offset
-				     + (i_dst * dest_composer->pitch)
-				     + (j_dst++ * dest_composer->cpp);
-			offset_src =3D src_composer->offset
-				     + (i * src_composer->pitch)
-				     + (j * src_composer->cpp);
-
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
+	u32 pixel_src;
+
+	for (y =3D y_src, i_dst =3D y_dst; y < y_limit; ++y) {
+		for (x =3D x_src, j_dst =3D x_dst; x < x_limit; ++x) {
+			pixel_src =3D get_pixel_from_buffer(x, y,
+							  vaddr_src,
+							  src_composer);
+			set_pixel(j_dst, i_dst, vaddr_dst, dest_composer,
+				  pixel_src);
+			j_dst++;
 		}
 		i_dst++;
 	}
--=20
2.21.0

--5lmqct4xe5d662r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0lRQIACgkQWJzP/com
vP/ayw/+Itdrm1NoRlQmR54QNjAdScgLRFos2HfiesebqHZnyReyndZka1CAk6VZ
dvg24orUDjIIVFudeE5KdwK+td8x4/GH1ZMkKGOuuQ6fP4ays4E4qz7HUTB+TEEB
76VQohu7DslRLdnQGAEGmLep6nPIWB9xGQLmUP6RwpHCzKPiwy2rh0POXb1wTyXe
a9erHEUdmbV9/6wYt6HyTWVwEQSfNl2Hl5FBAT8m9jUy/qwmkscAPPLeEC/t7NCB
RPiCRp0jQkmBPIIwnBjZsrpYdXPsvMQohx8ershd/BMd+nl1czSpW+mx85Kgn9pK
Az2oFP4m3xUr3FGrMRzLIy1yMZfbTGxrZ8E+XP3d/G+v23AdVfzuwR7NidwgpxZa
lZx+Nv3mC60opqqyI+fTdDPIM+2go/sDCklo2BDCjFi/y+CYTkDDMUzh9qbdWZmB
hO3coGfBFSbKQc9X8OdPNM9RYqxYz3+G86lRq2T+/MS7gozWDzElzfvm7Om0wzBa
39WRY007Zqz2AoHYlYqD/Jnk+4So/ZpTbwlXeophUlb0Sg+Du/GcmVJavA7Q/1wD
Kv7/LcwNZae3nQt8WQpUBuvntf7b6vkInjDZDAv2Tv1jl5y2rA+MB3Lr61rmzViE
CHuu0dW4HB69L+hItS/x/CSGDCLFaZLwJ9eMlZwDQpHcYxN0Zkw=
=mndw
-----END PGP SIGNATURE-----

--5lmqct4xe5d662r5--
