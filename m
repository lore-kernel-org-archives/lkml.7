Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C195BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917B32087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDLDNyQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfC0BvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:51:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56117 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbfC0BvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:51:05 -0400
Received: by mail-it1-f195.google.com with SMTP id z126so22930259itd.5;
        Tue, 26 Mar 2019 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QSaziYjkmv23ZIocqo6YaM3iWHVUdwZxhQSM3dO/v4=;
        b=dDLDNyQyBUVfcdVQ/KkVim18X7Bi3NJNtTmtH1VWvtumD4tk6CCvpqAw16k5DaFRID
         1QZKEE/pGz7JDfNgXG3vKUwQWGjfDPGh57yUbIrR7g/Tf5JtFXL6zO7FW+69Qj7GyTa5
         LIvcxrrgRa9v/DAjrQP/OeXiwcgYnbceWocpdcOLURJBmS1V1fbfQpJasY5fN5w7XNdl
         Jk69+7doqQebaqk/HbEna6BpADnK9lCjodUo64WcbVEhKT/HrNLYVn8or4oJNC8emLZc
         qJkFxCCZKHm4Zsp01u3KB0V00s3eqSt/AmE/i2be9Lar+on92nmzj4VqObE4Ulp0HD8O
         bEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QSaziYjkmv23ZIocqo6YaM3iWHVUdwZxhQSM3dO/v4=;
        b=YS9GiohToSAoW6b/zzYSG/YbVUVqS0r4RkeZ3ttPTPQ4iCVtHaF3NpRzXtdHGX5PrD
         eFtrDbuKzhLineoKCpDDgP5CJ3l/TXQCs5J1QvbKvcwBl2Bw3sd0hDh9v2dGgx7aSNpL
         HDKz1ITk/JR7gxKJ4KGxN8ZExbmF6+YHtMjNmgdAQMudqV8sB6wLytf57qWW+x4ks6ag
         bICJ92cZNaeclFhVcGifv2aIg5HcJboutR1sUc0dzfmkKKCv7bvaSEC9CJkk3Ff58AIo
         ZdNCtmtFD3El3rOkehxe+2TfAIK94OrEjIfrqtTaYnPcRHqMsi60bIsUyr+Yyt5KgMYm
         TJ2w==
X-Gm-Message-State: APjAAAXYIRoAHKTTwGlbXP6o5i/uEYv0Uz5Gq8Boxpwc89toqUUpIgbQ
        2LLrSxE2/ApQRaI911Hoodo=
X-Google-Smtp-Source: APXvYqxtISPv53sdT40H/+S5yVKZjgiPogMq/sltWCMrLw6uBCVGRUDqecXzuoWDmxh6fdvYhgJOig==
X-Received: by 2002:a02:a50a:: with SMTP id e10mr26166581jam.104.1553651465007;
        Tue, 26 Mar 2019 18:51:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id e27sm4550040ioc.14.2019.03.26.18.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:51:04 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v5 1/2] staging: mt7621-mmc: Remove obsolete Kconfig flags
Date:   Tue, 26 Mar 2019 19:50:56 -0600
Message-Id: <20190327015057.9568-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327015057.9568-1-thirtythreeforty@gmail.com>
References: <20190327015057.9568-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values are not referred to anywhere else in the kernel. Card
detect is controlled by the device tree property "mediatek,cd-poll",
and there is no driver support for eMMC whatsoever.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v2: Rewrite of v1
v3: [Not present]
v4: Resubmit of v2
v5: No change from v4

 drivers/staging/mt7621-mmc/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/Kconfig b/drivers/staging/mt7621-mmc/Kconfig
index 1eb79cd6e22f..01f231dd8511 100644
--- a/drivers/staging/mt7621-mmc/Kconfig
+++ b/drivers/staging/mt7621-mmc/Kconfig
@@ -6,11 +6,3 @@ config MTK_AEE_KDUMP
 	bool "MTK AEE KDUMP"
 	depends on MTK_MMC
 
-config MTK_MMC_CD_POLL
-	bool "Card Detect with Polling"
-	depends on MTK_MMC
-
-config MTK_MMC_EMMC_8BIT
-	bool "eMMC 8-bit support"
-	depends on MTK_MMC && RALINK_MT7628
-
-- 
2.21.0

