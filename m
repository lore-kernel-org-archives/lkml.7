Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9292087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfgDg/Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCRPxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfCRPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yJ1bCJlh1+xNZWhNi935RbqQH4eX3YSnCjfUf0Q33Jw=; b=jfgDg/Jqx4MD+4ItMeVRWHaILR
        /I40VTqfRDUdZ04EIPXZsB/qFaFOOy4liPvtPbkBQUEF19buGvk/DXBqSc++fVZobrRA1w0pjqcrV
        wfCg7u1Myza7PUpi5rRCjwCWpyfhKipqo/azqG62wJ6aY2yK+zCNfpvwe8R9vO5KCpfKBQsoRWlkF
        kVe3uQH2fX2fopwQX32DPC2DdkPJ2xewesYu3czcs8H3++uMcXVaaIaH/310d3HfSAoMl6NwyDihR
        3u46tOWSdSySPSt7dT9Ge6Hp9GuO4DJNbl3kQ7HxwmsElJWmAL65pNHREYsY7/6Kbikzc1YKGCkuf
        Po+z67QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ8-0005V0-RT; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0FBD25E45D78; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.094130029@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 13/25] x86/uaccess,kasan: Fix KASAN vs SMAP
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN inserts extra code for every LOAD/STORE emitted by te compiler.
Much of this code is simple and safe to run with AC=1, however the
kasan_report() function, called on error, is most certainly not safe
to call with AC=1.

Therefore wrap kasan_report() in user_access_{save,restore}; which for
x86 SMAP, saves/restores EFLAGS and clears AC before calling the real
function.

Also ensure all the functions are without __fentry__ hook. The
function tracer is also not safe.

Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/kasan/Makefile |    3 +++
 mm/kasan/common.c |   10 ++++++++++
 mm/kasan/report.c |    3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)

--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -2,11 +2,13 @@
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
 UBSAN_SANITIZE_generic.o := n
+UBSAN_SANITIZE_generic_report.o := n
 UBSAN_SANITIZE_tags.o := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o = -pg
 CFLAGS_REMOVE_generic.o = -pg
+CFLAGS_REMOVE_generic_report.o = -pg
 CFLAGS_REMOVE_tags.o = -pg
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
@@ -14,6 +16,7 @@ CFLAGS_REMOVE_tags.o = -pg
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -34,6 +34,7 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
+#include <linux/uaccess.h>
 
 #include "kasan.h"
 #include "../slab.h"
@@ -612,6 +613,15 @@ void kasan_free_shadow(const struct vm_s
 		vfree(kasan_mem_to_shadow(vm->addr));
 }
 
+extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
+
+void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+{
+	unsigned long flags = user_access_save();
+	__kasan_report(addr, size, is_write, ip);
+	user_access_restore(flags);
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 static bool shadow_mapped(unsigned long addr)
 {
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -281,8 +281,7 @@ void kasan_report_invalid_free(void *obj
 	end_report(&flags);
 }
 
-void kasan_report(unsigned long addr, size_t size,
-		bool is_write, unsigned long ip)
+void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
 {
 	struct kasan_access_info info;
 	void *tagged_addr;


