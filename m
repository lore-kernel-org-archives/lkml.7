Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1735DC7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D691220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167478;
	bh=selCjENc71nRH2XChEP9mH/5ybMV3GO3uOR2DbcAb3s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YZ3yFaPmIex8/fr6JnxbTKRXGgv3i6+hyYQ9QICiMR6FoSEuoIFFAa8WEefYu94Ae
	 u8Gmwk4B4ullfWvA/j11kWODaUSSyp2J5pngGKSmc4wt2dsuz3ZWj4OUZdO6E6sSp6
	 L5OW/1AEEndyNBWocXQoloqsHeKNjXuM6UCdRxbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfGOFLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfGOFLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:11:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9EC20868;
        Mon, 15 Jul 2019 05:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167474;
        bh=selCjENc71nRH2XChEP9mH/5ybMV3GO3uOR2DbcAb3s=;
        h=From:To:Cc:Subject:Date:From;
        b=2cebDNwsxh/f5Wq2z+jUtYslgOZnI8+rS8XmOFdsO5RPlhvCtD7UNHbN3oJw1Egep
         RxKyYMJmqW5KIiltUeR3Akxj/YrT5k/e3GeLMJ/DnTEs+MBz6Lnct/WPHxFuWHrUkh
         Rt4CbVcIoevW7S0T0s6NmdlC14zcCLSaJHCl2BEo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v2 00/15] tracing: of: Boot time tracing using devicetree
Date:   Mon, 15 Jul 2019 14:11:08 +0900
Message-Id: <156316746861.23477.5815110570539190650.stgit@devnote2>
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

Here is the 2nd version of RFC series to add boot-time tracing using
devicetree. Previous thread is here.

https://lkml.kernel.org/r/156113387975.28344.16009584175308192243.stgit@devnote2

In this version, I moved the ftrace node under /chosen/linux,ftrace
and remove compatible property, because it must be in fixed place.
Also this version has following features;

 - Introduce "instance" node, which can have events nodes for setting
   events filters and actions for the trace instance.
 - Introduce "cpumask" property
 - Introduce "ftrace-filters" and "ftrace-notraces"
 - Introduce "fgraph-filters", "fgraph-notraces" and "fgraph-max-depth"

At this moment, this feature is only available on the architecutre which
supports devicetree. For x86, we can use it on qemu with --dtb option,
or apply below patch on grub to add devicetree support on grub-x86.

https://github.com/mhiramat/grub/commit/644c35bfd2d18c772cc353b74215344f8264923a

Note that the devicetree for x86 must contain the nodes only under
/chosen/, or it may cause a problem if it conflicts with ACPI.
(Maybe we need to disable the FDT nodes except for nodes under /chosen
 on boot if ACPI exists.)

This series can be applied on Steve's tracing tree (ftrace/core) or
available on below

https://github.com/mhiramat/linux.git ftrace-devicetree-v2

Usage
======
With this series, we can setup new kprobe and synthetic events, more
complicated event filters and trigger actions including histogram
via devicetree.

For example, following kernel parameters

trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"

it can be written in devicetree like below.

/{
chosen {
	...
	ftrace {
		options = "sym-addr";
		events = "initcall:*";
		tp-printk;
		buffer-size-kb = <0x400>;	// 1024KB == 1MB
		ftrace-filters = "vfs*";
	};

Moreover, now we can expand it to add filters for events, kprobe events,
and synthetic events with histogram like below.

	ftrace {
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

Also, this version supports "instance" node, which allows us to
run several tracers for different purpose at once. For example,
one tracer is for tracing functions in module alpha, and others
tracing module beta, you can write followings.

	ftrace {
		instance0 {
			instance = "foo";
			tracer = "function";
			ftrace-filters = "*:mod:alpha";
		};
		instance1 {
			instance = "bar";
			tracer = "function";
			ftrace-filters = "*:mod:beta";
			
		};
	};

The instance node also accepts event nodes so that each instance
can customize its event tracing.

Discussion
=====
On the previous thread, we discussed that the this devicetree usage
itself was acceptable or not. Fortunately, I had a chance to discuss
it in a F2F meeting with Frank and Tim last week.

I think the advantages of using devicetree are,

- reuse devicetree's structured syntax for complicated tracefs settings
- reuse OF-APIs in linux kernel to accept and parse it
- reuse dtc complier to compile it and validate syntax. (with yaml schema,
  we can enhance it)
- reuse current bootloader (and qemu) to load it

And we talked about some other ideas to avoid using devicetree.

- expand kernel command line (ascii command strings)
- expand kernel command line with base64 encoded comressed ascii command 
   strings
- load (compressed) ascii command strings to somewhere on memory and pass
   the address via kernel cmdline
- load (compressed) ascii command strings to somewhere on memory and pass
   the address via /chosen node (as same as initrd)
- load binary C data and point it from kernel cmdline
- load binary C data and point it from /chosen node (as same as initrd)
- load binary C data as a section of kernel image

The first 2 ideas expand the kernel's cmdline to pass some "magic" command
to setup ftrace. In both case, the problems are the maximal size of cmdline
and the issues related to the complexity of commands.
My example showed that the ftrace settings becomes long even if making one
histogram, which can be longer than 256 bytes. The long and complex data
can easily lead mis-typing, but cmdline has no syntax validator, it just
ignores the mis-typed commands.
(Of course even with the devicetree, it must be smaller than 2 pages)

Next 2 ideas are similar, but load the commands on some other memory area
and pass only address via cmdline. This solves the size limitation issue,
but still no syntax validation. Of course we can make a new structured
syntax validator similar to (or just forked from) dt-validate.
The problem (or disadvantage) of these (and following) ideas, is to change
the kernel and boot loaders to load another binary blobs on memory.

Maybe if we introduce a generic structured kernel boot arguments, which is
a kind of /chosen node of devicetree. (But if there is already such hook,
why we make another one...?)
Also, this "GSKBA" may introduce a parser and access APIs which will be
very similar to OF-APIs. This also seems redundant to me.

So the last 3 ideas will avoid introducing new parser and APIs, we just
compile the data as C data and point it from cmdline or somewhere else.
With these ideas, we still need to expand boot loaders to support
loading new binary blobs. (And the last one requires to add elf header
parser/modifier to boot loader too)

>From the above reasons, I think using devicetree's /chosen node is 
the least intrusive way to introduce this boot-time tracing feature.

Any suggestions, thoughts?

Thank you,

---

Masami Hiramatsu (15):
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
      tracing: of: Add instance node support
      tracing: of: Add cpumask property support
      tracing: of: Add function tracer filter properties
      tracing: of: Add function-graph tracer option properties


 .../devicetree/bindings/chosen/linux,ftrace.yaml   |  306 ++++++++++++
 include/linux/trace_events.h                       |    1 
 kernel/trace/Kconfig                               |   10 
 kernel/trace/Makefile                              |    1 
 kernel/trace/ftrace.c                              |   85 ++-
 kernel/trace/trace.c                               |   90 ++--
 kernel/trace/trace_events.c                        |    3 
 kernel/trace/trace_events_hist.c                   |   14 -
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_kprobe.c                        |   81 ++-
 kernel/trace/trace_of.c                            |  507 ++++++++++++++++++++
 11 files changed, 1004 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chosen/linux,ftrace.yaml
 create mode 100644 kernel/trace/trace_of.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
