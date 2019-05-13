Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F05C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE0216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbdgrK2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfEMSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:38:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43456 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfEMSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:38:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id r3so15944355qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FonCtP1g9Oex74DsB02v8WaXiqf4qMPggv9YSkEBN/8=;
        b=JbdgrK2GRyaknoHdmvBr644KeFWGIJJpta34SGB4pYljZGBNIiDYQ5kOldUaFSyVWD
         ql36Zgo0eTOmjF08fWFLIQQ0Ctuo/W2d2PPKq/dNbfgXjfpi9kM99G2gvY9PFLjL6fiI
         byFIw88wceVLzJhdc0pZb18Izt0wttcCxXulprXnEOtO/VTBJO88G3Z+EtVsaNEM+g+2
         T9HYwbel1lw9gd4QxVsjdfJprN22ro81KDrMIghQyUeiu6vWL9oPWj1T6fSvefmydDcZ
         fnq/KNcckubaiQm9eQiaYzah3k0L6sH4I73z4S2pUT3OgQa8uwiyCwTCTlon2iDGfArq
         ej2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FonCtP1g9Oex74DsB02v8WaXiqf4qMPggv9YSkEBN/8=;
        b=m8N0//B2+b9Un8AldCjFV1o1kY7FOs+L0Z6fJEmFSv1w6CaqeBXyZuiKW/TTkAy5qz
         R4KTqcfOVaODYmAq1jR2/jjKLoKqd4BgNl0YNLQZNHr9LwDX0SHMV6HgPPStNq19+k8+
         1C4y4qP5ozxT1Wy652AM9Mo/1M+R0qc0naJoDDvvUFRPUsAs5T1cL0mlU/dVhMWFvptt
         YY2oesrLTqsiijxmKtHV7c9f6Kz/+xKwgXR68U1Fa5Ifz6DS7+cZNR23N0afWlLJRRkp
         6L6H6LDiiNSr87/sG13NEZAnHXkW8Zd0pZs0svehUTlmOeMBEEh7AkrC1YyUlzfzJ9On
         Hv6w==
X-Gm-Message-State: APjAAAVRH/IiTg9GY5n5wRzbOEZgIlpI8Rlduwa8+iNPqmP/YBe5tu8o
        +nlRixmuTHoVAmEgCqtC8Q8=
X-Google-Smtp-Source: APXvYqwvmSaA3hHxy2BkwfGp3kibDaZ0bPsa4W6dM134scMoUnScBVBCZ0tAJdhC28J73tnabzxbwA==
X-Received: by 2002:a0c:c192:: with SMTP id n18mr24124363qvh.203.1557772708654;
        Mon, 13 May 2019 11:38:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id b22sm4906295qtc.37.2019.05.13.11.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 11:38:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62797403AD; Mon, 13 May 2019 15:38:24 -0300 (-03)
Date:   Mon, 13 May 2019 15:38:24 -0300
To:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v8 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-ID: <20190513183412.GD8003@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155741476971.28419.15837024173365724167.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 10, 2019 at 12:12:49AM +0900, Masami Hiramatsu escreveu:
> Hi,
> 
> Here is the v8 series of probe-event to support user-space access.
> Previous version is here.
> 
> https://lkml.kernel.org/r/155732230159.12756.15040196512285621636.stgit@devnote2
> 
> In this version, I fixed some typos/style issues and renamed fields
> according to Ingo's comment, and added Ack from Steve.
> 
> Also this version is rebased on the latest -tip/master tree.

Ingo, since this touches 'perf probe' and Steven already provided an
Acked-by, if you're ok with it I can process these, testing the 'perf
probe' changes and then ship it to you in my next pull req, ok?

- Arnaldo
 
> Changes in v8:
>  [2/6] Fix style issues and typos according to Ingo's comment.
>  [3/6] Fix style issues according to Ingo's comment.
>  [6/6] Fix a typo and rename user field to user_access field.
> 
> 
> In summary, strncpy_from_user() should work as below
> 
>  - strncpy_from_user() can access user memory with set_fs(USER_DS)
>    in task context
> 
>  - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS)
>    in task context (e.g. devtmpfsd and init)
> 
>  - strncpy_from_user() can access user/kernel memory (depends on DS)
>    in IRQ context if pagefault is disabled. (both verified)
> 
> Note that this changes the warning behavior when
> CONFIG_DEBUG_ATOMIC_SLEEP=y, it still warns when
> __copy_from_user_inatomic() is called in IRQ context, but don't
> warn if pagefault is disabled because it will not sleep in
> atomic.
> 
> ====
> Kprobe event user-space memory access features:
> 
> For user-space access extension, this series adds 2 features,
> "ustring" type and user-space dereference syntax. "ustring" is
> used for recording a null-terminated string in user-space from
> kprobe events.
> 
> "ustring" type is easy, it is able to use instead of "string"
> type, so if you want to record a user-space string via
> "__user char *", you can use ustring type instead of string.
> For example,
> 
> echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events
> 
> will record the path string from user-space.
> 
> The user-space dereference syntax is also simple. Thi just
> adds 'u' prefix before an offset value.
> 
>    +|-u<OFFSET>(<FETCHARG>)
> 
> e.g. +u8(%ax), +u0(+0(%si))
> 
> This is more generic. If you want to refer the variable in user-
> space from its address or access a field in data structure in
> user-space, you need to use this.
> 
> For example, if you probe do_sched_setscheduler(pid, policy,
> param) and record param->sched_priority, you can add new
> probe as below;
>     
>    p do_sched_setscheduler priority=+u0($arg3)
> 
> Actually, with this feature, "ustring" type is not absolutely
> necessary, because these are same meanings.
> 
>   +0($arg2):ustring == +u0($arg2):string
> 
> Note that kprobe event provides these methods, but it doesn't
> change it from kernel to user automatically because we do not
> know whether the given address is in userspace or kernel on
> some arch.
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (6):
>       x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
>       uaccess: Add non-pagefault user-space read functions
>       tracing/probe: Add ustring type for user-space string
>       tracing/probe: Support user-space dereference
>       selftests/ftrace: Add user-memory access syntax testcase
>       perf-probe: Add user memory access attribute support
> 
> 
>  Documentation/trace/kprobetrace.rst                |   28 ++++-
>  Documentation/trace/uprobetracer.rst               |   10 +-
>  arch/x86/include/asm/uaccess.h                     |    4 -
>  include/linux/uaccess.h                            |   19 +++
>  kernel/trace/trace.c                               |    7 +
>  kernel/trace/trace_kprobe.c                        |   37 ++++++
>  kernel/trace/trace_probe.c                         |   37 +++++-
>  kernel/trace/trace_probe.h                         |    3 
>  kernel/trace/trace_probe_tmpl.h                    |   37 +++++-
>  kernel/trace/trace_uprobe.c                        |   19 +++
>  mm/maccess.c                                       |  122 +++++++++++++++++++-
>  tools/perf/Documentation/perf-probe.txt            |    3 
>  tools/perf/util/probe-event.c                      |   11 ++
>  tools/perf/util/probe-event.h                      |    2 
>  tools/perf/util/probe-file.c                       |    7 +
>  tools/perf/util/probe-file.h                       |    1 
>  tools/perf/util/probe-finder.c                     |   19 ++-
>  .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 +++++
>  18 files changed, 357 insertions(+), 41 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
