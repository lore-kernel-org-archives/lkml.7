Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEDCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4222CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Wv0f0CzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfH3GfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:35:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52678 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfH3GfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:35:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46KV8c4WMyzB09Zs;
        Fri, 30 Aug 2019 08:35:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Wv0f0CzV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6xDHGUkJL6Ou; Fri, 30 Aug 2019 08:35:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46KV8c3GtyzB09Zq;
        Fri, 30 Aug 2019 08:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567146912; bh=daBzpgXma54rEqO2TTJjz5G+MsbbiHTlA3O/m6q6Djs=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=Wv0f0CzVBZANV/E48p09FJhBCt+68AqUXjnNHvCpJfwlMSBGxiAKKhZmwuPtNIp5a
         mRzLsKlfF7jHzLHTeQDj011zQWo9y1NO4iSWg3ZqHrTDdQ7RS6kEaoK+uqCs4divqf
         3TfpqMbNSym1vQgaDm2lgqfQTHR3lgaU/f+VSMS0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 60AA08B8E0;
        Fri, 30 Aug 2019 08:35:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YuZIhhxde7Ii; Fri, 30 Aug 2019 08:35:13 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24AA98B8DD;
        Fri, 30 Aug 2019 08:35:13 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0F5B169881; Fri, 30 Aug 2019 06:35:13 +0000 (UTC)
Message-Id: <8a755a692fb26b04aa4f95dccc20b076ef7dcf0c.1567146181.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] powerpc/64: make buildable without CONFIG_COMPAT
In-Reply-To: <90594004804c6a9b690b69bdf0e5c4d6c880c5f4.1567117050.git.msuchanek@suse.de>
Date:   Fri, 30 Aug 2019 06:35:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2019 10:28 PM, Michal Suchanek wrote:
> There are numerous references to 32bit functions in generic and 64bit
> code so ifdef them out.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - fix 32bit ifdef condition in signal.c
> - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> v3:
> - use IS_ENABLED and maybe_unused where possible
> - do not ifdef declarations
> - clean up Makefile
> v4:
> - further makefile cleanup
> - simplify is_32bit_task conditions
> - avoid ifdef in condition by using return
> v5:
> - avoid unreachable code on 32bit
> - make is_current_64bit constant on !COMPAT
> - add stub perf_callchain_user_32 to avoid some ifdefs
> ---
>   arch/powerpc/include/asm/thread_info.h |  4 ++--
>   arch/powerpc/kernel/Makefile           |  7 +++----
>   arch/powerpc/kernel/entry_64.S         |  2 ++
>   arch/powerpc/kernel/signal.c           |  3 +--
>   arch/powerpc/kernel/syscall_64.c       |  6 ++----
>   arch/powerpc/kernel/vdso.c             |  5 ++---
>   arch/powerpc/perf/callchain.c          | 13 +++++++++++--
>   7 files changed, 23 insertions(+), 17 deletions(-)
> 
[...]

> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index c84bbd4298a0..881be5c4e9bb 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -15,7 +15,7 @@
>   #include <asm/sigcontext.h>
>   #include <asm/ucontext.h>
>   #include <asm/vdso.h>
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT
>   #include "../kernel/ppc32.h"
>   #endif
>   #include <asm/pte-walk.h>
> @@ -291,7 +291,8 @@ static inline int current_is_64bit(void)
>   	 * interrupt stack, and the thread flags don't get copied over
>   	 * from the thread_info on the main stack to the interrupt stack.
>   	 */
> -	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> +	return !IS_ENABLED(CONFIG_COMPAT) ||
> +		!test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
>   }
>   
>   #else  /* CONFIG_PPC64 */
> @@ -341,6 +342,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
>   
>   #endif /* CONFIG_PPC64 */
>   
> +#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
>   /*
>    * Layout for non-RT signal frames
>    */
> @@ -482,6 +484,13 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>   		sp = next_sp;
>   	}
>   }
> +#else /* 32bit */
> +static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> +				   struct pt_regs *regs)
> +{
> +	(void)&read_user_stack_32; /* unused if !COMPAT */

That looks pretty much like a hack.

See possible alternative below.

> +}
> +#endif /* 32bit */
>   
>   void
>   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> 

---
 arch/powerpc/perf/callchain.c | 62 +++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 881be5c4e9bb..1b169b32776a 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -165,22 +165,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	return read_user_stack_slow(ptr, ret, 8);
 }
 
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
-		return 0;
-	}
-	pagefault_enable();
-
-	return read_user_stack_slow(ptr, ret, 4);
-}
-
 static inline int valid_user_sp(unsigned long sp, int is_64)
 {
 	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
@@ -296,25 +280,10 @@ static inline int current_is_64bit(void)
 }
 
 #else  /* CONFIG_PPC64 */
-/*
- * On 32-bit we just access the address and let hash_page create a
- * HPTE if necessary, so there is no need to fall back to reading
- * the page tables.  Since this is called at interrupt level,
- * do_page_fault() won't treat a DSI as a page fault.
- */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	int rc;
-
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
 
-	pagefault_disable();
-	rc = __get_user_inatomic(*ret, ptr);
-	pagefault_enable();
-
-	return rc;
+static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
+{
+	return 0;
 }
 
 static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
@@ -344,6 +313,30 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
 
 #if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
 /*
+ * On 32-bit we just access the address and let hash_page create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do_page_fault() won't treat a DSI as a page fault.
+ */
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	int rc;
+
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+	    ((unsigned long)ptr & 3))
+		return -EFAULT;
+
+	pagefault_disable();
+	rc = __get_user_inatomic(*ret, ptr);
+	pagefault_enable();
+
+	if (IS_ENABLED(CONFIG_PPC32) || !rc)
+		return rc;
+
+	return read_user_stack_slow(ptr, ret, 4);
+}
+
+/*
  * Layout for non-RT signal frames
  */
 struct signal_frame_32 {
@@ -488,7 +481,6 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 				   struct pt_regs *regs)
 {
-	(void)&read_user_stack_32; /* unused if !COMPAT */
 }
 #endif /* 32bit */
 
-- 
2.13.3

