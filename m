Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CDC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386322342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSOL+gON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfH3VsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44289 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfH3VsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so652960qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMUUfqR9qni5WdKHQ/oyNL+2UIChMAX4UeIkA9AQdwY=;
        b=SSOL+gON3Po0oJ1FWWKWJE4v8adc9L0tmmyq8gb22o6mW9oof0uGkwarODWjUdauXk
         iS7iqFR0IN/mVkHlsKMEhEs6bM4D60o39lWHVDI/P4fscGqOy72Qa/pymH4W4JWidSyk
         PD3eYZdl2W90J2MJGLgihT+i1t+eKPXlJXaeGZrVZ1p5GF/6rp0z/P+fLBcvKOO8IbfO
         +3/1gKa3qw69tbr+oiveMPSvxQwkZ/bHkSROHl2Y44V2acsiYLk1mp70KgxfvQhpfLag
         hsNLHzQvwK2Iri7YLGA8aJF3qU53Xz2G8PuZzUPHaKryR9ddhlhuTa4/o+2yBkOnrBxo
         XVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMUUfqR9qni5WdKHQ/oyNL+2UIChMAX4UeIkA9AQdwY=;
        b=CNBVxQ1YH6H/JFKMHCoXzHYWjpfeqMZdD0nLrhojow5uzumhG9mXr7LkRG/6sV1x2O
         Xe4TapYtPVFEI8cE8zNHY0tp4u2v/Qou4socwQsinSrf0SeNnihGItVWrv9Sryj9muXU
         lRZoxbruvICbGzDNkoKE6FtSOgeRvoS7EA2k2QLLtXRnuWRbQyW3iN5YHkQxWgdR3CRT
         2WaoB402kXigeL4Ts4OK+vPXOhk1BlvmS7p782qyx1iIogTdU4bQ6cxsQO0bXNXBzDhT
         6YPvJVaLMD60wfsHWn9Iy9xKtQRcJ3fIv83FBwkd9pOMMc7x37UlDToxjSwMZw0S70qU
         rXow==
X-Gm-Message-State: APjAAAXFNNezzy1d/W9vb2ZAyWmDJHLTtQu23Ogh7RrN3bMtHLZKFXEx
        GKLhn4IBG14rCAvswPBOQQ==
X-Google-Smtp-Source: APXvYqxheb9X3q7fxWX/eZYOC0xWA8+EeUSIaZ98LhsuxehOSb/HGH3heo2WqwM/DCQiPysK8L32YA==
X-Received: by 2002:ac8:7951:: with SMTP id r17mr318089qtt.238.1567201685629;
        Fri, 30 Aug 2019 14:48:05 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:48:05 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] x86/mm/KASLR: Adjust the padding size for the direct mapping.
Date:   Fri, 30 Aug 2019 17:47:07 -0400
Message-Id: <20190830214707.1201-6-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system sometimes crashes while memory hot-adding on KASLR
enabled system. The crash happens because the regions pointed by
kaslr_regions[].base are overwritten by the hot-added memory.

It happens because of the padding size for kaslr_regions[].base isn't
enough for the system whose physical memory layout has huge space for
memory hotplug. kaslr_regions[].base points "actual installed
memory size + padding" or higher address. So, if the "actual + padding"
is lower address than the maximum memory address, which means the memory
address reachable by memory hot-add, kaslr_regions[].base is destroyed by
the overwritten.

  address
    ^
    |------- maximum memory address (Hotplug)
    |                                    ^
    |------- kaslr_regions[0].base       | Hotadd-able region
    |     ^                              |
    |     | padding                      |
    |     V                              V
    |------- actual memory address (Installed on boot)
    |

Fix it by getting the maximum memory address from SRAT and store
the value in boot_param, then set the padding size while KASLR
initializing if the default padding size isn't enough.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/mm/kaslr.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 8e5f3642e..a78844c57 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,6 +70,34 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static inline unsigned long phys_memmap_size(void)
+{
+	unsigned long padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unsigned long actual, maximum, base;
+
+	if (!boot_params.max_addr)
+		goto out;
+
+	/*
+	 * The padding size should set to get for kaslr_regions[].base
+	 * bigger address than the maximum memory address the system can
+	 * have. kaslr_regions[].base points "actual size + padding" or
+	 * higher address. If "actual size + padding" points the lower
+	 * address than the maximum memory size, fix the padding size.
+	 */
+	actual = roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
+	maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
+	base = actual + (padding << TB_SHIFT);
+
+	if (maximum > base)
+		padding = (maximum - actual) >> TB_SHIFT;
+out:
+#endif
+	return DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
+			padding;
+}
+
 /*
  * Even though a huge virtual address space is reserved for the direct
  * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
@@ -87,8 +115,7 @@ static inline unsigned long calc_direct_mapping_size(void)
 	 * Update Physical memory mapping to available and
 	 * add padding if needed (especially for memory hotplug support).
 	 */
-	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+	memory_tb = phys_memmap_size();
 
 	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 
-- 
2.18.1

