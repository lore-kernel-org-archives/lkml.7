Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ABC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1946121774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JUkF75FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfK1O5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:22 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:46752 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfK1O5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:17 -0500
Received: by mail-lf1-f52.google.com with SMTP id a17so20227454lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXPzWknvtf1pDS1t76ZMANmjBtlZNvhUYw0OaWSIA20=;
        b=JUkF75FCh3SS07DeV3fSdqHyMI/Noh9EyvHdbsMNF6gQ0gGlp80jLfFxeX5U7w9iWp
         qY3MwCyviAbjbvRjY8oH6xW8sFkuBc465mR7Q1nmPaV4vOaw1LqOqqMPDydkNzl6T+Hq
         6UDPgI9Fm9lhOr330fEtxCEBERw0sZ8tCYKpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXPzWknvtf1pDS1t76ZMANmjBtlZNvhUYw0OaWSIA20=;
        b=WImQuiceX4sfLfDLL3poZ8qk0nNVdcy80j3eHd6Ke8LVoEeegLZ4xpOv9IXXdK9pPi
         9oYimpKM12Z8klN/s6hTq3VTpZW94/lddeejuQtE/yOJ5o2cejOKZEyJ9nz5EM0NGYQs
         tg+SDOaMKXUhRS2fszUe2V9Kdwsdw0jq681XaDZwMqhxpFpfnzV4ypuuagyE8gpR1VIP
         pJPlDeDgpuLK72dSgYtKFenAu2LC/VZAwN5F4hKAAsiYZ/U7uVOsbCkw9O5aJ3Xc8Hya
         cnlhqZ7SlJYdY6ZIrVeTTk6I7MmQ3liyabcvN7T+dFAeAdTfQ0b5ckXNluLbfAKpd49L
         D1yQ==
X-Gm-Message-State: APjAAAX9/Y6b3JCZq8o608vHcMPWhHVBTMVjmvR790Jk5LVU9ZEuI3kQ
        tWtOl6biqPayg8iscmXhFf5UKIqOAs2Tc7Jk
X-Google-Smtp-Source: APXvYqxqB79nXhmI19iqDCVPIpR55JcddF3Aak40y+BalSCh6gCZDPNp6IH1GtPhmKlUHBIQYWbqCw==
X-Received: by 2002:ac2:5931:: with SMTP id v17mr5144854lfi.166.1574953035248;
        Thu, 28 Nov 2019 06:57:15 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 08/49] soc: fsl: qe: drop unneeded #includes
Date:   Thu, 28 Nov 2019 15:55:13 +0100
Message-Id: <20191128145554.1297-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These includes are not actually needed, and asm/rheap.h and
sysdev/fsl_soc.h are PPC-specific, hence prevent compiling QE for
other architectures.

Reviewed-by: Timur Tabi <timur@kernel.org>
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

