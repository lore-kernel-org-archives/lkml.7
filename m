Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256BB2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551357030;
	bh=nZThJA0k/dXmNsx3Jg5w9Kntc+Q3P5/MGbyxmmvjaU4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=T5lIS/RiwXck0Vm1Gflub++zG/WZhiZh7WdAOQvsgUlKhp+B51IHpbIUf9Bz/faWz
	 /obq3/shHu3VGq/nCHratZyR1Dg+Em4xevNxWsu2Ek1M+oyFIl7r5S60duljUl/4yn
	 xyv5Ul5MRQJh3HLf4FuYvc9DDR4i4P3VKrpCH+jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfB1Ma2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbfB1Ma2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:30:28 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BA12083D;
        Thu, 28 Feb 2019 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551357027;
        bh=nZThJA0k/dXmNsx3Jg5w9Kntc+Q3P5/MGbyxmmvjaU4=;
        h=From:To:Cc:Subject:Date:From;
        b=Go9rZ8Y94Km5VABpmVkpgWmVpWojR21f/UzQfcfM4crM/3tAbHPjovSce53O201OU
         smzw0RgmpqAbJ8X++9G0hGHtHxej6TcuU57/8vmx+i8cPdoE6Tq6tGtAr3k3MOAEzS
         C6Y36/EN2RfDUYDc620RzBhH/7GtwkthsUS9tIfY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 0/6] tracing/probes: uaccess: Add support user-space access
Date:   Thu, 28 Feb 2019 21:30:03 +0900
Message-Id: <155135700242.438.12930250099644500209.stgit@devbox>
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

Here is the v4 series of probe-event to support user-space access.
This version I fixed some issues pointed out by Steve (Thanks!)
and add a ftrace testcase for this feature.

- [4/6]: Add Steve's Ack
- [5/6]: Fix a bug and documentation
- [6/6]: New: add a new testcase

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


 Documentation/trace/kprobetrace.rst                |   28 +++++-
 Documentation/trace/uprobetracer.rst               |    9 +-
 arch/x86/include/asm/uaccess.h                     |   10 ++
 include/linux/uaccess.h                            |   33 +++++++
 kernel/trace/trace.c                               |    7 +
 kernel/trace/trace_kprobe.c                        |   43 +++++++++
 kernel/trace/trace_probe.c                         |   36 ++++++--
 kernel/trace/trace_probe.h                         |    3 +
 kernel/trace/trace_probe_tmpl.h                    |   37 +++++++-
 kernel/trace/trace_uprobe.c                        |   19 ++++
 mm/maccess.c                                       |   94 +++++++++++++++++++-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   31 +++++++
 12 files changed, 317 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
