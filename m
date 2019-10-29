Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48CC47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C06214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="p12QlXY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfJ2EVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:21:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41997 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfJ2EVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:21:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id c16so6900224plz.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9aL7CIPgVBLEowXwwKDN7h7+lLHlmYeACx0xfz4QPU=;
        b=p12QlXY0PFm+XioTxaj3mxPpn879Km9XTAKXd1KZEJJs9pobJBz1Hm7UzcWyYJIVfp
         p19iZl76ObQBmsydeOqk8cdnw0S/vKCZsOXJW1brmjlSGcIN+W47CfOia1/FJPW82W6z
         jE6+JfudbahSDEuG53tccgkDvhpxU//9CJC4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9aL7CIPgVBLEowXwwKDN7h7+lLHlmYeACx0xfz4QPU=;
        b=rT3rey/u0ctv4Mi6JeDYCAN8V7YC7tn2UomDwKogp/8P7GeoI4x509L1VSnnxfDEU2
         3aMuPjiTd4rjjQWmGw21i0LVsigIxNIwZAT9ADU4KBYHiISZGeU4KqhCFn7Sarkv8IYm
         5Evd8c2OQYxVndkasd70x7Gb37EUgZ05LnYOkMtv9qVi4IuzL6by/u6pGoXgNdq+8K5x
         7MIlmQDqJPiod70doI1LGnCWFRYfJrvkhLFUGhi2g7VyqmWSKL7iBPcrXu+vkEFR07mu
         0HVwp4rw5GBGw4B+Dwmog7jIFJxZYM9+j+DVsHp0S1AJjyBTgYHZYAorTF5tTmg9Pcfs
         ny1Q==
X-Gm-Message-State: APjAAAVhGPtJrBlZloWp6xDxT+kK3+yFeRoDD7ImVO8ZSGUI2vxYE9j/
        gWYuH3OVbd0/TFu3U7CHO5fQBA==
X-Google-Smtp-Source: APXvYqw4MKFeQK6pYRf79KGFRAAEh2wsHOiwEALC94r+gJllVaQ7+sHoUGr+gJCFpyDnOXwUXq1bAw==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr1697695pls.281.1572322880361;
        Mon, 28 Oct 2019 21:21:20 -0700 (PDT)
Received: from localhost ([2001:44b8:802:1120:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id a5sm3908450pfk.172.2019.10.28.21.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 21:21:19 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Tue, 29 Oct 2019 15:20:57 +1100
Message-Id: <20191029042059.28541-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029042059.28541-1-dja@axtens.net>
References: <20191029042059.28541-1-dja@axtens.net>
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
index 954e875e72b1..a6e5249ad74b 100644
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

