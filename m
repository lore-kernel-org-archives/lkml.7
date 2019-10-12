Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44032190F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waq0KdUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfJLPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 11:18:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55456 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 11:18:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so13027591wma.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00wbDsxYMw5kLcHoK10nqGz2XPnCpxBhd7bVGwk+FAw=;
        b=Waq0KdUP+gUillAGvOrqIDV7D5eG2F9ALA4QqXAzfIOgYzTT56gi3H2MpNWLS/L+SM
         oOuw+//6TfcIPR8s3qgncPPOF+LCmyAP8DjyoVmVFrqocGMgZhcCBhnTAqtYxy465J3M
         7AFMTO8KgBXIjw4NxeolNqSmoUamAFYABqIfno1lzjodIxUvpMz2Dnu4wgonaBEWeoEF
         zd116TwtaRxUIkE6ens1iMVMs0m9HfGR9qy7EC9mBihL5cO9040fojglCebTZ5AnElyx
         QeYHcf+EZUiFEcSJsN+EYAOOfvL/rBXKD/0JsM1BgAdNMuksdQSKn8eja89736elYizz
         24FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00wbDsxYMw5kLcHoK10nqGz2XPnCpxBhd7bVGwk+FAw=;
        b=Qocnd2WBAd8Drqn5G87OeWP56MCjkzZ17hsQfqao7vNi1fsTAsRWBPSG0zB0b0MCak
         Oz6ad42IXo25aD+t3Zrc8msWcE+KIWLLr/3xFdPJgzE6x/lF7qTLMjFhpM2bySeWJFE1
         rX59bjt/Ksp76BVpksCgfdakNsMzegHdLHy7D36ufBG4Id2uHgsdOasCqJ8uEW0hs98D
         BR+P1oFa9PJGLLLudLbaCZphXItS9yJsAt4KIrLGUyiwLw+inMfD0V471wI427Vgwex4
         XLvXdid+OGsfMwo1u602fDbwzRcx2dtTxGfzf7g8ZW1VY5vlqsdFJGLL3lqT4v/mnIR5
         cVnw==
X-Gm-Message-State: APjAAAWx3MS76bZtn7Y4+y1jgaW0pgOQrPOZY9gel90eLJdKEb+IA3iG
        IsnGlXaESWyvsx1vsBzrSg==
X-Google-Smtp-Source: APXvYqxdj2hI3aRsv91CVNxyxSaFgMHBIQAShwl9NmW/jf+ZJ/6OMqamZpcspf8MkIU6rGhvDZebHA==
X-Received: by 2002:a05:600c:2185:: with SMTP id e5mr7887447wme.78.1570893509733;
        Sat, 12 Oct 2019 08:18:29 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id r6sm13905017wmh.38.2019.10.12.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 08:18:29 -0700 (PDT)
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
Subject: [PATCH v2] staging: vc04_services: place the AND operator at the end of the previous line
Date:   Sat, 12 Oct 2019 16:18:05 +0100
Message-Id: <20191012151805.17988-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the AND logical operator at the end of the previous line;
to fix warning of "Logical continuations should be on the previous line".
 Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d4d1e44b16b2..beb6a0063bb8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1090,8 +1090,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 
 	ret = vchiq_mmal_port_set_format(dev->instance, camera_port);
 
-	if (!ret
-	    && camera_port ==
+	if (!ret &&
+	    camera_port ==
 	    &dev->component[COMP_CAMERA]->output[CAM_PORT_VIDEO]) {
 		bool overlay_enabled =
 		    !!dev->component[COMP_PREVIEW]->enabled;
-- 
2.21.0

