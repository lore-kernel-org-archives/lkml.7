Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9820818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="axy9nE/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfDJQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:52:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfDJQwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:52:49 -0400
Received: from zn.tnic (p200300EC2F0CAE00C097970AF3E0D9DA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:c097:970a:f3e0:d9da])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BA881EC0400;
        Wed, 10 Apr 2019 18:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554915167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YD7twoUSHvj2tbKIqgaYMiQ6PnIdVXwgROgLwtRhY3Y=;
        b=axy9nE/f33GZvpez9gyDJ/IPb871QrnaWByrUxf+bS5mxqKyAWtyLfEPCV3k5cLfity+m8
        PlIrtFXNG4/SUPfweb/xkFrqEAQcfl1oMvQmcv2JzQJFCWiNCkXuowOnu0vzZWx5DZrdcz
        LvXe/nufxTse1RR4R6hcedzNJLz6+EI=
Date:   Wed, 10 Apr 2019 18:52:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 12/27] x86/pkru: Provide .*_pkru_ins() functions
Message-ID: <20190410165241.GD26580@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-13-bigeasy@linutronix.de>
 <20190410163615.GB26580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410163615.GB26580@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 06:36:15PM +0200, Borislav Petkov wrote:
> Well, this is going in the wrong direction. The proper thing to do would
> be to have:
> 
> rdpkru()
> wrpkru()
> 
> which only do the inline asm with the respective opcodes. Just like
> rdtsc(), clflush(), etc.

IOW, like this:

---
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..e2948ce1376c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -127,14 +127,14 @@ static inline int pte_dirty(pte_t pte)
 static inline u32 read_pkru(void)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return __read_pkru();
+		return rdpkru();
 	return 0;
 }
 
 static inline void write_pkru(u32 pkru)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		__write_pkru(pkru);
+		wrpkru(pkru);
 }
 
 static inline int pte_young(pte_t pte)
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..396ff572d66a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -92,7 +92,7 @@ static inline void native_write_cr8(unsigned long val)
 #endif
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-static inline u32 __read_pkru(void)
+static inline u32 rdpkru(void)
 {
 	u32 ecx = 0;
 	u32 edx, pkru;
@@ -107,7 +107,7 @@ static inline u32 __read_pkru(void)
 	return pkru;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 	u32 ecx = 0, edx = 0;
 
@@ -119,12 +119,12 @@ static inline void __write_pkru(u32 pkru)
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
 #else
-static inline u32 __read_pkru(void)
+static inline u32 rdpkru(void)
 {
 	return 0;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 }
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..85260aa2a920 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6413,7 +6413,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
 	    vcpu->arch.pkru != vmx->host_pkru)
-		__write_pkru(vcpu->arch.pkru);
+		wrpkru(vcpu->arch.pkru);
 
 	pt_guest_enter(vmx);
 
@@ -6501,9 +6501,9 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
-		vcpu->arch.pkru = __read_pkru();
+		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vmx->host_pkru)
-			__write_pkru(vmx->host_pkru);
+			wrpkru(vmx->host_pkru);
 	}
 
 	vmx->nested.nested_run_pending = 0;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
