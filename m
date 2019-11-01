Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E42CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897D320679
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNdD3ggU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfKAWht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:37:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43709 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:37:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id c26so15026163qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGdeY7oWB17TnAUMaa0RtkRNLL4fGiuy6QxiZRPpPP8=;
        b=TNdD3ggUUn77JBgZbx0bJOfzDhFbOZLSfI7IOLdB//bieFBARrcHiwoIH87O7YgV0R
         ak+TPpvIhrrItkHz93pykSwRFdmCQr7bbo+ajQetvP4F4HGS7mB+HIZ/VcnUoPZDFkeg
         bNN3HibPUGLwJ5C6qD+vjY+bp4BuGxABAxOQGxjk7Uh10EX13HCgH3NCLo1Qa/QFNEu5
         37RNjHO7LDFzouXUAilGxaIiuZOmhX4QNavQEZI8SKa03uD0mhO7npP0qqjO5Crh0/r5
         IkQpglJqe5tf/aqELFE4swyCAt5BQLVluT11BfqBPve6t5hS1Lh+iUPpYNtUi7w0NDQo
         2DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGdeY7oWB17TnAUMaa0RtkRNLL4fGiuy6QxiZRPpPP8=;
        b=mBGXcTGJuSUh/APG4c0lZd6TgWwVhAa92DWugZUoxvCO+Zd9m/yjjOQCjsTDwNxJ4j
         0ELx710oO0bRnPQQVCO0uSD4R69GQGt+/w3bklrOW3wok46kUCoSeJwbJcuK8Fw5JBUW
         VhlX5uqvfqfew5lJCpDXq0x8J2eApW7UramsGzVcY/W1QDhA+x3RyM1bQvni9vA79Xfi
         7mjBs+SXO6K7gS0n57zjB3kZ39EzkH7a2e5uh3aEIfaMcvRRgNgZL8TN8VSX2JbzXXYX
         /mEfAFECAtCDgM0f8WdUw2kQegaslv1PNyv4BlwhWwgf7OMcmFk8XwSO4uI9a+Q+QnqM
         yGtw==
X-Gm-Message-State: APjAAAVL+Gub2m8oMl9TW24NBRtnyxkCdUWU5w0Wou/Zneo0jSVgnZCB
        rGfD3/s6/PibVN1pMeitGgY=
X-Google-Smtp-Source: APXvYqzRx6KDYglL02uS0KSCwKYUgED5SRybgScUirfxM9VudDlmhHkE8C/420B3/mS2oT6BWSddZQ==
X-Received: by 2002:ac8:74c3:: with SMTP id j3mr1871355qtr.113.1572647866452;
        Fri, 01 Nov 2019 15:37:46 -0700 (PDT)
Received: from localhost.localdomain (179-241-199-14.3g.claro.net.br. [179.241.199.14])
        by smtp.gmail.com with ESMTPSA id x64sm4192780qkd.88.2019.11.01.15.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 15:37:45 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] drm/vkms: Update VKMS documentation
Date:   Fri,  1 Nov 2019 19:37:35 -0300
Message-Id: <20191101223735.2425-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small changes in the driver documentation, clarifing the description.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

Tested using: make htmldocs
---
 drivers/gpu/drm/vkms/vkms_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 80524a22412a..52e761bd6c2d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -3,10 +3,10 @@
 /**
  * DOC: vkms (Virtual Kernel Modesetting)
  *
- * vkms is a software-only model of a kms driver that is useful for testing,
- * or for running X (or similar) on headless machines and be able to still
- * use the GPU. vkms aims to enable a virtual display without the need for
- * a hardware display capability.
+ * VKMS is a software-only model of a KMS driver that is useful for testing
+ * and for running X (or similar) on headless machines. VKMS aims to enable
+ * a virtual display with no need of a hardware display capability, releasing
+ * the GPU in DRM API tests.
  */
 
 #include <linux/module.h>
-- 
2.20.1

