Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBACA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0591921734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="eV1YePql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfJaJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:39:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37337 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfJaJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:39:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id u9so3991221pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v18HXwwUv8fdcmaD7WznN2j7mmagzU8FAwS/lrMAbV8=;
        b=eV1YePqlbyO7tj1kbB9uk7OP/edmTARvYsB9Zgi7PH5bknrFXg/tJPOc7emhOO4x5j
         KtyJj8T2PfQws87ybdR8idy8g57nveDsfrqx/ExGASQ3uibiJe4goUkyOdBsJ/O6tM75
         VsNL8fB1S0lA/l67fDIo2fDZfwDm47jbBhpzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v18HXwwUv8fdcmaD7WznN2j7mmagzU8FAwS/lrMAbV8=;
        b=Z3MwjLCZCyiTF6T6VeDsiugyFO594xS7pyl5pF7Vcdi2zwtiQ7CJUwUojZ74gDlzZ0
         91Y443c+vKitwjA4OIvwh6oW8AcC5sy8rbOuwmUzGltWBMLWe7o+ryefU75Ux4iPiOEX
         IQLi7aP54ru/ZG5sNf0/ACJmIPKecK0AVHGz53umhaU24MNz4YXnBe7EpvP6iyxk/AM/
         pCWpamyrVKDjDnABIXLfx+Q2ADfdeQvkc0/V+W6GmGLRzTT+RtLFsvYq4lF0NMfT1mDb
         QQ4+IHRF1SPrpnH2jUh5lTgFG9nVnr4mxyRpr687hElHSAUGAfsUwzoApphTgXAD5ugc
         ZFig==
X-Gm-Message-State: APjAAAW6UoZTe+b3CPVWmOzTfdQLGXTJlWOKorwoEfShrQVC9vhEqwti
        xuO/Zb3WJq5bgqlIpsUGngOcVg==
X-Google-Smtp-Source: APXvYqzcQf2seyFm3b/JjsEvVOy0D7utuomMGdhHrdtSNRCDKkdOsqd1sFCDqTrjR6KoKB+g/V5A2A==
X-Received: by 2002:a62:2f43:: with SMTP id v64mr91811pfv.13.1572514768894;
        Thu, 31 Oct 2019 02:39:28 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-783a-2bb9-f7cb-7c3c.static.ipv6.internode.on.net. [2001:44b8:1113:6700:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id p1sm2503669pfb.112.2019.10.31.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:39:28 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v11 3/4] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Thu, 31 Oct 2019 20:39:08 +1100
Message-Id: <20191031093909.9228-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031093909.9228-1-dja@axtens.net>
References: <20191031093909.9228-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supporting VMAP_STACK with KASAN_VMALLOC is straightforward:

 - clear the shadow region of vmapped stacks when swapping them in
 - tweak Kconfig to allow VMAP_STACK to be turned on with KASAN

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/Kconfig  | 9 +++++----
 kernel/fork.c | 4 ++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5f8a5d84dbbe..2d914990402f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -843,16 +843,17 @@ config HAVE_ARCH_VMAP_STACK
 config VMAP_STACK
 	default y
 	bool "Use a virtually-mapped stack"
-	depends on HAVE_ARCH_VMAP_STACK && !KASAN
+	depends on HAVE_ARCH_VMAP_STACK
+	depends on !KASAN || KASAN_VMALLOC
 	---help---
 	  Enable this if you want the use virtually-mapped kernel stacks
 	  with guard pages.  This causes kernel stack overflows to be
 	  caught immediately rather than causing difficult-to-diagnose
 	  corruption.
 
-	  This is presently incompatible with KASAN because KASAN expects
-	  the stack to map directly to the KASAN shadow map using a formula
-	  that is incorrect if the stack is in vmalloc space.
+	  To use this with KASAN, the architecture must support backing
+	  virtual mappings with real shadow memory, and KASAN_VMALLOC must
+	  be enabled.
 
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
diff --git a/kernel/fork.c b/kernel/fork.c
index 4b2a82eda8e5..0eef4243019c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/kasan.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -224,6 +225,9 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
+		/* Clear the KASAN shadow of the stack. */
+		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
+
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
-- 
2.20.1

