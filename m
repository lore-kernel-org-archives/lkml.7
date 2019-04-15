Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F34C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5CA218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353945;
	bh=O8ghSaqomER1TdRDCFfbm6Wh9mkw0U4JbgVizdDs5PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CqsYeMohNuL9f23mL5wJbl/9tjmAHxu7SeMvTgE24Xj0nswDZKzHCvcwakc7xDq7H
	 EbCd831T0+/3DhwcK3g2pqsylMbEmh3FqXW0lVPCmPEAEmEZXq3YcSIM9CHEZthFdH
	 twI+ZpP5fg3naq+WilUN31pzCVCNSRsaqivsUv2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfDOSpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfDOSpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C17B2073F;
        Mon, 15 Apr 2019 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353942;
        bh=O8ghSaqomER1TdRDCFfbm6Wh9mkw0U4JbgVizdDs5PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFqCwSdQ5PqYZ3sDVtwu0XoV2rXvA40BK5IoqWV6f+9sxgSjzMAC3vVhHTWfUl/mz
         Dz29+PUhbzAMVxZvPYbFtZRTivF47NTdisukkTf9TEF4onmKRel+qR4hdcFy3fawd1
         Rd+3bCdriY1IUHKK8owToR0AWLQGT0h9xtGCF64I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/76] powerpc: Avoid code patching freed init sections
Date:   Mon, 15 Apr 2019 20:43:37 +0200
Message-Id: <20190415183711.514716690@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 51c3c62b58b357e8d35e4cc32f7b4ec907426fe3 upstream.

This stops us from doing code patching in init sections after they've
been freed.

In this chain:
  kvm_guest_init() ->
    kvm_use_magic_page() ->
      fault_in_pages_readable() ->
	 __get_user() ->
	   __get_user_nocheck() ->
	     barrier_nospec();

We have a code patching location at barrier_nospec() and
kvm_guest_init() is an init function. This whole chain gets inlined,
so when we free the init section (hence kvm_guest_init()), this code
goes away and hence should no longer be patched.

We seen this as userspace memory corruption when using a memory
checker while doing partition migration testing on powervm (this
starts the code patching post migration via
/sys/kernel/mobility/migration). In theory, it could also happen when
using /sys/kernel/debug/powerpc/barrier_nospec.

Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/setup.h | 1 +
 arch/powerpc/lib/code-patching.c | 8 ++++++++
 arch/powerpc/mm/mem.c            | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 703ddf752516..709f4e739ae8 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -8,6 +8,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
+extern bool init_mem_is_free;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 753d591f1b52..c77c486fbf24 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -14,12 +14,20 @@
 #include <asm/page.h>
 #include <asm/code-patching.h>
 #include <asm/uaccess.h>
+#include <asm/setup.h>
+#include <asm/sections.h>
 
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+		return 0;
+	}
+
 	__put_user_size(instr, addr, 4, err);
 	if (err)
 		return err;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5f844337de21..1e93dbc88e80 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -62,6 +62,7 @@
 #endif
 
 unsigned long long memory_limit;
+bool init_mem_is_free;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -396,6 +397,7 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
+	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.19.1



