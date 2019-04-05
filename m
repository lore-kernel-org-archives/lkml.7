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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D558C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49899218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWOBojNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfDELvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38700 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfDELvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so7650922wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BeL1g4bbVVRk0NSIcnI5lqtabiN5icdMHgTYrfaRgdc=;
        b=MWOBojNRBOQnXZn9gwu5L+RaMvmE5KeVWfJW+4FgzUoO5SFHtiVo8GetomTjphJXe/
         e2j7Qo01PUgu4WdtI4yVpRfaEMfSJnWiWZpVLBwXP7uA6NoR5xvq2uV+9hxbnfmRRwdV
         dfvhzDlTzh9wn5cn3YY/+CUwHBSTN+HdoFRA1XXEbbKBZ8DAYjS8eQt9E+xo82HGEV2v
         H37yqLNIP8r3CvRkQtYxoUhsVYysXnLg1Rg7FAfSB6Ukp/dpkmXcUaVfRXNmcWNx6oI9
         gC82e5675B/Jof+VQKgCSJF9B8wtoWLiNMwCsL0N6mCHTpIJXDpI6Cq+tsHDHkj8ON5M
         Vxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeL1g4bbVVRk0NSIcnI5lqtabiN5icdMHgTYrfaRgdc=;
        b=OYelYJGH4WL3nq3jgiz07lUCrPMY7vYniv2qkLOEag18+dRlRzwCy4xLe+5nPako+/
         omlCcm9hBNUyWu/pu+ynT7kuUKtw34ERcDvFDWywG1yFYKMcNDrSfuI4JBik9AqPKz5Y
         L5IBomAq9m2FKkvmMhdlkl+41UxDw5VL8XMLnLB6iuqGQmI8RLeT2+fsMULnhTMZoCQ9
         5SFQvHTFEMSQZo2wNkKu3CNlvCI936sCWc94NqzxFfFxdGx1G/Sxxaaror4R2S0LiilQ
         gOC/P8tDnNyloDd8MHrdyHPuc8ZQg82fyGA+2yBe7DGBYoBJw/2u+oAYHwhENSX8F+5C
         ZjSQ==
X-Gm-Message-State: APjAAAVtI8tp5SrmUXhKx8GfQ+AS/bUBwiJw8OCm63/PmV2xGP9r7QhA
        cpUd884qhQmkak1xPZiZaO0=
X-Google-Smtp-Source: APXvYqyELna0ZxQmwoCxXIuHdwnj0hHGcki9RhhBcD9pj35dmjw7DJaeek0IVPuiT92eBM8vhWD1uA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr8045901wrn.270.1554465062410;
        Fri, 05 Apr 2019 04:51:02 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:01 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 09/20] ASoC: imx-spdif: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:59 +0300
Message-Id: <20190405115010.28838-10-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-spdif.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 797d66e43d49..4f7f210beb18 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -1,13 +1,6 @@
-/*
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/of_platform.h>
-- 
2.11.0

