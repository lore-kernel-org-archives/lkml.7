Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F02C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92A721773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DnApBmxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfC3QoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:44:05 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:43842 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730154AbfC3QoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:44:04 -0400
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 02BEF33800D6;
        Sat, 30 Mar 2019 19:44:01 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jkS9SZAv9F-hrEetawC;
        Sat, 30 Mar 2019 19:44:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553964240;
        bh=ekrJJPkvvc2IIUgqhYsDD1G/Ckjf+XccsQQiJwR67Z8=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=DnApBmxIFOz4WPtDyKFku2DHBCTBllcg3nquqyW5gX9yoWPHjzirhQIFjjO90Mwe/
         Xp52jhwwjF+brDPqgA6bBwXXaI1dnNEU72Y6thZh46Owy41mFJ0yJNLA4+O4PWCLaH
         XIiOPJDaBosaoEXc5tZXNo3wn0HzUyrg/I46T+Qo=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-c0b480c282c8.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:43:53 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "richard@nod.at" <richard@nod.at>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        George Spelvin <lkml@sdf.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Cc:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Morton Andrew <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "malat@debian.org" <malat@debian.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "jannh@google.com" <jannh@google.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
        "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>,
        "piaojun@huawei.com" <piaojun@huawei.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lchen@suse.com" <lchen@suse.com>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Subject: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the swap function
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:43:53 +0300
Message-Id: <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace int type with size_t type of the size argument
in the swap function, also affect all its dependencies.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 include/linux/sort.h         | 2 +-
 kernel/jump_label.c          | 2 +-
 lib/extable.c                | 2 +-
 lib/sort.c                   | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 89be1be1790c..1078c287198c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -176,7 +176,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_ftrace_find(ip);
 }
 
-static void orc_sort_swap(void *_a, void *_b, int size)
+static void orc_sort_swap(void *_a, void *_b, size_t size)
 {
 	struct orc_entry *orc_a, *orc_b;
 	struct orc_entry orc_tmp;
diff --git a/include/linux/sort.h b/include/linux/sort.h
index 2b99a5dd073d..aea39d552ff7 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -6,6 +6,6 @@
 
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
-	  void (*swap)(void *, void *, int));
+	  void (*swap)(void *, void *, size_t));
 
 #endif
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bad96b476eb6..340b788571fb 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -45,7 +45,7 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static void jump_label_swap(void *a, void *b, int size)
+static void jump_label_swap(void *a, void *b, size_t size)
 {
 	long delta = (unsigned long)a - (unsigned long)b;
 	struct jump_entry *jea = a;
diff --git a/lib/extable.c b/lib/extable.c
index f54996fdd0b8..db2888342cd7 100644
--- a/lib/extable.c
+++ b/lib/extable.c
@@ -28,7 +28,7 @@ static inline unsigned long ex_to_insn(const struct exception_table_entry *x)
 #ifndef ARCH_HAS_RELATIVE_EXTABLE
 #define swap_ex		NULL
 #else
-static void swap_ex(void *a, void *b, int size)
+static void swap_ex(void *a, void *b, size_t size)
 {
 	struct exception_table_entry *x = a, *y = b, tmp;
 	int delta = b - a;
diff --git a/lib/sort.c b/lib/sort.c
index 50855ea8c262..60fbbc29104a 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -114,7 +114,7 @@ static void swap_bytes(void *a, void *b, size_t n)
 	} while (n);
 }
 
-typedef void (*swap_func_t)(void *a, void *b, int size);
+typedef void (*swap_func_t)(void *a, void *b, size_t size);
 
 /*
  * The values are arbitrary as long as they can't be confused with
@@ -138,7 +138,7 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
 	else if (swap_func == SWAP_BYTES)
 		swap_bytes(a, b, size);
 	else
-		swap_func(a, b, (int)size);
+		swap_func(a, b, size);
 }
 
 /**
@@ -187,7 +187,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  */
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp_func)(const void *, const void *),
-	  void (*swap_func)(void *, void *, int size))
+	  void (*swap_func)(void *, void *, size_t size))
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
-- 
2.21.0


