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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A7FC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9621872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDFmTs46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfDELvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50478 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfDELvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so6387924wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2x51jPIH0NpTAZwd31yHCUn90dvk+fsja0ZQlVXpmSo=;
        b=nDFmTs46L0+WI6A3YT9/47BbL7eFFMUPGOridJqHcPWw7SzJkXp+Lja6JlMdsrxceP
         sNR0NtVKOyTm52rxqvnvhuB2GxwevorkKoFFLwYvr0wOHB1E2IWNesH08sT9ZM7h4ivy
         ciQwK99X6VH3MsF8YoUZDBljHIEoJaGvFwiF5vvQeaz6kZefdBbZtgeQYQKJqSnmsR1+
         3VqeXSNpBoTASHm/VY51ktLNFJHKfN47RWD3F0VnnOhK3wMBgd0mJ3gFCkQlsGcbiLbx
         nonwov5GXgpeL9rj55uyKCmDZ/HcfhLspYSseGR7/NBLQNvnPtLt9LPn1xa7bm+B6yQF
         89Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2x51jPIH0NpTAZwd31yHCUn90dvk+fsja0ZQlVXpmSo=;
        b=uSCrCVfEng2frP5tXilpeAVho7OHec3r7OcnalSrzYn/Ozwv5JBz7Gk9ddjDIPAEbq
         fLSPTJ2LlQ5rKX9Q9oqyiVc3f9WIQpgsil9L5EigZ0ljEEJ22FisyseTsVK/3QAm90nu
         iIDo/3CzJW+ZOiwUhEfhuMLro0DbEboivsLbviPbe3NgMABq+oKCe5EcZEf+3maQv6nX
         ceH7+OEuBKRpoYMjxUw//aT7VaEO3jG+TzKX4D8QkpbW2HVplsWyxnWyF9WTAHaQheCl
         LWnPMXtCMMDfzgWsqAmsBnfyuL0nQwA8Q5xEjTQlZBOs6FgyHIDLoT9CF/3A4SIq9JKx
         fY2w==
X-Gm-Message-State: APjAAAXM30QzLofQSt1EarWX/U+vsYBsPO9nGZ5cFNKlMCWhe2W28PXg
        YUoqALFkpKpSLFshrNiWHR/g26t/7Mdg+w==
X-Google-Smtp-Source: APXvYqwUdMHMsHxcn6/slTQiQuYvpjaiOMopOrkv83+I9j98fnppMMtAfD9bfMu3zYD2K0jK4Yrh9g==
X-Received: by 2002:a1c:a00a:: with SMTP id j10mr8063071wme.15.1554465077155;
        Fri, 05 Apr 2019 04:51:17 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:16 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 15/20] ASoC: mx27vis-aic32x4: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:05 +0300
Message-Id: <20190405115010.28838-16-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mx27vis-aic32x4.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index d7ec3d20065c..37a4520aef62 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -1,25 +1,10 @@
-/*
- * mx27vis-aic32x4.c
- *
- * Copyright 2011 Vista Silicon S.L.
- *
- * Author: Javier Martin <javier.martin@vista-silicon.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// mx27vis-aic32x4.c
+//
+// Copyright 2011 Vista Silicon S.L.
+//
+// Author: Javier Martin <javier.martin@vista-silicon.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

