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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF4AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D18A218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7WJ5lCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfDELuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so7580023wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95CAJLAF/PMh3aeIKltAlThBxHYZ7/UK1SaFatHO998=;
        b=u7WJ5lCS7iL4lqzM3ecwPPol6uZTsc7v7KTXVWiciGyixt9FpS4PoywAhrXFrJWhOa
         WReiXf3shgTK5AB3fYs7eLGzO1ZosLvTjFLyli7sdGkqk/JEH4zjA0GEZXzxGOgE9r1S
         CYMUHqlAJuwOUTGpeXdD3YxUcvWMjMBNocKn4tuFRDT0ARxlH5KqfC2rIpxVEgl3Igle
         TaBB7Efs1SLjxaweWRhyV7QBtS9eVjECqdGgIpROtrLi3J9Nc7U8WNB+D5GYB0TMtlVl
         aqQ0ryTGfkEziO+ThyheDASjpCCJb55WeAMYtxACZMHRPEKuPI/c/v2QN9VNb0Y+I3Ku
         k/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95CAJLAF/PMh3aeIKltAlThBxHYZ7/UK1SaFatHO998=;
        b=mCAnMODQdzvX6x5izSyTdv06OcMi+5BVNbMy7Q4YXUfroj9MHfD/Gv3254Ooi1f7Ku
         2boS3zbTH/sGyvZaCdqTt8m3d6/4+Sr2FXnDG9Vs1TRuV3sgdAIsYzcpZJy8JVsh6gxI
         iavy2YbcgkHHYZYJuKzNJn78Ao08qt8ZBlUTa5Mqs6K7UgRblNmopOEnoqc91Y9euBV5
         Xu/fF/7V8xHb2E1e7G1ZgjYLY75vRiVQPf07WDvMdjn32XPIuux2FJhSgi3W/b86+xFv
         4KkxVhPOVovnnPkaqvxbsUthmqfKqhCXEa2pi9k+SLyzilDASWd+G3SzNABnVC6iZLXO
         eJHA==
X-Gm-Message-State: APjAAAUQplGYufXnAfWdN+cRadN1HezlRr2IqCEgOKtiGcWTPexdGn2f
        PY9ygtWb1zQ5ywUX/JX8FRl8O5rcxO5r1A==
X-Google-Smtp-Source: APXvYqxuFJwAJF+0VqitwVMow9oRZU7BpMGSQ8snglUrvCMtCwk1TGPZIjFoQdZzmKvcJszT9eAgQA==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr8339985wru.215.1554465041835;
        Fri, 05 Apr 2019 04:50:41 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:41 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 03/20] ASoC: eukrea-tlv320: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:53 +0300
Message-Id: <20190405115010.28838-4-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/eukrea-tlv320.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 30a3d68b5c03..d648268cb454 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -1,19 +1,13 @@
-/*
- * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
- *
- * Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
- *
- * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- * which is Copyright 2009 Simtec Electronics
- * and on sound/soc/imx/phycore-ac97.c which is
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
+// eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
+//
+// Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
+//
+// based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+// which is Copyright 2009 Simtec Electronics
+// and on sound/soc/imx/phycore-ac97.c which is
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/errno.h>
 #include <linux/module.h>
-- 
2.11.0

