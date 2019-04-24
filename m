Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0DFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768E3217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfDXVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:18:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfDXVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:18:18 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJPHJ-00076S-C3; Wed, 24 Apr 2019 23:18:05 +0200
Date:   Wed, 24 Apr 2019 23:18:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
In-Reply-To: <20190421183529.9141-1-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019, Aubrey Li wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5ad92419be19..d5a9c5ddd453 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -208,6 +208,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select VIRT_TO_BUS
>  	select X86_FEATURE_NAMES		if PROC_FS
> +	select PROC_PID_ARCH_STATUS		if PROC_FS

Can you please stop mixing arch and proc code? There is no point in
enabling this on x86 right away.

> +
> +config PROC_PID_ARCH_STATUS
> +	bool "Enable /proc/<pid>/arch_status file"

Why is this switchable? x86 selects it if PROC_FS is enabled and all other
architectures are absolutely not interested in this.

> +	default n
> +	help
> +	  Provides a way to examine process architecture specific information.
> +	  See <file:Documentation/filesystems/proc.txt> for more information.

Which contains zero information about this file when only this patch is
applied. 

> @@ -94,6 +94,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/stat.h>
>  #include <linux/posix-timers.h>
> +#include <linux/processor.h>

That include is required because it does NOT contain anything useful for
this, right?

> +/*
> + * Add support for task architecture specific output in /proc/pid/arch_status.
> + * task_arch_status() must be defined in asm/processor.h
> + */
> +#ifdef CONFIG_PROC_PID_ARCH_STATUS
> +# ifndef task_arch_status
> +# define task_arch_status(m, task)
> +# endif

What exactly is the point of this macro mess? If an architecture selects
CONFIG_PROC_PID_ARCH_STATUS then it has to provide proc_task_arch_status()
and the prototype should be in include/linux/proc_fs.h.

> +static int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	task_arch_status(m, task);
> +	return 0;
> +}
> +#endif /* CONFIG_PROC_PID_ARCH_STATUS */

Thanks,

	tglx
