Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49C20896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDGSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:47:43 -0400
Received: from mailoutvs10.siol.net ([185.57.226.201]:56528 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbfDGSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 14:47:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3EDB3521E22;
        Sun,  7 Apr 2019 20:47:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DdDHnUZcL_UU; Sun,  7 Apr 2019 20:47:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D39355214D3;
        Sun,  7 Apr 2019 20:47:38 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E18B8521E22;
        Sun,  7 Apr 2019 20:47:36 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] media: cedrus: Fix initialization order
Date:   Sun,  7 Apr 2019 20:47:28 +0200
Message-Id: <20190407184728.16620-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, MEDIA_IOC_G_TOPOLOGY ioctl on cedrus fails due to incorrect
initialization order. Fix that by moving video_register_device() before
v4l2_m2m_register_media_controller() and while at it, fix error path.

Reported-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
index b98add3cdedd..d0429c0e6b6b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -300,7 +300,7 @@ static int cedrus_probe(struct platform_device *pdev)
 			 "Failed to initialize V4L2 M2M device\n");
 		ret =3D PTR_ERR(dev->m2m_dev);
=20
-		goto err_video;
+		goto err_v4l2;
 	}
=20
 	dev->mdev.dev =3D &pdev->dev;
@@ -310,23 +310,23 @@ static int cedrus_probe(struct platform_device *pde=
v)
 	dev->mdev.ops =3D &cedrus_m2m_media_ops;
 	dev->v4l2_dev.mdev =3D &dev->mdev;
=20
-	ret =3D v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
-						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
-	if (ret) {
-		v4l2_err(&dev->v4l2_dev,
-			 "Failed to initialize V4L2 M2M media controller\n");
-		goto err_m2m;
-	}
-
 	ret =3D video_register_device(vfd, VFL_TYPE_GRABBER, 0);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
-		goto err_v4l2;
+		goto err_m2m;
 	}
=20
 	v4l2_info(&dev->v4l2_dev,
 		  "Device registered as /dev/video%d\n", vfd->num);
=20
+	ret =3D v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
+						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
+	if (ret) {
+		v4l2_err(&dev->v4l2_dev,
+			 "Failed to initialize V4L2 M2M media controller\n");
+		goto err_video;
+	}
+
 	ret =3D media_device_register(&dev->mdev);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register media device\n");
@@ -339,10 +339,10 @@ static int cedrus_probe(struct platform_device *pde=
v)
=20
 err_m2m_mc:
 	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
-err_m2m:
-	v4l2_m2m_release(dev->m2m_dev);
 err_video:
 	video_unregister_device(&dev->vfd);
+err_m2m:
+	v4l2_m2m_release(dev->m2m_dev);
 err_v4l2:
 	v4l2_device_unregister(&dev->v4l2_dev);
=20
--=20
2.21.0

