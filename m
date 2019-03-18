Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DF72175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCRTUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:20:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfCRTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CE6530821EC;
        Mon, 18 Mar 2019 19:20:14 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D6D19C67;
        Mon, 18 Mar 2019 19:20:12 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:20:11 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 3/8] livepatch: Add klp-convert tool
Message-ID: <20190318192011.GA23157@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-4-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-4-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 19:20:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:08AM -0300, Joao Moreira wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Livepatches may use symbols which are not contained in its own scope,
> and, because of that, may end up compiled with relocations that will
> only be resolved during module load. Yet, when the referenced symbols
> are not exported, solving this relocation requires information on the
> object that holds the symbol (either vmlinux or modules) and its
> position inside the object, as an object may contain multiple symbols
> with the same name. Providing such information must be done
> accordingly to what is specified in
> Documentation/livepatch/module-elf-format.txt.
> 
> Currently, there is no trivial way to embed the required information
> as requested in the final livepatch elf object. klp-convert solves
> this problem in two different forms: (i) by relying on Symbols.list,
> which is built during kernel compilation, to automatically infer the
> relocation targeted symbol, and, when such inference is not possible
> (ii) by using annotations in the elf object to convert the relocation
> accordingly to the specification, enabling it to be handled by the
> livepatch loader.
> 
> Given the above, create scripts/livepatch to hold tools developed for
> livepatches and add source files for klp-convert there.
> 
> The core file of klp-convert is scripts/livepatch/klp-convert.c, which
> implements the heuristics used to solve the relocations and the
> conversion of unresolved symbols into the expected format, as defined
> in [1].
> 
> klp-convert receives as arguments the Symbols.list file, an input
> livepatch module to be converted and the output name for the converted
> livepatch. When it starts running, klp-convert parses Symbols.list and
> builds two internal lists of symbols, one containing the exported and
> another containing the non-exported symbols. Then, by parsing the rela
> sections in the elf object, klp-convert identifies which symbols must
> be converted, which are those unresolved and that do not have a
> corresponding exported symbol, and attempts to convert them
> accordingly to the specification.
> 
> By using Symbols.list, klp-convert identifies which symbols have names
> that only appear in a single kernel object, thus being capable of
> resolving these cases without the intervention of the developer. When
> various homonymous symbols exist through kernel objects, it is not
> possible to infer the right one, thus klp-convert falls back into
> using developer annotations. If these were not provided, then the tool
> will print a list with all acceptable targets for the symbol being
> processed.
> 
> Annotations in the context of klp-convert are accessible as struct
> klp_module_reloc entries in sections named
> .klp.module_relocs.<objname>. These entries are pairs of symbol
> references and positions which are to be resolved against definitions
> in <objname>.
> 
> Define the structure klp_module_reloc in
> include/linux/uapi/livepatch.h allowing developers to annotate the
> livepatch source code with it.
> 
> klp-convert relies on libelf and on a list implementation. Add files
> scripts/livepatch/elf.c and scripts/livepatch/elf.h, which are a
> libelf interfacing layer and scripts/livepatch/list.h, which is a
> list implementation.
> 
> Update Makefiles to correctly support the compilation of the new tool,
> update MAINTAINERS file and add a .gitignore file.
> 
> [1] - Documentation/livepatch/module-elf-format.txt
> 
> [khlebnikov: use HOSTLOADLIBES_ instead of HOSTLDFLAGS: -lelf must be
> at the end]
> [jmoreira:
> * add support to automatic relocation conversion in klp-convert.c
> * changelog]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  MAINTAINERS                     |   1 +
>  include/uapi/linux/livepatch.h  |   5 +
>  scripts/Makefile                |   1 +
>  scripts/livepatch/.gitignore    |   1 +
>  scripts/livepatch/Makefile      |   7 +
>  scripts/livepatch/elf.c         | 696 ++++++++++++++++++++++++++++++++++++++++
>  scripts/livepatch/elf.h         |  84 +++++
>  scripts/livepatch/klp-convert.c | 610 +++++++++++++++++++++++++++++++++++
>  scripts/livepatch/klp-convert.h |  50 +++
>  scripts/livepatch/list.h        | 389 ++++++++++++++++++++++
>  10 files changed, 1844 insertions(+)
>  create mode 100644 scripts/livepatch/.gitignore
>  create mode 100644 scripts/livepatch/Makefile
>  create mode 100644 scripts/livepatch/elf.c
>  create mode 100644 scripts/livepatch/elf.h
>  create mode 100644 scripts/livepatch/klp-convert.c
>  create mode 100644 scripts/livepatch/klp-convert.h
>  create mode 100644 scripts/livepatch/list.h
> 
> [ ... snip ... ]
> diff --git a/scripts/livepatch/elf.c b/scripts/livepatch/elf.c
> new file mode 100644
> index 000000000000..f279dd3be1b7
> --- /dev/null
> +++ b/scripts/livepatch/elf.c
> @@ -0,0 +1,696 @@
> +/*
> + * elf.c - ELF access library
> + *
> + * Adapted from kpatch (https://github.com/dynup/kpatch):
> + * Copyright (C) 2013-2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> [ ... snip ... ]

We could use the newer, more succinct SPDX version:
/* SPDX-License-Identifier: GPL-2.0 */

> diff --git a/scripts/livepatch/elf.h b/scripts/livepatch/elf.h
> new file mode 100644
> index 000000000000..e8aa8f5fb3bc
> --- /dev/null
> +++ b/scripts/livepatch/elf.h
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (C) 2015-2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> [ ... snip ... ]

/* SPDX-License-Identifier: GPL-2.0 */

> diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
> new file mode 100644
> index 000000000000..2a39d656c8d6
> --- /dev/null
> +++ b/scripts/livepatch/klp-convert.c
> @@ -0,0 +1,610 @@
> +/*
> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + * Copyright (C) 2017 Joao Moreira   <jmoreira@suse.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

/* SPDX-License-Identifier: GPL-2.0 */

> [ ... snip ... ]
> +
> +/* Removes symbols used for sympos annotation from livepatch elf object */
> +static void clear_sympos_symbols(struct section *sec, struct elf *klp_elf)
> +{
> +	struct symbol *sym, *aux;
> +
> +	list_for_each_entry_safe(sym, aux, &klp_elf->symbols, list) {
> +		if (sym->sec == sec) {
> +			list_del(&sym->list);
> +			free(sym);
> +		}
> +	}
> +}

Running klp-convert through 'valgrind --leak-check=full
--track-origins=yes', it found use-after-frees involving symbols that
were run through clear_sympos_symbols... later when must_convert() is
called against all of the rela->syms, the symbols are gone but the
corresponding relas are still allocated and live on their section
rela-list.

A similar use-after-free is present in update_relas() when we want to
elf_write_file() ... again, iterating through sections relas in which
their sym may have been freed.

Suggested fix here:

  [squash] livepatch/klp-convert: fix use-after-frees 
  https://github.com/torvalds/linux/commit/4e5f39e069ec39cac53ae4d7f3d15f05d17f47ff

There are also several other memory leak complaints from valgrind that I
cleaned up.  I didn't look at very error path, as that has a tendency to
clutter up the code, but for successful klp-convert invocations, this
should clean up the rest of the valgrind whining:

  [squash] livepatch/klp-convert: fix remaining memory leaks
  https://github.com/torvalds/linux/commit/ad7681937946bea430449b83f77622dbbe6300de 

> [ ... snip ... ]
> +
> +/* Checks if sympos is valid, otherwise prints valid sympos list */
> +static bool valid_sympos(struct sympos *sp)
> +{
> +	struct symbol_entry *e;
> +	int counter = 0;
> +
> +	list_for_each_entry(e, &symbols, list) {
> +		if ((strcmp(e->symbol_name, sp->symbol_name) == 0) &&
> +		    (strcmp(e->object_name, sp->object_name) == 0)) {
> +			if (counter == sp->pos)
> +				return true;
> +			counter++;
> +		}
> +	}
> +
> +	WARN("Provided KLP_SYMPOS does not match a symbol: %s.%s,%d",
> +			sp->object_name, sp->symbol_name, sp->pos);
> +	print_valid_module_relocs(sp->symbol_name);
> +
> +	return false;
> +}

I believe there is an off-by-one error condition either here, or in
livepatch kernel core sympos disambiguator code (in which case, external
tools like kpatch-build would also need to be adjusted).

The scenarios that I've observed using klp-convert and kpatch-build:

  sympos == 0, uniquely named symbol
  sympos == 1, non-unique symbol name, first instance
  sympos == 2, non-unique symbol name, second instance
  ...

When I built a klp-convert selftest, I made sure that the target module
contained multiple symbols of the same name across two .o files.
However, when I tried to use a KLP_MODULE_RELOC annotation in the
livepatch to resolve to the second (ie, last) symbol, using a sympos=2,
klp-convert kept telling me that the only valid KLP_SYMPOS were 0 and 1.

The following code adjusts klp-convert to match the sympos logic, as I
understand it in livepatch/core.c and kpatch-build;

  [squash] livepatch/klp-convert: fix klp-convert off-by-one sympos 
  https://github.com/torvalds/linux/commit/1ed8e5baa98f7920bbbaa562278b3ed44552e01f

This change also adds a check that sympos == 0 is in fact a uniquely
named symbol.

> [ ... snip ... ]
> +
> +int main(int argc, const char **argv)
> +{
> +	const char *klp_in_module, *klp_out_module, *symbols_list;
> +	struct rela *rela, *tmprela;
> +	struct section *sec, *aux;
> +	struct sympos sp;
> +	struct elf *klp_elf;
> +
> +	if (argc != 4) {
> +		WARN("Usage: %s <Symbols.list> <input.ko> <out.ko>", argv[0]);
> +		return -1;
> +	}
> +
> +	symbols_list = argv[1];
> +	klp_in_module = argv[2];
> +	klp_out_module = argv[3];
> +
> +	klp_elf = elf_open(klp_in_module);
> +	if (!klp_elf) {
> +		WARN("Unable to read elf file %s\n", klp_in_module);
> +		return -1;
> +	}
> +
> +	if (!load_syms_lists(symbols_list))
> +		return -1;
> +
> +	if (!load_usr_symbols(klp_elf)) {
> +		WARN("Unable to load user-provided sympos");
> +		return -1;
> +	}
> +
> +	list_for_each_entry_safe(sec, aux, &klp_elf->sections, list) {
> +		if (!is_rela_section(sec))
> +			continue;
> +
> +		list_for_each_entry_safe(rela, tmprela, &sec->relas, list) {
> +			if (!must_convert(rela->sym))
> +				continue;
> +
> +			if (!find_missing_position(rela->sym, &sp)) {
> +				WARN("Unable to find missing symbol");

A really minor suggestion, but I found it useful to tell the user
exactly which symbol was missing:

  [squash] livepatch/klp-convert: add missing symbol name to warning 
  https://github.com/torvalds/linux/commit/7a41a8f3d9b9e11f0c75914cb925af1486c1ecc6

> [ ... snip ... ]
> diff --git a/scripts/livepatch/klp-convert.h b/scripts/livepatch/klp-convert.h
> new file mode 100644
> index 000000000000..1f3da2d9430d
> --- /dev/null
> +++ b/scripts/livepatch/klp-convert.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + * Copyright (C) 2017 Joao Moreira   <jmoreira@suse.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> [ ... snip ... ]

/* SPDX-License-Identifier: GPL-2.0 */

> diff --git a/scripts/livepatch/list.h b/scripts/livepatch/list.h
> new file mode 100644
> index 000000000000..b324eb29c3b6
> --- /dev/null
> +++ b/scripts/livepatch/list.h
> @@ -0,0 +1,389 @@
> [ ... snip ... ]

This file has no license at all, suggested:
/* SPDX-License-Identifier: GPL-2.0 */

-- Joe
