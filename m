Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A665206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne5FvEOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfD0QIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:08:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0QIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:08:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so3051858pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jrtjq2Yr4HF77ya+Bh8Y543ibzBroImWXM+PFp8HcNA=;
        b=Ne5FvEOmBkxwTy2jX6gYCth3dn2KTnAtafRBz7JPu1Kw9BVIwGeEJCLpiKWoamMBcz
         urGD/8j0mz74mFKO3VtZEjzRVBwwIB6gYUb9VCqbSEK248CVHbMH2l/NKiMioer2a/vg
         MdQgJt2CFHiRTA5JIJUG1VXpICsh+w6igmDLbqoH7bgDSQ4hAgNPirMdTscfsLwslEZL
         cy/o0/oaK2wTTuDGvYCt5gjRG5HhQRC1mumeoqgQQYKxmFhF+keouNxB4hXtbgUmY+n3
         3tUv0qI+6aK7NhA+itZjAMYxJ00Efc+aZ/VuxxXeDa6deD/qwbjaBimIBzzPxOD94DQ0
         gXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jrtjq2Yr4HF77ya+Bh8Y543ibzBroImWXM+PFp8HcNA=;
        b=nPUr8nPfRBqYVNN7OoLaLUxLlmkFyRpvKwmgtn4hL+EHaqZBQiS8CN6CahqfL8EqgV
         S49QNFRUSHbux24d/QUvuHL0C9q8ng+X2m++k2a/llZgKvUJFN6VSnJL0nf4DI8oDlZu
         Lu/xWQcgipRCEdvyg7TCcExgrm1OUs+s5uerwjLjfC0zfBVAZqxoX2CWxmudE8A4lKDe
         kUA5/F6FrZuPIfx/LY5dvgEvSYF+f2TFVaQyAsQm+N/pIe65wSpElF3HN2RNmcbQToQt
         yjeVy0nZ+UmHUhfM/T+AuwkzXGPMELFFh0NaSo65dhSyLM+0bOZ8aT+RUulAfihWW4bU
         /QWw==
X-Gm-Message-State: APjAAAUVBwyDycIy5xvt4ST+VH+mYrm3Tsc4EkQPvWZF8n9knRW/7mdf
        7l0refwN3sIQicY85o+es+c=
X-Google-Smtp-Source: APXvYqyF69/OmR7bOmXYXW/LXDpGgNxGAtz8+b6/5BfchkZuZPAVu1YEIQnv0Kd0un/R9zqCk+NSTA==
X-Received: by 2002:a63:ea52:: with SMTP id l18mr35848874pgk.124.1556381289756;
        Sat, 27 Apr 2019 09:08:09 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.58])
        by smtp.gmail.com with ESMTPSA id a9sm38584613pfo.17.2019.04.27.09.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 09:08:09 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: vc04_services: bcm2835-camera: Modify return statement.
Date:   Sat, 27 Apr 2019 21:37:49 +0530
Message-Id: <20190427160749.11191-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify return statement and remove the respective assignment.

Issue found by Coccinelle.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 2e0a422cdf3e..9841c30450ce 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -270,11 +270,9 @@ static int ctrl_set_rotate(struct bm2835_mmal_dev *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = vchiq_mmal_port_parameter_set(dev->instance, &camera->output[2],
+	return vchiq_mmal_port_parameter_set(dev->instance, &camera->output[2],
 					    mmal_ctrl->mmal_id,
 					    &u32_value, sizeof(u32_value));
-
-	return ret;
 }
 
 static int ctrl_set_flip(struct bm2835_mmal_dev *dev,
@@ -313,11 +311,9 @@ static int ctrl_set_flip(struct bm2835_mmal_dev *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = vchiq_mmal_port_parameter_set(dev->instance, &camera->output[2],
+	return vchiq_mmal_port_parameter_set(dev->instance, &camera->output[2],
 					    mmal_ctrl->mmal_id,
 					    &u32_value, sizeof(u32_value));
-
-	return ret;
 }
 
 static int ctrl_set_exposure(struct bm2835_mmal_dev *dev,
-- 
2.17.1

