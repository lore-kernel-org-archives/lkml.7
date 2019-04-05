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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69052C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395092186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW6g/tH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfDELvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54858 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbfDELvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so6327034wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SYxt71K5cDuYYPDOLPDo0W42xN9f7ymOpTx0siZ9uFE=;
        b=OW6g/tH1grTVYgYEYMkJQbGS2cn6t1AC3p2IKqubQ54EQizIAuwEvs5JXVE4lGt/CR
         6nc8o/065laVyJN1qVxfbX0FjRuuQoFeswJO0AI1pGzl2lJ6fdzIt9g2KpfTNRL3CNc+
         Z+zSN86+hb/+/F80dpHjBNdJJdnTD2i/dVJLvQqcTbZ31khy40hMJPvsURuz9lWoj6Om
         YBstLXaN8thPL23pihpdzG1E7H6E6wSR1jYXrGY18usTK0koOjV7CctYYxnkd2/H163Z
         79GJuot18wl/YGx+KrtdW5wuaDT5y6KaQ/UxjgDaGhi/W78tSGfFOFgvdCKu1PNmY8FX
         homA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SYxt71K5cDuYYPDOLPDo0W42xN9f7ymOpTx0siZ9uFE=;
        b=aN/vHuDFcFjplafGnw7d3pGnYAzGfk66F082low2Vcv5k8jpR1B0aLnUmsU3++WGt5
         JtAwJGUfK4pzxRenRgCBGSnMF8ZKyKST6Z4OT+GMvCXH6VwnzxO4ENeV9jyVUgvkof/P
         Iu1jMCmHGWBv9eLNdV0H5Itu37eVLWNnaJxeZvpXer3wqtblS/TmrhbwSOJadTBlOxAu
         9HckaCJU9NKHsapyZu8UN/GGj5unx+hGY6P9VgWyoh8JekvuV1nPZXDGUKI377/WWRSX
         6U2KWrlF24NHKQrj7QoKforeVKpciV0g6kXSm1pPdAe2b+mgDDKm+EY3o0oPkk3pM7f6
         gqLg==
X-Gm-Message-State: APjAAAUlqQTsOBq0ZJwPVpHuFp9SQchGaHQSCbqyoECKHZniDF0pgh1u
        yPe3UmGbGTvM5/JPlH3y+ww=
X-Google-Smtp-Source: APXvYqwxNkQmVZrUi1vsYyK/2xnLgyg9ZpKXI/epAYR9GMay32GRo4cEV01N9SqKEx6qeF1Eb2HGPQ==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr8042987wmb.101.1554465059942;
        Fri, 05 Apr 2019 04:50:59 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:59 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 08/20] ASoC: imx-pcm-fiq: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:58 +0300
Message-Id: <20190405115010.28838-9-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-pcm-fiq.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 0578f3486847..c49aea4fba56 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -1,16 +1,11 @@
-/*
- * imx-pcm-fiq.c  --  ALSA Soc Audio Layer
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
+// imx-pcm-fiq.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-- 
2.11.0

