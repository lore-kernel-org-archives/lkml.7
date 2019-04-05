Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A99C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE442186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msVcIcmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfDELv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38841 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfDELv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so6860301wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j0LHszZ06ydUWsHWSBiBJiyy+zVHgOm4jnvb8gHVHMM=;
        b=msVcIcmcHgTh3ren7+o6qm3lDBHeyslORbE48nhEch5MwT5Q8nIEJf8Md1RidM/iWH
         1o7w+gaoPwmhYsybBc+HhNp2l0LEOj9odH0yCDXTMm3kwa/yidX4pjv0/cDxPVYkfY7k
         gfJRlpqXSYkF+BlTE2HgEVCFNAnCiayfI1g80r0MDX5RzRGQE51fZOe6SMRayaulDipL
         B3l6Ca+OJNUBYzHu8J84M4ZjchfmC7Csf2Jfk6VuhAcIUfAKdN8BRkXbrMIwv5/et68K
         ij9ZIBi5sG0R+ccB3y7H9DHOxLCWfjJ1in2iQAFNLrpTkAhTSYfcJmjAu9t6nKfPN6Jr
         nDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j0LHszZ06ydUWsHWSBiBJiyy+zVHgOm4jnvb8gHVHMM=;
        b=cRtLOb3w5rp3P6WgLsRXsKXbiBUWuhO9A2zTgstnD7vAu3YQyDm5AL7H8XQIip1c6R
         hJ2+PRFNbSxSJ1GFVf627Cz+aG6Cx1EqRQ0HUwsI8yhxa/aCBUtIGHgGuMBQhbrPATCK
         R54IoYi3e/ernofYV9KhQJDcMYclLqA9/WWk7+fSu7o+5I8CJehkVLavPDG3mhSejEOz
         aPRahYpEU1vv0tJYrmE9+qpFtJIe/M0L+ksbFBd1t4tEYDmAH6bZk2Gd03MEVQVzRRAQ
         6wYnBJNi3Z3yvTKhYVLRQkYpRDxyVO2EkITwHJt2O24f11ORwJRX7+3zNavKW6gyGchC
         lFQw==
X-Gm-Message-State: APjAAAWBmX0QTx+IAGnOHHBMawQh53eN9m/D9QAUc/n2ASP740pGvaoZ
        aom04u5hx5ZzXjFZumt+P18=
X-Google-Smtp-Source: APXvYqxdlO8sb27pw1jKTb0T6g/S++ganD951Y9ouO45N2CXdOTMBdH7uFY9vPmo74ZGrnaEqwEcOw==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr7481119wmb.85.1554465084799;
        Fri, 05 Apr 2019 04:51:24 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:24 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 18/20] ASoC: pcm030-audio-fabric: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:08 +0300
Message-Id: <20190405115010.28838-19-andradanciu1997@gmail.com>
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
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index e339f36cea95..a7fe4ad25c52 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -1,14 +1,10 @@
-/*
- * Phytec pcm030 driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Phytec pcm030 driver for the PSC of the Freescale MPC52xx
+// configured as AC97 interface
+//
+// Copyright 2008 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.11.0

