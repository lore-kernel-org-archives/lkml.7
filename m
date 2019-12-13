Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B66C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041E2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UuM2V4K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfLMAJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39189 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbfLMAJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so539306pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7LXSM1q2GY9tSqtn+1P3Di6orxqrPNEZZx+FLf5FeU=;
        b=UuM2V4K1pfhm3DU4USSJmxPPNOCK+lxHkiMUpSb/ZhQlLzq0R4BFABHvZ+PdLjTfyb
         qxyoKZjoq8n9Q06QUjkXTIhp9yDJ81x0xtkSY9l0CRvORlJrRyssr+uj7b7Lf2lnGBLa
         Scj0PJtYzKQcE1Q5M5oNnf0/A3Z9KZE4fwnfZuciBlzLoevSbVyECVWed/iifXHZgMd1
         kYr8o++3J10QLnwtZw7AGpAT6qP0lWvM7sqb7h3xGrZpwn0BocKS2i/58k2egmgcjRoh
         UofPakKvQNx2ckwQzkrTtS6UwhYVTjVxoYA2u+cRXhiOGPW2pCI9zzrvJVKN0BqicB3d
         UeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7LXSM1q2GY9tSqtn+1P3Di6orxqrPNEZZx+FLf5FeU=;
        b=pGGlBOV5JphFJ1QXgMYEbBpvXo7pKmNklobxmUfooaCLaEPoX/iiRCCxs8uBXqkyiN
         04a37bcQgiVxE5q90ZcsajivUVc13LFa7493u1V0bIqwSfDgl3P7SE2AGrhhZxgEj48y
         fBG4bzh+8SHU3s0IZ45MaASsVs62QlCrO6NomhVL5vciHEZlV53vvNnG14pkyJrO8QIK
         IdH71vafP8ZcFesVc6XpONu06Sab1vH1daWscJa1niJ0kmR/53J1rmGbsESWW5spQsES
         htf1/zdmvNfBGZf8EkBbDInyN9tRN0lGmSM0hX5miM5e+plVCfwA0it8qmO8ulmHGLNc
         Zu/g==
X-Gm-Message-State: APjAAAVeEp54Rs88GqMSigqpUscQFKUrOLWmWwKcSzZJ5pnMPRMSC1mL
        h+8q3cvAxqZslm30cHn0NTqh8k1GYd4=
X-Google-Smtp-Source: APXvYqwH5RCC62XX3IgQVMegNFg4AtfciPHDYUQDyxKRzqTXsEosb3l7xINxVKKM1VT53s02uY62cA==
X-Received: by 2002:a62:7541:: with SMTP id q62mr12790555pfc.256.1576195791806;
        Thu, 12 Dec 2019 16:09:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:51 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 53/58] tty/serial: Migrate zs to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:52 +0000
Message-Id: <20191213000657.931618-54-dima@arista.com>
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

Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/zs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e458ea2..1467952da3f6 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -44,10 +44,6 @@
  * complicated and prevents the use of some automatic modes of operation.
  */
 
-#if defined(CONFIG_SERIAL_ZS_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -1106,6 +1102,7 @@ static int __init zs_probe_sccs(void)
 			zport->scc	= &zs_sccs[chip];
 			zport->clk_mode	= 16;
 
+			uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ZS_CONSOLE);
 			uport->irq	= zs_parms.irq[chip];
 			uport->uartclk	= ZS_CLOCK;
 			uport->fifosize	= 1;
-- 
2.24.0

