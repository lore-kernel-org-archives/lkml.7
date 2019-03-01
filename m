Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A71C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06C920851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Srxb/Bb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfCAM51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:57:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mz4oRaDKZXq7U5gDKqGBgje3puwQYNVzedxYb1qsnAk=; b=Srxb/Bb79KEp6Pqg3cbb9Ka/P
        AnjA/aPwg/yd4EjFacKJmCdQ+cL3WODX35ZyxV3O/I0RaAdKxc9bzUw3lX3+QqznDkDsp/6hwE5bA
        70ehIqlt2xgkktPX58xI0vgLqf/7aeidBo7Lg2JQRrCd7Ocx+vvU83maiKvIfMDfCpPWpfejfMvPf
        HVXOwzrNMbUVszDuUeIU1G8BoUYmjFeytppfJWvpJLWODKRAn41BS5u+8ro+Zv/AZvTHA0RFA/Hcd
        8rZ5Cw+ezOEX4ZbQV8n/wUB3Rf7f7GUAo8xitBoRFP6Exz2Kxc2qBFsm4o2S1ylpEgQwirBqGRIcO
        WkiqYmVLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzhj6-0002yJ-0I; Fri, 01 Mar 2019 12:57:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D5EC239359C0; Fri,  1 Mar 2019 13:57:18 +0100 (CET)
Date:   Fri, 1 Mar 2019 13:57:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190301125718.GS32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net>
 <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
 <20190228190111.GI32494@hirez.programming.kicks-ass.net>
 <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
 <20190301122745.GR32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301122745.GR32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:27:45PM +0100, Peter Zijlstra wrote:
> arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x30: redundant UACCESS disable

> The usercopy one is difficult, that's copy_user_handle_tail(), it is
> buggered though, because that lacks notrace and thus has a __fentry__
> call in.
> 
> Also, afaict all exception jumps into copy_user_handle_tail() will have
> AC=1, but the __{get,put}_user_nocheck() things do STAC/CLAC all over
> again.
> 
> So what do we do? Annotate that we start with AC=1 and then immediately
> do the clac, and then let __{get,put}_user_nocheck() do their own thing?
> or make it use the unsafe stuff?

Or.. we move the thing to assembly. Of course, I suck at (writing) asm,
so the below is probably broken in various ways.

--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -208,9 +208,6 @@ __copy_from_user_flushcache(void *dst, c
 }
 
 unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len);
-
-unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len);
 
 #endif /* _ASM_X86_UACCESS_64_H */
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -194,6 +194,29 @@ ENDPROC(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
 /*
+ * Try to copy last bytes and clear the rest if needed.
+ * Since protection fault in copy_from/to_user is not a normal situation,
+ * it is not necessary to optimize tail handling.
+ *
+ * Input:
+ * rdi destination
+ * rsi source
+ * rdx count
+ *
+ * Output:
+ * eax uncopied bytes or 0 if successful.
+ */
+ENTRY(copy_user_handle_tail)
+	movl %edx,%ecx
+1:	rep movsb
+2:	mov %ecx,%eax
+	ASM_CLAC
+	ret
+
+	_ASM_EXTABLE_UA(1b, 2b)
+END(copy_user_handle_tail)
+
+/*
  * copy_user_nocache - Uncached memory copy with exception handling
  * This will force destination out of cache for more performance.
  *
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -55,26 +55,6 @@ unsigned long clear_user(void __user *to
 EXPORT_SYMBOL(clear_user);
 
 /*
- * Try to copy last bytes and clear the rest if needed.
- * Since protection fault in copy_from/to_user is not a normal situation,
- * it is not necessary to optimize tail handling.
- */
-__visible unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len)
-{
-	for (; len; --len, to++) {
-		char c;
-
-		if (__get_user_nocheck(c, from++, sizeof(char)))
-			break;
-		if (__put_user_nocheck(c, to, sizeof(char)))
-			break;
-	}
-	clac();
-	return len;
-}
-
-/*
  * Similar to copy_user_handle_tail, probe for the write fault point,
  * but reuse __memcpy_mcsafe in case a new read error is encountered.
  * clac() is handled in _copy_to_iter_mcsafe().
