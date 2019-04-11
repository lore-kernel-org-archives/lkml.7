Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53617206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VqOG2D/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKNY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:24:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDKNY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:24:27 -0400
Received: from zn.tnic (p200300EC2F0ABD005554386546A32455.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bd00:5554:3865:46a3:2455])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BA921EC0A8F;
        Thu, 11 Apr 2019 15:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554989065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYZFGJuQh96ZfbQXa73a/QXPcAfPdbPLLqBbRZOCmSk=;
        b=VqOG2D/t5XSiZvU5krKOLvovedcOzysCtVSiqse4y9d4betdqHZXFXGU+zuniuJYvFNnhi
        DmUg/RQVKKyxu7i3IEeIzbiD5UQ6gEnSFwLkYEFk58OEyUJnHcMde80QJyAHP/ofp30XR2
        hONaYwrtIwkzvO+NYxNA3huTSnisVY8=
Date:   Thu, 11 Apr 2019 15:24:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 12/27] x86/pkru: Provide .*_pkru_ins() functions
Message-ID: <20190411132418.GF30080@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-13-bigeasy@linutronix.de>
 <20190410163615.GB26580@zn.tnic>
 <20190410165241.GD26580@zn.tnic>
 <20190410212501.jglzib2qcygjnmxc@linutronix.de>
 <6f22b890-a3f7-f758-e955-384c17e6e4bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f22b890-a3f7-f758-e955-384c17e6e4bb@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:29:26PM -0700, Dave Hansen wrote:
> On 4/10/19 2:25 PM, Sebastian Andrzej Siewior wrote:
> >>  static inline void write_pkru(u32 pkru)
> >>  {
> >>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
> >> -		__write_pkru(pkru);
> >> +		wrpkru(pkru);
> > I think if this is a simple
> > 
> >    's@__write_pkru_ins@wrpkru@g'
> >    's@__read_pkru_ins@rdpkru@g'
> > 
> > then it should work just fine and match what Dave asked for.
> 
> I'm fine with it either way, fwiw.

Final version:

---
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 3 Apr 2019 18:41:41 +0200
Subject: [PATCH] x86/pkru: Provide *pkru() helpers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dave Hansen asked for __read_pkru() and __write_pkru() to be
symmetrical.

As part of the series __write_pkru() will read back the value and only
write it if it is different.

In order to make both functions symmetrical, move the function
containing only the opcode asm into a function called like the
instruction itself.

__write_pkru() will just invoke wrpkru() but in a follow-up patch will
also read back the value.

 [ bp: Convert asm opcode wrapper names to rd/wrpkru(). ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-13-bigeasy@linutronix.de
---
 arch/x86/include/asm/pgtable.h       |  2 +-
 arch/x86/include/asm/special_insns.h | 12 +++++++++---
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..e8875ca75623 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -127,7 +127,7 @@ static inline int pte_dirty(pte_t pte)
 static inline u32 read_pkru(void)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return __read_pkru();
+		return rdpkru();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..34897e2b52c9 100644
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
 
@@ -118,8 +118,14 @@ static inline void __write_pkru(u32 pkru)
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
+
+static inline void __write_pkru(u32 pkru)
+{
+	wrpkru(pkru);
+}
+
 #else
-static inline u32 __read_pkru(void)
+static inline u32 rdpkru(void)
 {
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..dd1e1eea4f0b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6501,7 +6501,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
-		vcpu->arch.pkru = __read_pkru();
+		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vmx->host_pkru)
 			__write_pkru(vmx->host_pkru);
 	}
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
