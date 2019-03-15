Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904CE2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfItA5WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCOTwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:52:46 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36158 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfCOTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:23 -0400
Received: by mail-yw1-f73.google.com with SMTP id o66so13196276ywc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UI7aEl8s0mFedqqMgOc8iwA/qQRORzYcgfY9MOX1Q3Q=;
        b=vfItA5WBR9mxsOR5v/mXd6WRiw4qlJltvNcK03CJ3M5tD9oVwrnLXYPI73iFuFVvAy
         bStP8xOii4yXjBbLTiAyKSB+txWVCS5HbLg7oCB6RFMjQ5I07jr4SiImmyWLTfMKN0Vo
         z36zX4CJInXJMuVWsluFJtX4mg9tVYzK2laFJNn9axSKJXusl77n+y3QdI2KYR44uRZK
         TdwpdeFyx3tJBo/3IPC6BPg3PY4+1i133Q8TRIUuSaS8J+5QIn7rjJkfF42EQR9AUQXB
         a+dyvkdV6VlmT38t3+1yugNVaOElo8rNqqI8UQ90j7irslaNCh2z5PcCU9Uzw8Cc9GWC
         No2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UI7aEl8s0mFedqqMgOc8iwA/qQRORzYcgfY9MOX1Q3Q=;
        b=E2lU/r3Gq+Kp3OlYGt7C2cJ+OXMoGt4wWl/ky7a5mUppx3o7tjjHH9U69TBxwgsXiI
         v01xoEdrInmwMgn7CgnIhb7FO7V6eyNnjejjvkIyG5d9F2ZI4cEg5WUOMnlcWGoXUpcz
         ImDaUbNOLFIde/e8WgQboCqadvqYSlpYpZnBq6XNWcBMJqh/1mrJx28bfKRxJlMosHHG
         OOz//oD4RCNuY1JYviwYx9wb03VnUwsS6VZKZF30RDY7tjGjm2UKITLNG2ru1CQoURj/
         freV+TNNR8vPGdL/vW0lQEwsgJ0q0KNpiqliE1ZxjlNGQ4nrGKMeCUX9+iodrzokVm7D
         GRwQ==
X-Gm-Message-State: APjAAAWUbVGQXlx6SBOM5N2DVdndjgMKx2GQMXPkaILEYVrQURthj9iz
        jWgz41u5aiHtelUQY87AiHjbAUabqsvV0/Bg
X-Google-Smtp-Source: APXvYqxeRzK18KUJ10+PDA+W93JZa2qDw/GudrGBEMPcLUXJuZN92dXCZ+z04uJTKknTff4jbLvWVF1Z13ZfBUn3
X-Received: by 2002:a5b:44e:: with SMTP id s14mr2709444ybp.100.1552679541907;
 Fri, 15 Mar 2019 12:52:21 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:36 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <0e1bd7fbde338061ea54234b3b1bd5ab6102381e.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 12/14] bpf, arm64: untag user pointers in stack_map_get_build_id_offset
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

stack_map_get_build_id_offset() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the user pointer in this function for doing the lookup and
calculating the offset, but save as is into the bpf_stack_build_id
struct.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/bpf/stackmap.c |  6 ++++--
 p                     | 45 -------------------------------------------
 2 files changed, 4 insertions(+), 47 deletions(-)
 delete mode 100644 p

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 950ab2f28922..bb89341d3faf 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -320,7 +320,9 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		vma = find_vma(current->mm, ips[i]);
+		u64 untagged_ip = untagged_addr(ips[i]);
+
+		vma = find_vma(current->mm, untagged_ip);
 		if (!vma || stack_map_get_build_id(vma, id_offs[i].build_id)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
@@ -328,7 +330,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
 			continue;
 		}
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + untagged_ip
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
diff --git a/p b/p
deleted file mode 100644
index 9d6fa5386e55..000000000000
--- a/p
+++ /dev/null
@@ -1,45 +0,0 @@
-commit 1fa6fadf644859e8a6a8ecce258444b49be8c7ee
-Author: Andrey Konovalov <andreyknvl@google.com>
-Date:   Mon Mar 4 17:20:32 2019 +0100
-
-    kasan: fix coccinelle warnings in kasan_p*_table
-    
-    kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
-    returning bool, but return 0 instead of false, which produces a coccinelle
-    warning. Fix it.
-    
-    Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
-    Reported-by: kbuild test robot <lkp@intel.com>
-    Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
-
-diff --git a/mm/kasan/init.c b/mm/kasan/init.c
-index 45a1b5e38e1e..fcaa1ca03175 100644
---- a/mm/kasan/init.c
-+++ b/mm/kasan/init.c
-@@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
- #else
- static inline bool kasan_p4d_table(pgd_t pgd)
- {
--	return 0;
-+	return false;
- }
- #endif
- #if CONFIG_PGTABLE_LEVELS > 3
-@@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
- #else
- static inline bool kasan_pud_table(p4d_t p4d)
- {
--	return 0;
-+	return false;
- }
- #endif
- #if CONFIG_PGTABLE_LEVELS > 2
-@@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
- #else
- static inline bool kasan_pmd_table(pud_t pud)
- {
--	return 0;
-+	return false;
- }
- #endif
- pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
-- 
2.21.0.360.g471c308f928-goog

