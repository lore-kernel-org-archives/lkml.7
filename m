Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D765C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73EC20656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnGf7v3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFWT6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 15:58:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 15:58:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so6263869pfq.0;
        Sun, 23 Jun 2019 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqiV2qXVyvyETTlywiwmX+J2RPyb6h6nZumJsLjKXn4=;
        b=nnGf7v3TEnbkjrXe/VyQFFTzffyv3aeugSMMFJMJzFU4ktzIwhonDAtVt0MLjQQu72
         gAeLDX5b/kN4w4d+iJ6znAfO3e4ulV+AUnPX4LQDiR8rtxkg423aZdodPX7ytQcHIIP2
         u6QCGjKcnwcW/ghsR5sGA9XEpNOcR47Np3/3bK/BAVvm20LGzrDYrN4tIVz3LDcfC0X5
         mzKTZkjuJCwMRFpXL7k0Ro+4vLSuC1674yIjsd6ZIQ/VbAjyO2ej2grxKJPiKessxR8q
         P815pf7CQb84nDjSMozoJM8FcTvtOtwh/VufUcIzURDO5U5gUwjziTwSG7PxX01ZkOe4
         da8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqiV2qXVyvyETTlywiwmX+J2RPyb6h6nZumJsLjKXn4=;
        b=XxqMKRIcPM0VSaNVBxQmjA27kwj90oY12fUbBDQ2pt05cGbagXkp6fWgu3yKfqEzy0
         0MBLltNgtJFYmwLZ1qWju2cBBWC6sSwD9vZLv1ERuaMxXlUArO5/Bc0o9tZ4QOhbpmDs
         mhlOaz8GILJwP18oHWm8uomZD/kHlbSjo6M0Wps5PLWQrgn2OXaXNHfHIhdQoH/LoxmW
         Ubl6xdl35sDmPWw6EkhAtAbXUtC5yRBIcOeoMxasr4EDKciOGkreffaWzYxmUNT0I5NC
         hOSLketIiSEnXci2IKvLCiIC420bz/3gwIYmxLaQZRQhSYpxt6/MeXIQqFr72aFzfT8n
         O/zQ==
X-Gm-Message-State: APjAAAXx+91odDM3r3oAGxtrdRuTuuF6b8VOVUquR9ln0KzOtPzqSp31
        olDbPeaarFYim5CP7paUtHhn1mbD
X-Google-Smtp-Source: APXvYqwW7yUmqsAtrFVBsCM0/4wlyw+6fwKkYWMtTdp+g72U8f1cGtDrWv2+pURe8Gl2smHe40rIQg==
X-Received: by 2002:a63:81c6:: with SMTP id t189mr17058937pgd.15.1561319928089;
        Sun, 23 Jun 2019 12:58:48 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r4sm7830372pjd.25.2019.06.23.12.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 12:58:47 -0700 (PDT)
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using devicetree
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
Date:   Sun, 23 Jun 2019 12:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 6/21/19 9:18 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is an RFC series of patches to add boot-time tracing using
> devicetree.
> 
> Currently, kernel support boot-time tracing using kernel command-line
> parameters. But that is very limited because of limited expressions
> and limited length of command line. Recently, useful features like
> histogram, synthetic events, etc. are being added to ftrace, but it is
> clear that we can not expand command-line options to support these
> features.

"it is clear that we can not expand command-line options" needs a fuller
explanation.  And maybe further exploration.


> 
> Hoever, I've found that there is a devicetree which can pass more
> structured commands to kernel at boot time :) The devicetree is usually
> used for dscribing hardware configuration, but I think we can expand it

Devicetree is standardized and documented as hardware description.


> for software configuration too (e.g. AOSP and OPTEE already introduced
> firmware node.) Also, grub and qemu already supports loading devicetree,
> so we can use it not only on embedded devices but also on x86 PC too.

Devicetree is NOT for configuration information.  This has been discussed
over and over again in mail lists, at various conferences, and was also an
entire session at plumbers a few years ago:

   https://elinux.org/Device_tree_future#Linux_Plumbers_2016_Device_Tree_Track

There is one part of device tree that does allow non-hardware description,
which is the "chosen" node which is provided to allow communication between
the bootloader and the kernel.

There clearly are many use cases for providing configuration information
and other types of data to a booting kernel.  I have been encouraging
people to come up with an additional boot time communication channel or
data object to support this use case.  So far, no serious proposal that
I am aware of.

> 
> With the devicetree, we can setup new kprobe and synthetic events, more
> complicated event filters and trigger actions including histogram.
> 
> For example, following kernel parameters
> 
> trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M
> 
> it can be written in devicetree like below.
> 
> 	ftrace {
> 		compatible = "linux,ftrace";
> 		options = "sym-addr";
> 		events = "initcall:*";
> 		tp-printk;
> 		buffer-size-kb = <0x400>;	// 1024KB == 1MB
> 	};
> 
> Moreover, now we can expand it to add filters for events, kprobe events,
> and synthetic events with histogram like below.
> 
> 	ftrace {
> 		compatible = "linux,ftrace";
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
> These complex configuration can not be done by kernel parameters.
> However, this is not replacing boot-time tracing by kernel parameters.
> This devicetree settings are applied in fs_initcall() stage, but kernel
> parameters are applied earlier stage. Anyway, this is enough useful
> for debugging/tracing kernel driver initializations.
> 
> I would like to discuss on some points about this idea.
> 
> - Can we use devicetree for configuring kernel dynamically?

No.  Sorry.

My understanding of this proposal is that it is intended to better
support boot time kernel and driver debugging.  As an alternate
implementation, could you compile the ftrace configuration information
directly into a kernel data structure?  It seems like it would not be
very difficult to populate the data structure data via a few macros.

-Frank


> - Would you have any comment for the devicetree format and default
>   behaviors?
> - Currently, kprobe and synthetic events are defined inside event
>   node, but it is able to define globally in ftrace node. Which is
>   better?
> - Do we need to support "status" property on each event node so
>   that someone can prepare "dtsi" include file and override the status?
> - Do we need instance-wide pid filter (set_event_pid) when boot-time?
> - Do we need more structured tree, like spliting event and group,
>   event actions and probes to be a tree of node, etc?
> - Do we need per group filter & enablement support?
> - How to support instances? (nested tree or different tree?)
> - What kind of options would we need?
> 
> Some kernel parameters are not implemented yet, like ftrace_filter,
> ftrace_notrace, etc. These will be implemented afterwards.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (11):
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
> 
> 
>  .../devicetree/bindings/tracing/ftrace.yaml        |  170 +++++++++++
>  include/linux/trace_events.h                       |    1 
>  kernel/trace/Kconfig                               |   10 +
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/trace.c                               |   49 ++-
>  kernel/trace/trace_events.c                        |    3 
>  kernel/trace/trace_events_hist.c                   |   14 +
>  kernel/trace/trace_events_trigger.c                |    2 
>  kernel/trace/trace_kprobe.c                        |   81 +++--
>  kernel/trace/trace_of.c                            |  311 ++++++++++++++++++++
>  10 files changed, 589 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tracing/ftrace.yaml
>  create mode 100644 kernel/trace/trace_of.c
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

