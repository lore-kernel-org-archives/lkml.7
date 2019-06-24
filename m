Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36892C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED51320657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyXY13Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfFXSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:40:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35541 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfFXSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:40:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so219550qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xc7E6Q4LnLHryLSmkUg1ksaID9+wBFyavVuJEKGYtS8=;
        b=hyXY13Q4SxuAZDKOEsl8hFJrS5gAfeMSl/aEEme2lcy3YW1kNBByzIwzg+ipH0qM6E
         oBlhXYdUbxOIjK4bV/LLT0H+ibh5RQO8prRq+Oye62SGDTo7UBoxUeaoBeCwRRUiOmpb
         WsLkPYHk7iyRYn+nGO/egIxtZ5vLkIllbsdLDwH0SK1Qpqp3UgCHlLneKdO+67svbIGV
         dKonopel+MR5/6hBmeJppesiC/Md3lbtoXG/q3yUOHiP2ZAQUDDXsSsWqbm337XSCSFz
         bQgR2JhOnS7BihuXdgp/HNzAyZYvtS/qAOpTmLq5igF0u20xmbYMN3lMGuh7MdO8K9Gn
         U2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xc7E6Q4LnLHryLSmkUg1ksaID9+wBFyavVuJEKGYtS8=;
        b=A0obi4ZaziURCQboF75eNVAgLlanaQhexyocOnwuzhbWPhRJtQkhjNG64G2BiSoC5l
         nJ72yK0gBYyVGRAUJUymlfOD3XFR0fY5yW4C5BWVUmJD0FbhON2fcL1I4KDojR7xToqL
         mjA/AXK/soE4pgeOL7FXKyaSPwbfVlYxmP4lunhWrleZ820ex5D0rqUm3/q5p0g0hP7R
         OGBNkR0gHGqj9jcGkbfL6owRn1kd6UwbTff+/4bJzKE+rJjwS8cAWPnXCrp6P5SvkKH6
         qf2gcDALjkTFBeR0J9DJCv/GpA5mjuN93AwjAyLNDiYpHyo6n5qNVKer7SWSuFJ1bFlT
         j5ng==
X-Gm-Message-State: APjAAAXDmOVtTYK5pNQCit63onnjoykUOvyHMCz7HMQjqyoG7h1isosR
        oW35bteDUngfGZJLdzTQxTE=
X-Google-Smtp-Source: APXvYqyQiLOg/yh/Xrp7wE4sYpUdoxTJXEXVCcoE3Wpa0WGyBBpKBZM1ngdu/nBdOmtofweOUgClXA==
X-Received: by 2002:ac8:35c2:: with SMTP id l2mr74141872qtb.123.1561401601341;
        Mon, 24 Jun 2019 11:40:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e63sm6151463qkd.57.2019.06.24.11.40.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:40:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C0E541153; Mon, 24 Jun 2019 15:39:50 -0300 (-03)
Date:   Mon, 24 Jun 2019 15:39:50 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf thread-stack: Fix thread stack return from
 kernel for kernel-only case
Message-ID: <20190624183950.GA4181@kernel.org>
References: <20190619064429.14940-1-adrian.hunter@intel.com>
 <20190619064429.14940-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619064429.14940-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 19, 2019 at 09:44:28AM +0300, Adrian Hunter escreveu:
> Commit f08046cb3082 ("perf thread-stack: Represent jmps to the start of a
> different symbol") had the side-effect of introducing more stack entries
> before return from kernel space. When user space is also traced, those
> entries are popped before entry to user space, but when user space is not
> traced, they get stuck at the bottom of the stack, making the stack grow
> progressively larger. Fix by detecting a return-from-kernel branch type,
> and popping kernel addresses from the stack then.
> 
> Note, the problem and fix affect the exported Call Graph / Tree but not
> the callindent option used by "perf script --call-trace".
> 
> Example:
> 
>   perf-with-kcore record example -e intel_pt//k -- ls
>   perf-with-kcore script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py example.db branches calls
>   ~/libexec/perf-core/scripts/python/exported-sql-viewer.py example.db

Trying with you above instructions I hit some snags, 'perf-with-kcore'
expects the first arg to be the directory where it'll find the perf.data
file, etc, right? I.e. to work I had to do:

[root@quaco tmp]# rm -rf bep
[root@quaco tmp]# rm -rf example.db 
[root@quaco tmp]# perf-with-kcore record bep -e intel_pt//k -- ls
Recording
Using /root/bin/perf
perf version 5.2.rc4.gd1d5628fa057
/root/bin/perf record -o bep/perf.data -e intel_pt//k -- ls
<SNIP>
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.123 MB bep/perf.data ]
Copying kcore
Done
[root@quaco tmp]# perf-with-kcore script bep --itrace=bep -s ~acme/libexec/perf-core/scripts/python/export-to-sqlite.py example.db branches calls
Using /root/bin/perf
perf version 5.2.rc4.gd1d5628fa057
/root/bin/perf script -i bep/perf.data --kallsyms=bep/kcore_dir/kallsyms --itrace=bep -s /home/acme/libexec/perf-core/scripts/python/export-to-sqlite.py example.db branches calls
2019-06-24 15:29:54.910209 Creating database ...
2019-06-24 15:29:54.913351 Writing records...
2019-06-24 15:29:58.009226 Adding indexes
2019-06-24 15:29:58.024644 Done
[root@quaco tmp]#

I.e. add 'bep' after 'script' and before '--itrace-bep'.

I'm fixing this up in the comment, please check.

With that in place I can reproduce your results below.


Thanks,

- Arnaldo
 
>   Menu option: Reports -> Context-Sensitive Call Graph
> 
>   Before: (showing Call Path column only)
> 
>     Call Path
>     ▶ perf
>     ▼ ls
>       ▼ 12111:12111
>         ▶ setup_new_exec
>         ▶ __task_pid_nr_ns
>         ▶ perf_event_pid_type
>         ▶ perf_event_comm_output
>         ▶ perf_iterate_ctx
>         ▶ perf_iterate_sb
>         ▶ perf_event_comm
>         ▶ __set_task_comm
>         ▶ load_elf_binary
>         ▶ search_binary_handler
>         ▶ __do_execve_file.isra.41
>         ▶ __x64_sys_execve
>         ▶ do_syscall_64
>         ▼ entry_SYSCALL_64_after_hwframe
>           ▼ swapgs_restore_regs_and_return_to_usermode
>             ▼ native_iret
>               ▶ error_entry
>               ▶ do_page_fault
>               ▼ error_exit
>                 ▼ retint_user
>                   ▶ prepare_exit_to_usermode
>                   ▼ native_iret
>                     ▶ error_entry
>                     ▶ do_page_fault
>                     ▼ error_exit
>                       ▼ retint_user
>                         ▶ prepare_exit_to_usermode
>                         ▼ native_iret
>                           ▶ error_entry
>                           ▶ do_page_fault
>                           ▼ error_exit
>                             ▼ retint_user
>                               ▶ prepare_exit_to_usermode
>                               ▶ native_iret

T

 
>   After: (showing Call Path column only)
> 
>     Call Path
>     ▶ perf
>     ▼ ls
>       ▼ 12111:12111
>         ▶ setup_new_exec
>         ▶ __task_pid_nr_ns
>         ▶ perf_event_pid_type
>         ▶ perf_event_comm_output
>         ▶ perf_iterate_ctx
>         ▶ perf_iterate_sb
>         ▶ perf_event_comm
>         ▶ __set_task_comm
>         ▶ load_elf_binary
>         ▶ search_binary_handler
>         ▶ __do_execve_file.isra.41
>         ▶ __x64_sys_execve
>         ▶ do_syscall_64
>         ▶ entry_SYSCALL_64_after_hwframe
>         ▶ page_fault
>         ▼ entry_SYSCALL_64
>           ▼ do_syscall_64
>             ▶ __x64_sys_brk
>             ▶ __x64_sys_access
>             ▶ __x64_sys_openat
>             ▶ __x64_sys_newfstat
>             ▶ __x64_sys_mmap
>             ▶ __x64_sys_close
>             ▶ __x64_sys_read
>             ▶ __x64_sys_mprotect
>             ▶ __x64_sys_arch_prctl
>             ▶ __x64_sys_munmap
>             ▶ exit_to_usermode_loop
>             ▶ __x64_sys_set_tid_address
>             ▶ __x64_sys_set_robust_list
>             ▶ __x64_sys_rt_sigaction
>             ▶ __x64_sys_rt_sigprocmask
>             ▶ __x64_sys_prlimit64
>             ▶ __x64_sys_statfs
>             ▶ __x64_sys_ioctl
>             ▶ __x64_sys_getdents64
>             ▶ __x64_sys_write
>             ▶ __x64_sys_exit_group
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/thread-stack.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 8e390f78486f..f91c00dfe23b 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -637,6 +637,23 @@ static int thread_stack__bottom(struct thread_stack *ts,
>  				     true, false);
>  }
>  
> +static int thread_stack__pop_ks(struct thread *thread, struct thread_stack *ts,
> +				struct perf_sample *sample, u64 ref)
> +{
> +	u64 tm = sample->time;
> +	int err;
> +
> +	/* Return to userspace, so pop all kernel addresses */
> +	while (thread_stack__in_kernel(ts)) {
> +		err = thread_stack__call_return(thread, ts, --ts->cnt,
> +						tm, ref, true);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int thread_stack__no_call_return(struct thread *thread,
>  					struct thread_stack *ts,
>  					struct perf_sample *sample,
> @@ -919,7 +936,18 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  			ts->rstate = X86_RETPOLINE_DETECTED;
>  
>  	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
> -		if (!sample->ip || !sample->addr)
> +		if (!sample->addr) {
> +			u32 return_from_kernel = PERF_IP_FLAG_SYSCALLRET |
> +						 PERF_IP_FLAG_INTERRUPT;
> +
> +			if (!(sample->flags & return_from_kernel))
> +				return 0;
> +
> +			/* Pop kernel stack */
> +			return thread_stack__pop_ks(thread, ts, sample, ref);
> +		}
> +
> +		if (!sample->ip)
>  			return 0;
>  
>  		/* x86 retpoline 'return' doesn't match the stack */
> -- 
> 2.17.1

-- 

- Arnaldo
