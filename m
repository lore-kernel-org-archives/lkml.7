Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6079208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMlbNLU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfDSVX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:23:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43327 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfDSVX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:23:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so4796562oig.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zyKRDcUH7uLbLXC7F5+i2ZLE7UEgE3LLZr7KeS/yAcc=;
        b=nMlbNLU8/dtKuZ4O8eAeKpGastYsWbCi4GG/9ih+epUAQAxmbubLKuLfU54olIA6aI
         vCYc3BpmqQtaT98EFLcvM1JGucRvjI/yHy8RE6CJJJQMq/G1Zd8MBVKnm67G1JmTcnZ2
         yfmz06ZMjBIltMI8SeP9y45Ts4CJfhuTyqgi2pDOq373ynueMlYezIZgYUbLMgT6K3XF
         /eNc6zhKIHT2NB6pZ1Z14aAe6bLGPCwI7twQfeAasNwY723dCmdtIEkgn48fcTFOqmP1
         PgtzMGcrYxYDcDHnZwyffTJC1uA/1g0a3AydpoTIlN4ByFkJ2Z8Fc4fAKHchH1CbxIYg
         +3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zyKRDcUH7uLbLXC7F5+i2ZLE7UEgE3LLZr7KeS/yAcc=;
        b=KecFP3ej1S7y5X53G69efQteXURRBnluRkEMKHA346RtVahw/fZxRYQr0dHHkCZTMk
         mTyDb+teMT0yvxSH6dau7Ud0d6ZMJYohtpwijPbfkdGnBCAj7+4juRhTqynm4EXZbThB
         PGRVvY1/eujoABQT0hS/rqUhoM73lVOmvyObasFOxQN51an1U5HZxXXyB3sQvIzeREqP
         SQ9Gs2H820CqZ5AH4Ef1B0aPg5ZZdjLDPFAfk0AKuZXABTvwA859KIyEvo56GIwHCHS9
         t6qzOZoMaIvRJdvV4RvZqr96P0pgR9FX43WruqM5rCE3hi3698N7+OsmpGjD48a7ETVK
         4opw==
X-Gm-Message-State: APjAAAW0zSdH0tAu+7U102NAlW1cX5OJ+XI6SgczNVdPq8jM1Ybmf3Ry
        hOh4lDDht4cw4T2SarSMDtSvfXTNFJxAhA==
X-Google-Smtp-Source: APXvYqwgcY7gSzTyTx0Q7SsHiu3LZ/nSkASn25fog7A3QF2y1uPfHp482cFUCosx5ihb9Dc8UjJS8w==
X-Received: by 2002:aca:5d8b:: with SMTP id r133mr3196348oib.72.1555709005370;
        Fri, 19 Apr 2019 14:23:25 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id n3sm2459066oia.46.2019.04.19.14.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:23:24 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Date:   Fri, 19 Apr 2019 16:23:21 -0500
Message-Id: <20190419212321.7325-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable and replace return type.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index e39ab5fae724..f87fa7f61db3 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -607,18 +607,13 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
 			    struct v4l2_ctrl *ctrl,
 			    const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
-	int ret;
 	struct vchiq_mmal_port *encoder_out;
 
 	dev->capture.encode_bitrate = ctrl->val;
 
 	encoder_out = &dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->output[0];
 
-	ret = vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
-					    mmal_ctrl->mmal_id,
-					    &ctrl->val, sizeof(ctrl->val));
-	ret = 0;
-	return ret;
+	return 0;
 }
 
 static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
-- 
2.17.1

