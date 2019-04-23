Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3AEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397C221738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7sO7mNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfDWOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:47:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41278 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:47:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so13025723otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sLF03lZ2Iim5bhmL1FcWVbfZrAVD/hxQUV2C8iXSzWI=;
        b=f7sO7mNBeM9Vf2897QPLnrQ6KcBehihxfMddfEy+A6VSKyzB90ZyUuX0LfOav8ss4f
         W2YjeLSoScZ3KH8TW/9ahhl969I7R7cCLJxRK2O5MOp8/zPpEjrC38nfBepErXtPWg52
         d8j4jEnzlmLUuvh+plf1lWkqJ9I9rvEAcr6pmpQiyJkX96QwvxDX60bGxTQNROL7TTmC
         izKt6hgftO6qfEQkQ3BrZj/U7ptZp1TBum3tbLBs+QDcJkpTLxoFTEvTjNSz6OSdcUVG
         nX35hpYXbbZKgYZwfeVWPOF/aNny29kSqkl+obfw5QcqpYcMwyfypIEmcIM1NAcQ3wfE
         vOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sLF03lZ2Iim5bhmL1FcWVbfZrAVD/hxQUV2C8iXSzWI=;
        b=WzbYHEc2NB5RtvzKYld6T8jUFEfdrPSPx8cyqqI8vqY3ApDO+zIhWIiDdnYENXZRg/
         Pboxf5f+cdyKr9zZQMGSYTDKOQf41xYZyqv89uWvZeoqjoPqtd06DzePOoIe6jOkOeLf
         fE8ICN2EfUAjRuaIE1BhHlyzaU1if0w1TiDUaIwnwPv/zG8SrgSPCX5tdnR/KxJ95VCU
         KvWF8qMuLXZteJWxgsgcO5PnFCJ3IBf+1qh6WnDq0m5wuklGC9VqLs30jxZuELHkbWmY
         5g4OpDIB0x8V22e8snbQiN/NTsneI+TwavFC1wZOoI4dzvWgy3L5GfgPdk49rRzmU+IH
         3yWw==
X-Gm-Message-State: APjAAAUHOY90Kp4CjSREiC4wSLYssWbVbsM0zgwT6FN3XdYQWFxbKkop
        ZvuzNojiWb8gtLY1jHg6r2I=
X-Google-Smtp-Source: APXvYqyKljS8C05etJviUuRnGeI+FdyHNvcH+4cXg9tVrEaYChoiwMlTueSnbVrOe0mx37xYl8Zxsw==
X-Received: by 2002:a05:6830:51:: with SMTP id d17mr15907007otp.178.1556030869423;
        Tue, 23 Apr 2019 07:47:49 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:fd8f:ea25:f4b2:9189])
        by smtp.gmail.com with ESMTPSA id w10sm6965565oiw.48.2019.04.23.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 07:47:47 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v3] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Date:   Tue, 23 Apr 2019 09:47:45 -0500
Message-Id: <20190423144745.21474-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable from the function and make a corresponding
change w.r.t the variable. In addition to that align the parameters in
the parentheses to maintain Linux kernel coding style

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v2 -
1) Fix my own error of removing function call from the variable.
2) Align the function parameters with parentheses.

Changes in v3 -
1) Since there was no real purpose of returning true value, replace it with
return value of the function vchiq_mmal_port_parameter_set().
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index e39ab5fae724..2e0a422cdf3e 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -607,18 +607,15 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
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
+	return vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
+					     mmal_ctrl->mmal_id, &ctrl->val,
+					     sizeof(ctrl->val));
 }
 
 static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
-- 
2.17.1

