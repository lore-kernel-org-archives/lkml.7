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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6C2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqGh6yZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfDELv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42134 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfDELvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so7609246wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=reV3+apEIiV+cf8d5UskOEI3OYpnKbwiiVSFEL+GB3o=;
        b=jqGh6yZ69s6rGwwFDqV1Y0+fXnzNjM25uGDoe6FZdhZs2wIwC0GmaLMNpymGzebE6C
         GIuYp2S8KWOve2NWe+FosoJtHU+gtrENwCa+7WO/neMyDjj4g4zyVuoJCdtulukeAjmI
         XAV61KTsLdQUORdiqjepAsTDHo94qke5OzcASEIYtffsM33YkgIlfYJ0Q+Du21pcw1mR
         MKQ6Z3cdrZ6sBy34XbTTOWY5pp/th9LohqUDubWfl3cJpMMLzqmO5dSMNksjKAfo4PbY
         2MpWlEp2zeu3HzIFl7JDt/UD2maaxKmehmw6uMytLLVu1C+WsxrTsrdWB823J58l2mgx
         +rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=reV3+apEIiV+cf8d5UskOEI3OYpnKbwiiVSFEL+GB3o=;
        b=nGSR1IK3MEE55yybYq8wH+8K+mPjMGNe6HSjomj9jyGWCqg/pnYZoZ+lkM1uNQF3BE
         V0bcWq4PzYfpPMVaMHKfb1gFe9QASoD1yCchV49TmsrxYAJ2BSYlk8nrCCLbkFN7488z
         Nx7/Z+tMSmCXEe5thUy0cJdzHkgvn2Q4ehsSjP4VepwsDY695pgEw/Z5DbzAagMSqKmQ
         Jz4Yz6mjEdhbr1IEadc3neducOgexi8NEjqjxr3CPbPihwQtVxfIdxSZPkJlDphdOKaw
         gFg4QJWfosG5fsqYI2mgawIAQNunVd/GOrpuVYKdBzcedHMyX0RS5L77K3KhzvShxYnx
         A92A==
X-Gm-Message-State: APjAAAVTpbF6nxgyCIKkjmHS2mjYgsMKBNbyeFBWat0jEwNmz2Xrzo0P
        SYFTnEslYUp4Fxn5PTg9DxE=
X-Google-Smtp-Source: APXvYqwes1A4L+aLyptK4y25SsxHUA3Xhyg4RTDeYO8I2b1kNaQ/lzBEttymiA+5M773gf3nhfWZ2g==
X-Received: by 2002:a5d:424b:: with SMTP id s11mr1033160wrr.158.1554465082294;
        Fri, 05 Apr 2019 04:51:22 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:21 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 17/20] ASoC: p1022_rdk: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:07 +0300
Message-Id: <20190405115010.28838-18-andradanciu1997@gmail.com>
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
 sound/soc/fsl/p1022_rdk.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 4afbdd610bfa..1c32c2d8c6b0 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -1,21 +1,17 @@
-/**
- * Freescale P1022RDK ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * Note: in order for audio to work correctly, the output controls need
- * to be enabled, because they control the clock.  So for playback, for
- * example:
- *
- *      amixer sset 'Left Output Mixer PCM' on
- *      amixer sset 'Right Output Mixer PCM' on
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022RDK ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+//
+// Note: in order for audio to work correctly, the output controls need
+// to be enabled, because they control the clock.  So for playback, for
+// example:
+//
+//      amixer sset 'Left Output Mixer PCM' on
+//      amixer sset 'Right Output Mixer PCM' on
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.11.0

