Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B402EC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404023429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qZFO1ufn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH3Aj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:39:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36443 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfH3Aj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:39:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3323016pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=qZFO1ufnQ4RzGLDmpNBBD8xLbLUSe/uPxIPwRgNb/8C1MeDgxj1IuxZwSgTtu/3mWo
         2plw5QzKfc1xhua3ICso6nWcau8unleFne2xH2R3zZpUctvuA8I7BebNJ6IqS45ly7u9
         r54BRf8K3pzPYXos1tiVjDS4eJ3Q9OdWwQfOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=F9NKmKd9qbE5XwFCtkKgatUOWPGB2bOF6abs99rQpx6HoXW88eMaAUwYZXfW2mdF4H
         NaQ37eLGOfcEXr7AboVhpUPtaAyEPZOu6MUR2zlDT0LZKZ0IV/0WUqUtUp+ukHc0406y
         hHHHxvcI02I2USCUcpVnGNkhmvQZVS5KKKd1NZ4tmXrpf1ghsj4b1MGuI7T6MGG4xOC/
         qb6/GUwN4PV1wX8SStjvyfisUtBhl3D0Foq+kl/6s+lSNl7tXNJ8z8y0slPAwp/rvSGD
         RaKV0yq1F+HAM/n8qYusElb5M/Ow3Ie6FiKpL95deXW16/GiN4PX/ZNQgWtTVOJyWRVw
         QiSQ==
X-Gm-Message-State: APjAAAVkvp0MbD982VRk54MIbf8EypAQRdXwV0k0oJClkrfAOEwMCAZ6
        Ot4g4+KzTNwNlmiM7Z8mnWU3DQ==
X-Google-Smtp-Source: APXvYqyKlf0Curg+QgHFMU7CVSgRUolc+ixnBqYSqq7ea1tAptjrSjZsllz7aAJpXkkpH/hEA4izKA==
X-Received: by 2002:a65:48c3:: with SMTP id o3mr10685138pgs.372.1567125568304;
        Thu, 29 Aug 2019 17:39:28 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id i4sm2211696pfd.168.2019.08.29.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:39:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Fri, 30 Aug 2019 10:38:19 +1000
Message-Id: <20190830003821.10737-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830003821.10737-1-dja@axtens.net>
References: <20190830003821.10737-1-dja@axtens.net>
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
index 6728c5fa057e..e15f1486682a 100644
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
index f601168f6b21..52279fd5e72d 100644
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

