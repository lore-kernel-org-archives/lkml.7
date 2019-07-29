Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07677216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="kZwz3XiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfG2OV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:21:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfG2OVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:21:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so28143983pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7zQctoUbbEOIFpo2YzbJpxQDN+pRrmLCUjs8vOkAsU=;
        b=kZwz3XiA2dsXPzcGr8BMeHi0Q8r5Ij+/PBK8Vx8c8QCcKJhFrrDBFKITSMR5uQ5Pi8
         nKH417WV7u4OJz4rjzW35RiQ402Jwzfx9u4n7eFeVKMP82hZx/7ua8ZWY2bYaTDYcnh3
         5FAoGTMbKLPZv0MVBB4IdczUX73bm6ZnSs15E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7zQctoUbbEOIFpo2YzbJpxQDN+pRrmLCUjs8vOkAsU=;
        b=IOrv35PslQuSBZsNChkDSGD2k8vtDsIrAQ+l+JNtXhNJhoWzn1PJrlvbO/yGbyQUkz
         8noIXTtxSRStgpQQD5OHcllkEJ95T36F8Etk0BDmWxRoSij6WtY+h93ANCf9tYwoJme8
         6gvgPkk5moIFGTAGoStexKzFyBW+NnKOZxwuJDab/B76YYnRrEnGeWVQI/5xtQGhAjF/
         EOqH9XhhGOqbAGhakxLSzIypgZipbXoVZQOMLSWeoVtInOPF9BnJwUYx0J6bHyQh2vd+
         Yxx7kx9aFr9NbU03VoKsHUjCpTgI+7vx8ngaPk1O9Qam0dshTsIC1N7cYS0YufVnps2s
         kL8w==
X-Gm-Message-State: APjAAAVF0f3P8w5E6v/uvl03wcYHTNrLbqPdKrFTjl2CKkK9e0fZxprL
        0s6TmADWYG/m9Rg2or4aZZ+FllTd
X-Google-Smtp-Source: APXvYqyh8hzXYVlRyPGlq4xtJAc38Emiq/syXzPg0A0KUJS5nwkYSCuqEx8dzzwpR52NEl2vN1VgIw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr36039354pfn.98.1564410085043;
        Mon, 29 Jul 2019 07:21:25 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id x14sm78684881pfq.158.2019.07.29.07.21.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:21:24 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 2/3] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Tue, 30 Jul 2019 00:21:07 +1000
Message-Id: <20190729142108.23343-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729142108.23343-1-dja@axtens.net>
References: <20190729142108.23343-1-dja@axtens.net>
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
index a7b57dd42c26..e791196005e1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -825,16 +825,17 @@ config HAVE_ARCH_VMAP_STACK
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
index d8ae0f1b4148..ce3150fe8ff2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/kasan.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -215,6 +216,9 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
+		/* Clear the KASAN shadow of the stack. */
+		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
+
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
-- 
2.20.1

