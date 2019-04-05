Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44858C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254A218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQToVb8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfDELvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731141AbfDELu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so6886816wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utJGoRmoCt1Yac5uZqSPuhhOnZaRHyvqQEV4XOPwu9o=;
        b=iQToVb8WaIhnC0kFylFioMF2Y9UqvJrZT3P6RyY9oir8Vgl5sB19XtviB6yuAE7oDm
         FYNp67IebAZFj68B7FE2+QhvL2Z8WuTFOOeG6VfgCkUXKI/QRdh3TsE2sB6BJdKNNPtv
         82+ODDhd8AP2EzpgFR77ymPF5vl5d78MkU0yI0cJZhtFCOKUGZ4BKppQfwcbyY+f3szf
         SMxIE6Rc9NARa+qRt+iWhauQIzdI0oEIxuKqil+oDQMZBByBsSjOAZ3x5ZWBsNZol2pq
         iAU2ZzyM3Olp6h1xHc3JRG4/jcPqnFEa6e7s3bga5naetU143x54BdFnrlsEDhVyrxEK
         wzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utJGoRmoCt1Yac5uZqSPuhhOnZaRHyvqQEV4XOPwu9o=;
        b=O0fWDABmyif4fzkQ8QBEnUwnmBGP5YDh1g+lkmHdSmRFNDXSJuExZAfwqPQBgzDYOQ
         F62M5BHo/Y2Tzq71dWmKayTq5P+rX2Xt1PNipkRGjssI3XWxyOSssvnsuELdGxGBtg1/
         W9jbLE4Sopef317CQ7ZCLmIzqwFXtv7a1sX/AJPTpNSMLl/zyi5YYCtJGhRW1zW0shP8
         FJ+fHrvd8gTGoFi7uxXBnPogifrcTJNWhmzk1vTqAvtaui+DnLpszYXR2ur53WtfTHgg
         6TWa/Up+U8zBVA/xkqLTkdU/jfq86fPkIm1Ju8xylbh4UnUE2V55LyKSoMwq70+wW+Qk
         kxog==
X-Gm-Message-State: APjAAAWdhGgGMA55D5o8cj4aaJH9DQO9xBlm2dfGv+2M7oNn492AVLe0
        V7N82FL1DbM39BWZ56cYgfY=
X-Google-Smtp-Source: APXvYqwTeKzT4qf+7/FYVUNWvvkVTEMxThnfCNcy69yPA3QINTDt4y04btghmlO+O+nhMq0z0ijpkw==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr7588888wmf.118.1554465057276;
        Fri, 05 Apr 2019 04:50:57 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:56 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 07/20] ASoC: imx-mc13783: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:57 +0300
Message-Id: <20190405115010.28838-8-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-mc13783.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9d19b808f634..545815a27074 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -1,17 +1,11 @@
-/*
- * imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
- *
- * Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
- *
- * Heavly based on phycore-mc13783:
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
+//
+// Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
+//
+// Heavly based on phycore-mc13783:
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

