Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B990C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE222186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbHDLtbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfDELus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33426 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so9562067wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shxp5QccDgvm7RtJoZA9C9TvzP7d0bo8vYGaOaufb+8=;
        b=EbHDLtbWQQPwQ5+zVtN5sPff0W0FDb8kf4if9Jhhndqtf0OV2p47KxUYLisTCXkhnh
         uHbbEiKhhIC/KMF1HBkX+iFCdexPC3k8xEnAKn78Cwx31hLzvd7Ukx5oLkIRUc+z/3nS
         2Q81fNc8S5rLG1xNa5dZDcf4Z+I1TNxLK07qjFVwjzJuCvFUNvitsenoZiwbqNI9cVCG
         Aeyt61aQz6P3W+rUJJ0Jmu6c8pASb2YBJZ1u6yy32g02ndY/afgIvwiHO/RoctAMLh7b
         tfFOigxNdTrgpsRwzOgcFYjS9RxVKFturDIzH9n42oi0p991iJWLhZNfUcl2ehvIDvTA
         eHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shxp5QccDgvm7RtJoZA9C9TvzP7d0bo8vYGaOaufb+8=;
        b=o0ls8oRCbT5OngXEaCocvtooBJja9NbCIjJ9YUgIaGNGhiFMCOlOQ4A4rqdCmnKfIa
         fcgd8vQtrUaGtAu3HShzfaLQPMB4mmQXluiKNHfCDxwYNVdJhUtEqMub/843KejIy7sx
         MOZI7gqONEk3fEITRLU1elLMN5uLINoqfHpomp7Mgl3IWPcnsSOUTM2SV87Qsd2+0R3a
         cWGAOK+YeMD+WBZ+gGFE/RnZx61NE4ObMwvACIpHsNcBWpzB8IlgmQqfZsGIiCdzj6/X
         5QzgwFJe3GNkTEW+cnRxSgoxjWPCZJ3/CWoueRZ+lo0e4qY23KEHugBmizt5PwEbHgMe
         J0qQ==
X-Gm-Message-State: APjAAAXXYJ9Vi14faAncaEDZOH/B5VS+82mk3suzMSkYnTWAQy6AVwXp
        nnX2WBEHBUAPnpqV5REaNoOj7PhNQf2iAA==
X-Google-Smtp-Source: APXvYqx9gP4WQb4WHpGF+ef+aOaJ/jWklMyCaVluOZumL8v3mJ9HlAbHFbKHZo6NDqiHE2x3gszVWg==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr7732009wml.24.1554465045260;
        Fri, 05 Apr 2019 04:50:45 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:44 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 04/20] ASoC: fsl-dma: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:54 +0300
Message-Id: <20190405115010.28838-5-andradanciu1997@gmail.com>
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
 sound/soc/fsl/fsl_dma.c | 26 +++++++++++---------------
 sound/soc/fsl/fsl_dma.h |  5 +----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 78871de35086..e22508301412 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -1,18 +1,14 @@
-/*
- * Freescale DMA ALSA SoC PCM driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * This driver implements ASoC support for the Elo DMA controller, which is
- * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
- * the PCM driver is what handles the DMA buffer.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale DMA ALSA SoC PCM driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// This driver implements ASoC support for the Elo DMA controller, which is
+// the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
+// the PCM driver is what handles the DMA buffer.
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 78fee97e8036..f19ae765b656 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mpc8610-pcm.h - ALSA PCM interface for the Freescale MPC8610 SoC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _MPC8610_PCM_H
-- 
2.11.0

