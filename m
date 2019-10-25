Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42984CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1626721D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cq8aDaHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504515AbfJYMlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:24 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36458 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440319AbfJYMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:16 -0400
Received: by mail-lf1-f50.google.com with SMTP id u16so1633018lfq.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UPJXileKtzgNTX19jaGjS3nvxXYAz4iWZyHIwwRbB8=;
        b=Cq8aDaHNDK2pJ1hz7Tm4r3n2o5xKlVmsy5GVlKTo3nhYXsZFH8YrV9Pe0Z4gso0sNE
         DoDf8PAe7XRAbnp8l7UsufUz5Ne84tTPq53S5Z/aGPYt2iQxgTFPztZHZWQk+5WoKfc6
         7Mv87tKK6TT/Y3EJlKu0GasI85IN6R0054Er8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UPJXileKtzgNTX19jaGjS3nvxXYAz4iWZyHIwwRbB8=;
        b=YdD5Vs8+2meg2Ljsbdphmo54bmimyzGHxdXJsPPQyAbKXuNJkGL6A4f5E/OL9b+ny/
         VNtGKVeUMVAsTtL8pGDtvg6TFsQvBx4+0hMFi/UXfyh+q/MHBFb5nam2CYSkrJvt4G10
         WF2ltvfaMIKH0O7oCncjv5HCfPukadBNGFF9c8iYCX+mLO0yC6U4GmIZCwOOWP6L/2n9
         apzxIPepVDWNM6HUaHSOWOAQUPJZMqvIXKDVm5rxL+viDqa6ZO/j/APjGyg65tpRVoIh
         Z1JRNv91soHRfX6aQ1RTCxs5DtKUPjlhx7h7eo5jIzHnlFgiFHhMVzmrvhY5ZwR6PHrR
         7pOw==
X-Gm-Message-State: APjAAAXtQ8okeLpDtOmoOAxMifNc+WZF+pisGqV3Nu8s4FbLi5FYEvw9
        RcLrj/+SLdmhwlFrg8Dr+rfDrw==
X-Google-Smtp-Source: APXvYqwHXocQXaraXBs+SE4Qhjblpr6C5oHh7mfzGWp34LGpet8GNLf0m9E8p9RMgjBLdwcqkBBDTw==
X-Received: by 2002:a19:655b:: with SMTP id c27mr2621651lfj.122.1572007273137;
        Fri, 25 Oct 2019 05:41:13 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:12 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 08/23] soc: fsl: qe: drop unneeded #includes
Date:   Fri, 25 Oct 2019 14:40:43 +0200
Message-Id: <20191025124058.22580-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
index 0ddf83d8e3ce..48051a684458 100644
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
index 776a2c9361e1..93ba17d250a3 100644
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

