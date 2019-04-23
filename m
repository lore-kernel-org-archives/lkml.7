Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C797C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDE420652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDWUNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:13:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWUNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:13:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E31533092670;
        Tue, 23 Apr 2019 20:13:12 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4B060C62;
        Tue, 23 Apr 2019 20:13:11 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:13:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 1/6] objtool: Refactor code to make it more suitable for
 multiple architecture support
Message-ID: <20190423201306.wyb57hz7xrvqbn75@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-2-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-2-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 23 Apr 2019 20:13:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:52:38PM +0100, Raphael Gault wrote:
> The jump destination and relocation offset used previously are only reliable
> on x86_64 architecture. We abstract these computations by calling arch-dependant

"dependent"

> implementation.
> 
> The control flow information and register macro definitions were based on
> the x86_64 architecture but should be abstract so that each architecture
> can define the correct values for the registers, especially the registers
> related to the stack frame (Frame Pointer, Stack Pointer and possibly
> Return Address).
> 
> The ORC unwinder is only supported on x86 at the moment and should thus be
> in the x86 architecture code. In order not to break the whole structure in
> case another architecture decides to support the ORC unwinder via objtool
> we choose to let the implementation be done in the architecture dependant
> code.

It's good practice to put each logical change into a separate patch.
That will also make the patches easier to review.

For example, each of the above three paragraphs should be a separate
commit.

Also it's a good idea to run the patches through checkpatch.pl (though
its warnings should be taken with a grain of salt).

> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/objtool/Build                           |   1 -
>  tools/objtool/arch.h                          |   9 ++
>  tools/objtool/arch/x86/Build                  |   1 +
>  tools/objtool/arch/x86/decode.c               | 106 ++++++++++++++++
>  tools/objtool/arch/x86/include/arch_special.h |  35 ++++++
>  tools/objtool/{ => arch/x86/include}/cfi.h    |   0
>  tools/objtool/{ => arch/x86}/orc_gen.c        |  10 +-
>  tools/objtool/check.c                         | 114 ++----------------
>  tools/objtool/check.h                         |   1 +
>  tools/objtool/orc.h                           |   4 +-
>  tools/objtool/special.c                       |  18 +--
>  11 files changed, 173 insertions(+), 126 deletions(-)
>  create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>  rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
>  rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
> 
> diff --git a/tools/objtool/Build b/tools/objtool/Build
> index 749becdf5b90..ec925d49565a 100644
> --- a/tools/objtool/Build
> +++ b/tools/objtool/Build
> @@ -2,7 +2,6 @@ objtool-y += arch/$(SRCARCH)/
>  objtool-y += builtin-check.o
>  objtool-y += builtin-orc.o
>  objtool-y += check.o
> -objtool-y += orc_gen.o

I'm not sure whether moving ORC out to the arch-specific code is the
best option.  I expect a lot of the ORC code to be generic.  But this
might be ok for now, until we get another ORC implementation.

Another possibility would be to make weak versions of the orc functions
somewhere (check.c?) and only compile the generic orc_gen.c on arches
which support it.  Then we could abstract out the arch-specific ORC bits
later.

>  objtool-y += orc_dump.o

orc_dump.o doesn't need to be built on arm64.  The "orc dump" option
should fail accordingly.

>  objtool-y += elf.o
>  objtool-y += special.o
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index b0d7dc3d71b5..0eff166ca613 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -22,6 +22,7 @@
>  #include <linux/list.h>
>  #include "elf.h"
>  #include "cfi.h"
> +#include "orc.h"
>  
>  #define INSN_JUMP_CONDITIONAL	1
>  #define INSN_JUMP_UNCONDITIONAL	2
> @@ -70,6 +71,8 @@ struct stack_op {
>  	struct op_src src;
>  };
>  
> +struct instruction;
> +
>  void arch_initial_func_cfi_state(struct cfi_state *state);
>  
>  int arch_decode_instruction(struct elf *elf, struct section *sec,
> @@ -79,4 +82,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>  
>  bool arch_callee_saved_reg(unsigned char reg);
>  
> +int arch_orc_read_unwind_hints(struct objtool_file *file);
> +
> +unsigned long arch_compute_jump_destination(struct instruction *insn);
> +
> +unsigned long arch_compute_rela_sym_offset(int addend);

arch_dest_rela_addend_offset() might be a more descriptive name.  Also
it might be simpler to just make it an arch-specific macro which is 0 on
arm64 and 4 on x86.

"compute" is implied, it can probably be removed from the names to make
them a little more concise.

> +
>  #endif /* _ARCH_H */
> diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
> index b998412c017d..74015be53ef0 100644
> --- a/tools/objtool/arch/x86/Build
> +++ b/tools/objtool/arch/x86/Build
> @@ -1,4 +1,5 @@
>  objtool-y += decode.o
> +objtool-y += orc_gen.o
>  
>  inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
>  inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 540a209b78ab..1af7b4996307 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -23,6 +23,8 @@
>  #include "lib/inat.c"
>  #include "lib/insn.c"
>  
> +
> +#include "../../check.h"
>  #include "../../elf.h"
>  #include "../../arch.h"
>  #include "../../warn.h"
> @@ -78,6 +80,105 @@ bool arch_callee_saved_reg(unsigned char reg)
>  	}
>  }
>  
> +unsigned long arch_compute_rela_sym_offset(int addend)
> +{
> +	return addend + 4;
> +}
> +
> +int arch_orc_read_unwind_hints(struct objtool_file *file)

I think this function would be better suited for orc_gen.c (which could
be renamed to just orc.c).

> diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
> new file mode 100644
> index 000000000000..bd91b1096359
> --- /dev/null
> +++ b/tools/objtool/arch/x86/include/arch_special.h
> @@ -0,0 +1,35 @@
> +/*
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

This needs the standard header macro guards, e.g.

#ifndef _X86_ARCH_SPECIAL_H
#define _X86_ARCH_SPECIAL_H

> +
> +#define EX_ENTRY_SIZE		12
> +#define EX_ORIG_OFFSET		0
> +#define EX_NEW_OFFSET		4
> +
> +#define JUMP_ENTRY_SIZE		16
> +#define JUMP_ORIG_OFFSET	0
> +#define JUMP_NEW_OFFSET		4
> +
> +#define ALT_ENTRY_SIZE		13
> +#define ALT_ORIG_OFFSET		0
> +#define ALT_NEW_OFFSET		4
> +#define ALT_FEATURE_OFFSET	8
> +#define ALT_ORIG_LEN_OFFSET	10
> +#define ALT_NEW_LEN_OFFSET	11
> +
> +#define IGNORE_SHF_EXEC_FLAG	0
> +
> +#define JUMP_DYNAMIC_IS_SWITCH_TABLE	0

These flags should be added with the commit which actually uses them.

Also "arch_special.h" is specific to special section parsing, so I'm
thinking these two macros don't really belong here.  Or maybe the header
file could be renamed to something more generic.

-- 
Josh
