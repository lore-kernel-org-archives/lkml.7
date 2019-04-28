Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DBC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AFC2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBOJNNkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfD1TJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:09:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43073 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfD1TJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:09:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so4021729plp.10;
        Sun, 28 Apr 2019 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAMozjG2W0PZy93LSAs4zDJPg/GRcksOW95uh6hbVyE=;
        b=IBOJNNkZqClAiZtUfjDX4XJRF+tNusbapSFsD6ms7P2O2jpYpqR8ewRLr3gSRHEFF7
         ISzkhUIWbEdsM3arGsGeMJxrwxVV758cqf7qAzlrlJvG0rKPm7bMtfVta3r4jiOhNJle
         Y0QkkhMXMkbRObYOh4B8ZI2bfmp+hm4BYyHudJxaeB18SZOdFvVy/P8fFHrR+sEtjcow
         5ofCj+06yDaJMsw8J4cjvl5c8d54dmG+8b5UouFmccR7irfV/QCi9CX/V+fWPBF50TBd
         tJz3oEdyj3R8XPXEs301gtjNTBi4wB5pL3Zj5dZoR9aDztLZuiF8lnDED0FPrPZysDmP
         KfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAMozjG2W0PZy93LSAs4zDJPg/GRcksOW95uh6hbVyE=;
        b=sUnBr7lWbqEqkhuuNSQEJLeGedIkc3xQ/RR0kBPXKGut4346ueKBsmwIlda3NtRpQN
         UXFPPAJVnrefp9rnpOkxAVaWCLnqOw9OSRQjL53ne9GVTfj9CNK/fcrS6+3vdq2FJxEy
         jEM4Li0QNLfs1qjHhqR7KrQQSD4e6p3n7Msi/KA9jic0F0SxntPjBta3miH4ChUefj9w
         3seo36gvywqdwlw7bB98FrwO3s1U6DuykolB8Prgy2P2je+QEegjaJt+Zxgwi0RvYuxP
         kiQJ7KtFAo5CwFMWSBR0+uNUWc4NFnvdwMna6aR1vCWWo2eCdxWXAjaBXpPk/nD/ouF8
         0muA==
X-Gm-Message-State: APjAAAUACXAw1LriLFWGF/BgETVsIwfkhKOdSiqhTeUZaGAu+9NW7Ftj
        EFNCW/jWX1Hw9dGPy0kUrA3InjCa
X-Google-Smtp-Source: APXvYqwVNB3dgH3aK6NrEyDftcG/KmBl9vAQYkqyAHKeMNUZhfiJ3u3+ECSKmJlhPOZsxgKEEvx7Tg==
X-Received: by 2002:a17:902:8c85:: with SMTP id t5mr49046497plo.23.1556478571430;
        Sun, 28 Apr 2019 12:09:31 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id o14sm34204712pgn.4.2019.04.28.12.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 12:09:30 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/8] media: staging/imx: Move add_video_device into capture_device_register
Date:   Sun, 28 Apr 2019 12:09:11 -0700
Message-Id: <20190428190916.26567-4-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428190916.26567-1-slongerbeam@gmail.com>
References: <20190428190916.26567-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move imx_media_add_video_device() into imx_media_capture_device_register().
Also the former has no error conditions to convert to void.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   |  5 -----
 drivers/staging/media/imx/imx-media-capture.c |  3 +++
 drivers/staging/media/imx/imx-media-csi.c     |  7 +------
 drivers/staging/media/imx/imx-media-utils.c   |  9 ++++-----
 drivers/staging/media/imx/imx-media.h         |  4 ++--
 drivers/staging/media/imx/imx7-media-csi.c    | 12 +-----------
 6 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index ddcd87a17c71..8242d88dfb82 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1241,7 +1241,6 @@ static int prp_s_frame_interval(struct v4l2_subdev *sd,
 static int prp_registered(struct v4l2_subdev *sd)
 {
 	struct prp_priv *priv = sd_to_priv(sd);
-	struct imx_ic_priv *ic_priv = priv->ic_priv;
 	int i, ret;
 	u32 code;
 
@@ -1271,10 +1270,6 @@ static int prp_registered(struct v4l2_subdev *sd)
 	if (ret)
 		return ret;
 
-	ret = imx_media_add_video_device(ic_priv->md, priv->vdev);
-	if (ret)
-		goto unreg;
-
 	ret = prp_init_controls(priv);
 	if (ret)
 		goto unreg;
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 211ec4df2066..335084a6b0cd 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -780,6 +780,9 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
 
 	vfd->ctrl_handler = &priv->ctrl_hdlr;
 
+	/* add vdev to the video device list */
+	imx_media_add_video_device(priv->md, vdev);
+
 	return 0;
 unreg:
 	video_unregister_device(vfd);
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index ea3d13103c91..c70fa6b509ae 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1820,13 +1820,8 @@ static int csi_registered(struct v4l2_subdev *sd)
 	if (ret)
 		goto free_fim;
 
-	ret = imx_media_add_video_device(priv->md, priv->vdev);
-	if (ret)
-		goto unreg;
-
 	return 0;
-unreg:
-	imx_media_capture_device_unregister(priv->vdev);
+
 free_fim:
 	if (priv->fim)
 		imx_media_fim_free(priv->fim);
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index c52aa59acd05..8a6e57652402 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -767,18 +767,17 @@ imx_media_find_subdev_by_devname(struct imx_media_dev *imxmd,
 EXPORT_SYMBOL_GPL(imx_media_find_subdev_by_devname);
 
 /*
- * Adds a video device to the master video device list. This is called by
- * an async subdev that owns a video device when it is registered.
+ * Adds a video device to the master video device list. This is called
+ * when a video device is registered.
  */
-int imx_media_add_video_device(struct imx_media_dev *imxmd,
-			       struct imx_media_video_dev *vdev)
+void imx_media_add_video_device(struct imx_media_dev *imxmd,
+				struct imx_media_video_dev *vdev)
 {
 	mutex_lock(&imxmd->mutex);
 
 	list_add_tail(&vdev->list, &imxmd->vdev_list);
 
 	mutex_unlock(&imxmd->mutex);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(imx_media_add_video_device);
 
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index ba2d75bcc4c9..71e20f53ed7b 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -189,8 +189,8 @@ imx_media_find_subdev_by_fwnode(struct imx_media_dev *imxmd,
 struct v4l2_subdev *
 imx_media_find_subdev_by_devname(struct imx_media_dev *imxmd,
 				 const char *devname);
-int imx_media_add_video_device(struct imx_media_dev *imxmd,
-			       struct imx_media_video_dev *vdev);
+void imx_media_add_video_device(struct imx_media_dev *imxmd,
+				struct imx_media_video_dev *vdev);
 int imx_media_find_mipi_csi2_channel(struct imx_media_dev *imxmd,
 				     struct media_entity *start_entity);
 struct media_pad *
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 96d01d8af874..f2037aba6e0e 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1126,17 +1126,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	if (ret < 0)
 		return ret;
 
-	ret = imx_media_capture_device_register(csi->vdev);
-	if (ret < 0)
-		return ret;
-
-	ret = imx_media_add_video_device(csi->imxmd, csi->vdev);
-	if (ret < 0) {
-		imx_media_capture_device_unregister(csi->vdev);
-		return ret;
-	}
-
-	return 0;
+	return imx_media_capture_device_register(csi->vdev);
 }
 
 static void imx7_csi_unregistered(struct v4l2_subdev *sd)
-- 
2.17.1

