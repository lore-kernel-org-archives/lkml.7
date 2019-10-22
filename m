Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256BC21906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJVTvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbfJVTvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:51:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251B721872;
        Tue, 22 Oct 2019 19:51:06 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:51:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hassan Naveed <hnaveed@wavecomp.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] TRACING: FTRACE: Use xarray structure for ftrace
 syscalls
Message-ID: <20191022155104.29b062a5@gandalf.local.home>
In-Reply-To: <20191022182303.14829-1-hnaveed@wavecomp.com>
References: <20191022182303.14829-1-hnaveed@wavecomp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 18:24:25 +0000
Hassan Naveed <hnaveed@wavecomp.com> wrote:


Nit, the subject should simply be:

 "tracing: Use xarray for syscall trace events"


> Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
> ---
>  kernel/trace/trace_syscalls.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index f93a56d2db27..1fee710be874 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>	/* for MODULE_NAME_LEN via KSYM_SYMBOL_LEN */
>  #include <linux/ftrace.h>
>  #include <linux/perf_event.h>
> +#include <linux/xarray.h>
>  #include <asm/syscall.h>
>  
>  #include "trace_output.h"
> @@ -30,7 +31,7 @@ syscall_get_enter_fields(struct trace_event_call *call)
>  extern struct syscall_metadata *__start_syscalls_metadata[];
>  extern struct syscall_metadata *__stop_syscalls_metadata[];
>  
> -static struct syscall_metadata **syscalls_metadata;
> +static DEFINE_XARRAY(syscalls_metadata);
>  
>  #ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME
>  static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> @@ -101,10 +102,7 @@ find_syscall_meta(unsigned long syscall)
>  
>  static struct syscall_metadata *syscall_nr_to_meta(int nr)
>  {
> -	if (!syscalls_metadata || nr >= NR_syscalls || nr < 0)
> -		return NULL;
> -
> -	return syscalls_metadata[nr];
> +	return xa_load(&syscalls_metadata, (unsigned long)nr);
>  }
>  
>  const char *get_syscall_name(int syscall)
> @@ -535,13 +533,6 @@ void __init init_ftrace_syscalls(void)
>  	unsigned long addr;
>  	int i;
>  
> -	syscalls_metadata = kcalloc(NR_syscalls, sizeof(*syscalls_metadata),
> -				    GFP_KERNEL);
> -	if (!syscalls_metadata) {
> -		WARN_ON(1);
> -		return;
> -	}
> -
>  	for (i = 0; i < NR_syscalls; i++) {
>  		addr = arch_syscall_addr(i);
>  		meta = find_syscall_meta(addr);
> @@ -549,7 +540,7 @@ void __init init_ftrace_syscalls(void)
>  			continue;
>  
>  		meta->syscall_nr = i;
> -		syscalls_metadata[i] = meta;
> +		xa_store(&syscalls_metadata, i, meta, GFP_KERNEL);

Shouldn't xa_store() return be tested for memory failure?

-- Steve

>  	}
>  }
>  

