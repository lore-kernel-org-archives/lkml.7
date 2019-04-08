Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C51BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC752087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei5RSYQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfDHQdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:33:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:33:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so7936358pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=adM7GO+50iuUmAcUxnBbVrKSbGKte77qypSkx5gSfhY=;
        b=Ei5RSYQFkvcE01miYVzVojPZwxiN2U9LXOt1q9JVINBVwt5R8GaU1JFRkrhb4RBnSP
         nqUEBJyAVk+Z6bVI1gmnTVL3qXSJedH44vnn4Qt+nMNfaRWpXCzaazPt9xdYO44fmzCq
         PtP2llahNxeiZPDqI48SUV7FCmTIqs809723EWpkg0tGvRz8RcXsRBTGbCuf0zDktVPD
         j18PFWJWxH6mCipz5CLiR6kcPQv620qrDK1hJcMkR40ZrryDCjCLB3rCU81/Aq38xzZN
         /zEZ00Wu7Mm6GHv8vEyXSVGUnsgxKA4hXYxCXPwtsHzssk1+7+vdjuF2ehZKiAckSwTR
         nsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=adM7GO+50iuUmAcUxnBbVrKSbGKte77qypSkx5gSfhY=;
        b=qtsTR+IqXow055Pi8rk672yICG1Fhz4NiJZntCyGD10oSlXriWlc21NoJxAnbKvO+e
         iFq/Wi0JvmwlAfrOnKNpfm3lZXAtRUTPy4wDDk3wzsK0p8pIdZ+cZZc1WemdjGjOSKmb
         MCYJUnXwQLflMD/VfFCdt29PO045fUIrLf939UHLpw4jnitIPUC66B8PliRRJp5A4YjE
         6nvruDBqJR/xYGoONAIu7e6GqvVYCwfZ6zn4nRdZT4FJR20fGb7NKs+5OYBE2iZA2jZ2
         ekxCTpzgIXpa4m82w8e7al0nQcZVNokPnxn75Kv8mjGw4sDTRGc8xISlG5kNTyAtByRR
         bNZQ==
X-Gm-Message-State: APjAAAUzUj5b2Uws+qO1JBuYIIqnbvztv6uzlfaFTeTeYKOMdSB1Gng4
        7KDvkvhkOoER80cy0585o+EaLF/0zZo=
X-Google-Smtp-Source: APXvYqxho0IpZwRA9Y5E/1foJWx2ZKY2a26+T3ucHduOhyin2w+5vx2twZyiFxTBcpUZXzuwLTbD+Q==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr31269768pfd.164.1554741217261;
        Mon, 08 Apr 2019 09:33:37 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a7-6c70-b197-cec7-ec88-495a.emome-ip6.hinet.net. [2001:b400:e3a7:6c70:b197:cec7:ec88:495a])
        by smtp.gmail.com with ESMTPSA id 143sm62117103pge.50.2019.04.08.09.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:33:36 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     will.deacon@arm.com
Cc:     catalin.marinas@arm.com, steven.price@arm.com,
        f.fainelli@gmail.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vichy.kuo@gmail.com
Subject: [PATCH v3 1/2] kaslr: shift linear region randomization ahead of memory_limit
Date:   Tue,  9 Apr 2019 00:33:18 +0800
Message-Id: <20190408163319.10382-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following is schematic diagram of the program before and after the
modification.

Before:
if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)
if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*

After:
if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*
if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)

After grouping modification of memstart_address by moving linear region
randomization ahead of memory_init, driver can safely using macro,
__phys_to_virt, in (b) or (c), if necessary.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
Changes in v2:
- add Fixes tag

Changes in v3:
- adding patch of shifting linear region randomization ahead of
 memory_limit

 arch/arm64/mm/init.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..5142020fc146 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -389,6 +389,23 @@ void __init arm64_memblock_init(void)
 		memblock_remove(0, memstart_addr);
 	}
 
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern u16 memstart_offset_seed;
+		u64 range = linear_region_size -
+			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+
+		/*
+		 * If the size of the linear region exceeds, by a sufficient
+		 * margin, the size of the region that the available physical
+		 * memory spans, randomize the linear region as well.
+		 */
+		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
+			range /= ARM64_MEMSTART_ALIGN;
+			memstart_addr -= ARM64_MEMSTART_ALIGN *
+					 ((range * memstart_offset_seed) >> 16);
+		}
+	}
+
 	/*
 	 * Apply the memory limit if it was set. Since the kernel may be loaded
 	 * high up in memory, add back the kernel region that must be accessible
@@ -428,22 +445,6 @@ void __init arm64_memblock_init(void)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		extern u16 memstart_offset_seed;
-		u64 range = linear_region_size -
-			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
-
-		/*
-		 * If the size of the linear region exceeds, by a sufficient
-		 * margin, the size of the region that the available physical
-		 * memory spans, randomize the linear region as well.
-		 */
-		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-			range /= ARM64_MEMSTART_ALIGN;
-			memstart_addr -= ARM64_MEMSTART_ALIGN *
-					 ((range * memstart_offset_seed) >> 16);
-		}
-	}
 
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
-- 
2.17.1

