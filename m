Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE19C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480412067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5oMBl65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfD1TJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:09:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45171 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfD1TJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:09:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so652631pgi.12;
        Sun, 28 Apr 2019 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tMVTYKS5f19+Vm4lAbyz0i8RYRYsyQ7fmIGeWfhtUU=;
        b=X5oMBl65Gh0JL6mVOb8ik7GtY5LrDrWQHf+bIwJRwgbkrzfDWJw56XeTCRWH6424S4
         jt1OFojoMsOR3n92M6zoAv+Dp8I0A3cVGFSumw5Nmt8ZX9YvvU44YDeTkbHmQXzn2KYE
         iXwkaI9Jm6EhyRppPC2Hyu7eWCZLmcEspbwuzS61t5odxwiUvl10BGXViH08GOvVgHBr
         nr+lZJlO+r4186skd8zNIeriWB6oiKSAi/3RZxRqsQjiaPebqGG/Wv5JKPzRa4sDMomA
         P0j6NacLuglKJ5Jywgp0IQlMNLMx7sJrDDDIxP9KINF1sK9ChlnEb32iB4EUh34kVhYP
         Skwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tMVTYKS5f19+Vm4lAbyz0i8RYRYsyQ7fmIGeWfhtUU=;
        b=EEimnj21e3MTXN7WytraQJ+KsWSduETcuCKFD4H1QMhu6gyL5H0eCw/dzSdIZ5/Xny
         hgDn7Zfg1vkhceRToPTPpyrwilE1QuxMr1A+qpWTwc41qcf5ARkgmRYKTdz5pWdoAOZt
         OXAp8BHqkDLZvDML2cgMY7jPu3AZGM1LUFt0iae+A0c3iWGggnrorAVVNzyc018aC8uo
         v7fBwbqZRcsqez6LGTdjYLkunkRrcFLuOR6Sel3wiqBMZdUy51+G5nUXREF6I4+3XeGC
         zlTwe0Q5vj/UeVvCxGt9WB9hT1xUQDExHQ+wZ17vz/q8sc1v4WJiL+bwU8S8hpgdUPkK
         cPGA==
X-Gm-Message-State: APjAAAWtPYNvPvvQKZEEwRCPQEpdXH1JneaB71DC9+BD8DJ0iZsQ/ZBI
        p29snO52B3H6xOPd3+MIqdV5iz+x
X-Google-Smtp-Source: APXvYqxXRm+wORjX9rU22ovralGAytuPMNEfQGkK6GdKzvLac+9nvxiP4EXkz54MwUTY+V3Lg3z1Mg==
X-Received: by 2002:aa7:8383:: with SMTP id u3mr15971576pfm.245.1556478580546;
        Sun, 28 Apr 2019 12:09:40 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id o14sm34204712pgn.4.2019.04.28.12.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 12:09:39 -0700 (PDT)
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
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 8/8] media: staging/imx: Don't set driver data for v4l2_dev
Date:   Sun, 28 Apr 2019 12:09:16 -0700
Message-Id: <20190428190916.26567-9-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428190916.26567-1-slongerbeam@gmail.com>
References: <20190428190916.26567-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The media device is already available via multiple methods, there is no
need to set driver data for v4l2_dev to the media device.

In imx_media_link_notify(), get media device from link->graph_obj.mdev.

In imx_media_capture_device_register(), get media device from
v4l2_dev->mdev.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-capture.c    | 5 +++--
 drivers/staging/media/imx/imx-media-dev-common.c | 7 ++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index b77a67bda47c..565d21f169d8 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -732,15 +732,16 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
 {
 	struct capture_priv *priv = to_capture_priv(vdev);
 	struct v4l2_subdev *sd = priv->src_sd;
+	struct v4l2_device *v4l2_dev = sd->v4l2_dev;
 	struct video_device *vfd = vdev->vfd;
 	struct vb2_queue *vq = &priv->q;
 	struct v4l2_subdev_format fmt_src;
 	int ret;
 
 	/* get media device */
-	priv->md = dev_get_drvdata(sd->v4l2_dev->dev);
+	priv->md = container_of(v4l2_dev->mdev, struct imx_media_dev, md);
 
-	vfd->v4l2_dev = sd->v4l2_dev;
+	vfd->v4l2_dev = v4l2_dev;
 
 	ret = video_register_device(vfd, VFL_TYPE_GRABBER, -1);
 	if (ret) {
diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
index 89dc4ec8dadb..66b505f7e8df 100644
--- a/drivers/staging/media/imx/imx-media-dev-common.c
+++ b/drivers/staging/media/imx/imx-media-dev-common.c
@@ -260,10 +260,11 @@ static int imx_media_inherit_controls(struct imx_media_dev *imxmd,
 static int imx_media_link_notify(struct media_link *link, u32 flags,
 				 unsigned int notification)
 {
+	struct imx_media_dev *imxmd = container_of(link->graph_obj.mdev,
+						   struct imx_media_dev, md);
 	struct media_entity *source = link->source->entity;
 	struct imx_media_pad_vdev *pad_vdev;
 	struct list_head *pad_vdev_list;
-	struct imx_media_dev *imxmd;
 	struct video_device *vfd;
 	struct v4l2_subdev *sd;
 	int pad_idx, ret;
@@ -279,8 +280,6 @@ static int imx_media_link_notify(struct media_link *link, u32 flags,
 	sd = media_entity_to_v4l2_subdev(source);
 	pad_idx = link->source->index;
 
-	imxmd = dev_get_drvdata(sd->v4l2_dev->dev);
-
 	pad_vdev_list = to_pad_vdev_list(sd, pad_idx);
 	if (!pad_vdev_list) {
 		/* nothing to do if source sd has no pad vdev list */
@@ -384,8 +383,6 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev,
 		goto cleanup;
 	}
 
-	dev_set_drvdata(imxmd->v4l2_dev.dev, imxmd);
-
 	INIT_LIST_HEAD(&imxmd->vdev_list);
 
 	v4l2_async_notifier_init(&imxmd->notifier);
-- 
2.17.1

