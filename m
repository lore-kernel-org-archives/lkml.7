Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE6CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112E9205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIxYRcAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfJUQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:12:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8CwcR6v1uIMRz/wnpf5/hldbLghItEkQZRfurp20NNc=; b=WIxYRcApaEJwySXidgbw/Ghed
        IDd7mjEQ0/M/yVsa12n/Cf/JVSub3Gaf55r/p0gFhmYdEn1bt/6uAacISKFp19wjX89NXPZTFaHyR
        jgG9cdiqZnOPxcDXzSWQIYmsuIyQS7TtBv6NEzLHH2ebzfoWasYNLPTewnDjKJvB0rLpdj2iDMNsc
        AvqJqc0XaqbPOV81XE03sdq7C0yqTSB8q9uA2B6/tf6zuuAvN5ty4DraR7C8cfJOLcKnsTGrBp+KL
        DgFqEBzTbHd8+31n7ltyE0Go9ncWQjYThotJsz0CKffoKcObg3z1Vl+dVU5tzwPgPGLy84PIEuJuj
        adgnNPXOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMaHS-0007Nf-H9; Mon, 21 Oct 2019 16:11:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 714553016E5;
        Mon, 21 Oct 2019 18:10:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99BAA201EF24E; Mon, 21 Oct 2019 18:11:35 +0200 (CEST)
Date:   Mon, 21 Oct 2019 18:11:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191021161135.GD19358@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191021153425.GB19358@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021153425.GB19358@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:34:25PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 04:14:02PM +0200, Peter Zijlstra wrote:

> So On IRC Josh suggested we use text_poke() for RELA. Since KLP is only
> available on Power and x86, and Power does not have STRICT_MODULE_RWX,
> the below should be sufficient.
> 
> Completely untested...

And because s390 also has: HAVE_LIVEPATCH and STRICT_MODULE_RWX the even
less tested s390 bits included below.

Heiko, apologies if I completely wrecked it.

The purpose is to remove module_disable_ro()/module_enable_ro() from
livepatch/core.c such that:

 - nothing relies on where in the module loading path module text goes RX.
 - nothing ever has writable text

> ---
>  arch/x86/kernel/module.c  | 40 +++++++++++++++++++++++++++++++++-------
>  include/linux/livepatch.h |  7 +++++++
>  kernel/livepatch/core.c   | 14 ++++++++++----
>  3 files changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index d5c72cb877b3..76fa2c5f2d7b 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -126,11 +126,12 @@ int apply_relocate(Elf32_Shdr *sechdrs,
>  	return 0;
>  }
>  #else /*X86_64*/
> -int apply_relocate_add(Elf64_Shdr *sechdrs,
> +int __apply_relocate_add(Elf64_Shdr *sechdrs,
>  		   const char *strtab,
>  		   unsigned int symindex,
>  		   unsigned int relsec,
> -		   struct module *me)
> +		   struct module *me,
> +		   void *(*write)(void *addr, const void *val, size_t size))
>  {
>  	unsigned int i;
>  	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
> @@ -162,19 +163,19 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  		case R_X86_64_64:
>  			if (*(u64 *)loc != 0)
>  				goto invalid_relocation;
> -			*(u64 *)loc = val;
> +			write(loc, &val, 8);
>  			break;
>  		case R_X86_64_32:
>  			if (*(u32 *)loc != 0)
>  				goto invalid_relocation;
> -			*(u32 *)loc = val;
> +			write(loc, &val, 4);
>  			if (val != *(u32 *)loc)
>  				goto overflow;
>  			break;
>  		case R_X86_64_32S:
>  			if (*(s32 *)loc != 0)
>  				goto invalid_relocation;
> -			*(s32 *)loc = val;
> +			write(loc, &val, 4);
>  			if ((s64)val != *(s32 *)loc)
>  				goto overflow;
>  			break;
> @@ -183,7 +184,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  			if (*(u32 *)loc != 0)
>  				goto invalid_relocation;
>  			val -= (u64)loc;
> -			*(u32 *)loc = val;
> +			write(loc, &val, 4);
>  #if 0
>  			if ((s64)val != *(s32 *)loc)
>  				goto overflow;
> @@ -193,7 +194,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  			if (*(u64 *)loc != 0)
>  				goto invalid_relocation;
>  			val -= (u64)loc;
> -			*(u64 *)loc = val;
> +			write(loc, &val, 8);
>  			break;
>  		default:
>  			pr_err("%s: Unknown rela relocation: %llu\n",
> @@ -215,6 +216,31 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  	       me->name);
>  	return -ENOEXEC;
>  }
> +
> +int apply_relocate_add(Elf64_Shdr *sechdrs,
> +		   const char *strtab,
> +		   unsigned int symindex,
> +		   unsigned int relsec,
> +		   struct module *me)
> +{
> +	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy);
> +}
> +
> +int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
> +		   const char *strtab,
> +		   unsigned int symindex,
> +		   unsigned int relsec,
> +		   struct module *me)
> +{
> +	int ret;
> +
> +	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke);
> +	if (!ret)
> +		text_poke_sync();
> +
> +	return ret;
> +}
> +
>  #endif
>  
>  int module_finalize(const Elf_Ehdr *hdr,
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 273400814020..5b8c10871b70 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -217,6 +217,13 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
>  void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor);
>  void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
>  
> +
> +extern int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
> +			      const char *strtab,
> +			      unsigned int symindex,
> +			      unsigned int relsec,
> +			      struct module *me);
> +
>  #else /* !CONFIG_LIVEPATCH */
>  
>  static inline int klp_module_coming(struct module *mod) { return 0; }
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index ab4a4606d19b..e690519aba31 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -245,6 +245,15 @@ static int klp_resolve_symbols(Elf_Shdr *relasec, struct module *pmod)
>  	return 0;
>  }
>  
> +int __weak klp_apply_relocate_add(Elf64_Shdr *sechdrs,
> +			      const char *strtab,
> +			      unsigned int symindex,
> +			      unsigned int relsec,
> +			      struct module *me)
> +{
> +	apply_relocate_add(sechdrs, strtab, symindex, relsec, me);
> +}
> +
>  static int klp_write_object_relocations(struct module *pmod,
>  					struct klp_object *obj)
>  {
> @@ -285,7 +294,7 @@ static int klp_write_object_relocations(struct module *pmod,
>  		if (ret)
>  			break;
>  
> -		ret = apply_relocate_add(pmod->klp_info->sechdrs,
> +		ret = klp_apply_relocate_add(pmod->klp_info->sechdrs,
>  					 pmod->core_kallsyms.strtab,
>  					 pmod->klp_info->symndx, i, pmod);
>  		if (ret)
> @@ -721,16 +730,13 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  
>  	mutex_lock(&text_mutex);
>  
> -	module_disable_ro(patch->mod);
>  	ret = klp_write_object_relocations(patch->mod, obj);
>  	if (ret) {
> -		module_enable_ro(patch->mod, true);
>  		mutex_unlock(&text_mutex);
>  		return ret;
>  	}
>  
>  	arch_klp_init_object_loaded(patch, obj);
> -	module_enable_ro(patch->mod, true);
>  
>  	mutex_unlock(&text_mutex);
>  

diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index ba8f19bb438b..5f3443098172 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -174,7 +174,8 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 }
 
 static int apply_rela_bits(Elf_Addr loc, Elf_Addr val,
-			   int sign, int bits, int shift)
+			   int sign, int bits, int shift.
+			   void (*write)(void *addr, const char *data, size_t len))
 {
 	unsigned long umax;
 	long min, max;
@@ -194,26 +195,29 @@ static int apply_rela_bits(Elf_Addr loc, Elf_Addr val,
 			return -ENOEXEC;
 	}
 
-	if (bits == 8)
-		*(unsigned char *) loc = val;
-	else if (bits == 12)
-		*(unsigned short *) loc = (val & 0xfff) |
+	if (bits == 8) {
+		write(loc, &val, 1);
+	} else if (bits == 12) {
+		unsigned short tmp = (val & 0xfff) |
 			(*(unsigned short *) loc & 0xf000);
-	else if (bits == 16)
-		*(unsigned short *) loc = val;
-	else if (bits == 20)
-		*(unsigned int *) loc = (val & 0xfff) << 16 |
-			(val & 0xff000) >> 4 |
-			(*(unsigned int *) loc & 0xf00000ff);
-	else if (bits == 32)
-		*(unsigned int *) loc = val;
-	else if (bits == 64)
-		*(unsigned long *) loc = val;
+		write(loc, &tmp, 2);
+	} else if (bits == 16) {
+		write(loc, &val, 2);
+	} else if (bits == 20) {
+		unsigned int tmp = (val & 0xfff) << 16 |
+			(val & 0xff000) >> 4 | (*(unsigned int *) loc & 0xf00000ff);
+		write(loc, &tmp, 4);
+	} else if (bits == 32) {
+		write(loc, &val, 4);
+	} else if (bits == 64) {
+		write(loc, &val, 8);
+	}
 	return 0;
 }
 
 static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
-		      const char *strtab, struct module *me)
+		      const char *strtab, struct module *me,
+		      void (*write)(void *addr, const void *data, size_t len))
 {
 	struct mod_arch_syminfo *info;
 	Elf_Addr loc, val;
@@ -241,17 +245,17 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	case R_390_64:		/* Direct 64 bit.  */
 		val += rela->r_addend;
 		if (r_type == R_390_8)
-			rc = apply_rela_bits(loc, val, 0, 8, 0);
+			rc = apply_rela_bits(loc, val, 0, 8, 0, write);
 		else if (r_type == R_390_12)
-			rc = apply_rela_bits(loc, val, 0, 12, 0);
+			rc = apply_rela_bits(loc, val, 0, 12, 0, write);
 		else if (r_type == R_390_16)
-			rc = apply_rela_bits(loc, val, 0, 16, 0);
+			rc = apply_rela_bits(loc, val, 0, 16, 0, write);
 		else if (r_type == R_390_20)
-			rc = apply_rela_bits(loc, val, 1, 20, 0);
+			rc = apply_rela_bits(loc, val, 1, 20, 0, write);
 		else if (r_type == R_390_32)
-			rc = apply_rela_bits(loc, val, 0, 32, 0);
+			rc = apply_rela_bits(loc, val, 0, 32, 0, write);
 		else if (r_type == R_390_64)
-			rc = apply_rela_bits(loc, val, 0, 64, 0);
+			rc = apply_rela_bits(loc, val, 0, 64, 0, write);
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.  */
 	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
@@ -260,15 +264,15 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	case R_390_PC64:	/* PC relative 64 bit.	*/
 		val += rela->r_addend - loc;
 		if (r_type == R_390_PC16)
-			rc = apply_rela_bits(loc, val, 1, 16, 0);
+			rc = apply_rela_bits(loc, val, 1, 16, 0, write);
 		else if (r_type == R_390_PC16DBL)
-			rc = apply_rela_bits(loc, val, 1, 16, 1);
+			rc = apply_rela_bits(loc, val, 1, 16, 1, write);
 		else if (r_type == R_390_PC32DBL)
-			rc = apply_rela_bits(loc, val, 1, 32, 1);
+			rc = apply_rela_bits(loc, val, 1, 32, 1, write);
 		else if (r_type == R_390_PC32)
-			rc = apply_rela_bits(loc, val, 1, 32, 0);
+			rc = apply_rela_bits(loc, val, 1, 32, 0, write);
 		else if (r_type == R_390_PC64)
-			rc = apply_rela_bits(loc, val, 1, 64, 0);
+			rc = apply_rela_bits(loc, val, 1, 64, 0, write);
 		break;
 	case R_390_GOT12:	/* 12 bit GOT offset.  */
 	case R_390_GOT16:	/* 16 bit GOT offset.  */
@@ -293,23 +297,23 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 		val = info->got_offset + rela->r_addend;
 		if (r_type == R_390_GOT12 ||
 		    r_type == R_390_GOTPLT12)
-			rc = apply_rela_bits(loc, val, 0, 12, 0);
+			rc = apply_rela_bits(loc, val, 0, 12, 0, write);
 		else if (r_type == R_390_GOT16 ||
 			 r_type == R_390_GOTPLT16)
-			rc = apply_rela_bits(loc, val, 0, 16, 0);
+			rc = apply_rela_bits(loc, val, 0, 16, 0, write);
 		else if (r_type == R_390_GOT20 ||
 			 r_type == R_390_GOTPLT20)
-			rc = apply_rela_bits(loc, val, 1, 20, 0);
+			rc = apply_rela_bits(loc, val, 1, 20, 0, write);
 		else if (r_type == R_390_GOT32 ||
 			 r_type == R_390_GOTPLT32)
-			rc = apply_rela_bits(loc, val, 0, 32, 0);
+			rc = apply_rela_bits(loc, val, 0, 32, 0, write);
 		else if (r_type == R_390_GOT64 ||
 			 r_type == R_390_GOTPLT64)
-			rc = apply_rela_bits(loc, val, 0, 64, 0);
+			rc = apply_rela_bits(loc, val, 0, 64, 0, write);
 		else if (r_type == R_390_GOTENT ||
 			 r_type == R_390_GOTPLTENT) {
 			val += (Elf_Addr) me->core_layout.base - loc;
-			rc = apply_rela_bits(loc, val, 1, 32, 1);
+			rc = apply_rela_bits(loc, val, 1, 32, 1, write);
 		}
 		break;
 	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
@@ -357,17 +361,17 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 			val += rela->r_addend - loc;
 		}
 		if (r_type == R_390_PLT16DBL)
-			rc = apply_rela_bits(loc, val, 1, 16, 1);
+			rc = apply_rela_bits(loc, val, 1, 16, 1, write);
 		else if (r_type == R_390_PLTOFF16)
-			rc = apply_rela_bits(loc, val, 0, 16, 0);
+			rc = apply_rela_bits(loc, val, 0, 16, 0, write);
 		else if (r_type == R_390_PLT32DBL)
-			rc = apply_rela_bits(loc, val, 1, 32, 1);
+			rc = apply_rela_bits(loc, val, 1, 32, 1, write);
 		else if (r_type == R_390_PLT32 ||
 			 r_type == R_390_PLTOFF32)
-			rc = apply_rela_bits(loc, val, 0, 32, 0);
+			rc = apply_rela_bits(loc, val, 0, 32, 0, write);
 		else if (r_type == R_390_PLT64 ||
 			 r_type == R_390_PLTOFF64)
-			rc = apply_rela_bits(loc, val, 0, 64, 0);
+			rc = apply_rela_bits(loc, val, 0, 64, 0, write);
 		break;
 	case R_390_GOTOFF16:	/* 16 bit offset to GOT.  */
 	case R_390_GOTOFF32:	/* 32 bit offset to GOT.  */
@@ -375,20 +379,20 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 		val = val + rela->r_addend -
 			((Elf_Addr) me->core_layout.base + me->arch.got_offset);
 		if (r_type == R_390_GOTOFF16)
-			rc = apply_rela_bits(loc, val, 0, 16, 0);
+			rc = apply_rela_bits(loc, val, 0, 16, 0, write);
 		else if (r_type == R_390_GOTOFF32)
-			rc = apply_rela_bits(loc, val, 0, 32, 0);
+			rc = apply_rela_bits(loc, val, 0, 32, 0, write);
 		else if (r_type == R_390_GOTOFF64)
-			rc = apply_rela_bits(loc, val, 0, 64, 0);
+			rc = apply_rela_bits(loc, val, 0, 64, 0, write);
 		break;
 	case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
 	case R_390_GOTPCDBL:	/* 32 bit PC rel. off. to GOT shifted by 1. */
 		val = (Elf_Addr) me->core_layout.base + me->arch.got_offset +
 			rela->r_addend - loc;
 		if (r_type == R_390_GOTPC)
-			rc = apply_rela_bits(loc, val, 1, 32, 0);
+			rc = apply_rela_bits(loc, val, 1, 32, 0, write);
 		else if (r_type == R_390_GOTPCDBL)
-			rc = apply_rela_bits(loc, val, 1, 32, 1);
+			rc = apply_rela_bits(loc, val, 1, 32, 1, write);
 		break;
 	case R_390_COPY:
 	case R_390_GLOB_DAT:	/* Create GOT entry.  */
@@ -412,9 +416,10 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	return 0;
 }
 
-int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+int __apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       unsigned int symindex, unsigned int relsec,
-		       struct module *me)
+		       struct module *me,
+		       void (*write)(void *addr, const void *data, size_t len))
 {
 	Elf_Addr base;
 	Elf_Sym *symtab;
@@ -437,6 +442,25 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
+static void memwrite(void *addr, const void *data, size_t len)
+{
+	memcpy(addr, data, len);
+}
+
+int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+		       unsigned int symindex, unsigned int relsec,
+		       struct module *me)
+{
+	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memwrite);
+}
+
+int klp_apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+		       unsigned int symindex, unsigned int relsec,
+		       struct module *me)
+{
+	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, s390_kernel_write);
+}
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)

