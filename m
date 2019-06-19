Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B6C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F421880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956837;
	bh=2Hs26H6sq/rBanLBrUY3STi9babTBtGpAswe+ybrkiA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yq4giqn/MS488ioSBGGu9kkYhjBL8b21g0x4sqFz7jrnd2R72FflOl/1Iw+2CGLOj
	 6xFCBsulh08x7cmsNhnOWB4WrQxhQEByGqfHkNAMTPn83dA5FpTdpSuHJotyh66DB8
	 VkJ18wklDFEM6BK/0ys7OFexUARfELUKPNIXY0mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfFSPHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfFSPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:07:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B732166E;
        Wed, 19 Jun 2019 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956834;
        bh=2Hs26H6sq/rBanLBrUY3STi9babTBtGpAswe+ybrkiA=;
        h=From:To:Cc:Subject:Date:From;
        b=vdYodJXkI5eElfgHeW2Mwn0tQfTT6Lw9KIWGUxoFp1RnXFximO4k8VRpSKHHblzPz
         fRAMmGh7uv4hsmY2t47KB2MqzdctqV6bT/v5ZRogb9XQy+XCx86ql04B1S591c4qfP
         HoQGXVwYD+zclDvv53Kos92anqE888fEtzxEUt+4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 00/12] tracing/probe: Add multi-probes per event support
Date:   Thu, 20 Jun 2019 00:07:09 +0900
Message-Id: <156095682948.28024.14190188071338900568.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the 2nd version of multi-probes per event support on ftrace
and perf-tools.

Previous version is here;
https://lkml.org/lkml/2019/5/31/573

>From this version, I omitted first 9 patches which has been picked
to Steve's tree.
In this version, I've fixed some bugs and hardened some unexpected
error cases according to Steve's comment.
Here are changes in this version:

 - [1/12] This have below changes. 
    - Warn if the primary trace_probe does not exist.
    - Fix enable_trace_kprobe() to not return error if the any probes
      are "gone" state. If all probes have gone or any other error
      reason, the event can not be enabled and return error.
    - Fix trace_probe_enable() to roll back all enabled uprobe if
      any one of uprobe is failed to enable.
 - [7/12] Swap the checking order of filename for avoiding unexpected
     memory access.


====
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


Thank you,

---

Masami Hiramatsu (12):
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
 kernel/trace/trace.c                               |    8 -
 kernel/trace/trace_dynevent.c                      |   10 +
 kernel/trace/trace_dynevent.h                      |    7 -
 kernel/trace/trace_events_hist.c                   |    4 
 kernel/trace/trace_kprobe.c                        |  241 ++++++++++++++----
 kernel/trace/trace_probe.c                         |  176 +++++++++++--
 kernel/trace/trace_probe.h                         |   67 ++++-
 kernel/trace/trace_uprobe.c                        |  263 +++++++++++++++-----
 tools/testing/selftests/ftrace/test.d/functions    |    2 
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |   35 +++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   15 +
 13 files changed, 665 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
