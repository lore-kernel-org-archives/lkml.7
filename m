Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06BF2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hdFnDRJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfKAMma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:30 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39742 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbfKAMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:27 -0400
Received: by mail-lf1-f54.google.com with SMTP id 195so7122912lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=hdFnDRJdcgxhAccXp9uTboOxUbnJlSp0zSK/9NqGvvlqPrlSUt3SotDrKCgDfJ0z2g
         WZTvLP0QqJd7fWxqqZ488553cVAWmEXlpLcD8q/rA8qfW1cUKsdN1uJRZkHMMx/WqkIZ
         R4gwq+nWPpPxEACNFxX3JjQO2ml1dZnp0M0Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=A3mXYGNwunU9Uoz1uon4sjKdFrQOeKgEJJRm5TJ8Db0O7+yCG95ebjFiQGMybeXKYv
         X3tnlwug1cbnp4HLYBi2YVmzjy7ijb9fSey3qAHYjPGagMJFNeWngLhrseieo/kiJGj1
         kjzX17z2na2BMoq2+UbkSL2u+CBYE9blbRJ/5yYn4MB7KYx8vd4VFCc6ehBE0aHiPMv1
         ytT2ww345g7NXDT/1hJB/ZoiFjZVO16hn7D2zLgI/X/Q8rThy5K5+KqpYg+yN1PNjpEL
         94IngLzDdD4V55bF545RUXgtI4HhuAXkWUZWWxRMUF2GvR7cOrQns9r/wzZhGyzrlncF
         cQvw==
X-Gm-Message-State: APjAAAXZub7d9Twoi2/cQz3VV9kqIj/oK4gs6NeTkQtGCsn4UQU9VM5P
        8mbzxSLPYFMFjnW+XnxBVZE4RA==
X-Google-Smtp-Source: APXvYqz+D19y23LVE0Y+cV1TdLje+zl11XW4b/kvCYTngov3WvPxQrsppRZFBETw4cxKCzrx/qrcdg==
X-Received: by 2002:ac2:5bc2:: with SMTP id u2mr7138805lfn.173.1572612145317;
        Fri, 01 Nov 2019 05:42:25 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 08/36] soc: fsl: qe: drop unneeded #includes
Date:   Fri,  1 Nov 2019 13:41:42 +0100
Message-Id: <20191101124210.14510-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
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

