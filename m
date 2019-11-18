Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Kp/2Qrl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKRLXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:23:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39900 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfKRLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so18972420wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=Kp/2Qrl0WogI3QIBxtJTW5MJVHIbq/2uw1JW8ScQJeaJ4OyPwesWLCJi7WSHLKMmD0
         ZXE7qjL8rxpVre74lQfEWFzbu1zCpKehD8HpFh675ZEG0kVNRIqqLtrZM8vEXIU8L5go
         kKVx8nM77mj5guxSm2VdPkZruIH3Hcra9EFNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyeKnOkwmKeZFZzRl62UDL9FeDrPQAcAwjRLFXYmB4s=;
        b=YuZDaNa4QtIKUc+9fQAtCJQ5swtq8y1BEzWBAB0y76ATuyfffUyhLW6fFASSFhQ1IY
         fx/7VP1FqLO8dhFTZOOkEvPygTH/Oy/7bvL/BaVyqBncPZt734IVOQJYzEciA8PzxK7O
         1ynSSFRarMOniEd0muD65L2Pg6xyc0yGSXs3+GnF+t2lX5e8H/J2mZnr5NmfJ3DaXzAk
         fyW3Te8S2lsKf48JwSmO8NaGTIQKZ9fQPp3QXymTsL5uPcT8JVvCzKtfRkzvFQ/YIMSt
         w0a0JAxR64Y3UL/M5SgOoPHFFZjpbBY08h1EfW2j5mRx2BLVmNkvi58zInCr/8mtKNvE
         b5Dw==
X-Gm-Message-State: APjAAAWkHAHo5cKqbsq6+eIVMm3FaI22poWic8qvz9NP45SidNDgq4DP
        eckmC0NsLrxTb/+I107nxcXwRw==
X-Google-Smtp-Source: APXvYqzaBJa2z4p/MIy/XkJ1yYVw9Z/Old2wqWcOIlNDO2iI1uAYS9WoVgZQiK8eXdVFkYWSnSXLBQ==
X-Received: by 2002:adf:d091:: with SMTP id y17mr30842193wrh.182.1574076220773;
        Mon, 18 Nov 2019 03:23:40 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:40 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 08/48] soc: fsl: qe: drop unneeded #includes
Date:   Mon, 18 Nov 2019 12:22:44 +0100
Message-Id: <20191118112324.22725-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

