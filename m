Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49055C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDWUS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E690930ADBC9;
        Tue, 23 Apr 2019 20:18:28 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8FBE10018E0;
        Tue, 23 Apr 2019 20:18:26 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:18:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 2/6] objtool: arm64: Add required implementation for
 supporting the aarch64 architecture in objtool.
Message-ID: <20190423201823.fnddnyxpu64jnlgp@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-3-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-3-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 23 Apr 2019 20:18:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:52:39PM +0100, Raphael Gault wrote:
> Provide implementation for the arch-dependent functions that are called by the main check
> function of objtool.
> The ORC unwinder is not yet supported by the arm64 architecture so we only provide a dummy
> interface for now.
> The decoding of the instruction is split into classes and subclasses as described into
> the Instruction Encoding in the ArmV8.5 Architecture Reference Manual.

Where did the code for the decoder come from?  Was it written from
scratch?

> diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
> new file mode 100644
> index 000000000000..54bcce4c58c0
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/arch_special.h
> @@ -0,0 +1,44 @@
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
> +

Needs a header guard.

> +#define EX_ENTRY_SIZE		8
> +#define EX_ORIG_OFFSET		0
> +#define EX_NEW_OFFSET		4
> +
> +#define JUMP_ENTRY_SIZE		16
> +#define JUMP_ORIG_OFFSET	0
> +#define JUMP_NEW_OFFSET		4
> +
> +#define ALT_ENTRY_SIZE		12
> +#define ALT_ORIG_OFFSET		0
> +#define ALT_NEW_OFFSET		4
> +#define ALT_FEATURE_OFFSET	8
> +#define ALT_ORIG_LEN_OFFSET	10
> +#define ALT_NEW_LEN_OFFSET	11
> +
> +/*
> + * On arm64 the .altinstr_replacement is not always marked
> + * as containing executable instruction. But we still want
> + * to process it so we ignore the SHF_EXEC flag
> + */
> +#define IGNORE_SHF_EXEC_FLAG	1
> +
> +/*
> + * The jump table detection is not the same on arm64 so for
> + * now we just detect if it is a dynamic jump (br <Xn> insn)
> + */
> +#define JUMP_DYNAMIC_IS_SWITCH_TABLE	1

Same as for x86, these flags should be added in the same patch which
uses them.

> +
> +#define X86_FEATURE_POPCNT (4*32+23)
> diff --git a/tools/objtool/arch/arm64/include/asm/orc_types.h b/tools/objtool/arch/arm64/include/asm/orc_types.h
> new file mode 100644
> index 000000000000..46f516dd80ce
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/asm/orc_types.h
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
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
> +
> +#ifndef _ORC_TYPES_H
> +#define _ORC_TYPES_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +
> +/*
> + * The ORC_REG_* registers are base registers which are used to find other
> + * registers on the stack.
> + *
> + * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
> + * address of the previous frame: the caller's SP before it called the current
> + * function.
> + *
> + * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
> + * the current frame.
> + *
> + * The most commonly used base registers are SP and BP -- which the previous SP
> + * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
> + * usually based on.
> + *
> + * The rest of the base registers are needed for special cases like entry code
> + * and GCC realigned stacks.
> + */
> +#define ORC_REG_UNDEFINED		0
> +#define ORC_REG_PREV_SP			1
> +#define ORC_REG_DX			2
> +#define ORC_REG_DI			3
> +#define ORC_REG_BP			4
> +#define ORC_REG_SP			5
> +#define ORC_REG_R10			6
> +#define ORC_REG_R13			7
> +#define ORC_REG_BP_INDIRECT		8
> +#define ORC_REG_SP_INDIRECT		9
> +#define ORC_REG_MAX			15
> +
> +/*
> + * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
> + * caller's SP right before it made the call).  Used for all callable
> + * functions, i.e. all C code and all callable asm functions.
> + *
> + * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
> + * to a fully populated pt_regs from a syscall, interrupt, or exception.
> + *
> + * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
> + * points to the iret return frame.
> + *
> + * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
> + * aren't used in struct orc_entry due to size and complexity constraints.
> + * Objtool converts them to real types when it converts the hints to orc
> + * entries.
> + */
> +#define ORC_TYPE_CALL			0
> +#define ORC_TYPE_REGS			1
> +#define ORC_TYPE_REGS_IRET		2
> +#define UNWIND_HINT_TYPE_SAVE		3
> +#define UNWIND_HINT_TYPE_RESTORE	4
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * This struct is more or less a vastly simplified version of the DWARF Call
> + * Frame Information standard.  It contains only the necessary parts of DWARF
> + * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
> + * unwinder how to find the previous SP and BP (and sometimes entry regs) on
> + * the stack for a given code address.  Each instance of the struct corresponds
> + * to one or more code locations.
> + */
> +struct orc_entry {
> +	s16		sp_offset;
> +	s16		bp_offset;
> +	unsigned	sp_reg:4;
> +	unsigned	bp_reg:4;
> +	unsigned	type:2;
> +	unsigned	end:1;
> +} __packed;
> +
> +/*
> + * This struct is used by asm and inline asm code to manually annotate the
> + * location of registers on the stack for the ORC unwinder.
> + *
> + * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
> + */
> +struct unwind_hint {
> +	u32		ip;
> +	s16		sp_offset;
> +	u8		sp_reg;
> +	u8		type;
> +	u8		end;
> +};
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ORC_TYPES_H */

It seems odd to have the above header file in arm64 code, since it
doesn't implement ORC.  Is it really needed?

-- 
Josh
