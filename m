Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C82218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551369773;
	bh=gVm2PjyBTaixTjPI4EfkTsBS1hgrUmbLXTea/y8o9EI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0w4Y8I/OZxqlMmg/SRVIY3vDeTj6poFMvtCV10+tumz2FRsPxYf2ohBOj1EROZkud
	 zdhmTsocpwd3bJUtQrh+XAxMl70Zmw17ICB6XParl7CVw4bzSol7EzIxiaL/e/OFTM
	 hFQkrhjiL9eZXxyvqbd0db5cFO0+jE/g8PYKWCdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfB1QCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfB1QCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:02:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA45D2184A;
        Thu, 28 Feb 2019 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551369770;
        bh=gVm2PjyBTaixTjPI4EfkTsBS1hgrUmbLXTea/y8o9EI=;
        h=From:To:Cc:Subject:Date:From;
        b=ET1jYZTidx5mdoJdOuHSHNIfjxRz/794/wbT1Z7RJj+yXFM9CdbSlNwG60RrxlUXP
         TEtkBwRi/n920j789R7sIi74pIm0c4wm7AHAXvIhGuISIeWmdDSelaaulvMBPGHhcm
         1TwBwh140Ay+yDOBP9iMyr86XkXD92t3G0bpKjr0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH v5 0/6] tracing/probes: uaccess: Add support user-space access
Date:   Fri,  1 Mar 2019 01:02:25 +0900
Message-Id: <155136974478.2968.3105123100519786079.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the v5 series of probe-event to support user-space access.
This version I simplified probe_user_read (Thanks PeterZ!) and move
open-coded non-pagefault strnlen_user code to mm/maccess.c.

Changes in v5:
- [3/6]: Simplify probe_user_read() and add strnlen_unsafe_user()
- [4/6]: Use strnlen_unsafe_user()

V4 series is here;

https://lkml.kernel.org/r/155135700242.438.12930250099644500209.stgit@devbox

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

For perf-probe, we can add some attribute for each argument
which indicate that the variable in user space. If gcc/clang
supports debuginfo for __user (address_space attribute),
perf-probe can support it and automatically choose the
correct dereference method. 

Thank you,

---

Masami Hiramatsu (5):
      uaccess: Use user_access_ok() in user_access_begin()
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference
      selftests/ftrace: Add user-memory access syntax testcase

Peter Zijlstra (1):
      uaccess: Add user_access_ok()


 Documentation/trace/kprobetrace.rst                |   28 ++++-
 Documentation/trace/uprobetracer.rst               |    9 +
 arch/x86/include/asm/uaccess.h                     |   10 +-
 include/linux/uaccess.h                            |   34 +++++-
 kernel/trace/trace.c                               |    7 +
 kernel/trace/trace_kprobe.c                        |   35 ++++++
 kernel/trace/trace_probe.c                         |   36 +++++-
 kernel/trace/trace_probe.h                         |    3 
 kernel/trace/trace_probe_tmpl.h                    |   37 +++++-
 kernel/trace/trace_uprobe.c                        |   19 +++
 mm/maccess.c                                       |  122 +++++++++++++++++++-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   31 +++++
 12 files changed, 338 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
