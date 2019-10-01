Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374DBECDFB6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A770218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="PkKrMZvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfJAG7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 02:59:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40311 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:58:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so7227198pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ix0tFBRmdQmDh77QwfWZLAnX69tqINWfajYEldnceVk=;
        b=PkKrMZvkp74INNZKZ2dDIpCNCHVjGw8vj5JQwUl5yuKjn+mrkDNW8nd0IZRL/da0Oz
         7fYU6QSXP186MQjobjFiMYF4HdN6zwscGQCBq3hJxKnmjoj5ZSDDM0bRTFsJsfIVE6Q+
         OTWhweQ8a8sjTdtOPJIyMwGFIBF/D+52CCXT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ix0tFBRmdQmDh77QwfWZLAnX69tqINWfajYEldnceVk=;
        b=E9bqRBlGCgHxP3KwVVfzoG56Wzu3C2/XefC0iKkUl56Pl6pVdB9ouGmkLP1FDwZbTa
         3kiahQO4DEJONiZFMEpbdmUXHni+YrC8MDtWJG4a3IaJ6jT3U1MbuTvq2nR3vOKaDwVm
         RStLULQ9uyDjbn7A59T1hYz4arLgG5GL5z/a2wW5+T2023/l/k+hHDY8C0uOTeCAkL3M
         mixxmOgiMGKQbC+nZghdUsEMSDdUC2JbgJVPVZ/tMJd5yl0ZfrZEL4adOTUZWwF5//+j
         vmx7MzBH2DhGymVGFcUNeSALCTa+Zpyc5bEm0dODvWvzckmoYhhzTRjBzfIKzIVBbp3f
         kkhw==
X-Gm-Message-State: APjAAAVik58UNjcv5xBhbXlU0xXl7M8R3c/oO4vO5l660vV50YyCO6VH
        yjqg6eHw0zpeRnzi5bsR47T7Qw==
X-Google-Smtp-Source: APXvYqzGnBRD0kjONgaXtURBaqezFW/Qadqkue2P9h+PeB1Qy/HXS+o7oYYr+Hx3pOOW3xuZwH5UTA==
X-Received: by 2002:a63:7d10:: with SMTP id y16mr28593557pgc.368.1569913137887;
        Mon, 30 Sep 2019 23:58:57 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id x12sm14654380pfm.130.2019.09.30.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 23:58:57 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Tue,  1 Oct 2019 16:58:32 +1000
Message-Id: <20191001065834.8880-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001065834.8880-1-dja@axtens.net>
References: <20191001065834.8880-1-dja@axtens.net>
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
index 6adbbcf448c3..0c9e6478ba85 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/kasan.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -229,6 +230,9 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
+		/* Clear the KASAN shadow of the stack. */
+		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
+
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
-- 
2.20.1

