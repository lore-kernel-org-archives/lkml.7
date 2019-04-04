Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E88C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C796206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXaXfid+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfDDLxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:53:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55119 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:53:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so2689117wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vc8JhnKR4Bcfb3mi4PgaRMI/IBnv1Y7aronixVijIxU=;
        b=jXaXfid+eOF4AjlaE9LiXCJE31BRlyI7H9ydNwUXVh5/i//nAA3oofBRJCBGYTGafL
         uyX2IMpYXuwni6tvqjaejowU+KGbX+U1ceeEHJANRyDz+LnhE4HTfvabiVtT11AZ5viG
         8EDq335r6XVi3WHni1ZLPW0hNWFd1PwGp+zJlGA/pxRYdsIi2+xpNaLbm0XAtktycYqG
         uTNm/qNQzaKwPYouyxebaPKqAb0v+canAUuZoevgWUCrd0+0oXi7u4S5eJG87DDd6l2E
         +XOlRZrD+s1MI5DyP+mwbl9+D9dHmuv4gJfsUUx8YKNBaDvXyOdeInGZr9AAi2nFz9In
         7frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vc8JhnKR4Bcfb3mi4PgaRMI/IBnv1Y7aronixVijIxU=;
        b=tLEgVhVKDXeV/YWWOoLQOIG+XNwRdv3GfL6r5DMNnJKwmymFL57TH/hKDzY9yNsaOp
         EVmJUZrpXs0Uc2gP0DxRMzGbsXXUZ6a2jdHFNIP7tDeoHt2Tha3iSqI/ivZx6l/0htik
         7ej9t0ItIGY0UN0m1duFl0YdPdnHmXCsAQsyAO16XqwpVKq6BcHai/QYLdem80d4LqeN
         UNT9dq2Zg2+DX9PyCMFVrCnbZx1Fd8aq0vIqPaqjaM/Msg5r/VGzvU4LY+PggwYCT6qP
         IKDj7FrKbUV6gfAmtyj18YayArD9vbvzsRuh1aV060fGLv9MBVvT8kTC2R/FIdmokRXr
         zq6Q==
X-Gm-Message-State: APjAAAWssymv1Khec0yJGsmQ23tJkXqPGoZlNHiA3CLmth0lYkMQjl8s
        qmMxrRY5asttjLfa4zhakl8=
X-Google-Smtp-Source: APXvYqxHXNCxc/Bz8SuAoxRpukx5J2vcHCvfzJUi2tin4bPMy6/e3ffPERh3+HK9RWk5mSxhxelnrA==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr3745219wmh.93.1554378790075;
        Thu, 04 Apr 2019 04:53:10 -0700 (PDT)
Received: from localhost.localdomain ([178.138.32.90])
        by smtp.gmail.com with ESMTPSA id e9sm30366457wrp.35.2019.04.04.04.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 04:53:09 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH] ASoC: imx-pcm-dma: Switch to SPDX identifier
Date:   Thu,  4 Apr 2019 14:52:52 +0300
Message-Id: <20190404115252.29230-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-pcm-dma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 314814ddd2b0..6c495761f33c 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -1,16 +1,12 @@
-/*
- * imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This code is based on code copyrighted by Freescale,
- * Liam Girdwood, Javier Martin and probably others.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
-- 
2.11.0

