Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1EBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE62521872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK/yz/qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfDELvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46958 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDELvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so7569455wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVtJaCRQkL06Lgj4cYGTrwycXVpfjWzOTw0Y4T0ycL4=;
        b=gK/yz/qGLluaLr0VEbpy4b/NOkCKfLa23Mq3oyuyjXjAd+BmnANAhTrMPaVhd9kmXW
         q7KA7hjlTjKhk6vEyrs2q7BEsCTNmBtk7QParQgv9OZMB4dq+xOeZTfdzDKghG0nVorA
         bZYCe6PlcaDffA5MyIx4MsIeumV8T+/PpYoRcd3iS+FH/uJTz4Ja1yAbS0KnbKFih6tU
         ZTI3fQvu/9lnbtJM3oA1mowkFRJTAWC3GuziGZAE9uJIHs0JGnep/C3vD3GmcMFdC6oH
         7N+UMqqe2D1QrIJc3E4IQYMhw3BL2576iDieyfpQXySvudn5McQ4I2TXMEVW9uu9DScf
         ILBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVtJaCRQkL06Lgj4cYGTrwycXVpfjWzOTw0Y4T0ycL4=;
        b=Ux7q0d2k64d20mXO90f/mqka5E0SQ1sDcFPTFuZUJ/9CnMSUlH2xAEsiLkseyaAXBq
         DFnf/BWNPaT54NZcwOpirG/1TXTSf1qGwPwgA9wYXL3RnZrVebb5p6OZux9ab2Cc7IDv
         NhExJKxa+4FCdJ77J+FVEYqvQnu8YFHVAZpF+UafBmMceKoi6PFtASAjoxAEhPX1m4Ym
         p3TbJZ1eV/oqRot2oTv4K+OYreAi3ld42GXv8eTAyl8q3nmMixUzcTh8GpQgOWwGIAJO
         290qS6oyIEB9q/Z4XS8LGfactVvCMrnmtakrTURlq7Iv9HhJEZmCcg6R2e0Wi4CghCJ9
         b2VA==
X-Gm-Message-State: APjAAAX1wQU2+L5auZhmRYy6BDgJ9VI08uB0F987sU3G32Oa6PHcv05x
        GC73RL+MTl9ZSyNJpWmvKdA=
X-Google-Smtp-Source: APXvYqxsNu+QSOxKTRBs+pDbZjipKEmZVsheIqMIax4sUKKoTDW5BJEcsbARSm+yBpfjBkMmYYM6+A==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr6380191wrs.155.1554465072316;
        Fri, 05 Apr 2019 04:51:12 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:11 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 13/20] ASoC: mpc5200_psc_i2s: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:03 +0300
Message-Id: <20190405115010.28838-14-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index d8232943ccb6..6de97461ba25 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,10 +1,10 @@
-/*
- * Freescale MPC5200 PSC in I2S mode
- * ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2008 Secret Lab Technologies Ltd.
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- */
+// SPDX-License-Identifier: GPL
+//
+// Freescale MPC5200 PSC in I2S mode
+// ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2008 Secret Lab Technologies Ltd.
+// Copyright (C) 2009 Jon Smirl, Digispeaker
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

