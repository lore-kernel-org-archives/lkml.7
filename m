Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99424C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8A20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="vVKhK3Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbfFJIo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38119 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbfFJIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so6023235lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pHoNwA6p3prwHBUsOArztRsZNohgEg95rwPndspSpc=;
        b=vVKhK3Z/9oUDrWOnijqul3sgVLBAZtHkrf0+/0H58vpn8/4+XDVOD9r7rLBrsrE0nv
         r348ZzWoLlWN1m4qW9vRFh8hi6LiUJde/q/6D14G3DJtxsfoeBSI+1Dh4gXUbVjLPnMR
         GZpKqGDVT3nosshMJQmk6dNLGi8+YI3+fAVt9ae8V8ybQTLAYKt05uLFfauyPcN6Cg59
         qqYWeOrREnbUV/pY/wAWzpUOj3GxSwL1MO/Mj5qa7PoMxfGKClkrMadKm7whQWfE/Dh7
         oaezOSdJHK7xPeOjYE8PWg6HSL9317hdXm5MkQ0Q158lLdzNfJks+wR9uPLFi4AWo4d7
         36fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pHoNwA6p3prwHBUsOArztRsZNohgEg95rwPndspSpc=;
        b=HN5EQTD0QFXszOTtq7MXTWXtItphRc5OTNS+lmKkwfEchcR97qd8O4zcvajm5+ni5M
         qZpNSFJEoa1c3jPH3RzxSl1lAUrd2jVuKoukGahrxS10oAOSgi9SPYAGvgJcX3HgIN9f
         bPc5E+oXMRRoSE7G059MoDLTn+XZp7gF+0pVfBJFfYjUQx1oh/jr+fjnzbeD8uPHGEvI
         2d1LTqPEwaSmmUY+60J0DIvhgH1uUs+FlrPkYLi/gjwOi/rTR399tSoUhonQDvnrhbEz
         TRsOOSiKlx2qXsR45poHAzjlLQkvSdVu1ua1KdQSG1VZ664+dMoB+stbG8D3pw0HZWii
         QsVw==
X-Gm-Message-State: APjAAAVu4a/M7Ulz+Y+1jgTz2GfjR2BLpjPQmgH3g7Jf8QjQwPhhZw5M
        M3vtPHZKseTs+Dk003/m0AJD6Q==
X-Google-Smtp-Source: APXvYqyAE/NrAnQ15xTIjzj6+th6UYKbDJ8+TOXJjiw6JXen5CJB050fGT04FuerdSbjsUHnoHrBWg==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr7036944lfm.17.1560156292107;
        Mon, 10 Jun 2019 01:44:52 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:51 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 3/5] staging: kpc2000: remove unnecessary debug prints in dma.c
Date:   Mon, 10 Jun 2019 10:44:30 +0200
Message-Id: <20190610084432.12597-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610084432.12597-1-simon@nikanor.nu>
References: <20190610084432.12597-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debug prints that are used only to inform about function entry or exit
can be removed as ftrace can be used to get this information.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc_dma/dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index 059932ab5907..8092d0cf4a4a 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -92,8 +92,6 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	unsigned int i;
 	int rv;
 
-	dev_dbg(&eng->pldev->dev, "Setting up DMA engine [%p]\n", eng);
-
 	caps = GetEngineCapabilities(eng);
 
 	if (WARN(!(caps & ENG_CAP_PRESENT), "%s() called for DMA Engine at %p which isn't present in hardware!\n", __func__, eng))
@@ -161,8 +159,6 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 {
 	unsigned long timeout;
 
-	dev_dbg(&eng->pldev->dev, "Destroying DMA engine [%p]\n", eng);
-
 	// Disable the descriptor engine
 	WriteEngineControl(eng, 0);
 
-- 
2.20.1

