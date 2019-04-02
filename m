Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF7AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924302082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554195890;
	bh=GPr5Ji32DfujYAPrI6hhoOiYlLaydBmUmem50BGQnuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjMUldFjmJpm6msXJeXwCLd8iK6Y637tbWqjk82kdg6fr1QqYAx/n/jzPJG8/2IV5
	 oq/nL57tQWr7fMFh1FhYnzKqlZ0LjOxJlPsZbJXGKyKj93cJVhBHBrRgM7dg7ZG5j6
	 BUTlkHh2O79ro6y/1eS3Ic1M4OvgOZvIgdAgO9/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfDBJEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBJEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:04:48 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1957207E0;
        Tue,  2 Apr 2019 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554195887;
        bh=GPr5Ji32DfujYAPrI6hhoOiYlLaydBmUmem50BGQnuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zI4NYLlD0mVBauF8Gz7wn7+TEiz3fWDzqCi/TujvCb/ASUBOHQzKNpEucnXlu2VVs
         OlRzcCHNCMjTmoSKzoAl/Ys3gdElf/XyVyIluIVCgtQMbiHR+kSKlwnHfDPSo0CxKg
         2p+hY41omaP7N+eKO2onBtPyPtG7R3TMFGIx7sqg=
Date:   Tue, 2 Apr 2019 17:04:39 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] csky: add support for libdw
Message-ID: <20190402090439.GA2743@guoren-Inspiron-7460>
References: <cover.1554186270.git.han_mao@c-sky.com>
 <3490576b6f88fc0f0c733282535671d263d67533.1554186270.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3490576b6f88fc0f0c733282535671d263d67533.1554186270.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

On Tue, Apr 02, 2019 at 02:35:43PM +0800, Mao Han wrote:
> diff --git a/tools/arch/csky/include/uapi/asm/perf_regs.h b/tools/arch/csky/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..337d8fa
> --- /dev/null
> +++ b/tools/arch/csky/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef _ASM_CSKY_PERF_REGS_H
> +#define _ASM_CSKY_PERF_REGS_H
> +
> +enum perf_event_csky_regs {
> +	PERF_REG_CSKY_TLS,
> +	PERF_REG_CSKY_LR,
> +	PERF_REG_CSKY_PC,
> +	PERF_REG_CSKY_SR,
> +	PERF_REG_CSKY_SP,
> +	PERF_REG_CSKY_ORIG_A0,
> +	PERF_REG_CSKY_R0,
> +	PERF_REG_CSKY_R1,
> +	PERF_REG_CSKY_R2,
> +	PERF_REG_CSKY_R3,
> +	PERF_REG_CSKY_R4,
> +	PERF_REG_CSKY_R5,
> +	PERF_REG_CSKY_R6,
> +	PERF_REG_CSKY_R7,
> +	PERF_REG_CSKY_R8,
> +	PERF_REG_CSKY_R9,
> +	PERF_REG_CSKY_R10,
> +	PERF_REG_CSKY_R11,
> +	PERF_REG_CSKY_R12,
> +	PERF_REG_CSKY_R13,
> +	PERF_REG_CSKY_R16,
> +	PERF_REG_CSKY_R17,
> +	PERF_REG_CSKY_R18,
> +	PERF_REG_CSKY_R19,
> +	PERF_REG_CSKY_R20,
> +	PERF_REG_CSKY_R21,
> +	PERF_REG_CSKY_R22,
> +	PERF_REG_CSKY_R23,
> +	PERF_REG_CSKY_R24,
> +	PERF_REG_CSKY_R25,
> +	PERF_REG_CSKY_R26,
> +	PERF_REG_CSKY_R27,
> +	PERF_REG_CSKY_R28,
> +	PERF_REG_CSKY_R29,
> +	PERF_REG_CSKY_R30,
> +	PERF_REG_CSKY_HI,
> +	PERF_REG_CSKY_LO,
> +	PERF_REG_CSKY_DCSR,
> +	PERF_REG_CSKY_MAX,
> +};
We should follow pt_regs name in macro:
	PERF_REG_CSKY_A0
	PERF_REG_CSKY_A1
	PERF_REG_CSKY_A2
	PERF_REG_CSKY_A3
	PERF_REG_CSKY_A4
	PERF_REG_CSKY_REGS0
	PERF_REG_CSKY_REGS1
	...
#ifdef __CSKYABIV2__
	PERF_REG_CSKY_EXREGS0
	PERF_REG_CSKY_EXREGS1
	...

> +#endif /* _ASM_CSKY_PERF_REGS_H */
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fe3f97e..42985ae 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -59,6 +59,10 @@ ifeq ($(SRCARCH),arm64)
>    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
>  endif
>  
> +ifeq ($(SRCARCH),csky)
> +  NO_PERF_REGS := 0
> +endif
> +
>  ifeq ($(ARCH),s390)
>    NO_PERF_REGS := 0
>    NO_SYSCALL_TABLE := 0
> @@ -77,7 +81,7 @@ endif
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
>  # to the check.
> -ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390))
> +ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky))
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>  
> diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
> new file mode 100644
> index 0000000..54afe4a
> --- /dev/null
> +++ b/tools/perf/arch/csky/Build
> @@ -0,0 +1 @@
> +libperf-y += util/
> diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
> new file mode 100644
> index 0000000..7fbca17
> --- /dev/null
> +++ b/tools/perf/arch/csky/Makefile
> @@ -0,0 +1,3 @@
> +ifndef NO_DWARF
> +PERF_HAVE_DWARF_REGS := 1
> +endif
> diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
> new file mode 100644
> index 0000000..6baae28
> --- /dev/null
> +++ b/tools/perf/arch/csky/include/perf_regs.h
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include <linux/types.h>
> +#include <asm/perf_regs.h>
> +
> +#define PERF_REGS_MASK	((1ULL << PERF_REG_CSKY_MAX) - 1)
> +#define PERF_REGS_MAX	PERF_REG_CSKY_MAX
> +#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
> +
> +#define PERF_REG_IP	PERF_REG_CSKY_PC
> +#define PERF_REG_SP	PERF_REG_CSKY_SP
> +
> +static inline const char *perf_reg_name(int id)
> +{
> +	switch (id) {
> +	case PERF_REG_CSKY_R0:
> +		return "r0";
	case PERF_REG_CSKY_A0:
		return "a0";

> +	case PERF_REG_CSKY_R4:
> +		return "r4";
	case PERF_REG_CSKY_REGS0
		return "regs0";
...

> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> new file mode 100644
> index 0000000..8e45471
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/Build
> @@ -0,0 +1,2 @@
> +libperf-$(CONFIG_DWARF) += dwarf-regs.o
> +libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/arch/csky/util/dwarf-regs.c
> new file mode 100644
> index 0000000..d9b78e2
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/dwarf-regs.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +// Mapping of DWARF debug register numbers into register names.
> +
> +#include <stddef.h>
> +#include <dwarf-regs.h>
> +
> +#define CSKY_MAX_REGS 71
> +
> +const char *csky_regs_table[CSKY_MAX_REGS] = {
               ^^^^^^^^^^^^^^^
	       csky_dwarf_regs_table ? please add origin dwarf talbe's
	       file path in gcc and add abiv1's.
> +        "%r0", "%r1", "%r2", "%r3", "%r4", "%r5", "%r6", "%r7",
> +        "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%sp", "%lr",
> +        "%r16", "%r17", "%r18", "%r19", "%r20", "%21", "%22", "%23",
                                                    ^^^    ^^^    ^^^
						    %r21?
> +        "%r24", "%r25", "%r26", "%r27", "%r28", "%r29", "%r30", "%tls",
> +        "%pc", "%cc", "%hi", "%lo", "%rr", "%rr", "%rr", "%rr",
> +        "%rr", "%rr", "%rr", "%rr", "%rr", "%rr", "%rr", "%rr",
> +        "%rr", "%rr", "%rr", "%rr", "%vr0", "%vr1", "%vr2", "%vr3",
> +        "%vr4", "%vr5", "%vr6", "%vr7", "%vr8", "%vr9", "%vr10", "%vr11",
> +        "%vr12", "%vr13", "%vr14", "%vr15", "%rr", "%rr", "%epc",
> +};
Please use macro ref: tools/perf/arch/arm64/util/dwarf-regs.c

> +
> +const char *get_arch_regstr(unsigned int n)
> +{
> +        return (n < CSKY_MAX_REGS) ? csky_regs_table[n] : NULL;
> +}
> diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
> new file mode 100644
> index 0000000..1b5b845
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/unwind-libdw.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <elfutils/libdwfl.h>
> +#include "../../util/unwind-libdw.h"
> +#include "../../util/perf_regs.h"
> +#include "../../util/event.h"
> +
> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +{
> +	struct unwind_info *ui = arg;
> +	struct regs_dump *user_regs = &ui->sample->user_regs;
> +	Dwarf_Word dwarf_regs[PERF_REG_CSKY_MAX];
> +
> +#define REG(r) ({						\
> +	Dwarf_Word val = 0;					\
> +	perf_reg_value(&val, user_regs, PERF_REG_CSKY_##r);	\
> +	val;							\
> +})
> +
> +	dwarf_regs[0]  = REG(R0);
> +	dwarf_regs[1]  = REG(R1);
> +	dwarf_regs[2]  = REG(R2);
> +	dwarf_regs[3]  = REG(R3);
> +	dwarf_regs[4]  = REG(R4);
> +	dwarf_regs[5]  = REG(R5);
> +	dwarf_regs[6]  = REG(R6);
> +	dwarf_regs[7]  = REG(R7);
> +	dwarf_regs[8]  = REG(R8);
> +	dwarf_regs[9]  = REG(R9);
> +	dwarf_regs[10] = REG(R10);
> +	dwarf_regs[11] = REG(R11);
> +	dwarf_regs[12] = REG(R12);
> +	dwarf_regs[13] = REG(R13);
> +	dwarf_regs[14] = REG(SP);
> +	dwarf_regs[15] = REG(LR);
> +	dwarf_regs[16] = REG(R16);
> +	dwarf_regs[17] = REG(R17);
> +	dwarf_regs[18] = REG(R18);
> +	dwarf_regs[19] = REG(R19);
> +	dwarf_regs[20] = REG(R20);
> +	dwarf_regs[21] = REG(R21);
> +	dwarf_regs[22] = REG(R22);
> +	dwarf_regs[23] = REG(R23);
> +	dwarf_regs[24] = REG(R24);
> +	dwarf_regs[25] = REG(R25);
> +	dwarf_regs[26] = REG(R26);
> +	dwarf_regs[27] = REG(R27);
> +	dwarf_regs[28] = REG(R28);
> +	dwarf_regs[29] = REG(R29);
> +	dwarf_regs[30] = REG(R30);
> +	dwarf_regs[31] = REG(TLS);
> +	dwarf_regs[32] = REG(PC);
> +	dwfl_thread_state_register_pc(thread, dwarf_regs[32]);
> +
> +	return dwfl_thread_state_registers(thread, 0, PERF_REG_CSKY_MAX,
> +					   dwarf_regs);
> +}
Try LIBUNWIND__ARCH_REG_ID, see:
tools/perf/arch/arm64/util/unwind-libunwind.c

Best Regards
 Guo Ren
