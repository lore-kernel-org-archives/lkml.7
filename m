Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74295C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DD32253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GKyPG04u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfLMAIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37565 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfLMAII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so390429plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHHmkEl4SpR4ivIudHsXj+xUr9cWriV3GCavBgAuZTs=;
        b=GKyPG04uIaq+p8lC1GSMtA4ysgCMpPhqhJt0hRkCS/dSXJUg8Mq/cz4mYTTvt1Mj5C
         sgk4+YyllI2M1plKsEoURSfrh7o3i3E5Kw63LDCyDtZccMWS9WdoZB1JGvBOWJZhKoU3
         DPlx/tDcCQs0W37+UWQjm3Nq5jwxzCvrVMcibMJpEceROwbcd+UH/MfnXlVALblW4c8H
         n6WLjNOhznj9tYPwpVGTz3cwarLa2i/GWH1E0Tjt++KPOJQmOIRP0/w4jEFU+iSsle4C
         fKDnJwkLWGnEOSqOlBSfX+sT3oejnYLPlUhj+Uz/Z2sfdYO05PORyfLzR4apZ/PR3LPw
         pcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHHmkEl4SpR4ivIudHsXj+xUr9cWriV3GCavBgAuZTs=;
        b=ZkDAr7JR6kJpfigUDsjiJwb3fGeicUrwSAduh+2p8bjZXIIJsHYAC4X/AR+DlMxBRV
         LhOjdssGE9nkHqXk0/DAqSB8X0q2O6nD7T4qNdULplEltbiEcIddO98tWy9Xnm+yrrhh
         hcAxcgYbapd3l2v8fvjHSb3xiuP1gGBwfhQdQXANUkrZi4XtJsUvrkJeT7L9X+HpGINj
         jc4guqyPvCfx6igZUTJRgfbv2Q+sCZXi86j6p02q7WITjnd0nJDFEe5ulcrYecclWodz
         lVMe9G1/j/IFOGeR3VFPqOZGYPD5zdSY3MEuAuI+ZTUARs+WEvpYCFyWTlo+8NX/5NLY
         ODoQ==
X-Gm-Message-State: APjAAAW0PgDEYL+vS71gOgzqjyIhktQ/hFP/cv8Uvu7Wk1JDyK0b2Cbj
        mcbbR2qdn1WAhWdsPx+HGB3lNftVNUQ=
X-Google-Smtp-Source: APXvYqzpjPu4dvRRLM1GayX0PxOdEk6fFvVgEaWtqh+n01buttVx3B7NKOP7RlJqvfCFFpB1p86ulQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr13284014pjv.78.1576195686920;
        Thu, 12 Dec 2019 16:08:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 18/58] tty/serial: Migrate fsl_lpuart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:17 +0000
Message-Id: <20191213000657.931618-19-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/fsl_lpuart.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4e128d19e0ad..76c69d255d92 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -5,10 +5,6 @@
  *  Copyright 2012-2014 Freescale Semiconductor, Inc.
  */
 
-#if defined(CONFIG_SERIAL_FSL_LPUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/dma-mapping.h>
@@ -864,9 +860,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 			if (sr & UARTSR1_OR)
 				flg = TTY_OVERRUN;
 
-#ifdef SUPPORT_SYSRQ
 			sport->port.sysrq = 0;
-#endif
 		}
 
 		tty_insert_flip_char(port, rx, flg);
@@ -946,9 +940,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 			if (sr & UARTSTAT_OR)
 				flg = TTY_OVERRUN;
 
-#ifdef SUPPORT_SYSRQ
 			sport->port.sysrq = 0;
-#endif
 		}
 
 		tty_insert_flip_char(port, rx, flg);
@@ -2461,6 +2453,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->port.ops = &lpuart32_pops;
 	else
 		sport->port.ops = &lpuart_pops;
+	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LPUART_CONSOLE);
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 
 	if (lpuart_is_32(sport))
-- 
2.24.0

