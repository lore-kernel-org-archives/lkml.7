Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF2FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C6C21A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="YSJ6KAHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406700AbfJQBZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:25:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33761 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406080AbfJQBZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:25:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so528830pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Qk9PXHlMYGMSaAT4No+OXlpNbokcwpw05BcYMTN8o0=;
        b=YSJ6KAHiGnESyfIOPhPKg1SYOVmjMBpomipuFXEhixlmLzKVW8KvRvn5hHyn6j2Y1i
         p0eSmpQseV9wxx3eeTbQ1axx5VnzPdFc8iQC+dfYkX4tE20eVuU8xw8dU0mQPGkNS4RJ
         MaD1w2zcSOG1GUeN4MR3fRhoXpOaM2LU5n7Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Qk9PXHlMYGMSaAT4No+OXlpNbokcwpw05BcYMTN8o0=;
        b=bk21fIuEhv8CJe81xJ0N1OM9DsdVI4YmY+ZNTZwR9b6fyxs8HMRjAXL66d/+l8b5hd
         G54yrTgTsoQcdsbDZhP7PFfkALQmp1n04aJS3UHpCSJydV+pStmI1NI1suu2DrLhvr78
         nFivXzIk33FBL1XH0oq81TP1PqEOOZJFFpDpfjS4X4eS5zMzTQi4P2ABhvqCiWJBYI/U
         G1DtO7JwCXOCxxcW/1Wy5EKLlDUzdIeiWLwEl2qqpxOuW9FzuSX6eERDvefZKX4fENxu
         d6gZsJ2Ac7tL7OgmP/vq92hVYIrftK6rdyoMpo2ZhaB/NC2Ac/iZvQyKmP+OR7C2vyCk
         LF5w==
X-Gm-Message-State: APjAAAWez6MyBDWZ/R6G/vxlqmcX1BxtHToIo7MBG/+WITHBaWoO02uX
        IUN/ryUxZTwUSCso8HvB8K5Ghw==
X-Google-Smtp-Source: APXvYqxXibUE0U8yVD2FdPr0YPQf1k44k2wbp/Do/vRXY+EPhK1zFPUYH2gqnpMbv50YR9NpPNR7KQ==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr1154784pjn.58.1571275527734;
        Wed, 16 Oct 2019 18:25:27 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 127sm351343pfy.56.2019.10.16.18.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:25:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Thu, 17 Oct 2019 12:25:04 +1100
Message-Id: <20191017012506.28503-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017012506.28503-1-dja@axtens.net>
References: <20191017012506.28503-1-dja@axtens.net>
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
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/Kconfig  | 9 +++++----
 kernel/fork.c | 4 ++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git arch/Kconfig arch/Kconfig
index 5f8a5d84dbbe..2d914990402f 100644
--- arch/Kconfig
+++ arch/Kconfig
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
diff --git kernel/fork.c kernel/fork.c
index bcdf53125210..484ca6b0ae6c 100644
--- kernel/fork.c
+++ kernel/fork.c
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

