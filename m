Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF47C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF020665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOaYprUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393053AbfFMQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:55:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42466 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbfFMCLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:11:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so28754202edq.9;
        Wed, 12 Jun 2019 19:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0cVvTv62Az1HTrl8FUiIHyxSc2jG6hN8Hla75BR5w4M=;
        b=QOaYprUy58aYx9mi4m91RPw+yTHHislGhUo783bCLgkBVWrShDTV6jY+zsCkdfCoqG
         eoauFxtYTWaOLjk5v68w7R1+0tVLBVRIGyEym6CgAfE5xjo+ZYn4i6532sT3AU3kseBw
         HoQYm9G+7u8HQjuPgvFyM5uitbZ3Ql+z37/l5YxAHXcJo1mkDgw54jy5iF6igvpJbclj
         b/OevCFYu83pizJrTwDy0DUaW89ilAnz4TvTdtnsSKkSOLrUowI7PvNQ+KC8FZkaXJhq
         KnU1FkSDXQXkmzOvDqXzkDwWFJ2gkAjRToM8IR/QdReoloeJTV+XiCeMMvUxeMVn++Tu
         aMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0cVvTv62Az1HTrl8FUiIHyxSc2jG6hN8Hla75BR5w4M=;
        b=R/Sk00goVCDPkJ3GWz6UpQsjkf+fXmGuQ2byT8GqryT99xPM2FBsTqlVOwwqNeP5gB
         04jd5intdK8fPCo/hNCxDdBzsF/Pl2cTozAS1r6DCc9MBDmlFLQ2rsoRLLZrD67ZsLYQ
         NhiWxJ333Sw0nHjfoGUtvIDssw01jpZ9DaIbZvVtXeR0ptQ//4iU0qZOplSgg+6PWfDb
         1eB4JtpV+qhxo27jhHAE1bYRjsuh+YBL9oHIWneEbsvpPvaFiflafI2nf5wqXGEFJOxv
         mD7M4phd0Iq80xCJtz8cSN/cI4nLdo56HmcE2PLJe/G1gI+8RaGEW9kj/HpeeRteKCs/
         Bdew==
X-Gm-Message-State: APjAAAWuLiCc/lufqhqUwfp/0WvTboQ+ypT4l+vwhFlweaeK1OxgCzXP
        bkCf58PmWEIyyW7gpZJb480=
X-Google-Smtp-Source: APXvYqzLd3ifguWITMiOZcgmncv5B0deo4wOLKQDnv7+CdbJeThnYCTF1jdNVtCFDE3yxhQCAIzN6g==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr1902254ejb.42.1560391861842;
        Wed, 12 Jun 2019 19:11:01 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id d22sm267726ejm.83.2019.06.12.19.10.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 19:11:00 -0700 (PDT)
Date:   Wed, 12 Jun 2019 23:10:54 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [RESEND PATCH V3] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmacjpd643vk5d4c"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmacjpd643vk5d4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For historical reason, the function drm_wait_vblank_ioctl always return
-EINVAL if something gets wrong. This scenario limits the flexibility
for the userspace make detailed verification of the problem and take
some action. In particular, the validation of =E2=80=9Cif (!dev->irq_enable=
d)=E2=80=9D
in the drm_wait_vblank_ioctl is responsible for checking if the driver
support vblank or not. If the driver does not support VBlank, the
function drm_wait_vblank_ioctl returns EINVAL which does not represent
the real issue; this patch changes this behavior by return EOPNOTSUPP.
Additionally, some operations are unsupported by this function, and
returns EINVAL; this patch also changes the return value to EOPNOTSUPP
in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
libdrm, which is used by many compositors; because of this, it is
important to check if this change breaks any compositor. In this sense,
the following projects were examined:

* Drm-hwcomposer
* Kwin
* Sway
* Wlroots
* Wayland-core
* Weston
* Xorg (67 different drivers)

For each repository the verification happened in three steps:

* Update the main branch
* Look for any occurrence "drmWaitVBlank" with the command:
  git grep -n "drmWaitVBlank"
* Look in the git history of the project with the command:
  git log -SdrmWaitVBlank

Finally, none of the above projects validate the use of EINVAL which
make safe, at least for these projects, to change the return values.

Change since V2:
 Daniel Vetter and Chris Wilson
 - Replace ENOTTY by EOPNOTSUPP
 - Return EINVAL if the parameters are wrong

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Update:
  Now IGT has a way to validate if a driver has vblank support or not.
  See: https://gitlab.freedesktop.org/drm/igt-gpu-tools/commit/2d244aed6916=
5753f3adbbd6468db073dc1acf9A

 drivers/gpu/drm/drm_vblank.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 0d704bddb1a6..d76a783a7d4b 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1578,10 +1578,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, v=
oid *data,
 	unsigned int flags, pipe, high_pipe;
=20
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (vblwait->request.type &
 	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
--=20
2.21.0

--jmacjpd643vk5d4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0BsK0ACgkQWJzP/com
vP/4gA/7Biiupy7WhSPymKnZ+eYD/VkGhQ4xZ5o56UC7EC2582d/qLV3AGUW5R0C
syX2HCKmxfNdpOBOa/75VOVjl9w6NS+Le/gnuVL07H9uW7zUefwWCEXNR7l1o22Z
htFjEkqX8CYCzm9WMA+iUqgcpp0Em+/6FkTqLcTIBQqXsBFNOdnK1UNG8H1yI0jY
r/Zl2a1Me6B3JtS3vLmBSRLh7xez+fOiX2pXbT1t+WZUlC+TGcIqn14WVaAXgJuw
XKYzQxl+FJadL291ezbozPXNy29ljZ5PNOvxnhcG4SA9b55WGWM4Zh6GjeLcQqgY
LaogzlZpe/QfTyk23C0efRUoXEFLhvB92IDWoeGo+brZG3y6ynQkGY7Xra0q1tem
i0u9QGoFmfbAvlNXvJwZ7Q1ZOHqUGxKvfg0AZO3S0hwV0wb/lFAN2INT2uRMCapj
VBipChDqv/9q+BLvMfyIMmpeAguVgA21iVtHHS61GvtBkj3tZVUFqlKcicQVe9rL
nyemMYkrzoeozU+6gVShDJXDonB8Vf7tWB0tqKIsrtfqQsIQ0avY/IMl/Bo++gV3
9EstV2YuONvhuL6ad2V5tq+ErwrQC0jaya8GWeO0TFGfiEO8XqvWmlnSvaw3+nuw
UEtMVj3H7eM4zJpUPNm0NoQwUpy6meETdn9pqbmn0JzEeQzs1Xs=
=Oj71
-----END PGP SIGNATURE-----

--jmacjpd643vk5d4c--
