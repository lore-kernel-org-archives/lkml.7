Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD989C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE9221872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTLf8ikW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfDELvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36341 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbfDELvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so7656719wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4hOLEy1KAA39sFWNk89CJxULZaItnMmPfy0ZrsUguQ=;
        b=uTLf8ikWgZGaU5U704onyfDUodYw6lCqifcV6omsTrKn4JHBdcCZAZLs5gpSrH6twO
         4EjX+jRArj24uk1brErJRDIG4EN/cx05I+NdmSAfe5uKOsFUKhUdFLhMnEeEYR6XSDID
         IeKbRIGSwopflQDoyfj1SLCLXwtw7NhEWiYA3vww9V/xPmvsrPnFEEUvkYo6KumHCvso
         vkSG63fdjibxtbBTGyoCMn4wQn7nUXEASDSEL0PKl8qJM6jxmkMW2HdNN+XxskN3IAbX
         KSHoYDihVRStp+vKqC2EEo7wTdVDdcEIOSekPMfpdJAfRj1LTs8UXqdghcsOxganz87W
         cOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4hOLEy1KAA39sFWNk89CJxULZaItnMmPfy0ZrsUguQ=;
        b=INUo2uWBHQnWJOyVq+LtNcesMMYKhsDvzQhWaof192Nc1yGSNlf8c5zceKYkGhCkV+
         q8Ol0SOr805GGnRYhkSw6iF5EkxAJcao7a6iLPYtr4hEOS73XgxXc7CGgmp0lCllQSy6
         WNWRBvwpa+V2rKegPPx42ZUbER6U8m3aJHH9AytsyyAqXdMU+8DaGE5KrMLGJsXi4MQD
         0CNGITTjtDF/OyFktxfLO34Jim2frnNWfBBEAu0/FMFH1mh9kJN2PTzCyebt+Npv/bMr
         B1j9Nkt/5ZC5WqvIap+dkJfLg5CAJuYKopDHPBfVAlW10E+1Hn3n57heHO9j/RS785+M
         T22A==
X-Gm-Message-State: APjAAAURd6J65NvqVY9sWG9eQlXQV8lviARNXG0BmKCU/tk6LTm+1gUD
        dHffI2jPmgI8JazZ+OCS2j0=
X-Google-Smtp-Source: APXvYqzXXzPbcrL114rjzAe/hUC5/G0u+3qzwTXWsA6V4W4RWDRI+5ISLM+d1K9vaj7I6i0v+FmTbw==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr8008718wro.216.1554465074869;
        Fri, 05 Apr 2019 04:51:14 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:14 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 14/20] ASoC: mpc8610_hpcd: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:04 +0300
Message-Id: <20190405115010.28838-15-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc8610_hpcd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a639b52c16f6..f6261a3eeb0f 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,14 +1,10 @@
-/**
- * Freescale MPC8610HPCD ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale MPC8610HPCD ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.11.0

