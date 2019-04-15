Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB84C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A4520825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555309716;
	bh=/wFgb+3kpwuAEzHNzIFgWV58Rb7g7mRG14TDGPLj4wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c+qZNNl1gM2A1Ccha978VfEMhBqrIGAF/kHID6VNUXunDrK7HWSSXSgbw75E68kt9
	 hePRRL7O8cv47a71V2i69Mr6NL+9vaYuZ50I6tYv8E+40o5Ovu0EotwcbdW7gwLdgC
	 uZAmS4KOfRr4CvHP3rvDg2xTp6LsM968RX1qgv7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDOG2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfDOG2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:28:34 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8E820674;
        Mon, 15 Apr 2019 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555309713;
        bh=/wFgb+3kpwuAEzHNzIFgWV58Rb7g7mRG14TDGPLj4wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYtgC2Dj6mG9c6WsQtYdpVlbinVFPnzsihb3EjsHYRdZn4N6g5TpnWGnCb2nwm1lG
         Kg6wnj7a1VMJbRlRlbta/G9NzKMymjUUiiSBv1P74dZoENYV0ubLdlZYRfJ/h8Bf4e
         4SJ1XO0hHJKr6kwGTWo/DW2yhXLXYTrCGvYaJfLk=
Date:   Mon, 15 Apr 2019 14:28:06 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 3/3] csky: Add support for libdw
Message-ID: <20190415062806.GA1720@guoren-Inspiron-7460>
References: <cover.1554967684.git.han_mao@c-sky.com>
 <7901e20b00a9186a5314999ba05b4e5ab2c4d19f.1554967684.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7901e20b00a9186a5314999ba05b4e5ab2c4d19f.1554967684.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 03:45:01PM +0800, Mao Han wrote:
> This patch add support for DWARF register mappings and libdw registers
> initialization, which is used by perf callchain analyzing when
> --call-graph=dwarf is given.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@redhat.com>
> CC: Namhyung Kim <namhyung@kernel.org>
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> ---
>  tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
>  tools/perf/Makefile.config                   |   6 +-
>  tools/perf/arch/csky/Build                   |   1 +
>  tools/perf/arch/csky/Makefile                |   3 +
>  tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
>  tools/perf/arch/csky/util/Build              |   2 +
>  tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
>  tools/perf/arch/csky/util/unwind-libdw.c     |  78 +++++++++++++++++++++
>  8 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/csky/Build
>  create mode 100644 tools/perf/arch/csky/Makefile
>  create mode 100644 tools/perf/arch/csky/include/perf_regs.h
>  create mode 100644 tools/perf/arch/csky/util/Build
>  create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
> 
> diff --git a/tools/arch/csky/include/uapi/asm/perf_regs.h b/tools/arch/csky/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..ee323d8
> --- /dev/null
> +++ b/tools/arch/csky/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef _ASM_CSKY_PERF_REGS_H
> +#define _ASM_CSKY_PERF_REGS_H
> +
> +/* Index of struct pt_regs */
> +enum perf_event_csky_regs {
> +	PERF_REG_CSKY_TLS,
> +	PERF_REG_CSKY_LR,
> +	PERF_REG_CSKY_PC,
> +	PERF_REG_CSKY_SR,
> +	PERF_REG_CSKY_SP,
> +	PERF_REG_CSKY_ORIG_A0,
> +	PERF_REG_CSKY_A0,
> +	PERF_REG_CSKY_A1,
> +	PERF_REG_CSKY_A2,
> +	PERF_REG_CSKY_A3,
> +	PERF_REG_CSKY_REGS0,
> +	PERF_REG_CSKY_REGS1,
> +	PERF_REG_CSKY_REGS2,
> +	PERF_REG_CSKY_REGS3,
> +	PERF_REG_CSKY_REGS4,
> +	PERF_REG_CSKY_REGS5,
> +	PERF_REG_CSKY_REGS6,
> +	PERF_REG_CSKY_REGS7,
> +	PERF_REG_CSKY_REGS8,
> +	PERF_REG_CSKY_REGS9,
> +#if defined(__CSKYABIV2__)
> +	PERF_REG_CSKY_EXREGS0,
> +	PERF_REG_CSKY_EXREGS1,
> +	PERF_REG_CSKY_EXREGS2,
> +	PERF_REG_CSKY_EXREGS3,
> +	PERF_REG_CSKY_EXREGS4,
> +	PERF_REG_CSKY_EXREGS5,
> +	PERF_REG_CSKY_EXREGS6,
> +	PERF_REG_CSKY_EXREGS7,
> +	PERF_REG_CSKY_EXREGS8,
> +	PERF_REG_CSKY_EXREGS9,
> +	PERF_REG_CSKY_EXREGS10,
> +	PERF_REG_CSKY_EXREGS11,
> +	PERF_REG_CSKY_EXREGS12,
> +	PERF_REG_CSKY_EXREGS13,
> +	PERF_REG_CSKY_EXREGS14,
> +	PERF_REG_CSKY_HI,
> +	PERF_REG_CSKY_LO,
> +	PERF_REG_CSKY_DCSR,
> +#endif
> +	PERF_REG_CSKY_MAX,
> +};
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
> index 0000000..e4e5f33
> --- /dev/null
> +++ b/tools/perf/arch/csky/Build
> @@ -0,0 +1 @@
> +perf-y += util/
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
> index 0000000..8f336ea
> --- /dev/null
> +++ b/tools/perf/arch/csky/include/perf_regs.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
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
> +	case PERF_REG_CSKY_A0:
> +		return "a0";
> +	case PERF_REG_CSKY_A1:
> +		return "a1";
> +	case PERF_REG_CSKY_A2:
> +		return "a2";
> +	case PERF_REG_CSKY_A3:
> +		return "a3";
> +	case PERF_REG_CSKY_REGS0:
> +		return "regs0";
> +	case PERF_REG_CSKY_REGS1:
> +		return "regs1";
> +	case PERF_REG_CSKY_REGS2:
> +		return "regs2";
> +	case PERF_REG_CSKY_REGS3:
> +		return "regs3";
> +	case PERF_REG_CSKY_REGS4:
> +		return "regs4";
> +	case PERF_REG_CSKY_REGS5:
> +		return "regs5";
> +	case PERF_REG_CSKY_REGS6:
> +		return "regs6";
> +	case PERF_REG_CSKY_REGS7:
> +		return "regs7";
> +	case PERF_REG_CSKY_REGS8:
> +		return "regs8";
> +	case PERF_REG_CSKY_REGS9:
> +		return "regs9";
> +	case PERF_REG_CSKY_SP:
> +		return "sp";
> +	case PERF_REG_CSKY_LR:
> +		return "lr";
> +	case PERF_REG_CSKY_PC:
> +		return "pc";
> +#if defined(__CSKYABIV2__)
> +	case PERF_REG_CSKY_EXREGS0:
> +		return "exregs0";
> +	case PERF_REG_CSKY_EXREGS1:
> +		return "exregs1";
> +	case PERF_REG_CSKY_EXREGS2:
> +		return "exregs2";
> +	case PERF_REG_CSKY_EXREGS3:
> +		return "exregs3";
> +	case PERF_REG_CSKY_EXREGS4:
> +		return "exregs4";
> +	case PERF_REG_CSKY_EXREGS5:
> +		return "exregs5";
> +	case PERF_REG_CSKY_EXREGS6:
> +		return "exregs6";
> +	case PERF_REG_CSKY_EXREGS7:
> +		return "exregs7";
> +	case PERF_REG_CSKY_EXREGS8:
> +		return "exregs8";
> +	case PERF_REG_CSKY_EXREGS9:
> +		return "exregs9";
> +	case PERF_REG_CSKY_EXREGS10:
> +		return "exregs10";
> +	case PERF_REG_CSKY_EXREGS11:
> +		return "exregs11";
> +	case PERF_REG_CSKY_EXREGS12:
> +		return "exregs12";
> +	case PERF_REG_CSKY_EXREGS13:
> +		return "exregs13";
> +	case PERF_REG_CSKY_EXREGS14:
> +		return "exregs14";
> +	case PERF_REG_CSKY_TLS:
> +		return "tls";
> +	case PERF_REG_CSKY_HI:
> +		return "hi";
> +	case PERF_REG_CSKY_LO:
> +		return "lo";
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> new file mode 100644
> index 0000000..1160bb2
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/Build
> @@ -0,0 +1,2 @@
> +perf-$(CONFIG_DWARF) += dwarf-regs.o
> +perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/arch/csky/util/dwarf-regs.c
> new file mode 100644
> index 0000000..3591ca1
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/dwarf-regs.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +// Mapping of DWARF debug register numbers into register names.
> +
> +#include <stddef.h>
> +#include <dwarf-regs.h>
> +
> +#if defined(__CSKYABIV2__)
> +#define CSKY_MAX_REGS 71
> +const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
> +	/* r0 ~ r8 */
> +	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
> +	/* r9 ~ r15 */
> +	"%regs4", "%regs5", "%regs6", "%regs7", "%regs8", "%regs9", "%sp",
> +	"%lr",
> +	/* r16 ~ r23 */
> +	"%exregs0", "%exregs1", "%exregs2", "%exregs3", "%exregs4",
> +	"%exregs5", "%exregs6", "%exregs7",
> +	/* r24 ~ r31 */
> +	"%exregs8", "%exregs9", "%exregs10", "%exregs11", "%exregs12",
> +	"%exregs13", "%exregs14", "%tls",
> +	"%pc", "%cc", "%hi", "%lo", NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL, NULL, "%vr0", "%vr1", "%vr2", "%vr3",
> +	"%vr4", "%vr5", "%vr6", "%vr7", "%vr8", "%vr9", "%vr10", "%vr11",
> +	"%vr12", "%vr13", "%vr14", "%vr15", NULL, NULL, "%epc",
Remove vr0-vr15 first.

> +};
> +#else
> +#define CSKY_MAX_REGS 70
> +const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
> +	/* r0 ~ r8 */
> +	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
> +	/* r9 ~ r15 */
> +	"%regs2", "%regs3", "%regs4", "%regs5", "%regs6", "%regs7", "%regs8",
> +	"%lr",
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +	"%vap", "%cc", "%vfp", "%epc", "%hi", "%lo", "%fr0", "%fr1",
> +	"%fr2", "%fr3", "%fr4", "%fr5", "%fr6", "%fr7", "%fr8", "%fr9",
> +	"%fr10", "%fr11", "%fr12", "%fr13", "%fr14", "%fr15", "%fr16", "%fr17",
> +	"%fr18", "%fr19", "%fr20", "%fr21", "%fr22", "%fr23", "%fr24", "%fr25",
> +	"%fr26", "%fr27", "%fr28", "%fr29", "%fr30", "%fr31"
Please remove vap cc vfp hi lo fr0~fr31, current abiv1 linux couldn't
suppport them.

Best Regards
 Guo Ren
