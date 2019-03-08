Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8902087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552048315;
	bh=mnYR4NzsIbK8WlErtVJzY23YkceQl9WkGTYDEHykWvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DrbyArMmfvQuKLkoUco5xOtKELbtQLB9ctLKq4bPPiiJosprEuWn4tebPwzVWUOV3
	 oaVnLwawPhzDDkfrYFxWLkFBPXpCl1fxgE0l0FmbR5H9zFWPks48LTyBE5fqQDsllL
	 DsJy9GBpYOkP3m+VGPNOdG7kczTFJDsYlOMTghXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCHMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCHMbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:31:53 -0500
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245AD20851;
        Fri,  8 Mar 2019 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552048312;
        bh=mnYR4NzsIbK8WlErtVJzY23YkceQl9WkGTYDEHykWvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrNUBSeRa8n/l4caBMrvV5QgNB5LmLgkAzO8jtreTuQJnSbD9R2MLvqU+8WGOZ8jd
         WuLKlOznb1A3mZe6MAV1AEPMR8Q0r8KaCWSHRyODOXlqD+FRavwSwpinzhOFtgnUiY
         dbEWncn1oblYfqyCoSye113H/2y4TqWUfltv9iqM=
Date:   Fri, 8 Mar 2019 13:31:43 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Eugene Loh <eugene.loh@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] kallsyms: store type information in its own array
Message-ID: <20190308123143.GA21385@linux-8ccs>
References: <1551124798-12712-1-git-send-email-eugene.loh@oracle.com>
 <6f25e7d5-ccf5-8ea6-e73e-ca8d4e5800f2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6f25e7d5-ccf5-8ea6-e73e-ca8d4e5800f2@oracle.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Eugene Loh [07/03/19 15:37 -0800]:
>It's been 1.5 weeks.  Could I get some feedback on this patch? Thanks.

Apologies, I was on vacation the past week.

Added some CC's from the last time we talked about overwriting the
st_size/st_info Elf_Sym fields, in case anyone else has comments.

>On 02/25/2019 11:59 AM, eugene.loh@oracle.com wrote:
>>From: Eugene Loh <eugene.loh@oracle.com>
>>
>>When a module is loaded, its symbols' Elf_Sym information is stored
>>in a symtab.  Further, type information is also captured.  Since
>>Elf_Sym has no type field, historically the st_info field has been
>>hijacked for storing type:  st_info was overwritten.
>>
>>commit 5439c985c5a83a8419f762115afdf560ab72a452 ("module: Overwrite
>>st_size instead of st_info") changes that practice, as its one-liner
>>indicates.  Unfortunately, this change overwrites symbol size,
>>information that a tool like DTrace expects to find.
>>
>>Allocate a typetab array to store type information so that no Elf_Sym
>>field needs to be overwritten.
>>
>>Fixes: 5439c985c5a8 ("module: Overwrite st_size instead of st_info")
>>Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
>>Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
>>---
>>  include/linux/module.h   |  1 +
>>  kernel/module-internal.h |  2 +-
>>  kernel/module.c          | 21 ++++++++++++++-------
>>  3 files changed, 16 insertions(+), 8 deletions(-)
>>
>>diff --git a/include/linux/module.h b/include/linux/module.h
>>index f5bc4c0..9c1bc21 100644
>>--- a/include/linux/module.h
>>+++ b/include/linux/module.h
>>@@ -315,6 +315,7 @@ struct mod_kallsyms {
>>  	Elf_Sym *symtab;
>>  	unsigned int num_symtab;
>>  	char *strtab;
>>+	char *typetab;
>>  };
>>  #ifdef CONFIG_LIVEPATCH
>>diff --git a/kernel/module-internal.h b/kernel/module-internal.h
>>index 79c9be2..67828af 100644
>>--- a/kernel/module-internal.h
>>+++ b/kernel/module-internal.h
>>@@ -20,7 +20,7 @@ struct load_info {
>>  	unsigned long len;
>>  	Elf_Shdr *sechdrs;
>>  	char *secstrings, *strtab;
>>-	unsigned long symoffs, stroffs;
>>+	unsigned long symoffs, stroffs, init_typeoff, core_typeoff;

Small nit: typeoff to typeoffs to match symoffs and stroffs.

Otherwise the rest looks fine to me. I guess it's about time we get
rid of the Elf_Sym field hijacking anyway :-)

Thanks!

Jessica

>>  	struct _ddebug *debug;
>>  	unsigned int num_debug;
>>  	bool sig_ok;
>>diff --git a/kernel/module.c b/kernel/module.c
>>index 2ad1b52..c7c1bcd 100644
>>--- a/kernel/module.c
>>+++ b/kernel/module.c
>>@@ -2647,6 +2647,8 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>>  	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
>>  	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
>>  	mod->core_layout.size += strtab_size;
>>+	info->core_typeoff = mod->core_layout.size;
>>+	mod->core_layout.size += ndst * sizeof(char);
>>  	mod->core_layout.size = debug_align(mod->core_layout.size);
>>  	/* Put string table section at end of init part of module. */
>>@@ -2660,6 +2662,8 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>>  				      __alignof__(struct mod_kallsyms));
>>  	info->mod_kallsyms_init_off = mod->init_layout.size;
>>  	mod->init_layout.size += sizeof(struct mod_kallsyms);
>>+	info->init_typeoff = mod->init_layout.size;
>>+	mod->init_layout.size += nsrc * sizeof(char);
>>  	mod->init_layout.size = debug_align(mod->init_layout.size);
>>  }
>>@@ -2683,20 +2687,23 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>>  	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
>>  	/* Make sure we get permanent strtab: don't use info->strtab. */
>>  	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
>>+	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoff;
>>-	/* Set types up while we still have access to sections. */
>>-	for (i = 0; i < mod->kallsyms->num_symtab; i++)
>>-		mod->kallsyms->symtab[i].st_size
>>-			= elf_type(&mod->kallsyms->symtab[i], info);
>>-
>>-	/* Now populate the cut down core kallsyms for after init. */
>>+	/*
>>+	 * Now populate the cut down core kallsyms for after init
>>+	 * and set types up while we still have access to sections.
>>+	 */
>>  	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
>>  	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
>>+	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoff;
>>  	src = mod->kallsyms->symtab;
>>  	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
>>+		mod->kallsyms->typetab[i] = elf_type(src + i, info);
>>  		if (i == 0 || is_livepatch_module(mod) ||
>>  		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
>>  				   info->index.pcpu)) {
>>+			mod->core_kallsyms.typetab[ndst] =
>>+			    mod->kallsyms->typetab[i];
>>  			dst[ndst] = src[i];
>>  			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
>>  			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
>>@@ -4084,7 +4091,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>>  			const Elf_Sym *sym = &kallsyms->symtab[symnum];
>>  			*value = kallsyms_symbol_value(sym);
>>-			*type = sym->st_size;
>>+			*type = kallsyms->typetab[symnum];
>>  			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
>>  			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
>>  			*exported = is_exported(name, *value, mod);
>
