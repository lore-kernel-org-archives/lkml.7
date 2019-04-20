Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F5DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B920821
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOYRxci5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfDTQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:56:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45990 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfDTQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:56:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so6510810otk.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oThT7uOJYj+D0UqYv7lT6L2LxoANKCg7LyACp/+if0s=;
        b=SOYRxci5ZsYcqpFBMNbq2HW5IhcQbkHUznBK1kzDFmcTe0OU3HhmeZMmKt70xetYzy
         WdEjsXaYT7IPmKv7d1lOr/zvuHoDJlWPHQKJCq+icDpdQQiECaa85RVNJ92B35rdI6PL
         QMrjMdzbjLw4HQ01o4KsQL1EhvgICRQbRtcOoH7OrkBohP8DzsxBwRfpbH9XySq+praO
         X3BR3o6AY9tbvXCBgeemlT5W90IJ2Ac3DQWf4YdIAnv8hxlQ17/aUDr2PJFa4+Q3Vvcw
         iNaQ/eR/CoIQeXwEKcARZUtu0OADNhrnFznA+8PybhiceTZRoFE/O/FIIu0zKCBP/FcQ
         BwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oThT7uOJYj+D0UqYv7lT6L2LxoANKCg7LyACp/+if0s=;
        b=sG83ytU+obXXyxgS2ExMPY4HuEXbuNueg0o1N6mWUJrR6fVg8qhkz2n10Ri05HJwRr
         u6+P0HpRiX6/rKYUfsNGrv7IslTORcTTH4iaN6RuQQczr1SXN8uinPyTLsNFs5uV7tN6
         PtVI+aPD/SLSk+0qqRq+tEls1lFsrOaHEBl1IHYVUjqcCPN1ArjGOJfUPu5zZ23obkss
         TXSpH8xllZxELTu2OQoXYPB8E22c70E032N8XhRtSgxuwstN8yvOsxBhDMf82gWnUlaU
         /cSoSRsT4oMOROUZUy1hmm+fDCjAxGgoT0vxDN07bLvMhDpSkKHLjdNGAWyQ+LmYi3px
         FDCg==
X-Gm-Message-State: APjAAAXbNOEjHPGtCaR3y1cRXYtz4XZwkoY5ZLsuiLKnCFJqYe4gDs0F
        R8osXFVekhKVK0sBE6JQWaU=
X-Google-Smtp-Source: APXvYqwES6UIDA1i/g29atJ5cFlrjw91I0PtImp8n0cy6UxeoVV2mctnJnsBLUaB+5w2vq9ct1b1Vg==
X-Received: by 2002:a9d:4799:: with SMTP id b25mr5861103otf.264.1555779411562;
        Sat, 20 Apr 2019 09:56:51 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id o1sm3740746otj.11.2019.04.20.09.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 09:56:50 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v2] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Date:   Sat, 20 Apr 2019 11:56:44 -0500
Message-Id: <20190420165644.11892-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable and replace return type.
In addition to that align the function parameters with parentheses to
maintain Linux coding style.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v2

1) Fix my own error of removing function call from the variable.
2) Align the function parameters with parentheses.

---
---
 .../staging/vc04_services/bcm2835-camera/controls.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index e39ab5fae724..71eb349c3138 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -607,18 +607,16 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
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
+	vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
+				      mmal_ctrl->mmal_id, &ctrl->val,
+				      sizeof(ctrl->val));
+	return 0;
 }
 
 static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
-- 
2.17.1

