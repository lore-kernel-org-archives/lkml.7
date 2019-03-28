Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3541C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71921850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiA5YxfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfC1VXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:23:31 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35727 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfC1VXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:23:30 -0400
Received: by mail-qt1-f201.google.com with SMTP id x12so232368qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IprNtYcSrwGubnlM8xXtHMs9hP1pvIa5GfxRkBIh3k0=;
        b=LiA5YxfFJqdLfmAn4cU2pMnefY2pjrFIPGjsbZrVwlKZNOfwfE0jEr7rayflK9z8NA
         qQL4PAn81IykqsL9tvsvxdA68h5juD53v7L4pCDr17a8Y4osJy8PDaTXe6N8ZTlBN/G9
         tg8O2jA/7lFjMkpDkzEzaFzYCDHofuLzaNkGf9rtYcV3pyDURNg2mDZ5KVkb+ibTPuFD
         OQtCgIb8vcuEmpFqSJEPe+v5wD+pBvUpiaWjz+Cl8qmiktanLZ+EHN1W/7xg4n07EuHy
         XjEk6DqIUD85yxidqDhIrpNNnOxVkszKFxmv41zXedWGqz0wkEa2awliSckf1Ic6y12y
         jwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IprNtYcSrwGubnlM8xXtHMs9hP1pvIa5GfxRkBIh3k0=;
        b=L23jCkKOrjUWleRzWPCfs3hJQ6A/SPPPI9hh4W9dYvWGqUWDx2d39izWoMjYEgJBQq
         1u1MOcfBa/N7iqDLnSb9W3C2kxRR/+gjpm+RrqULCiN1DQ7k/wVXEi2d+dni0V295wPv
         GCyjL/JwldhbIkRqcOaxtbgyVr0bKAaIU2tnkg/1vZlOc6TyWOX2cFYuh6NbudVUr3I1
         l3ncC6CR+LD6cJ6SY+cDxqBjPfbP49jz6uVCnW6hHhOZHRyj97BiypZi67rThWtVKhm2
         LbmV1BkAZD7ohaU7s3PHkUv8XL8DmFMRpxi6PVlYHOFEAo+/rytFMIwopK7oBl1w4Hq7
         0b1g==
X-Gm-Message-State: APjAAAV5WamJnjNgLthiBfexjASjCV+/PVVNw2eEZ15RiSgexH/f8izp
        x+C5wdzrCK1koUHlbfHdyd/lekEj6A==
X-Google-Smtp-Source: APXvYqz7ngmrn37zKxu8cuCFbKZ7p1TYNMzTwVvfnDrInIUhpysEmvnP+wM7/pqju70hWSgjcEP0NGjXBQ==
X-Received: by 2002:a37:6442:: with SMTP id y63mr2329086qkb.12.1553808209061;
 Thu, 28 Mar 2019 14:23:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:23:21 +0100
In-Reply-To: <20190328212321.92463-1-jannh@google.com>
Message-Id: <20190328212321.92463-2-jannh@google.com>
Mime-Version: 1.0
References: <20190328212321.92463-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 2/2] x86: fix __user annotations
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Signed-off-by : Qiaowei Ren" <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix __user annotations in various places across the x86 tree:

 - cast to wrong pointer type in __user_atomic_cmpxchg_inatomic()
 - generic_load_microcode() deals with a pointer that can be either a
   kernel pointer or a user pointer; change the code to pass it around as
   a __user pointer, and add explicit casts to convert between __user and
   __kernel
 - save_xstate_epilog() has missing __user in explicit casts
 - setup_sigcontext() and x32_setup_rt_frame() rely on the cast performed
   by put_user_ex() on its first argument, but sparse requires __force for
   casting __user pointers to unsigned long
 - xen_hvm_config() has missing __user

This patch removes all sparse warnings about the asn:1 address space
(__user) in arch/x86/ for my kernel config.

Signed-off-by: Jann Horn <jannh@google.com>
---
This patch requires the previous one, "[PATCH 1/2] kernel.h: use
parentheses around argument in u64_to_user_ptr()", otherwise
xen_hvm_config() breaks. Can we take both together through the x86 tree,
or does the first one have to go through akpm's tree?

 arch/x86/include/asm/uaccess.h        |  3 +--
 arch/x86/include/asm/uaccess_64.h     |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
 arch/x86/kernel/fpu/signal.c          |  6 +++---
 arch/x86/kernel/signal.c              |  4 ++--
 arch/x86/kvm/x86.c                    |  8 ++++----
 arch/x86/lib/usercopy_64.c            |  4 +++-
 7 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1954dd5552a2..a21f2a2f17bf 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -585,7 +585,6 @@ extern void __cmpxchg_wrong_size(void)
 #define __user_atomic_cmpxchg_inatomic(uval, ptr, old, new, size)	\
 ({									\
 	int __ret = 0;							\
-	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	__uaccess_begin_nospec();					\
@@ -661,7 +660,7 @@ extern void __cmpxchg_wrong_size(void)
 		__cmpxchg_wrong_size();					\
 	}								\
 	__uaccess_end();						\
-	*__uval = __old;						\
+	*(uval) = __old;						\
 	__ret;								\
 })
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index a9d637bc301d..cbca2cb28939 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -208,7 +208,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 }
 
 unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len);
+copy_user_handle_tail(char __user *to, char __user *from, unsigned len);
 
 unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len);
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e8ef65c275c7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -861,11 +861,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-				int (*get_ucode_data)(void *, const void *, size_t))
+static enum ucode_state generic_load_microcode(int cpu,
+		const void __user *data, size_t size,
+		int (*get_ucode_data)(void *, const void __user *, size_t))
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u8 *ucode_ptr = data, *new_mc = NULL, *mc = NULL;
+	const u8 __user *ucode_ptr = data;
+	u8 *new_mc = NULL, *mc = NULL;
 	int new_rev = uci->cpu_sig.rev;
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -945,9 +947,10 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	return ret;
 }
 
-static int get_ucode_fw(void *to, const void *from, size_t n)
+static int get_ucode_fw(void *to, const void __user *from, size_t n)
 {
-	memcpy(to, from, n);
+	/* cast paired with request_microcode_fw() */
+	memcpy(to, (const void __force *)from, n);
 	return 0;
 }
 
@@ -993,7 +996,8 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 	}
 
-	ret = generic_load_microcode(cpu, (void *)firmware->data,
+	/* cast paired with get_ucode_fw() */
+	ret = generic_load_microcode(cpu, (void __force __user *)firmware->data,
 				     firmware->size, &get_ucode_fw);
 
 	release_firmware(firmware);
@@ -1001,7 +1005,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	return ret;
 }
 
-static int get_ucode_user(void *to, const void *from, size_t n)
+static int get_ucode_user(void *to, const void __user *from, size_t n)
 {
 	return copy_from_user(to, from, n);
 }
@@ -1012,7 +1016,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
 
-	return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
+	return generic_load_microcode(cpu, buf, size, &get_ucode_user);
 }
 
 static struct microcode_ops microcode_intel_ops = {
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f6a1d299627c..55b80de13ea5 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -92,13 +92,13 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 		return err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 *)(buf + fpu_user_xstate_size));
+			  (__u32 __user *)(buf + fpu_user_xstate_size));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
 	 * from the state in task struct) to the user buffers.
 	 */
-	err |= __get_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
@@ -113,7 +113,7 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	 */
 	xfeatures |= XFEATURE_MASK_FPSSE;
 
-	err |= __put_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	return err;
 }
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 08dfd4c1a4f9..e13cd972f9af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		put_user_ex(regs->ss, &sc->ss);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, &sc->fpstate);
+		put_user_ex((unsigned long __force)fpstate, &sc->fpstate);
 
 		/* non-iBCS2 extensions.. */
 		put_user_ex(mask, &sc->oldmask);
@@ -569,7 +569,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 			restorer = NULL;
 			err |= -EFAULT;
 		}
-		put_user_ex(restorer, &frame->pretcode);
+		put_user_ex((unsigned long __force)restorer, &frame->pretcode);
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65e4559eef2f..ca087debefbf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2317,11 +2317,11 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 static int xen_hvm_config(struct kvm_vcpu *vcpu, u64 data)
 {
 	struct kvm *kvm = vcpu->kvm;
+	struct kvm_xen_hvm_config *cfg = &kvm->arch.xen_hvm_config;
 	int lm = is_long_mode(vcpu);
-	u8 *blob_addr = lm ? (u8 *)(long)kvm->arch.xen_hvm_config.blob_addr_64
-		: (u8 *)(long)kvm->arch.xen_hvm_config.blob_addr_32;
-	u8 blob_size = lm ? kvm->arch.xen_hvm_config.blob_size_64
-		: kvm->arch.xen_hvm_config.blob_size_32;
+	u8 __user *blob_addr =
+		u64_to_user_ptr(lm ? cfg->blob_addr_64 : cfg->blob_addr_32);
+	u8 blob_size = lm ? cfg->blob_size_64 : cfg->blob_size_32;
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	u8 *page;
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index ee42bb0cbeb3..cd8a1802adde 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -58,9 +58,11 @@ EXPORT_SYMBOL(clear_user);
  * Try to copy last bytes and clear the rest if needed.
  * Since protection fault in copy_from/to_user is not a normal situation,
  * it is not necessary to optimize tail handling.
+ * We don't know which side of the copy is in userspace; we treat both sides as
+ * user pointers.
  */
 __visible unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len)
+copy_user_handle_tail(char __user *to, char __user *from, unsigned len)
 {
 	for (; len; --len, to++) {
 		char c;
-- 
2.21.0.392.gf8f6787159e-goog

