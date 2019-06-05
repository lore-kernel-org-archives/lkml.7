Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B2C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83312070D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGd6ZJMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFECpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:45:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40611 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFECpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:45:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so1871664qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BQfBVOtXcs0qzMIh6nmcxcUOcBUU3ej7Z8jgcon5kpQ=;
        b=DGd6ZJMuCw4wWZb+/hxWOpe9FC4seEzDtRiNche1kXONtQmbx5I/TVyogo3MR8MUWg
         HX6XrIaLRKq5qnBeAO1kziZycNh11yLibk5y5Z6zxNAz8FpGMDO4W8zjHpTOY48uxwh0
         2yKqYIbwCADSDGxIwSiX7e67IIgsaFx29/f9EbgczyWWZ1017hDufsviKY6l9RCB28BB
         yg10iQ1Zs85d6jclpSeI8s7DyqFvT0MEh22tb5XTElf2lZM+Z4VU2FdRWd5Q/dP15QjI
         6AN1fOJ8cyAqtPqmjBSFFa2+GQ1DFLGRfKssCxSb3x/3Sz8OmAip2ggLGaejoPGMjZ3G
         HksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BQfBVOtXcs0qzMIh6nmcxcUOcBUU3ej7Z8jgcon5kpQ=;
        b=dR6M5dLV4hZ2BWdszf/CcSAHXEqPQTnmRfEQ0SKsnqEoGR3/yDnfFWMM+ZuwFSYE5Z
         H7ZxT0SEYSTv91zNsrGjiIcIFz28uS8Jb8StfnEAL5YdxVnVkExgLpfcrcYbLTVEJdQw
         gvxNkjzr6zUbN3Z6TY+1b9X65HlzdIPqQuzo6wr775vz4+7WNMJ2VPPGeRmOaMfMP0UJ
         iLynGgEidsX/+xb129gwk5elUqrvedXN4zdJli9A57Hdvda0uYiSVzFUOlrjPuKJArYd
         hP21kA21QPawS9IqvR3vPhc7Hptgme5gUoOBJu++ijEQoWgNx8GNj0hfbhU+z++dnoDH
         gvWg==
X-Gm-Message-State: APjAAAXeNb4PQgttlgkbdQuQFnlVFubwisfYAayrOp3ZemaPV+LNr34B
        tXviXS+yUNhpMgJCRhD1JoqCia9JML4=
X-Google-Smtp-Source: APXvYqyUU6pz3RkTE8SZvZU5kZk+A62iNXn5Zu4YkGvXgB2qdg6ofbFKPeKy+4/S47uUiSpQ815bRQ==
X-Received: by 2002:aed:3804:: with SMTP id j4mr31335025qte.361.1559702748899;
        Tue, 04 Jun 2019 19:45:48 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id k40sm9325569qta.50.2019.06.04.19.45.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 19:45:48 -0700 (PDT)
Date:   Tue, 4 Jun 2019 23:45:43 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Simon Ser <simon.ser@intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        18oliveira.charles@gmail.com
Subject: [PATCH V2] drm/vkms: Avoid extra discount in the timestamp value
Message-ID: <20190605024543.pcsnkf74mmgfhtuh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjpgzm34khffs6b6"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fjpgzm34khffs6b6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After the commit def35e7c5926 ("drm/vkms: Bugfix extra vblank frame")
some of the crc tests started to fail in the vkms with the following
error:

 [drm:drm_crtc_add_crc_entry [drm]] *ERROR* Overflow of CRC buffer,
    userspace reads too slow.
 [drm] failed to queue vkms_crc_work_handle
 ...

The aforementioned commit fixed the extra vblank added by
`drm_crtc_arm_vblank_event()` which is invoked inside
`vkms_crtc_atomic_flush()` if the vblank event count was zero, otherwise
`drm_crtc_send_vblank_event()` is invoked. The fix was implemented in
`vkms_get_vblank_timestamp()` by subtracting one period from the current
timestamp, as the code snippet below illustrates:

 if (!in_vblank_irq)
  *vblank_time -=3D output->period_ns;

The above fix works well when `drm_crtc_arm_vblank_event()` is invoked.
However, it does not properly work when `drm_crtc_send_vblank_event()`
executes since it subtracts the correct timestamp, which it shouldn't.
In this case, the `drm_crtc_accurate_vblank_count()` function will
returns the wrong frame number, which generates the aforementioned
error. Such decrease in `get_vblank_timestamp()` produce a negative
number in the following calculation within `drm_update_vblank_count()`:

 u64 diff_ns =3D ktime_to_ns(ktime_sub(t_vblank, vblank->time));

After this operation, the DIV_ROUND_CLOSEST_ULL macro is invoked using
diff_ns with a negative number, which generates an undefined result;
therefore, the returned frame is a huge and incorrect number. Finally,
the code below is part of the `vkms_crc_work_handle()`, note that the
while loop depends on the returned value from
`drm_crtc_accurate_vblank_count()` which may cause the loop to take a
long time to finish in case of huge value.

 frame_end =3D drm_crtc_accurate_vblank_count(crtc);
 while (frame_start <=3D frame_end)
   drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);

This commit fixes this issue by checking if the vblank timestamp
corresponding to the current software vblank counter is equal to the
current vblank; if they are equal, it means that
`drm_crtc_send_vblank_event()` was invoked and vkms does not need to
discount the extra vblank, otherwise, `drm_crtc_arm_vblank_event()` was
executed and vkms have to discount the extra vblank. This fix made the
CRC tests work again whereas keep all tests from kms_flip working as
well.

V2: Update commit message

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_c=
rtc.c
index 7508815fac11..3ce60e66673e 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -74,9 +74,13 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, u=
nsigned int pipe,
 {
 	struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(dev);
 	struct vkms_output *output =3D &vkmsdev->output;
+	struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
=20
 	*vblank_time =3D output->vblank_hrtimer.node.expires;
=20
+	if (*vblank_time =3D=3D vblank->time)
+		return true;
+
 	if (!in_vblank_irq)
 		*vblank_time -=3D output->period_ns;
=20
--=20
2.21.0


--fjpgzm34khffs6b6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlz3LNcACgkQWJzP/com
vP/X4hAApcr5/bEnDAvsOsV2xeueMBVUxkCOy5jyP804U41fgrRvvSmSXL9r4Aha
6gaKPXNYjxTX/q6NiVLJ0eKd/ghuyjdWEygnVKzslqkdlZPMGLsXW+eh9CVEPpdS
3ntASLzK+X8SEK0ghEqwIBjibvigKl7m9/Me/5dcF9omezMDYUgdCuip2Bl12S7u
snxH/0kfZZ4FbpvkzNg19rK7Jy3gQaJhJ2NVokdY3tNsqwRlRC2o25oISFXZCC+T
/GDKvUs2MlV24b8l+IOECZrAyXa3627IoKGhirNXbNdPipU5/lel5c5uy0u38zVO
2yH7veHOs45SNrFKayY0M8CsEorBtg4BuYZdLToYZz6+MwuRODj758nVb3zTqPPS
EpUg1kya5bV9WujDz9oVodf7AwWa+/7G98VSwDCa5ffc6NLODLSwiRzCa380GdS+
UZGAt6nEMXXwBkYPgLsQuZ/2tZ3ASRdgRbZN7zDCWmGi/ataX1/psdFpDAfTtsVU
2lJY665DmPvtT1QPNyfZKV+A76RYfdxXYk6ANd65cWFPyQ+15oYYejo8cfBt3gO0
FayQJzWXgMXkeOkUJJLaeNsQIth1wamo4AYKNrM3cf9bCKG8lQaObkvufjpWbnAF
XUCj3wDLKxkc0zOpA0nsXI9N5ZagdqHadTFnFlW9IKkBJHEuKzk=
=5usR
-----END PGP SIGNATURE-----

--fjpgzm34khffs6b6--
