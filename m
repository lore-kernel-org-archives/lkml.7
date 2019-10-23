Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CDCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEDD21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glSAeidi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406580AbfJWPR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:17:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390140AbfJWPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RSwZx5vXYUgltg6SGAgq4hYjxU5vyXKL5mMiSRK1G+c=; b=glSAeidi9my/AlJrLdNkbFUKp
        CHfBM7dYonAuhtzeGlRiirtBYrxg1M/IqUVhyq0nhlSMeQhu85UFv3aAPiHcNG+v4wBBwI5itww7m
        WMOFic49egghTv8tdW6einsAIORpmqfWBdtg5BxsCrb7ck972Te1g0Uhc5uAfzgSn/QHHGw+6pk4a
        FJ1Pfqdf5buIekasrF8v8ygA+Kg8Fj/ZYdSZ2I+UnW4s3jPp23VqhhaPDKw1eEinYBp6fO7mzCEzl
        alvwIcZ6dteZgr5S9qb7Wq2SDF1kHEtimShzcQ495HZHVout1vIemy7tfPzLHY5E3YM940Uo3Raxj
        WWFa0tnKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNINd-0007k2-1F; Wed, 23 Oct 2019 15:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0A69300EBF;
        Wed, 23 Oct 2019 17:15:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B11FF2B1D76AD; Wed, 23 Oct 2019 17:16:54 +0200 (CEST)
Date:   Wed, 23 Oct 2019 17:16:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191023151654.GF19358@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114835.GT1817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:48:35PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 04:14:02PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 21, 2019 at 08:53:12AM -0500, Josh Poimboeuf wrote:
> 
> > > Doesn't livepatch code also need to be modified?  We have:
> > 
> > Urgh bah.. I was too focussed on the other klp borkage :/ But yes,
> > arm64/ftrace and klp are the only two users of that function (outside of
> > module.c) and Mark was already writing a patch for arm64.
> > 
> > Means these last two patches need to wait a little until we've fixed
> > those.
> 
> So the other KLP issue:
> 
> <mbenes> peterz: ad klp, apply_relocate_add() and text_poke()... what
>          about apply_alternatives() and apply_paravirt()? They call
>          text_poke_early(), which was ok with module_disable/enable_ro(), but
> 	 now it is not, I suppose. See arch_klp_init_object_loaded() in
>          arch/x86/kernel/livepatch.c.
> 
> <peterz> mbenes: hurm, I don't see why we would need to do
>          apply_alternatives() / apply_paravirt() later, why can't we do that
> 	 the moment we load the module
> 
> <peterz> mbenes: that is, those things _never_ change after boot
> 
> <mbenes> peterz: as jpoimboe explained. See commit
>          d4c3e6e1b193497da3a2ce495fb1db0243e41e37 for detailed explanation.
> 
> Now sadly that commit missed all the useful information, luckily I could
> find the patch in my LKML folder, more sad, that thread still didn't
> contain the actual useful information, for that I was directed to
> github:
> 
>   https://github.com/dynup/kpatch/issues/580
> 
> Now, someone is owning me a beer for having to look at github for this.
> 
> That finally explained that what happens is that the RELA was trying to
> fix up the paravirt indirect call to 'local_irq_disable', which
> apply_paravirt() will have overwritten with 'CLI; NOP'. This then
> obviously goes *bang*.
> 
> This then raises a number of questions:
> 
>  1) why is that RELA (that obviously does not depend on any module)
>     applied so late?
> 
>  2) why can't we unconditionally skip RELA's to paravirt sites?
> 
>  3) Is there ever a possible module-dependent RELA to a paravirt /
>     alternative site?
> 
> 
> Now, for 1), I would propose '.klp.rela.${mod}' sections only contain
> RELAs that depend on symbols in ${mod} (or modules in general). We can
> fix up RELAs that depend on core kernel early without problems. Let them
> be in the normal .rela sections and be fixed up on loading the
> patch-module as per usual.
> 
> This should also deal with 2, paravirt should always have RELAs into the
> core kernel.
> 
> Then for 3) we only have alternatives left, and I _think_ it unlikely to
> be the case, but I'll have to have a hard look at that.
> 
> Hmmm ?

Something like so on top, I suppose.

---

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -131,7 +131,8 @@ static int __apply_relocate_add(Elf64_Sh
 		   unsigned int symindex,
 		   unsigned int relsec,
 		   struct module *me,
-		   void *(*write)(void *addr, const void *val, size_t size))
+		   void *(*write)(void *addr, const void *val, size_t size),
+		   bool klp)
 {
 	unsigned int i;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
@@ -157,6 +158,14 @@ static int __apply_relocate_add(Elf64_Sh
 
 		val = sym->st_value + rel[i].r_addend;
 
+		/*
+		 * .klp.rela.* sections should only contain module
+		 * related RELAs. All core-kernel RELAs should be in
+		 * normal .rela.* sections and be applied when loading
+		 * the patch module itself.
+		 */
+		WARN_ON_ONCE(klp && core_kernel_text(val));
+
 		switch (ELF64_R_TYPE(rel[i].r_info)) {
 		case R_X86_64_NONE:
 			break;
@@ -223,7 +232,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		   unsigned int relsec,
 		   struct module *me)
 {
-	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy);
+	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy, false);
 }
 
 int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
@@ -234,7 +243,7 @@ int klp_apply_relocate_add(Elf64_Shdr *s
 {
 	int ret;
 
-	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke);
+	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke, true);
 	if (!ret)
 		text_poke_sync();
 
