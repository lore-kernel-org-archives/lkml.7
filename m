Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D0C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B60F2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557898684;
	bh=VDqN652jfu2+CsFhKrXWtZSjlc0ZOrvjwHYqGXU4Pcs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=C3K6pVfyc7yBT4aaKBvVVs4g99yowbFN7fkKLL6csH/UsJoAxJWLKbkWVu2QycQ8C
	 T6T4Fq2xf3KNi6jOgbkizdl3b4d4BARHxm5GgjAqIWVOSwxXkMMKRk1ttFX356NGrY
	 ibscn5HDhd1bFd8ALMFyTNefiQS+VRIyGMiwE994=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfEOFiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:38:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D89F20862;
        Wed, 15 May 2019 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898681;
        bh=VDqN652jfu2+CsFhKrXWtZSjlc0ZOrvjwHYqGXU4Pcs=;
        h=From:To:Cc:Subject:Date:From;
        b=YqodSyyoRh7W1gLGV01RvBGbFLvFq6Jgd/xBCgksZsWNgDwx3bHDCG0Pyklx0xCV4
         y2gj2Jj8qCesTcGg3iQdO8wcrVYQKfgS85oZMeSHgKbLBzlDztrxLM54wGOBXZkG2p
         80KU18IflPW+/BmAr+yR11eb6O+sroTvX79Wf6kU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH -tip v9 0/6] tracing/probes: uaccess: Add support user-space access
Date:   Wed, 15 May 2019 14:37:44 +0900
Message-Id: <155789866428.26965.8344923934342528416.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the v9 series of probe-event to support user-space access.
Previous version is here.

https://lkml.kernel.org/r/155741476971.28419.15837024173365724167.stgit@devnote2

In this version, I fixed more typos/style issues.

Changes in v9:
 [3/6]
      - Fix other style & coding issues (Thanks Ingo!)
      - Update fetch_store_string() for style consistency.
 [4/6]
      - Remove an unneeded line break.
      - Move || and && in if-condition at the end of line.

In summary, strncpy_from_user() should work as below

 - strncpy_from_user() can access user memory with set_fs(USER_DS)
   in task context

 - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS)
   in task context (e.g. devtmpfsd and init)

 - strncpy_from_user() can access user/kernel memory (depends on DS)
   in IRQ context if pagefault is disabled. (both verified)

Note that this changes the warning behavior when
CONFIG_DEBUG_ATOMIC_SLEEP=y, it still warns when
__copy_from_user_inatomic() is called in IRQ context, but don't
warn if pagefault is disabled because it will not sleep in
atomic.

====
Kprobe event user-space memory access features:

For user-space access extension, this series adds 2 features,
"ustring" type and user-space dereference syntax. "ustring" is
used for recording a null-terminated string in user-space from
kprobe events.

"ustring" type is easy, it is able to use instead of "string"
type, so if you want to record a user-space string via
"__user char *", you can use ustring type instead of string.
For example,

echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events

will record the path string from user-space.

The user-space dereference syntax is also simple. Thi just
adds 'u' prefix before an offset value.

   +|-u<OFFSET>(<FETCHARG>)

e.g. +u8(%ax), +u0(+0(%si))

This is more generic. If you want to refer the variable in user-
space from its address or access a field in data structure in
user-space, you need to use this.

For example, if you probe do_sched_setscheduler(pid, policy,
param) and record param->sched_priority, you can add new
probe as below;
    
   p do_sched_setscheduler priority=+u0($arg3)

Actually, with this feature, "ustring" type is not absolutely
necessary, because these are same meanings.

  +0($arg2):ustring == +u0($arg2):string

Note that kprobe event provides these methods, but it doesn't
change it from kernel to user automatically because we do not
know whether the given address is in userspace or kernel on
some arch.


Thank you,

---

Masami Hiramatsu (6):
      x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference
      selftests/ftrace: Add user-memory access syntax testcase
      perf-probe: Add user memory access attribute support


 Documentation/trace/kprobetrace.rst                |   28 ++++-
 Documentation/trace/uprobetracer.rst               |   10 +-
 arch/x86/include/asm/uaccess.h                     |    4 -
 include/linux/uaccess.h                            |   19 +++
 kernel/trace/trace.c                               |    7 +
 kernel/trace/trace_kprobe.c                        |   48 +++++++-
 kernel/trace/trace_probe.c                         |   37 +++++-
 kernel/trace/trace_probe.h                         |    3 
 kernel/trace/trace_probe_tmpl.h                    |   36 +++++-
 kernel/trace/trace_uprobe.c                        |   19 +++
 mm/maccess.c                                       |  122 +++++++++++++++++++-
 tools/perf/Documentation/perf-probe.txt            |    3 
 tools/perf/util/probe-event.c                      |   11 ++
 tools/perf/util/probe-event.h                      |    2 
 tools/perf/util/probe-file.c                       |    7 +
 tools/perf/util/probe-file.h                       |    1 
 tools/perf/util/probe-finder.c                     |   19 ++-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 +++++
 18 files changed, 364 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
