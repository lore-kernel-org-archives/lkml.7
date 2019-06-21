Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADCDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9806208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133888;
	bh=bmmhinY8SaBf9mjaOoJOC0qxeDwt2Gq/4NQji2bO8nc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vPRol5BWH3jPe30KDo8FltGjX9NjbxYm+DLABzFJmHTb+OoxnyPimPh2+aRl5w2nM
	 uHBhN/kc7VlWb+LIjvdtzaVvSlLJ2g3hbIHz3riLlDSO5HfLo1c+5kP6aNqJdVoJSc
	 U7ejKFMcJpEeXlMtQPSIlVLUyvz8EI9gWWEMUE8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFUQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:18:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3BF208C3;
        Fri, 21 Jun 2019 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133885;
        bh=bmmhinY8SaBf9mjaOoJOC0qxeDwt2Gq/4NQji2bO8nc=;
        h=From:To:Cc:Subject:Date:From;
        b=BbY48cE1dNaor+IBZRQ+fR1dj8L8CUTaDo0zwJlTzdL3r2zHNTT1l/9e72Q3mm1p9
         t6CyrYhJwHU4F/CGHCFIWJuxKLEQaVj4dlB78l/V6SFRo4fEpY2HBZS2zIpv2DmsSP
         aVuzIw16Af13DFXAwpqbpvTV0WdSBRHMtEyCb0Nk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 00/11] tracing: of: Boot time tracing using devicetree
Date:   Sat, 22 Jun 2019 01:18:00 +0900
Message-Id: <156113387975.28344.16009584175308192243.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an RFC series of patches to add boot-time tracing using
devicetree.

Currently, kernel support boot-time tracing using kernel command-line
parameters. But that is very limited because of limited expressions
and limited length of command line. Recently, useful features like
histogram, synthetic events, etc. are being added to ftrace, but it is
clear that we can not expand command-line options to support these
features.

Hoever, I've found that there is a devicetree which can pass more
structured commands to kernel at boot time :) The devicetree is usually
used for dscribing hardware configuration, but I think we can expand it
for software configuration too (e.g. AOSP and OPTEE already introduced
firmware node.) Also, grub and qemu already supports loading devicetree,
so we can use it not only on embedded devices but also on x86 PC too.

With the devicetree, we can setup new kprobe and synthetic events, more
complicated event filters and trigger actions including histogram.

For example, following kernel parameters

trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M

it can be written in devicetree like below.

	ftrace {
		compatible = "linux,ftrace";
		options = "sym-addr";
		events = "initcall:*";
		tp-printk;
		buffer-size-kb = <0x400>;	// 1024KB == 1MB
	};

Moreover, now we can expand it to add filters for events, kprobe events,
and synthetic events with histogram like below.

	ftrace {
		compatible = "linux,ftrace";
		...
		event0 {
			event = "task:task_newtask";
			filter = "pid < 128";	// adding filters
			enable;
		};
		event1 {
			event = "kprobes:vfs_read";
			probes = "vfs_read $arg1 $arg2"; // add kprobes
			filter = "common_pid < 200";
			enable;
		};
		event2 {
			event = "initcall_latency";	// add synth event
			fields = "unsigned long func", "u64 lat";
			// with histogram
			actions = "hist:keys=func.sym,lat:vals=lat:sort=lat";
		};
		// and synthetic event callers
		event3 {
			event = "initcall:initcall_start";
			actions = "hist:keys=func:ts0=common_timestamp.usecs";
		};
		event4 {
			event = "initcall:initcall_finish";
			actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)";
		};
	};

These complex configuration can not be done by kernel parameters.
However, this is not replacing boot-time tracing by kernel parameters.
This devicetree settings are applied in fs_initcall() stage, but kernel
parameters are applied earlier stage. Anyway, this is enough useful
for debugging/tracing kernel driver initializations.

I would like to discuss on some points about this idea.

- Can we use devicetree for configuring kernel dynamically?
- Would you have any comment for the devicetree format and default
  behaviors?
- Currently, kprobe and synthetic events are defined inside event
  node, but it is able to define globally in ftrace node. Which is
  better?
- Do we need to support "status" property on each event node so
  that someone can prepare "dtsi" include file and override the status?
- Do we need instance-wide pid filter (set_event_pid) when boot-time?
- Do we need more structured tree, like spliting event and group,
  event actions and probes to be a tree of node, etc?
- Do we need per group filter & enablement support?
- How to support instances? (nested tree or different tree?)
- What kind of options would we need?

Some kernel parameters are not implemented yet, like ftrace_filter,
ftrace_notrace, etc. These will be implemented afterwards.

Thank you,

---

Masami Hiramatsu (11):
      tracing: Apply soft-disabled and filter to tracepoints printk
      tracing: kprobes: Output kprobe event to printk buffer
      tracing: Expose EXPORT_SYMBOL_GPL symbol
      tracing: kprobes: Register to dynevent earlier stage
      tracing: Accept different type for synthetic event fields
      tracing: Add NULL trace-array check in print_synth_event()
      dt-bindings: tracing: Add ftrace binding document
      tracing: of: Add setup tracing by devicetree support
      tracing: of: Add trace event settings
      tracing: of: Add kprobe event support
      tracing: of: Add synthetic event support


 .../devicetree/bindings/tracing/ftrace.yaml        |  170 +++++++++++
 include/linux/trace_events.h                       |    1 
 kernel/trace/Kconfig                               |   10 +
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |   49 ++-
 kernel/trace/trace_events.c                        |    3 
 kernel/trace/trace_events_hist.c                   |   14 +
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_kprobe.c                        |   81 +++--
 kernel/trace/trace_of.c                            |  311 ++++++++++++++++++++
 10 files changed, 589 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tracing/ftrace.yaml
 create mode 100644 kernel/trace/trace_of.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
