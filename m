Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2442C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LY5zhChz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfJUPet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:34:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfJUPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SBmuHY1zrIfyuRvYOx1xGQpAYRpV1fFuzLwSk80OX4k=; b=LY5zhChzeXPR6G5HKCb3we1j+
        mJ6xe7mCc6enRslGq/FnvDmZRV5p8NvsmJ1ZEkOL8VO45f4c+8zIzQEbZbqvAkNT8E1Xak7rHL+3g
        ArIj0A4vUYlEMiilp54GLXO1O8ULTG6Bo9ZpUOsvPqfSzzO2TUKb1Ac2EgVoV1NzGiAJSCe16Z10s
        Bgdgd+xMQIR/V8lfwQ7BjX/MoMAVcVrf/+5Out9tA7dnluObiKFkI6Ut1LrfPaXkwBOmgadXP8SQw
        EF0d6ddOZVYcAW2UxX2l6L0AcjG+4txsoD0p+W0Nrlsj4Zv6z4nUMs/RDDzi7+6NA675xgyGZ75qz
        VytJ69whA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMZhU-0000dA-4m; Mon, 21 Oct 2019 15:34:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E672300EBF;
        Mon, 21 Oct 2019 17:33:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DE4C201EF68D; Mon, 21 Oct 2019 17:34:25 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:34:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191021153425.GB19358@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021141402.GI1817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:14:02PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 08:53:12AM -0500, Josh Poimboeuf wrote:
> > On Fri, Oct 18, 2019 at 09:35:40AM +0200, Peter Zijlstra wrote:
> > > Now that set_all_modules_text_*() is gone, nothing depends on the
> > > relation between ->state = COMING and the protection state anymore.
> > > This enables moving the protection changes later, such that the COMING
> > > notifier callbacks can more easily modify the text.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > ---
> > >  kernel/module.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -3683,10 +3683,6 @@ static int complete_formation(struct mod
> > >  	/* This relies on module_mutex for list integrity. */
> > >  	module_bug_finalize(info->hdr, info->sechdrs, mod);
> > >  
> > > -	module_enable_ro(mod, false);
> > > -	module_enable_nx(mod);
> > > -	module_enable_x(mod);
> > > -
> > >  	/* Mark state as coming so strong_try_module_get() ignores us,
> > >  	 * but kallsyms etc. can see us. */
> > >  	mod->state = MODULE_STATE_COMING;
> > > @@ -3852,6 +3848,10 @@ static int load_module(struct load_info
> > >  	if (err)
> > >  		goto bug_cleanup;
> > >  
> > > +	module_enable_ro(mod, false);
> > > +	module_enable_nx(mod);
> > > +	module_enable_x(mod);
> > > +
> > >  	/* Module is ready to execute: parsing args may do that. */
> > >  	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
> > >  				  -32768, 32767, mod,
> > 
> > [ Sorry if this was already discussed, I still have a large backlog. ]
> > 
> > Doesn't livepatch code also need to be modified?  We have:
> 
> Urgh bah.. I was too focussed on the other klp borkage :/ But yes,
> arm64/ftrace and klp are the only two users of that function (outside of
> module.c) and Mark was already writing a patch for arm64.
> 
> Means these last two patches need to wait a little until we've fixed
> those.

So On IRC Josh suggested we use text_poke() for RELA. Since KLP is only
available on Power and x86, and Power does not have STRICT_MODULE_RWX,
the below should be sufficient.

Completely untested...

---
 arch/x86/kernel/module.c  | 40 +++++++++++++++++++++++++++++++++-------
 include/linux/livepatch.h |  7 +++++++
 kernel/livepatch/core.c   | 14 ++++++++++----
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index d5c72cb877b3..76fa2c5f2d7b 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -126,11 +126,12 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
-int apply_relocate_add(Elf64_Shdr *sechdrs,
+int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
-		   struct module *me)
+		   struct module *me,
+		   void *(*write)(void *addr, const void *val, size_t size))
 {
 	unsigned int i;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
@@ -162,19 +163,19 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_X86_64_64:
 			if (*(u64 *)loc != 0)
 				goto invalid_relocation;
-			*(u64 *)loc = val;
+			write(loc, &val, 8);
 			break;
 		case R_X86_64_32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
-			*(u32 *)loc = val;
+			write(loc, &val, 4);
 			if (val != *(u32 *)loc)
 				goto overflow;
 			break;
 		case R_X86_64_32S:
 			if (*(s32 *)loc != 0)
 				goto invalid_relocation;
-			*(s32 *)loc = val;
+			write(loc, &val, 4);
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
 			break;
@@ -183,7 +184,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
-			*(u32 *)loc = val;
+			write(loc, &val, 4);
 #if 0
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
@@ -193,7 +194,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			if (*(u64 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
-			*(u64 *)loc = val;
+			write(loc, &val, 8);
 			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
@@ -215,6 +216,31 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	       me->name);
 	return -ENOEXEC;
 }
+
+int apply_relocate_add(Elf64_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy);
+}
+
+int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	int ret;
+
+	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke);
+	if (!ret)
+		text_poke_sync();
+
+	return ret;
+}
+
 #endif
 
 int module_finalize(const Elf_Ehdr *hdr,
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 273400814020..5b8c10871b70 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -217,6 +217,13 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
 void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor);
 void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
 
+
+extern int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
+			      const char *strtab,
+			      unsigned int symindex,
+			      unsigned int relsec,
+			      struct module *me);
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ab4a4606d19b..e690519aba31 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -245,6 +245,15 @@ static int klp_resolve_symbols(Elf_Shdr *relasec, struct module *pmod)
 	return 0;
 }
 
+int __weak klp_apply_relocate_add(Elf64_Shdr *sechdrs,
+			      const char *strtab,
+			      unsigned int symindex,
+			      unsigned int relsec,
+			      struct module *me)
+{
+	apply_relocate_add(sechdrs, strtab, symindex, relsec, me);
+}
+
 static int klp_write_object_relocations(struct module *pmod,
 					struct klp_object *obj)
 {
@@ -285,7 +294,7 @@ static int klp_write_object_relocations(struct module *pmod,
 		if (ret)
 			break;
 
-		ret = apply_relocate_add(pmod->klp_info->sechdrs,
+		ret = klp_apply_relocate_add(pmod->klp_info->sechdrs,
 					 pmod->core_kallsyms.strtab,
 					 pmod->klp_info->symndx, i, pmod);
 		if (ret)
@@ -721,16 +730,13 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 
 	mutex_lock(&text_mutex);
 
-	module_disable_ro(patch->mod);
 	ret = klp_write_object_relocations(patch->mod, obj);
 	if (ret) {
-		module_enable_ro(patch->mod, true);
 		mutex_unlock(&text_mutex);
 		return ret;
 	}
 
 	arch_klp_init_object_loaded(patch, obj);
-	module_enable_ro(patch->mod, true);
 
 	mutex_unlock(&text_mutex);
 
