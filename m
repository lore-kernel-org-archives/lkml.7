Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E516AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86612087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne6EsUxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfDTGZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 02:25:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39297 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 02:25:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so1697177plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5eYjgAsBC3XqXGX80qARfYHiQGGMVO10Cq/0ayGDIfs=;
        b=ne6EsUxiM7fm/3b/4dYw+d6V6DwS2tpgfq4ZZSDKIHIfCm44QqiUcT00uD0UCKgPFM
         LWF40vMvQlz7h/f1QojDIWXlQ3oUx+KzNnY8gpquuA55K6Mn0SxZqC11FxvEpJlbTTQ1
         8poXz8ty1fvBbTHBFiUGAG9O0cJURRmfgXytanzZQHgS8JNuZgCBG1wH2m5Pbm/eISAZ
         yI1SSMnL60wtT/i8xzNcjTe5ZPNTsS7MsUI/oXQ9iiGmTBa3GOD3mGp95ygbxCf09p9O
         rUeSfWlJj/MWcV7v26lTUPCSs1us/mqXPoTHUhoFB4k9gLnXmRDD0r1xCq839Y5B1371
         jBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5eYjgAsBC3XqXGX80qARfYHiQGGMVO10Cq/0ayGDIfs=;
        b=uR2GmTLlFR7X5V191Fc7wkvJsqr8OaHe7X1s2CGGIk2UhcL0kC7Z0FUyoCQaL0XiQE
         y+bMs5vqeEmkbpp/sNd8yrhjd7+hryShWFZAWr0v9yhtuHv5EqvitTiPm0BIx+/fXbaW
         75Cz8UuKeLDAc7RSkzsazPldmKrTMNlkfAKheacjxjc9erpU3gfkG508vGCjxT7C3Lg3
         wuXLhAkxEKA5j3zLnF4zDukCy3bw3LccpOtSUs8KGmEqHyFKmuJwPjJHzFadeJNgbU6N
         5h9WGrz8mN9K7YA48kFhOdYvT4w7XBGQ2V4oeCjPboAqtyex3UdFEMzhZSAeM8f/Jqco
         ZTQg==
X-Gm-Message-State: APjAAAXAMELuyp9dnmmcLWFiIXSOU811S/dWxQ6Q87aPcd8j9+7aiB+5
        7SVYkl9fDOHUFTE9410i/JY=
X-Google-Smtp-Source: APXvYqwYXWjwEeL74s34QIJPBa9twjTwO+BFQVlSSpneIbbV0izI58sdWpfAWIkp+n7ONnxERSNqMw==
X-Received: by 2002:a17:902:ba85:: with SMTP id k5mr8017579pls.270.1555741517795;
        Fri, 19 Apr 2019 23:25:17 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id n1sm6657877pgv.19.2019.04.19.23.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 23:25:17 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, yangbo.lu@nxp.com, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, arnd@arndb.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: fsl-dpaa2: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 06:24:36 +0000
Message-Id: <20190420062436.20255-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/fsl-dpaa2/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 991e154c0eca..b7852f49b4fb 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -5,7 +5,7 @@
 config FSL_DPAA2
 	bool "Freescale DPAA2 devices"
 	depends on FSL_MC_BUS
-	---help---
+	help
 	  Build drivers for Freescale DataPath Acceleration
 	  Architecture (DPAA2) family of SoCs.
 
@@ -13,6 +13,6 @@ config FSL_DPAA2_ETHSW
 	tristate "Freescale DPAA2 Ethernet Switch"
 	depends on FSL_DPAA2
 	depends on NET_SWITCHDEV
-	---help---
+	help
 	Driver for Freescale DPAA2 Ethernet Switch. Select
 	BRIDGE to have support for bridge tools.
-- 
2.11.0

