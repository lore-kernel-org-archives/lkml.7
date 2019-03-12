Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749662148D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kri4cLDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCLDSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:18:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43772 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfCLDSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:18:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so682041pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wvA9T6/TnDxr0fiOhfgtvIIsBWhGjtxR6aGzmCB5ohY=;
        b=kri4cLDWCODzwGPUwbtY9Xa2KfDEeQR53bKqNWFkCSE9yvfKOovBO5dDoGr50D6EPc
         z51hq3TUHsPphx5Gz/D0Py9VPmbwfog+VQes5CroS6Fh4QLdt1uEqtXGBLzsV89oKjvI
         V+zAGjSTiMHyXxa2jpHwu9YzB5ZhpQKUYxhy7y10lwRtlQClHuOOGmb1hQT5qr57vSpr
         xJ3UyHpB/6RTKhoHQ/4COKPRttKZ+KyUyXl3O4Fo/hAn334ewaAqBb8dX0VQgDL3q+rS
         mvRFI7/eD6mQJbr3h/+yw3llnqiURkYLs7o0LaGR7pgTr9/QgxzvpNLwARoUemo7kSHb
         DEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wvA9T6/TnDxr0fiOhfgtvIIsBWhGjtxR6aGzmCB5ohY=;
        b=KPvurNniW2thy43EiuterngbIX2OfJBT5SwL9bBF8wEjUa7lQs8/nhfUQtxeO4DOYj
         w4iEsi0Lk4qELFSkTYBWdOflzoHMBCFnvbnjnKlYPsLMlC1ZKrs2ymPA2i9vyvqnzA8b
         l7+TwPSV3GxFhI1bpQL2jYYJMiIic4AVkrDHZs5R9IHLaeKJDblkLlj+aQqs3c9O7R1e
         09C1SLg6AAMzfNtcnNUjvAqdWvpLFA1tMt2cUbLHgALbOk2VFKFybznDWCAVLtfJbRHX
         FbJBf6i6BE74C7NpZvbSQCWV8DsmyJCn7iiSHDRuNX1oyGxUzJfvDw9dRS6r5uy5zCKY
         SZGg==
X-Gm-Message-State: APjAAAVBB1SeBmeCNIy5m++7nXs/jBEWbezPFApUMr+WQkSbybHosn0e
        Wvd8SfTAmhwKUcF7ZPxVF1I=
X-Google-Smtp-Source: APXvYqzn7QIkcHg3lI8BqigZNhUFyVgzsvLqx1PMjinIeLexhzcz3868YdO2UcFDD8pM+n2wr7DnvQ==
X-Received: by 2002:a63:6985:: with SMTP id e127mr33231054pgc.101.1552360687866;
        Mon, 11 Mar 2019 20:18:07 -0700 (PDT)
Received: from ubuntu14_04.bitmain.com (61-220-100-83.HINET-IP.hinet.net. [61.220.100.83])
        by smtp.gmail.com with ESMTPSA id l12sm16255575pgn.83.2019.03.11.20.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 20:18:07 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 1/1] initrd: move initrd_start calculate within linear mapping range check
Date:   Tue, 12 Mar 2019 11:17:20 +0800
Message-Id: <20190312031720.6263-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the previous case, initrd_start and initrd_end can be successfully
returned even (base < memblock_start_of_DRAM()) or (base + size >
memblock_start_of_DRAM() + linear_region_size).

That means even linear mapping range check fail for initrd_start and
initrd_end, it still can get virtual address. Here we put
initrd_start/initrd_end to be calculated only when linear mapping check
pass.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 arch/arm64/mm/init.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..1adf418de685 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -425,6 +425,9 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+			/* the generic initrd code expects virtual addresses */
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = initrd_start + phys_initrd_size;
 		}
 	}
 
@@ -450,11 +453,6 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(phys_initrd_start);
-		initrd_end = initrd_start + phys_initrd_size;
-	}
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1

