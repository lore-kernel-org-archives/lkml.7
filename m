Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA032C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77CE20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tACyKVez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEAFyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:54:15 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:32921 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAFyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:54:15 -0400
Received: by mail-pf1-f171.google.com with SMTP id z28so2886065pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lGmhHTbrp62WjPCsadPfyC1/U+nVR+naFYtOSFn8Cmg=;
        b=tACyKVezHNTMlt1e1Q+CUmGgy0ZYjIaUL5MNsq7A69XdyYaigxSpiHPBYCt9WycK9i
         /tVwMrG0QX9+ieuRWi4UAK6qnAGs4XiOVkSMk73fj2kDKtP4WYeOOvzLlI90tGWJbGEj
         xCLKIAYWY/yPAuH01HaWsH6tp4mOsJ6vkYGmrV5pvRBa4EizH76aEssvW1Q1mZb7uXVx
         x15WlLbkg2sVZCfj23vBh08RFuRAlwyX/g02QCdVHjGuG9HGXcxq3NOki5+RreReVtaV
         P6UDP4WrYRvGl87qRSmwYEBi/XUpX2iK2OrTpDmk0BOw4bZQDWWtC0TBTAOivLL5PJKP
         n48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lGmhHTbrp62WjPCsadPfyC1/U+nVR+naFYtOSFn8Cmg=;
        b=HOAvh7xwVjo7PP/M4sbLyGrfoiQ4dgwiDfygKw8jj+Q+3IZ+tqH+1QmNcquzRJ/7a5
         cnWvIN4U4cvEIIn7qlZj9H+PPTS0HyyDkXZgt5wpA2K6PWfv4GTh2K80G29DvWZhe95K
         dm9Xysah819zQNwGB8MYt/F7PoqXa+fh8lKDnmQ0W/k7d1Mh7hlB21Kxfo1K/55M2IUJ
         zbwxMQLgdW5FEbNp+CwDzOkGuQc0iuxzSqCEi9iH3gPkttEdwbeNEn97u5pkWOtLe86x
         jUxOWh26dmP7O2+DAYENxdbjSna68vBKpIa2PUGKGc3kSx2m9AfOVHeTYBIUV1QBIkVv
         bQFw==
X-Gm-Message-State: APjAAAUCSMKtM99v6aETdgSIZkHa/Ntiikge68C3UVA4K6HeIIEzWY1T
        kLE2dKZ/awyC2YmWx1/jfoc=
X-Google-Smtp-Source: APXvYqzVYhq/yVFaxE/scWgarPNMtyOGpYnl2Qtq6YhPzhFF/vh4UFOFc+MidadXbez8i4moztfRNw==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr76311287pfa.198.1556690053661;
        Tue, 30 Apr 2019 22:54:13 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.94])
        by smtp.gmail.com with ESMTPSA id e184sm62816141pfc.102.2019.04.30.22.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 22:54:13 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2] staging: vc04_services: bcm2835-camera: Compress two lines into one line
Date:   Wed,  1 May 2019 11:23:53 +0530
Message-Id: <20190501055353.1935-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value directly without saving it in a variable and remove that
variable.

Issue suggested by Coccinelle.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
Changes in v2:
-Change subject line and log message
-Remove respective unused variable

 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index c9b6346111a5..68f08dc18da9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1491,7 +1491,6 @@ static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 				 struct vchiq_mmal_component *camera,
 				 struct bm2835_mmal_dev *dev)
 {
-	int ret;
 	struct mmal_parameter_camera_config cam_config = {
 		.max_stills_w = dev->max_width,
 		.max_stills_h = dev->max_height,
@@ -1507,10 +1506,9 @@ static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 		.use_stc_timestamp = MMAL_PARAM_TIMESTAMP_MODE_RAW_STC
 	};
 
-	ret = vchiq_mmal_port_parameter_set(instance, &camera->control,
+	return vchiq_mmal_port_parameter_set(instance, &camera->control,
 					    MMAL_PARAMETER_CAMERA_CONFIG,
 					    &cam_config, sizeof(cam_config));
-	return ret;
 }
 
 #define MAX_SUPPORTED_ENCODINGS 20
-- 
2.17.1

