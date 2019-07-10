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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B91C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CF52064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf1ZG598"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGJBzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:55:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32791 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGJBzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:55:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id h24so797383qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+A+XURfQyB8AGFyMf1LEzeRDTsqVu/9+CULnouL4R1Y=;
        b=Kf1ZG5989CAPh773hWh61mlxI7hJpjFULTKfO6o9mI051brplF5Ag+TJCLa+tu7rbs
         CH1z34q9ANrkA1eE2ArJFFmD9DhTM0xjtw5gdChjav4mjfu1paPqYxxBLwHGr80o+qR2
         L/FRXpmikkLBHBDzdTgvTE7b4uTcYlVAabk1PTf6S7Rgh/T2dIssdUtG4zCNfEY+OqoV
         0tjBJf5xTrh5dJf5TALbvY+gUPuqqECUETbmpgwDnJO2WD2/IKQJJb+4dIxnSWe3uKQ4
         RkLk9GVU5cEL/SJKy1Xb7h7oqBUaaWFUtJsopzqwVTv0Fz0ojJNznnimE26PnHjPIQwd
         sy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+A+XURfQyB8AGFyMf1LEzeRDTsqVu/9+CULnouL4R1Y=;
        b=aK6Ve+cRDjzNzONMic7m/G927x1g9tIbv7NsYZQGihfV75qZbwxqF8V2achGCnRrG5
         YEDVltoDET29iAVzC7L+l24Dy3e8sybsUSq+NnPOAz/YAEScyVowZxOxViwO7cUdCP73
         o1jzYX5BWTmxvmMpWBoCLn043YZDO1buUL4VuyiEzO9EMacJgfQHEFwo+gQAgaJLPM4B
         +JRz0AmOuEpqQd5BoHnsqxKceY+qHN2Qt0lcNRGwdHCozFuvbRZAk6wtWUwZMX14PFCm
         7cQn5afLitzPH+zWhopzTrdAx6B6hM0984Zi3bcRa3Nkpybk2P3JNWQUJkSKDXqRIHYQ
         GL4A==
X-Gm-Message-State: APjAAAU3D4gKvR/8OBclAAVrl+QYJ4Zsd1G38XU6FmYCY0TG9KiACsov
        RjA3YlA8hToQxe4Gg6Wthiw=
X-Google-Smtp-Source: APXvYqxBcjbo+yP5AUv1Ap9d8SOzy//okd1bX0SnEzMbzUs56O39l3Czd6XGj3iXhVjga9zgt4d5ng==
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr21981970qtc.300.1562723719095;
        Tue, 09 Jul 2019 18:55:19 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id z4sm406271qtd.60.2019.07.09.18.55.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:55:18 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:55:14 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] drm/vkms: Add support for vkms work without vblank
Message-ID: <20190710015514.42anrmx3r2ijaomz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6esr2cieaotn52rj"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6esr2cieaotn52rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, vkms only work with enabled VBlank. This patch adds another
operation model that allows vkms to work without VBlank support. In this
scenario, vblank signaling is faked by calling drm_send_vblank_event()
in vkms_crtc_atomic_flush(); this approach works due to the
drm_vblank_get() =3D=3D 0 checking.

Changes since V2:
 - Rebase

Changes since V1:
  Daniel Vetter:
  - Change module parameter name from disablevblank to virtual_hw
  - Improve parameter description
  - Improve commit message

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 10 ++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c  | 13 +++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h  |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_c=
rtc.c
index 49a8ec2cb1c1..a0c75b8c4335 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -207,12 +207,22 @@ static int vkms_crtc_atomic_check(struct drm_crtc *cr=
tc,
 static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
+	struct vkms_output *vkms_out =3D drm_crtc_to_vkms_output(crtc);
+
+	if (vkms_out->disable_vblank)
+		return;
+
 	drm_crtc_vblank_on(crtc);
 }
=20
 static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_state)
 {
+	struct vkms_output *vkms_out =3D drm_crtc_to_vkms_output(crtc);
+
+	if (vkms_out->disable_vblank)
+		return;
+
 	drm_crtc_vblank_off(crtc);
 }
=20
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_dr=
v.c
index 152d7de24a76..542a002ef9d5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -34,6 +34,11 @@ bool enable_writeback;
 module_param_named(enable_writeback, enable_writeback, bool, 0444);
 MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
=20
+bool virtual_hw;
+module_param_named(virtual_hw, virtual_hw, bool, 0444);
+MODULE_PARM_DESC(virtual_hw,
+		 "Enable virtual hardware mode (disables vblanks and immediately complet=
es flips)");
+
 static const struct file_operations vkms_driver_fops =3D {
 	.owner		=3D THIS_MODULE,
 	.open		=3D drm_open,
@@ -154,9 +159,13 @@ static int __init vkms_init(void)
 	if (ret)
 		goto out_unregister;
=20
-	vkms_device->drm.irq_enabled =3D true;
+	vkms_device->output.disable_vblank =3D virtual_hw;
+	vkms_device->drm.irq_enabled =3D !virtual_hw;
+
+	if (virtual_hw)
+		DRM_INFO("Virtual hardware mode enabled");
=20
-	ret =3D drm_vblank_init(&vkms_device->drm, 1);
+	ret =3D (virtual_hw) ? 0 : drm_vblank_init(&vkms_device->drm, 1);
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
 		goto out_fini;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_dr=
v.h
index 9ff2cd4ebf81..256e5e65c947 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -21,6 +21,7 @@
=20
 extern bool enable_cursor;
 extern bool enable_writeback;
+extern bool virtual_hw;
=20
 struct vkms_composer {
 	struct drm_framebuffer fb;
@@ -69,6 +70,7 @@ struct vkms_output {
 	struct drm_connector connector;
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
+	bool disable_vblank;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 	/* ordered wq for composer_work */
--=20
2.21.0

--6esr2cieaotn52rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0lRYEACgkQWJzP/com
vP9MDxAAwhNkK7mcj0n8LEr9fUZV6JWhcpikrLWRFWdyhTSZlY3woV9UvgSWWDdc
SvIUmpA9PxRK3FEg1OZbQE2M+rLHbNh63MSPyZY9kRwgYhEYND6G+PpbRp9epWB5
80eUrJ10uF8+PR42yW7JSPZKTNdcH9RPHZOB3V5IU4M+gYZqcTzYRN1Bd7lGqb2M
z9T5vdK4GM24DGphcY7HCifIdcoIgT20WJnwCVHHPUR6nk55ysbLxLte4lB6IPRs
9YfCtPYOrsAOdmQwRZMUJbbA11OEb3cDkU3I67inFDf+PqpLeV47JUPpSqY1s2uP
BpGJLZlVON403+Xh9xV2kxx1SwRqUCbL/FAvpCUUJXRzQk2/a1FWg78sHRIsHCh/
uN7EnHvolADG5s1TY2P8DwCuYPv/HMyMUurWlwP5QW6owXiP7Fk4H1UjUonSboAz
jHb0olSV5xN66S7OyEFZymmJTf1Q7G0HppCHAZb1WTQYIeoPF2+D2KrwSpx3u4cz
kQR7Sg39HW+7L4aOc7/dg2dk8mz8v0BXfW9ayorxkYxDFVCTUznJwgO3B8mFCQC2
85HVluyT8gaGh+VpZzLXIz/AfNqbqPti7Pf/CzjImmCtpL+dN9Zty7J/wbC4zpFT
kbp2hdEclnDEWcmsbHRGW2EGLPMM9ftVjR+24+VQohAxqhpBjZg=
=SQQk
-----END PGP SIGNATURE-----

--6esr2cieaotn52rj--
