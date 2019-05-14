Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B96C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12321019
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557810184;
	bh=PPf3TTbuKMJ/fkecEWRek7+XnrIVrZrncKfAgPPDnho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xGS4l2TJlFWe/o04djK52nKd2dYPhmhP5lBFC0JPuKZ9l7mKJ3xOpZmHBAWSXyBH7
	 0qY+zyJkSEb2HJV6OyyxUtAPKj7kyaPFFo48sRJSa2HKe+s+PQauaajB1HVkcvNa4t
	 IWYWfCcdyDe/XdFtI79heuDrUkUnizcQuXueKxCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfENFDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENFDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:03:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C2B208C3;
        Tue, 14 May 2019 05:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557810180;
        bh=PPf3TTbuKMJ/fkecEWRek7+XnrIVrZrncKfAgPPDnho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSFUQXic5+OxljCFqRmEotWBNzZdlW9NS7EqMK7FNI06K5Fwk4DtuqXS7hIRPdRO4
         9EDwyVSE0/idp8IrzUzQOUzDWp7JYAbc2qeNmE1fLx93Jn5WqI47mklcqxIi2Moqif
         ePHiSfUZ8KiITaVL0qkzlHBxnkQRdyIoqupr69uc=
Date:   Tue, 14 May 2019 14:02:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20190514140253.1edece79ff72ba47b9a8c72c@kernel.org>
In-Reply-To: <20190513183412.GD8003@kernel.org>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
        <20190513183412.GD8003@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 15:38:24 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, May 10, 2019 at 12:12:49AM +0900, Masami Hiramatsu escreveu:
> > Hi,
> > 
> > Here is the v8 series of probe-event to support user-space access.
> > Previous version is here.
> > 
> > https://lkml.kernel.org/r/155732230159.12756.15040196512285621636.stgit@devnote2
> > 
> > In this version, I fixed some typos/style issues and renamed fields
> > according to Ingo's comment, and added Ack from Steve.
> > 
> > Also this version is rebased on the latest -tip/master tree.
> 
> Ingo, since this touches 'perf probe' and Steven already provided an
> Acked-by, if you're ok with it I can process these, testing the 'perf
> probe' changes and then ship it to you in my next pull req, ok?

Thanks Arnaldo! For the perf probe enhancement, it should work on
the kernel which doesn't support 'u' prefix. :)

Thank you,

> 
> - Arnaldo
>  
> > Changes in v8:
> >  [2/6] Fix style issues and typos according to Ingo's comment.
> >  [3/6] Fix style issues according to Ingo's comment.
> >  [6/6] Fix a typo and rename user field to user_access field.
> > 
> > 
> > In summary, strncpy_from_user() should work as below
> > 
> >  - strncpy_from_user() can access user memory with set_fs(USER_DS)
> >    in task context
> > 
> >  - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS)
> >    in task context (e.g. devtmpfsd and init)
> > 
> >  - strncpy_from_user() can access user/kernel memory (depends on DS)
> >    in IRQ context if pagefault is disabled. (both verified)
> > 
> > Note that this changes the warning behavior when
> > CONFIG_DEBUG_ATOMIC_SLEEP=y, it still warns when
> > __copy_from_user_inatomic() is called in IRQ context, but don't
> > warn if pagefault is disabled because it will not sleep in
> > atomic.
> > 
> > ====
> > Kprobe event user-space memory access features:
> > 
> > For user-space access extension, this series adds 2 features,
> > "ustring" type and user-space dereference syntax. "ustring" is
> > used for recording a null-terminated string in user-space from
> > kprobe events.
> > 
> > "ustring" type is easy, it is able to use instead of "string"
> > type, so if you want to record a user-space string via
> > "__user char *", you can use ustring type instead of string.
> > For example,
> > 
> > echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events
> > 
> > will record the path string from user-space.
> > 
> > The user-space dereference syntax is also simple. Thi just
> > adds 'u' prefix before an offset value.
> > 
> >    +|-u<OFFSET>(<FETCHARG>)
> > 
> > e.g. +u8(%ax), +u0(+0(%si))
> > 
> > This is more generic. If you want to refer the variable in user-
> > space from its address or access a field in data structure in
> > user-space, you need to use this.
> > 
> > For example, if you probe do_sched_setscheduler(pid, policy,
> > param) and record param->sched_priority, you can add new
> > probe as below;
> >     
> >    p do_sched_setscheduler priority=+u0($arg3)
> > 
> > Actually, with this feature, "ustring" type is not absolutely
> > necessary, because these are same meanings.
> > 
> >   +0($arg2):ustring == +u0($arg2):string
> > 
> > Note that kprobe event provides these methods, but it doesn't
> > change it from kernel to user automatically because we do not
> > know whether the given address is in userspace or kernel on
> > some arch.
> > 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (6):
> >       x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
> >       uaccess: Add non-pagefault user-space read functions
> >       tracing/probe: Add ustring type for user-space string
> >       tracing/probe: Support user-space dereference
> >       selftests/ftrace: Add user-memory access syntax testcase
> >       perf-probe: Add user memory access attribute support
> > 
> > 
> >  Documentation/trace/kprobetrace.rst                |   28 ++++-
> >  Documentation/trace/uprobetracer.rst               |   10 +-
> >  arch/x86/include/asm/uaccess.h                     |    4 -
> >  include/linux/uaccess.h                            |   19 +++
> >  kernel/trace/trace.c                               |    7 +
> >  kernel/trace/trace_kprobe.c                        |   37 ++++++
> >  kernel/trace/trace_probe.c                         |   37 +++++-
> >  kernel/trace/trace_probe.h                         |    3 
> >  kernel/trace/trace_probe_tmpl.h                    |   37 +++++-
> >  kernel/trace/trace_uprobe.c                        |   19 +++
> >  mm/maccess.c                                       |  122 +++++++++++++++++++-
> >  tools/perf/Documentation/perf-probe.txt            |    3 
> >  tools/perf/util/probe-event.c                      |   11 ++
> >  tools/perf/util/probe-event.h                      |    2 
> >  tools/perf/util/probe-file.c                       |    7 +
> >  tools/perf/util/probe-file.h                       |    1 
> >  tools/perf/util/probe-finder.c                     |   19 ++-
> >  .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 +++++
> >  18 files changed, 357 insertions(+), 41 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
