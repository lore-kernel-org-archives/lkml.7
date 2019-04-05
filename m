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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51121872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkB1Jmea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfDELvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41639 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfDELvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so7626205wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+OTpVZBA8uEEjVrhe1iZlVCIOZYr2qeStkCdhTpd78=;
        b=SkB1JmeavbeT/kTYfi6qOrpvDBimlKj4KDGXksXabW1ICIC7apPTZIiMAG33Wiz4bI
         IOHJANsNqGrY3SbYCcCSYI2/fSkx95TaZTPXS+Nsf7V3DTZjvguJlMQgyQgHa6nmJCTc
         SsJuqX1ZBxXo0Mv+1Cr6GNeyanJxYNZ05tAH5FRztqFehOTA4nq/xLPcIWBoT0sdNoiz
         UUULkWWlSqDKhdymFVh7XruwJmIEVZz/xaF6CfK4K/G9DcUrEcn73sR0ulpV1JuMesAe
         KHQX928kMa5IdIfW4R/4fFE0o3xPLaxLgcU+Zi09QDFtFGXLB6WVno4Exu4v9BHcw8s1
         m3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+OTpVZBA8uEEjVrhe1iZlVCIOZYr2qeStkCdhTpd78=;
        b=GUuMwGpVaaKp6S3V5POIs1aE7BAZnDFIk5Y/Uy/Wu1/odf0NLlD+DFjvf/2PD9LLSW
         ZYHFifawBvr0AGYAf2vsRXnDIxTALY8xalhg8VZiqMYVZiBD4Bg7Esws2joHZzXMPubv
         d+FcyU06sYQrfgfjzVHfNzTEVUbQih09o44K7EP+dNnYGhZg1Jc/uLuXwAdp2Cl4mOiA
         5BQOnI0zmtaK3FKlWacORxBtryum4SwJGGSmrjXrnbuGeYnjLxxl0KYthPFTTOwffZ42
         qZ1EniTzLHYVh6ycIbVOfNrEO32YvMOoNxkfTEgydUMi6dMEqKwyUtrBhppxsSstiO2z
         rbCw==
X-Gm-Message-State: APjAAAUdRW/s6niAsWsKFQzagEGED8m7ss4B0vpKInhdp39BakEA/m/L
        TQGaSZtHh7iBy+iJd+mR2YU=
X-Google-Smtp-Source: APXvYqxE3rwFGHbzDjKb2cE59TTOK+BEkT/DHYg9VnVuBEFYoT+927OS9xrZVXgngpKGGf7W2qIcbQ==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr7890715wrv.70.1554465089746;
        Fri, 05 Apr 2019 04:51:29 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:29 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 20/20] ASoC: wm1133-ev1: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:10 +0300
Message-Id: <20190405115010.28838-21-andradanciu1997@gmail.com>
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
 sound/soc/fsl/wm1133-ev1.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 2f80b21b2921..aad24ccbef90 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -1,16 +1,11 @@
-/*
- *  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
- *
- *  Copyright (c) 2010 Wolfson Microelectronics plc
- *  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  Based on an earlier driver for the same hardware by Liam Girdwood.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
+//
+//  Copyright (c) 2010 Wolfson Microelectronics plc
+//  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+//
+//  Based on an earlier driver for the same hardware by Liam Girdwood.
 
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-- 
2.11.0

