Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B487C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FAF21530
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmqfT6AN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfGOOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33646 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389825AbfGOOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so7799031pgk.0;
        Mon, 15 Jul 2019 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oHXaKImUv1rfiZBAiugAe6lIvXbPxoVio6W2zNf9umg=;
        b=JmqfT6AN3NLjmChT/67LF7RE13MEG3EfSs23XmRAERMGHwD/l+qqD74Z6K/mYdbFea
         cZZM3IpiuZsGorEYgIi8fZlZjmcxdvkW4VYA+Jme+gYmVrHtVlRYYduFwyoG3dRZ4Orv
         q2QwQEiLnjeKhP6GJOtRnoMtC5SEv56sUdussNB3Qqw6urwiOkmhF/6w7+nXQA7eMQ8m
         cd2cghs7rKZWeX72pyj5HBo29bDtGiJv4U0UQwePZ2vbS3BnIBDdLmdGdyvYpiVQ6g45
         FQXUrBq5y22XOvnSr3wiZnNgeA3GCOrtNmjj8dXWaRCM8bpc6oIBDvg6IiSdU6miNkmr
         rKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oHXaKImUv1rfiZBAiugAe6lIvXbPxoVio6W2zNf9umg=;
        b=qxSFeXBdzwipNU4bi23kdCDcwwy+85v5GI9lapN1I4iXIYwnjBnRK65vaWztZ08kWV
         DQo03Eq8XkeaPponIpAqTjwJk77nrC42UQDq1aZjjIrjF6IlD/2YtQ4oxyWMFMUd0sX3
         dwqw1zMWMlKPSzjHR75y0IhLYJcpWayBjf3ldS4uyGbzY/6WHnBCUH1w+KgI75640Sve
         AkCv2JU+oby7OMbU1XMhDXZJFXjx1d8kV4plhlW0X/MMOa+pdTQ9e8MbbVI/BMlfaOq1
         bXUygA5cHRvKqu5/0FEfeKuBDnCFv94/+9mGeo0TckuehxJ7zz6Ay49xKhOYplRcahMT
         GepQ==
X-Gm-Message-State: APjAAAXqaN6EY7oGLUTq5zLjOZWf5TWmWR4Jy14ZDVx+3tT6KLEe7xkl
        cT/1WLVUfOtHOPj/eS2vipI=
X-Google-Smtp-Source: APXvYqz4iAMwoHY4Ihx3e/Y8s0V8+rINaatjbsoQMS7jJ1KTpBy3qjhLfRuUr0nPSvoIZ0HvcHxXVA==
X-Received: by 2002:a63:60c1:: with SMTP id u184mr23776856pgb.275.1563200493722;
        Mon, 15 Jul 2019 07:21:33 -0700 (PDT)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id i137sm10976242pgc.4.2019.07.15.07.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 07:21:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/15] tracing: of: Boot time tracing using
 devicetree
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>, Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <488a65e6-1d80-0acb-5092-80c18b7ff447@gmail.com>
Date:   Mon, 15 Jul 2019 07:21:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156316746861.23477.5815110570539190650.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

After receiving this email, I replied to one email on the v1 thread,
so there will be a little bit of overlap in the ordering of the two
threads.  Feel free to reply to my comments in the v1 thread in this
thread instead.

More comments below.

On 7/14/19 10:11 PM, Masami Hiramatsu wrote:> Hello,
> 
> Here is the 2nd version of RFC series to add boot-time tracing using
> devicetree. Previous thread is here.
> 
> https://lkml.kernel.org/r/156113387975.28344.16009584175308192243.stgit@devnote2
> 
> In this version, I moved the ftrace node under /chosen/linux,ftrace
> and remove compatible property, because it must be in fixed place.
> Also this version has following features;
> 
>  - Introduce "instance" node, which can have events nodes for setting
>    events filters and actions for the trace instance.
>  - Introduce "cpumask" property
>  - Introduce "ftrace-filters" and "ftrace-notraces"
>  - Introduce "fgraph-filters", "fgraph-notraces" and "fgraph-max-depth"
> 
> At this moment, this feature is only available on the architecutre which
> supports devicetree. For x86, we can use it on qemu with --dtb option,
> or apply below patch on grub to add devicetree support on grub-x86.
> 
> https://github.com/mhiramat/grub/commit/644c35bfd2d18c772cc353b74215344f8264923a
> 
> Note that the devicetree for x86 must contain the nodes only under
> /chosen/, or it may cause a problem if it conflicts with ACPI.
> (Maybe we need to disable the FDT nodes except for nodes under /chosen
>  on boot if ACPI exists.)
> 
> This series can be applied on Steve's tracing tree (ftrace/core) or
> available on below
> 
> https://github.com/mhiramat/linux.git ftrace-devicetree-v2
> 
> Usage
> ======
> With this series, we can setup new kprobe and synthetic events, more
> complicated event filters and trigger actions including histogram
> via devicetree.
> 
> For example, following kernel parameters
> 
> trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
> 
> it can be written in devicetree like below.
> 
> /{
> chosen {
> 	...
> 	ftrace {
> 		options = "sym-addr";
> 		events = "initcall:*";
> 		tp-printk;
> 		buffer-size-kb = <0x400>;	// 1024KB == 1MB
> 		ftrace-filters = "vfs*";
> 	};
> 
> Moreover, now we can expand it to add filters for events, kprobe events,
> and synthetic events with histogram like below.
> 
> 	ftrace {
> 		...
> 		event0 {
> 			event = "task:task_newtask";
> 			filter = "pid < 128";	// adding filters
> 			enable;
> 		};
> 		event1 {
> 			event = "kprobes:vfs_read";
> 			probes = "vfs_read $arg1 $arg2"; // add kprobes
> 			filter = "common_pid < 200";
> 			enable;
> 		};
> 		event2 {
> 			event = "initcall_latency";	// add synth event
> 			fields = "unsigned long func", "u64 lat";
> 			// with histogram
> 			actions = "hist:keys=func.sym,lat:vals=lat:sort=lat";
> 		};
> 		// and synthetic event callers
> 		event3 {
> 			event = "initcall:initcall_start";
> 			actions = "hist:keys=func:ts0=common_timestamp.usecs";
> 		};
> 		event4 {
> 			event = "initcall:initcall_finish";
> 			actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)";
> 		};
> 	};
> 
> Also, this version supports "instance" node, which allows us to
> run several tracers for different purpose at once. For example,
> one tracer is for tracing functions in module alpha, and others
> tracing module beta, you can write followings.
> 
> 	ftrace {
> 		instance0 {
> 			instance = "foo";
> 			tracer = "function";
> 			ftrace-filters = "*:mod:alpha";
> 		};
> 		instance1 {
> 			instance = "bar";
> 			tracer = "function";
> 			ftrace-filters = "*:mod:beta";
> 			
> 		};
> 	};
> 
> The instance node also accepts event nodes so that each instance
> can customize its event tracing.
> 
> Discussion
> =====
> On the previous thread, we discussed that the this devicetree usage
> itself was acceptable or not. Fortunately, I had a chance to discuss
> it in a F2F meeting with Frank and Tim last week.

Thanks for writing up some of what we discussed.

Let me add a problem statement and use case.  I'll probably get it at least
a little bit wrong, so please update as needed.

(1) You feel the ftrace kernel command line syntax is not sufficiently user
    friendly.

(2) The kernel command line is too small to contain the full set of desired
    ftrace commands and options.

(3) There is a desire to change the boot time ftrace commands and options
    without re-compiling or re-linking the Linux kernel.


> 
> I think the advantages of using devicetree are,
> 
> - reuse devicetree's structured syntax for complicated tracefs settings
> - reuse OF-APIs in linux kernel to accept and parse it
> - reuse dtc complier to compile it and validate syntax. (with yaml schema,
>   we can enhance it)
> - reuse current bootloader (and qemu) to load it

Devicetree is not a universal data structure and communication channel.

Devicetree is a description of the hardware and also conveys bootloader
specific information that is need by the kernel to boot.


> And we talked about some other ideas to avoid using devicetree.
> 
> - expand kernel command line (ascii command strings)
> - expand kernel command line with base64 encoded comressed ascii command 
>    strings

Base64 being one of possibly many ways to convert arbitrary binary data to
ascii safe data _if_ you want to transfer the ftrace options and commands
in a binary format.


> - load (compressed) ascii command strings to somewhere on memory and pass
>    the address via kernel cmdline

Similar to the way initrd is handled, if I understand correctly.  (I am not
up to date on how initrd location is passed to the kernel for a non-devicetree
kernel.)

Compressed or not compressed would be an ftrace design choice.


> - load (compressed) ascii command strings to somewhere on memory and pass
>    the address via /chosen node (as same as initrd)

Compressed or not compressed would be an ftrace design choice.


> - load binary C data and point it from kernel cmdline
> - load binary C data and point it from /chosen node (as same as initrd)
> - load binary C data as a section of kernel image

For the three options above:

Binary data if ftrace prefers structured data.
A list of strings if ftrace wants to use the existing kernel command line
syntax.

For the third of the above three options, the linker would provide the start
and end address of the ftrace options and commands section.


> The first 2 ideas expand the kernel's cmdline to pass some "magic" command
> to setup ftrace. In both case, the problems are the maximal size of cmdline
> and the issues related to the complexity of commands.

Not a "magic" command.  Either continue using the existing ftrace syntax or
add something like: ftrace_cmd="whatever format ftrace desires".

Why can the maximum size of the cmdline not be increased?


> My example showed that the ftrace settings becomes long even if making one
> histogram, which can be longer than 256 bytes. The long and complex data
> can easily lead mis-typing, but cmdline has no syntax validator, it just
> ignores the mis-typed commands.

Hand typing a kernel command line is already not a fun exercise, even
before adding ftrace commands.  If you are hand typing kernel command
lines then I suggest you improve your tools (eg bootloader or whatever
is not allowing you to edit and store command lines).


> (Of course even with the devicetree, it must be smaller than 2 pages)
> 
> Next 2 ideas are similar, but load the commands on some other memory area
> and pass only address via cmdline. This solves the size limitation issue,
> but still no syntax validation. Of course we can make a new structured
> syntax validator similar to (or just forked from) dt-validate.
> The problem (or disadvantage) of these (and following) ideas, is to change
> the kernel and boot loaders to load another binary blobs on memory.
> 
> Maybe if we introduce a generic structured kernel boot arguments, which is
> a kind of /chosen node of devicetree. (But if there is already such hook,
> why we make another one...?)

I got lost in the next sentence, so for my benefit:
GSKBA == generic structured kernel boot arguments

> Also, this "GSKBA" may introduce a parser and access APIs which will be
> very similar to OF-APIs. This also seems redundant to me.
 

> So the last 3 ideas will avoid introducing new parser and APIs, we just
> compile the data as C data and point it from cmdline or somewhere else.

Or if in a kernel data section then the linker can provide the begin and
end address of the blob.  This is already implemented for some other data
structures.

> With these ideas, we still need to expand boot loaders to support
> loading new binary blobs. (And the last one requires to add elf header
> parser/modifier to boot loader too)

Why would the boot loader need to access the elf header?  The linker
can provide the location of the new kernel data section via kernel
variables.

> 
>>From the above reasons, I think using devicetree's /chosen node is 
> the least intrusive way to introduce this boot-time tracing feature.

This is still mis-use of the devicetree data structure.  This data
does not belong in the devicetree.


> 
> Any suggestions, thoughts?
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (15):
>       tracing: Apply soft-disabled and filter to tracepoints printk
>       tracing: kprobes: Output kprobe event to printk buffer
>       tracing: Expose EXPORT_SYMBOL_GPL symbol
>       tracing: kprobes: Register to dynevent earlier stage
>       tracing: Accept different type for synthetic event fields
>       tracing: Add NULL trace-array check in print_synth_event()
>       dt-bindings: tracing: Add ftrace binding document
>       tracing: of: Add setup tracing by devicetree support
>       tracing: of: Add trace event settings
>       tracing: of: Add kprobe event support
>       tracing: of: Add synthetic event support
>       tracing: of: Add instance node support
>       tracing: of: Add cpumask property support
>       tracing: of: Add function tracer filter properties
>       tracing: of: Add function-graph tracer option properties
> 
> 
>  .../devicetree/bindings/chosen/linux,ftrace.yaml   |  306 ++++++++++++
>  include/linux/trace_events.h                       |    1 
>  kernel/trace/Kconfig                               |   10 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/ftrace.c                              |   85 ++-
>  kernel/trace/trace.c                               |   90 ++--
>  kernel/trace/trace_events.c                        |    3 
>  kernel/trace/trace_events_hist.c                   |   14 -
>  kernel/trace/trace_events_trigger.c                |    2 
>  kernel/trace/trace_kprobe.c                        |   81 ++-
>  kernel/trace/trace_of.c                            |  507 ++++++++++++++++++++
>  11 files changed, 1004 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/chosen/linux,ftrace.yaml
>  create mode 100644 kernel/trace/trace_of.c
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

