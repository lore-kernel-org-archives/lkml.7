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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E062DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F1721924
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHTVfm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfDELvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37796 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbfDELv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so7657253wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxBrociOZFoM+5+G6/1SJONXjwRav3ZwO+z6b4WcMWY=;
        b=ODHTVfm8phZ6v28JJZiATVCm9BSw0H0lhSWvNOSudoXCOldCxzzbibC7riYnccRfOx
         RUmAOj8XWobuMfVfNu+o1LT7G5kcuRi5SEHBUbqgiVCguYODXgH+BTpXTx5sWl4W/L6j
         DzAZwmjJ1P8fHQPAC7xwP/tCKmxv6lFvHuYPCwTgZYsQGM6gxpcUiB33lOIQC/aAUb66
         Z+KHEOQ2JOYGAwQgwP2thPWZOt2y6ha3BcDvkGNzBEvZR32hamtiT8voNV5VGN360Uft
         tnJ/aZqC1WQQpTUuQwB+6UwLLwX3Vziy3uzKgejwjnH1bzwBUJlNiYx6WEaly7n6Nx3G
         h+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxBrociOZFoM+5+G6/1SJONXjwRav3ZwO+z6b4WcMWY=;
        b=gAv4ESthIBc7XQnCsJ9dTRAtIl87Yy8Fu/3XQTXV0ImkDlUmANG1rwE1OlnJDu49o7
         c2DmbZry+Bk6fKEbDaOJp+Q9eQC+eu38rRrUuPrvoLAt6iqGw71jcyYWU0UUNDIdc8EW
         IHy3PxfaRUmuQO2GimFB3rTZ+KZwDBW5L8r9iMHv+o/l7+PZI5RLhkMUnAwtYQ+lcpPT
         la+M77UgAOf6zv4KBM98drVlH6KlOoBqHMV62v+wDLnpxnhHLE93Fij9hDr34ALX2NPH
         goP4JiQxIyjeghfKsLnekMJ1ZJpH5duyTpGEnpa0i4DDXPYXUAf6aoqfB6IHx/5J/mFt
         z76A==
X-Gm-Message-State: APjAAAUajhomVBLEX0wPENdG0LsDQ0isL0x6KvobX9qrSlMkkCMeD9Ai
        98gwAtMNPSkVpIyHvjAaF7w=
X-Google-Smtp-Source: APXvYqxTRIMzJY6NWNsw0vEX//ook9rzUfILFZxglnXL9GEtBRN5aVlR1vCok6kytBZ+7Y8AH4IaAA==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr5474588wrw.103.1554465087193;
        Fri, 05 Apr 2019 04:51:27 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:26 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 19/20] ASoC: phycore-ac97: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:09 +0300
Message-Id: <20190405115010.28838-20-andradanciu1997@gmail.com>
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
 sound/soc/fsl/phycore-ac97.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index 66fb6c4614d2..fe7ba6db7c96 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -1,14 +1,8 @@
-/*
- * phycore-ac97.c  --  SoC audio for imx_phycore in AC97 mode
- *
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
+// phycore-ac97.c  --  SoC audio for imx_phycore in AC97 mode
+//
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

