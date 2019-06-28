Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8071208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="F96K1IIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1OEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:04:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34194 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfF1OEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:04:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so6417000qtu.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TtCBV3dv3lEbG+/Fl3MOz0T0TVohkkYJU98cwcixuvQ=;
        b=F96K1IICnsJfZn53/kwRm1vvbIo7q8vJIYhCCu2yi2d30Eq+0mjKuqbd4a8FDTuvtV
         Negyxz/Lb1dJrZQ7AAw0xmX7Szb810eOW9PgnsFaT00jtGVSWVOam+Vpbj7Edt5/DiID
         9R0oQr9sCrD9pG+tjppcckcdPjmzzRJ3lto2wfwQ60IZgRubQVkPdfG6DOOm17g1lQ31
         OXBSXrpHLdn1O9afeOR5WUWH0EuLf1p3tHqhFqYev/WEDtHJm0lEUXzATje+mVMuk/AB
         8d81bjziN1zLAPVYsOQP5KS/2Vwk3aiau8NcU84Evk+E1FljELYSd7N09bKp796Na0c0
         /5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TtCBV3dv3lEbG+/Fl3MOz0T0TVohkkYJU98cwcixuvQ=;
        b=GRwYA1BxYXtS4YV+DddKo1G4KOxu/QGKQXKKc6d9z/uCuMRBap+LGTQJQnv2TEIhjf
         Trh/9PKaDHc9J5X9ENxMovmmstX6x0r6VanVHeLLQ2l4b/TC+R0bQ94HxnTif6CZ+PhC
         ubu5xNvOzdJBc9PMMpqdcZoq1LhCwA1nStoYUifXz8/1fDYLzaXBhk3k3i+DxKqhag+N
         YnTd+GfkPNaMkUwAyNwSGTTCprHhpVe/fNPanjmqafEiyrxHAKT4syha1vf5fEuD/sAa
         zyUayda9yHERxGkJk1FTsRj8pzZQigSKDdZqbxigouBO8WMx8ZT8gyyWgpUA2N8klcpL
         rNiQ==
X-Gm-Message-State: APjAAAX1z0J9bOko+ScOflXIFiBABZMU9+YKmqYodiSScJJcw95Cg//U
        bzwfOh6QXhUXbmiKzcBz8t7O0g==
X-Google-Smtp-Source: APXvYqyjeSciFcaL48I+xGOjSfb9/Tjy2YGnp7YoXOFLumU17Q7I47Wu9sCEP5Uc0iMXMHLJZ6pNyA==
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr8442028qth.136.1561730644147;
        Fri, 28 Jun 2019 07:04:04 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 139sm1076137qkg.127.2019.06.28.07.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 07:04:03 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] powerpc/setup_64: fix -Wempty-body warnings
Date:   Fri, 28 Jun 2019 10:03:49 -0400
Message-Id: <1561730629-5025-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of setup_64.c, it has,

  #ifdef DEBUG
  #define DBG(fmt...) udbg_printf(fmt)
  #else
  #define DBG(fmt...)
  #endif

where DBG() could be compiled away, and generate warnings,

arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find dcache properties !\n");
                                                 ^
arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find icache properties !\n");

Fix it by using the no_printk() macro, and make sure that format and
argument are always verified by the compiler.

Suggested-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Use no_printk() macro, and make sure that format and argument are always
    verified by the compiler using a more generic form ##__VA_ARGS__ per Joe.

v2: Fix it by using a NOP while loop per Tyrel.

 arch/powerpc/kernel/setup_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..cea933a43f0a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,9 +69,9 @@
 #include "setup.h"
 
 #ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG(fmt, ...) udbg_printf(fmt, ##__VA_ARGS__)
 #else
-#define DBG(fmt...)
+#define DBG(fmt, ...) no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 int spinning_secondaries;
-- 
1.8.3.1

