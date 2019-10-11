Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B4B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohL+8VJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfJKV2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:28:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:28:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so3904856wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfKWmljBhhbz3pJBgekKZhzWDuOhbB2Ddk+2ciq5ka8=;
        b=ohL+8VJP0l1i/xy0IfSmPtrL86ip7fjeuW1/iu+Sq+coC15EESOFdIzzuM2SkrzcDp
         fWkdD/TWp29+ZqHi+8G/Hjx96kwjYoTWtIElaX1yqFaUQ+JKGvg4ABxezy94lJmB3Puk
         Rb+GgD4njHOCran2sa2lSWA2kW/vsf2H4/MazSua3/X7YQ3/1fjtmNLGm3+7JPjXU5ZO
         QT9qt6tFlpEXYYXhGQUhDhsx1Bg86f3vF3Oe15bCyn6QFVC7OQc/EkiIUdZBWADPinC1
         u4Zdg0h9GKwNGgVYSFooVhOPaJ+TOihFOA6BB4LBgOk7u4/Owc2aa0VOhy8povBPYnVV
         NbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfKWmljBhhbz3pJBgekKZhzWDuOhbB2Ddk+2ciq5ka8=;
        b=Bh8Fuk4PRTH1KPiLZ1VIfueId/si5UlHywYqbsll5vnmeill2JOKndBwAnzQyRDx2I
         QPOv5sK4B6GtLS2/q1x2Nw2jcOGQWqOzXJlILMq/KiQvh37Fg8JESpHHgbXR/vl4cLlm
         Q/efvRdNbQCxWvP45UDVC5/54OT3yWbF67wUC6NjL2Kj15wmonjvwkc4BcQz/Z6RxrHk
         RsDVQNhQgtOBZl5Kb7mu1sAicllZcbZTAFYpZpL58iv4ENNn5sGM1NNs/RQN0EK5bYDe
         ksTyZjRn6eJbuX4GiHNxurUFIReH3MFvDBylZ77aVIINirS8JOpj7yDjmQ+KYtFd7gd9
         XNTA==
X-Gm-Message-State: APjAAAUYBDzRqC2qirBO3MwnnCrwd6PTQCif6OBdB9CcOkewvhmRakVr
        tRThXtgzhgUq0uex4BkXNA==
X-Google-Smtp-Source: APXvYqwmF1lNodIYp/c2WCNVIrwj7JDssewLAiUGEg6UdvMuE+ulWfi4WV5klajsEZVsvTcfVRTJZQ==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr15196152wrw.115.1570829278309;
        Fri, 11 Oct 2019 14:27:58 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id a13sm22797955wrf.73.2019.10.11.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 14:27:57 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, eric@anholt.net, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, daniela.mormocea@gmail.com,
        dave.stevenson@raspberrypi.org, hverkuil-cisco@xs4all.nl,
        mchehab+samsung@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: vc04_services: fix warning of Logical continuations should be on the previous line
Date:   Fri, 11 Oct 2019 22:27:45 +0100
Message-Id: <20191011212745.20262-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning of logical continuations should be on the previous line.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 41 ++++++++-----------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d4d1e44b16b2..365bcd97e19d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -337,9 +337,8 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 			if (is_capturing(dev)) {
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 					 "Grab another frame");
-				vchiq_mmal_port_parameter_set(
-					instance,
-					dev->capture.camera_port,
+			vchiq_mmal_port_parameter_set(instance,
+						      dev->capture.camera_port,
 					MMAL_PARAMETER_CAPTURE,
 					&dev->capture.frame_count,
 					sizeof(dev->capture.frame_count));
@@ -392,9 +391,8 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 	    is_capturing(dev)) {
 		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 			 "Grab another frame as buffer has EOS");
-		vchiq_mmal_port_parameter_set(
-			instance,
-			dev->capture.camera_port,
+		vchiq_mmal_port_parameter_set(instance,
+					      dev->capture.camera_port,
 			MMAL_PARAMETER_CAPTURE,
 			&dev->capture.frame_count,
 			sizeof(dev->capture.frame_count));
@@ -1090,8 +1088,7 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 
 	ret = vchiq_mmal_port_set_format(dev->instance, camera_port);
 
-	if (!ret
-	    && camera_port ==
+	if (!ret && camera_port ==
 	    &dev->component[COMP_CAMERA]->output[CAM_PORT_VIDEO]) {
 		bool overlay_enabled =
 		    !!dev->component[COMP_PREVIEW]->enabled;
@@ -1124,9 +1121,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 					  dev->capture.timeperframe.numerator;
 		ret = vchiq_mmal_port_set_format(dev->instance, preview_port);
 		if (overlay_enabled) {
-			ret = vchiq_mmal_port_connect_tunnel(
-				dev->instance,
-				preview_port,
+			ret = vchiq_mmal_port_connect_tunnel(dev->instance,
+							     preview_port,
 				&dev->component[COMP_PREVIEW]->input[0]);
 			if (!ret)
 				ret = vchiq_mmal_port_enable(dev->instance,
@@ -1154,9 +1150,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 			    camera_port->recommended_buffer.num;
 
 			ret =
-			    vchiq_mmal_port_connect_tunnel(
-					dev->instance,
-					camera_port,
+			    vchiq_mmal_port_connect_tunnel(dev->instance,
+							   camera_port,
 					&encode_component->input[0]);
 			if (ret) {
 				v4l2_dbg(1, bcm2835_v4l2_debug,
@@ -1655,8 +1650,8 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 	dev->capture.enc_level = V4L2_MPEG_VIDEO_H264_LEVEL_4_0;
 
 	/* get the preview component ready */
-	ret = vchiq_mmal_component_init(
-			dev->instance, "ril.video_render",
+	ret = vchiq_mmal_component_init(dev->instance,
+					"ril.video_render",
 			&dev->component[COMP_PREVIEW]);
 	if (ret < 0)
 		goto unreg_camera;
@@ -1669,8 +1664,8 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 	}
 
 	/* get the image encoder component ready */
-	ret = vchiq_mmal_component_init(
-		dev->instance, "ril.image_encode",
+	ret = vchiq_mmal_component_init(dev->instance,
+					"ril.image_encode",
 		&dev->component[COMP_IMAGE_ENCODE]);
 	if (ret < 0)
 		goto unreg_preview;
@@ -1731,15 +1726,13 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 
 unreg_vid_encoder:
 	pr_err("Cleanup: Destroy video encoder\n");
-	vchiq_mmal_component_finalise(
-		dev->instance,
-		dev->component[COMP_VIDEO_ENCODE]);
+	vchiq_mmal_component_finalise(dev->instance,
+				      dev->component[COMP_VIDEO_ENCODE]);
 
 unreg_image_encoder:
 	pr_err("Cleanup: Destroy image encoder\n");
-	vchiq_mmal_component_finalise(
-		dev->instance,
-		dev->component[COMP_IMAGE_ENCODE]);
+	vchiq_mmal_component_finalise(dev->instance,
+				      dev->component[COMP_IMAGE_ENCODE]);
 
 unreg_preview:
 	pr_err("Cleanup: Destroy video render\n");
-- 
2.21.0

