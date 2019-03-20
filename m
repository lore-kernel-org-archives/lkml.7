Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A56C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F3D21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfCTThD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:37:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfCTThC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:37:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CABDAD88;
        Wed, 20 Mar 2019 19:37:00 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:36:59 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 3/8] livepatch: Add klp-convert tool
In-Reply-To: <20190318192011.GA23157@redhat.com>
Message-ID: <alpine.LSU.2.21.1903202021570.29796@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-4-jmoreira@suse.de> <20190318192011.GA23157@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > [ ... snip ... ]
> > +
> > +/* Checks if sympos is valid, otherwise prints valid sympos list */
> > +static bool valid_sympos(struct sympos *sp)
> > +{
> > +	struct symbol_entry *e;
> > +	int counter = 0;
> > +
> > +	list_for_each_entry(e, &symbols, list) {
> > +		if ((strcmp(e->symbol_name, sp->symbol_name) == 0) &&
> > +		    (strcmp(e->object_name, sp->object_name) == 0)) {
> > +			if (counter == sp->pos)
> > +				return true;
> > +			counter++;
> > +		}
> > +	}
> > +
> > +	WARN("Provided KLP_SYMPOS does not match a symbol: %s.%s,%d",
> > +			sp->object_name, sp->symbol_name, sp->pos);
> > +	print_valid_module_relocs(sp->symbol_name);
> > +
> > +	return false;
> > +}
> 
> I believe there is an off-by-one error condition either here, or in
> livepatch kernel core sympos disambiguator code (in which case, external
> tools like kpatch-build would also need to be adjusted).
> 
> The scenarios that I've observed using klp-convert and kpatch-build:
> 
>   sympos == 0, uniquely named symbol
>   sympos == 1, non-unique symbol name, first instance
>   sympos == 2, non-unique symbol name, second instance
>   ...

Yes, that is exactly how we defined it back then.
 
> When I built a klp-convert selftest, I made sure that the target module
> contained multiple symbols of the same name across two .o files.
> However, when I tried to use a KLP_MODULE_RELOC annotation in the
> livepatch to resolve to the second (ie, last) symbol, using a sympos=2,
> klp-convert kept telling me that the only valid KLP_SYMPOS were 0 and 1.
> 
> The following code adjusts klp-convert to match the sympos logic, as I
> understand it in livepatch/core.c and kpatch-build;
> 
>   [squash] livepatch/klp-convert: fix klp-convert off-by-one sympos 
>   https://github.com/torvalds/linux/commit/1ed8e5baa98f7920bbbaa562278b3ed44552e01f
> 
> This change also adds a check that sympos == 0 is in fact a uniquely
> named symbol.

Looks good to me. Maybe we can even make it simpler and use similar 
approach as in klp_find_callback() and klp_find_object_symbol() from 
kernel/livepatch/core.c. On the other hand, given that we want to print 
useful output in all cases, the code might happen to be more complicated 
and definitely ugly. 
 
> > [ ... snip ... ]
> > +
> > +int main(int argc, const char **argv)
> > +{
> > +	const char *klp_in_module, *klp_out_module, *symbols_list;
> > +	struct rela *rela, *tmprela;
> > +	struct section *sec, *aux;
> > +	struct sympos sp;
> > +	struct elf *klp_elf;
> > +
> > +	if (argc != 4) {
> > +		WARN("Usage: %s <Symbols.list> <input.ko> <out.ko>", argv[0]);
> > +		return -1;
> > +	}
> > +
> > +	symbols_list = argv[1];
> > +	klp_in_module = argv[2];
> > +	klp_out_module = argv[3];
> > +
> > +	klp_elf = elf_open(klp_in_module);
> > +	if (!klp_elf) {
> > +		WARN("Unable to read elf file %s\n", klp_in_module);
> > +		return -1;
> > +	}
> > +
> > +	if (!load_syms_lists(symbols_list))
> > +		return -1;
> > +
> > +	if (!load_usr_symbols(klp_elf)) {
> > +		WARN("Unable to load user-provided sympos");
> > +		return -1;
> > +	}
> > +
> > +	list_for_each_entry_safe(sec, aux, &klp_elf->sections, list) {
> > +		if (!is_rela_section(sec))
> > +			continue;
> > +
> > +		list_for_each_entry_safe(rela, tmprela, &sec->relas, list) {
> > +			if (!must_convert(rela->sym))
> > +				continue;
> > +
> > +			if (!find_missing_position(rela->sym, &sp)) {
> > +				WARN("Unable to find missing symbol");
> 
> A really minor suggestion, but I found it useful to tell the user
> exactly which symbol was missing:
> 
>   [squash] livepatch/klp-convert: add missing symbol name to warning 
>   https://github.com/torvalds/linux/commit/7a41a8f3d9b9e11f0c75914cb925af1486c1ecc6

I think that Joao has exactly the same hunk staged somewhere 
already. You are right. The message is not much informative.

Miroslav
