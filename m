Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A075C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4950721872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ9izbld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDELwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:52:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38802 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfDELvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so6859214wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CKd2aDJsgP2hWOqiDkLKniTsVcnzpZOMdyBGV6fEio=;
        b=pJ9izbldDPFDxl4JmV3u49KvY6DGq5hrRchRNguSR7cK7MJxbXa4E5bT/v1K3gY7f1
         tJpH2ZnV8do1FB8pylSVXDHZd4XWOXPEVy+lPB1bUcE4jFA8nEm2bee0VdSO/R523b4n
         qh5ZHodPJWAFbPqGBd9eCOOhNkdVPrGRrYD9CrBGGG5YNXyGg87ezNkU1JhSl3q+jqAx
         hMyYw49oRmJDzLFY1JbTKJ6D3APmZVYiqEXtT7jpJRwm3jFMkCuC3NiPxV9XG0pMEiE7
         QOJhiCCyUg6QHpZ+1IICmG19aEW+IkNin5NL8+T0+MOoCtcqoN9zuHewi4oxySIxWnBB
         GonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CKd2aDJsgP2hWOqiDkLKniTsVcnzpZOMdyBGV6fEio=;
        b=GZ+qU2QXWJvAArgbuEtFNc9sayHEQq7aJCi08japmFr/eL4tnCB7/o9SvpYqZ+jWYc
         KMdNCeukVMR0RaynnZ6uJPLtPNbXQvJKVTMFhCANbQ391vIAjqJ8MluYQiC4TYQSSLS5
         DfbW0Mbu1wTXXC20xPyKy/U/GU+sOOtrRTF/v/8MzRgiP0VS4M/2oAokCml/YGOcNUhZ
         /ZzPCdCsPpYFvrHCx6p8ZQW/Wd1qUlv6OsazbH1mNq5veAzW1SojmFU27hTOW96nmcD6
         a0uldEp7PAI3qsMV/bWiM3JV75187mcGPBBXzNGy/zZe8Yca8twRmUU/l6can7QNNX9x
         w/Bg==
X-Gm-Message-State: APjAAAWF+PPhorSnW9Mkha8K7ZA6mMwuW/1phTD4FChIxHAmfHBpZ/MI
        d7AD4D/pb+uJyc/mYWlyAUs=
X-Google-Smtp-Source: APXvYqyTxHpLYLeysm/HlV+n+VZ5SRSwzCKz1yAWWQvIC9Rgxe8rbSJZItE9HKUY7VwOMlezU+y7SA==
X-Received: by 2002:a1c:14:: with SMTP id 20mr7358086wma.66.1554465067303;
        Fri, 05 Apr 2019 04:51:07 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:06 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 11/20] ASoC: mpc5200_dma: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:01 +0300
Message-Id: <20190405115010.28838-12-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc5200_dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index c1a4544eb16b..4396442c2fdd 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,10 +1,10 @@
-/*
- * Freescale MPC5200 PSC DMA
- * ALSA SoC Platform driver
- *
- * Copyright (C) 2008 Secret Lab Technologies Ltd.
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- */
+// SPDX-License-Identifier: GPL
+//
+// Freescale MPC5200 PSC DMA
+// ALSA SoC Platform driver
+//
+// Copyright (C) 2008 Secret Lab Technologies Ltd.
+// Copyright (C) 2009 Jon Smirl, Digispeaker
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

