Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAC5FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532D9206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AWL4Blnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKHNE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:04:26 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34404 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKHNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:41 -0500
Received: by mail-lj1-f172.google.com with SMTP id 139so6136180ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=AWL4BlnxggywgAuCQF9TZmvfyD1xgx+d4KcuFAXs5z0SjvgeOT8ufhw+0kLd6irh+k
         LWFYtzapxaTuBh/+hzavZstnGb4XF7eUmqtgUl25ZK4pjgZG3d9UIH1hjWv04ZBgdYit
         n1G4bDAqkSP9msbsWTTT49q+Qpi/lQ/IdwTJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=ciHHfZOA1RpeVeDqOato96oA5WjhBJtVeP7pE3rJjUHoJbUeYWX4bhEak1wojLyJka
         JHNqtEmx+Tq313Uor3kpyQ/+ueN5qatmD06aFYOmaFLop2BO4pUIiY19DYGdJrxvDZG0
         x1qBpVcOPP+wdhMDAtH5NzaRUYHpN4PgU2XieGhl+azHEscqsF0JdefrQDGPd4UfqAG+
         HT3Etzb33yBfAv+W5/T4cpZt41inlvdnQwdapqXpqWtluW2dS4+ATs3MpoD4D2BZP+m5
         FMoGsCZpqMg0ec6e7N6U1wchD4kNZSxv7KVRAd4bCBdMBo7z+IBUuZLBP0PJPbPUACDw
         Q2cw==
X-Gm-Message-State: APjAAAWEc8kAaFQzcW8wttFaXNSAgJJNbxFhtr8g54LI9vfI0Pmso4sC
        T8jhwy3AC3rVgvxPG8RGEO5P5A==
X-Google-Smtp-Source: APXvYqxxzgl3V5o2TwDPF+SxfEJQQMlY/U/MArtCXbnEjF83JFE0HGJ+v+jIFpYrTXQzamx1BSnEhw==
X-Received: by 2002:a2e:558:: with SMTP id 85mr6764276ljf.67.1573218098161;
        Fri, 08 Nov 2019 05:01:38 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:37 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 08/47] soc: fsl: qe: drop unneeded #includes
Date:   Fri,  8 Nov 2019 14:00:44 +0100
Message-Id: <20191108130123.6839-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These includes are not actually needed, and asm/rheap.h and
sysdev/fsl_soc.h are PPC-specific, hence prevent compiling QE for
other architectures.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c    | 5 -----
 drivers/soc/fsl/qe/qe_io.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 1d8aa62c7ddf..a4763282ea68 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -26,13 +26,8 @@
 #include <linux/crc32.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
-#include <asm/irq.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
-#include <asm/prom.h>
-#include <asm/rheap.h>
 
 static void qe_snums_init(void);
 static int qe_sdma_init(void);
diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 5e3471ac09dd..f6b10f38b2f4 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -18,8 +18,6 @@
 
 #include <asm/io.h>
 #include <soc/fsl/qe/qe.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_soc.h>
 
 #undef DEBUG
 
-- 
2.23.0

