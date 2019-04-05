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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DEA2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCConTvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfDELuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50420 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfDELuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so6386312wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5asv/MMYgaT3vlOnBG4Dw1w/S6VrgPjfjegRPmtGsPM=;
        b=eCConTvSb7AtK58n0Df+uaIqd4+v8mj3krxRh+M1NjPa3BIXzvJC0lKUikEFLPu9c/
         u/3ZNVP1G6+MJve5Hj8UDyaWxAZ14UfYj+vEuyRrKwz5FIyDGQn4APYxFyjyjz3QmvPg
         TThMVPReH6VZKhwZeUm/vUG5KRcgxRBeukfOZ2EQrGQbT+gbE8KmHrqUSnk6OYCEYuHa
         A6/iBmlME3RfBeHwK5k9kp8CSvsva860jHBmKebcwi8um93NAiLe21p3y8R+Fbagt2L8
         tJBb+1JGndrZBWRnEWtFfTnekqSHlxRFooRsqtKnhW8qIXcW6kaJR/5RXIebUzchHLKm
         rgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5asv/MMYgaT3vlOnBG4Dw1w/S6VrgPjfjegRPmtGsPM=;
        b=VnijaZBM+OKK0ANX6dOY4uap4Yalb4hxeqXOi7OsvaM2BM9UaaHvcCYPhJa8BHxMwY
         bsdiuL8UNdttdpxo+b+HycvbAhOQ++aAI3COhVIWgouTmWfOS0x5odf4glEKdOZOGOeN
         8pKtjjd9k7iFkCmBMFUsowormWbYwaxRqthB+W1GEtuo4tYjeAg+qdh0QnAHZSTvaN+i
         8YfSraPkaZWHZzlPXHkXHxF/LC+SEnrjHyUnFglVHD+sWRendWUngHc/1aDr5QggIO/Q
         y5lGxW6S9NcyAh2/xDGCYpDMosZYMwKVeamB9dnh/nvf++Vm2CsoSoM2in3aMynnS4Z5
         H1KA==
X-Gm-Message-State: APjAAAUzeatDdb1r0X22c8PlODsvSti6CfBj173TZV1urD4Ne6LDmyK4
        3K0uNmf1V1wLbVV4lQTQdo4=
X-Google-Smtp-Source: APXvYqw8hkwRw3wCb1GQ+HDlwT/I55ykrChmpfn2wnpPr+ajoYDMDFk263jAmBxPUG8SKiK0Ppz8ig==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr7549383wmj.60.1554465048087;
        Fri, 05 Apr 2019 04:50:48 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:47 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 05/20] ASoC: imx-audmux: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:55 +0300
Message-Id: <20190405115010.28838-6-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-audmux.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 99e07b01a2ce..04e59e66711d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -1,21 +1,11 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
+// Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+//
+// Initial development of this code was funded by
+// Phytec Messtechnik GmbH, http://www.phytec.de
 
 #include <linux/clk.h>
 #include <linux/debugfs.h>
-- 
2.11.0

