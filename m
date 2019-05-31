Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39674C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C0826B79
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315803;
	bh=TYn4XCbuyQQrr0ba3NzLdG0ZB4LCCoCAIhrcCnHK+lk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pAL949qmLTvZRp2TCCusoF6Gwok/ge4maiicHu/kGHAsswWS3AMnNL58CyxehlAIs
	 IPjOXwUJPOL807qKF3Z7yVo9+HwtKpVxpMAFlBO8CcjPLVR26LlCt/beXIoC43W8lv
	 MKuLNYRFzObaJ//je6nIwKQjhXMGjxOC9SntLhW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEaPQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfEaPQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:16:42 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD12726B77;
        Fri, 31 May 2019 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315800;
        bh=TYn4XCbuyQQrr0ba3NzLdG0ZB4LCCoCAIhrcCnHK+lk=;
        h=From:To:Cc:Subject:Date:From;
        b=fd0LebYybwtynYOoZPbKYrA10bGyl8OVS4T2h9OG5huSZd/JdiwfqV3jK+iEzDrU9
         evRPawDrQw95H8KL+woqS5uClrhY/J7N0MS8YsocUXXVsf0WjfzhnUBhQTFQXcBxv3
         AxnRb51aysns4G+TbTgEYDsUdrJ7Ss/VRbz2aGN0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 00/21] tracing/probe: Add multi-probes per event support
Date:   Sat,  1 Jun 2019 00:16:25 +0900
Message-Id: <155931578555.28323.16360245959211149678.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a series to add multi-probes per event support to probe-event.

For trace-event, we can insert same trace-event on several places
on the code, and those can record similar information as a same event
with same format.

This series implements similar feature on probe-event. Since the probe
event is based on the compiled binary, sometimes we find that the target
source line is complied into several different addresses, e.g. inlined
function, unrolled loop, etc. In those cases, it is useful to put a
same probe-event on different addresses.

With this series, we can append multi probes on one event as below

  # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
  # echo p:testevent fork_idle r1=%ax r2=%cx >> kprobe_events
  # kprobe_events
  p:kprobes/testevent _do_fork r1=%ax r2=%dx
  p:kprobes/testevent fork_idle r1=%ax r2=%cx

This means testevent is hit on both of _do_fork and fork_idle.
As you can see, the appended event must have same number of arguments
and those must have same 'type' and 'name' as original one. This is like
a function signature, it checks whether the appending event has the same
type and name of event arguments and same probe type, but doesn't care
about the assignment.

So, below appending commands will be rejected.

  # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
  # echo p:testevent fork_idle r1=%ax >> kprobe_events
  (No 2nd argument)
  # echo p:testevent fork_idle r1=%ax r2=%ax:x8 >> kprobe_events
  (The type of 2nd argument is different)

If one inlined code has an argument on a register, but another
inlined code has fixed value (as a result of optimization),
you can also specify the fixed immediate value, e.g.

  # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
  # echo p:testevent fork_idle r1=%ax r2=\1 >> kprobe_events

Of course, it is hard to find those assignment changes by manual.
I'm preparing another series of patches for perf-probe, which will
automatically find such "cloned" targets and fold those into one
event.
(Should I merge that series into this series?)

Thank you,

---

Masami Hiramatsu (21):
      tracing/kprobe: Set print format right after parsed command
      tracing/uprobe: Set print format when parsing command
      tracing/probe: Add trace_probe init and free functions
      tracing/probe: Add trace_event_call register API for trace_probe
      tracing/probe: Add trace_event_file access APIs for trace_probe
      tracing/probe: Add trace flag access APIs for trace_probe
      tracing/probe: Add probe event name and group name accesses APIs
      tracing/probe: Add trace_event_call accesses APIs
      tracing/kprobe: Check registered state using kprobe
      tracing/probe: Split trace_event related data from trace_probe
      tracing/dynevent: Delete all matched events
      tracing/dynevent: Pass extra arguments to match operation
      tracing/kprobe: Add multi-probe per event support
      tracing/uprobe: Add multi-probe per uprobe event support
      tracing/kprobe: Add per-probe delete from event
      tracing/uprobe: Add per-probe delete from event
      tracing/probe: Add immediate parameter support
      tracing/probe: Add immediate string parameter support
      selftests/ftrace: Add a testcase for kprobe multiprobe event
      selftests/ftrace: Add syntax error test for immediates
      selftests/ftrace: Add syntax error test for multiprobe


 Documentation/trace/kprobetrace.rst                |    1 
 Documentation/trace/uprobetracer.rst               |    1 
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace_dynevent.c                      |   10 
 kernel/trace/trace_dynevent.h                      |    7 
 kernel/trace/trace_events_hist.c                   |    4 
 kernel/trace/trace_kprobe.c                        |  408 +++++++++++---------
 kernel/trace/trace_probe.c                         |  247 ++++++++++++
 kernel/trace/trace_probe.h                         |  121 +++++-
 kernel/trace/trace_uprobe.c                        |  358 ++++++++++--------
 tools/testing/selftests/ftrace/test.d/functions    |    2 
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |   35 ++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   15 +
 13 files changed, 830 insertions(+), 387 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
