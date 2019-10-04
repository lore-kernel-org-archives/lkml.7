Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF05C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D192133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIZU3DOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfJDTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:09:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37812 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfJDTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:09:53 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so15908254iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7XAUCdbkHP+3qeD8IAi87BfnaeBU6yWduxm7aN24lrc=;
        b=PIZU3DOCNHkv//gcgVRRCWke4OqJTknwSMnrMGdlNMOQk5+OAk2CU4eRA34YoyeI4i
         gHzd0EfCXxavyvjfJn0MEx83fyTJBpGqHOYEwYVHvak3hPaPlD8CYK2VMCI3j6k8KkUO
         4qYEotBxrvW3HOa00czkUrEfMxl0WQVCa/f+/TEFQG2xBwyaOa+0MscWPyTZOwaG6g6Q
         Xa0RkY7Hqn/tViO/qtkRply5N8osvwqlWLW7HB5etrBY4jZGqLwS4Q1UWa1QuiSjCLqj
         bK1scbdu/XQLmH5D4kn6Zkup5bU3uv06GghskxHr+l57gDDzh5PhGchgmewNS0NDI6Pp
         qrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7XAUCdbkHP+3qeD8IAi87BfnaeBU6yWduxm7aN24lrc=;
        b=XFg8pSHz87HV1Oni3RpuT4zc0FZxKTLITQ/CMIl+f8yi8Znp/ulIxx/a4TxstlKPr1
         zHBU/8NdFaXPUSN1D3g0Id4TJvnZiJKo6Givi6NiOmIdXDugMTBZ+pR1vShFQodKMraI
         JnGZmVPk726bkBAyJwamJJFjCA7IRtWPCqxAXU7Ewl13ojSgZGZlLXyX6xxAoF47hYz+
         9c2hMZjR11cvIGPAFdIwaiRYwYPLxQYZ45KJUdyuTFc5+oOcxJrDR8YySGX9yeQQBfcM
         LC2pShsQv5MK6nUpXsdWXHxoKzRb6u/Y16AMLGG2w9UpTAEZ86ttT1tkNHAczNMLltcG
         h6uA==
X-Gm-Message-State: APjAAAU9Ua2S5zMAznRLcPmlrmQFmN8WPEH8zE+5xZsY5a38u//po8jR
        s9gjMQik4NIHg0ReA3W4uFY=
X-Google-Smtp-Source: APXvYqxEP0qwOKKETCDmhwNirLOgrLxBuE1ywrf9+wtD9KLEnWuQcbFxVGAfRcVq1nneGNqxdqVLNQ==
X-Received: by 2002:a6b:3bc9:: with SMTP id i192mr2438459ioa.295.1570216190936;
        Fri, 04 Oct 2019 12:09:50 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i26sm2722087iol.84.2019.10.04.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 12:09:50 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: fix memory leak in imx_pd_bind
Date:   Fri,  4 Oct 2019 14:09:33 -0500
Message-Id: <20191004190938.15353-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx_pd_bind, the duplicated memory for imxpd->edid via kmemdup should
be released in drm_of_find_panel_or_bridge or imx_pd_register fail.

Fixes: ebc944613567 ("drm: convert drivers to use drm_of_find_panel_or_bridge")
Fixes: 19022aaae677 ("staging: drm/imx: Add parallel display support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/imx/parallel-display.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index e7ce17503ae1..9522d2cb0ad5 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -227,14 +227,18 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 
 	/* port@1 is the output port */
 	ret = drm_of_find_panel_or_bridge(np, 1, 0, &imxpd->panel, &imxpd->bridge);
-	if (ret && ret != -ENODEV)
+	if (ret && ret != -ENODEV) {
+		kfree(imxpd->edid);
 		return ret;
+	}
 
 	imxpd->dev = dev;
 
 	ret = imx_pd_register(drm, imxpd);
-	if (ret)
+	if (ret) {
+		kfree(imxpd->edid);
 		return ret;
+	}
 
 	dev_set_drvdata(dev, imxpd);
 
-- 
2.17.1

