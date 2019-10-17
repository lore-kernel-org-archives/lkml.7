Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E306FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076AD2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQa8pUEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406422AbfJQPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:42:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44650 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbfJQPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:42:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so2258380qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7SgqcBu4H0dJ0a1XVrR4P5IqOAXfzEIFli1m7ofQZTU=;
        b=MQa8pUEYm2AJaeJ+t58qwU6vPL4fhPd8LuyDsckVf0eZpIGSFiK0Kf3Gg/7rSW4pF4
         bz+wHYD+fSJWVO4JEviNAc+p5yG1XYbVh6e0EoSdpTlrh7A4dHqdfnilw5Tk3QhRtHU0
         G9rtcCIFHv3CPirjont2iaTU9p1PFdbg7hpAoZGd6HRe0JW7MLCYGiLBj/U3RF+VNfUi
         ersOCaEQPAfrchdIhYulr6RhqsHLqGy21HSDenqXL7smQ7TTdJsejwpHht/PwpOfe588
         al19BFU3DpYtotN+FMqCO/Gj2KPN8jlEX7TENq500mEIK/A/EAxMay+4KbgtNdYbUZKl
         odFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7SgqcBu4H0dJ0a1XVrR4P5IqOAXfzEIFli1m7ofQZTU=;
        b=HYrhzBKwwxjj7dRJJIhDyYy31Kv34j2ulpbFZ8EYzQYRorQ8w2SqwrSmCz1tSnp/SP
         hAed6J7Sl7a0+YurgpBIZdwx2D+YN9G31F/z9rtsvAfPIa7Y3lD2g9RdWI/27ORHr/rv
         eg4Hg2InGDZfunjFOoVap8zrvvv6r95B71x8eScRs1WUPvYLO/QHVRuy9hsF+rKajHxN
         LV23VH0XWYUTmpzOWoDtSetQ7oU54+Ei6B1YUkXaOD65ZXtKCtwxJuK8DgP9KzjMjJDd
         P6trsApQJuG7HS1DBBpOpf8GURa92fWEQZdr0AYYuGRaqjM86yqoho1DgBHZRavytQeg
         qi7A==
X-Gm-Message-State: APjAAAUetQLl+ni5DOPmJLEGFeAZZdfAIsjnyB36PEsb2O0quA/fIlin
        qrtk1hS9lEvHeKeQZxgh8m4oBt9I
X-Google-Smtp-Source: APXvYqw8DulTBmpti3QAQ0tydsoM2uNCI+7kg/3ozZYoz77gLPeI1f3K9qBE7GmjGvbVlk+U1HXkQw==
X-Received: by 2002:a05:620a:1fc:: with SMTP id x28mr3577034qkn.324.1571326928646;
        Thu, 17 Oct 2019 08:42:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q25sm1083370qtr.25.2019.10.17.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:42:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 177424DD66; Thu, 17 Oct 2019 12:42:05 -0300 (-03)
Date:   Thu, 17 Oct 2019 12:42:05 -0300
To:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017154205.GC8974@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try and continue later, but if you guys can take a look...

The first call in that loop:

  while ((event = trace_find_next_event(pevent, event)))

works and the event is valid, one of the sched: tracepoints, but then
the next call returns this:

struct tep_event *trace_find_next_event(struct tep_handle *pevent,
                                        struct tep_event *event)
{
        static int idx;
        int events_count;
        struct tep_event *all_events;

        all_events = tep_get_first_event(pevent);
        events_count = tep_get_events_count(pevent);
        if (!pevent || !all_events || events_count < 1)
                return NULL;

        if (!event) {
                idx = 0;
                return all_events;
        }

        if (idx < events_count && event == (all_events + idx)) {
                idx++;
                if (idx == events_count)
                        return NULL;
                return (all_events + idx);
        }

        for (idx = 1; idx < events_count; idx++) {
                if (event == (all_events + (idx - 1)))
                        return (all_events + idx);
        }
        return NULL;
}

Oh, static int idx, oops, anyway, the all_events + idx returned for the
second call to trace_find_next_event() fails, in a hurry now, will get
back to this later.

- Arnaldo


[root@quaco ~]# perf record -e sched:* sleep 1
[ perf record: Woken up 33 times to write data ]
[ perf record: Captured and wrote 0.030 MB perf.data (8 samples) ]
[root@quaco ~]# perf script -g python
Segmentation fault (core dumped)
[root@quaco ~]#

Bisected to:

[acme@quaco perf]$ git bisect bad
bb3dd7e7c4d5e024d607c0ec06c2a2fb9408cc99 is the first bad commit
commit bb3dd7e7c4d5e024d607c0ec06c2a2fb9408cc99
Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Date:   Fri Oct 5 12:22:25 2018 -0400

    tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file
    
    As traceevent is going to be transferred into a proper library,
    its local data should be protected from the library users.
    This patch encapsulates struct tep_handler into a local header,
    not visible outside of the library. It implements also a bunch
    of new APIs, which library users can use to access tep_handler members.
    
    Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: linux trace devel <linux-trace-devel@vger.kernel.org>
    Cc: tzvetomir stoyanov <tstoyanov@vmware.com>
    Link: http://lkml.kernel.org/r/20181005122225.522155df@gandalf.local.home
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

:040000 040000 7a23aa486fd8ed255b681e6c959d6ab64d16f2f6 d95f601bb03b81bc04070b69635df40b62c70a1a M	tools
[acme@quaco perf]$

[root@quaco ~]# gdb perf
GNU gdb (GDB) Fedora 8.3-6.fc30
Reading symbols from perf...
(gdb) run script -g python
Starting program: /root/bin/perf script -g python
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 10352]

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff76f55e5 in __strlen_avx2 () from /lib64/libc.so.6
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.177-1.fc30.x86_64 elfutils-libs-0.177-1.fc30.x86_64 glib2-2.60.7-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libcap-2.26-5.fc30.x86_64 libgcc-9.2.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-2.fc30.x86_64 libxcrypt-4.4.10-1.fc30.x86_64 libzstd-1.4.2-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-440.fc30.x86_64 popt-1.16-17.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-18.fc30.x86_64
(gdb) bt
#0  0x00007ffff76f55e5 in __strlen_avx2 () from /lib64/libc.so.6
#1  0x00007ffff7601a1e in __vfprintf_internal () from /lib64/libc.so.6
#2  0x00007ffff75ec2ba in fprintf () from /lib64/libc.so.6
#3  0x00000000005ec8db in python_generate_script (pevent=0xbedb10, outfile=0x71f761 "perf-script") at util/scripting-engines/trace-event-python.c:1739
#4  0x000000000046e94a in cmd_script (argc=0, argv=0x7fffffffd680) at builtin-script.c:3848
#5  0x00000000004e0d86 in run_builtin (p=0xa3d238 <commands+408>, argc=3, argv=0x7fffffffd680) at perf.c:312
#6  0x00000000004e0ff3 in handle_internal_command (argc=3, argv=0x7fffffffd680) at perf.c:364
#7  0x00000000004e113a in run_argv (argcp=0x7fffffffd4dc, argv=0x7fffffffd4d0) at perf.c:408
#8  0x00000000004e1506 in main (argc=3, argv=0x7fffffffd680) at perf.c:538
(gdb) fr 3
#3  0x00000000005ec8db in python_generate_script (pevent=0xbedb10, outfile=0x71f761 "perf-script") at util/scripting-engines/trace-event-python.c:1739
1739			fprintf(ofp, "def %s__%s(", event->system, event->name);
(gdb) p event
$1 = (struct tep_event *) 0xbfa298
(gdb) p *event
$2 = {tep = 0x31, name = 0x61775f6465686373 <error: Cannot access memory at address 0x61775f6465686373>, id = 1767859563, flags = 1600482404, format = {nr_common = 1752459639, nr_fields = 1601467759, common_fields = 0x6e6f6d6d00697069,
    fields = 0x93b7367616c665f}, print_fmt = {format = 0x21 <error: Cannot access memory at address 0x21>, args = 0x64656e6769736e75}, system = 0x74726f687320 <error: Cannot access memory at address 0x74726f687320>,
  handler = 0x656966090a3b303a, context = 0x51}
(gdb) list -20
1714		fprintf(ofp, "# in the format files.  Those fields not available as "
1715			"handler params can\n");
1716
1717		fprintf(ofp, "# be retrieved using Python functions of the form "
1718			"common_*(context).\n");
1719
1720		fprintf(ofp, "# See the perf-script-python Documentation for the list "
1721			"of available functions.\n\n");
1722
1723		fprintf(ofp, "from __future__ import print_function\n\n");
(gdb)
1724		fprintf(ofp, "import os\n");
1725		fprintf(ofp, "import sys\n\n");
1726
1727		fprintf(ofp, "sys.path.append(os.environ['PERF_EXEC_PATH'] + \\\n");
1728		fprintf(ofp, "\t'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')\n");
1729		fprintf(ofp, "\nfrom perf_trace_context import *\n");
1730		fprintf(ofp, "from Core import *\n\n\n");
1731
1732		fprintf(ofp, "def trace_begin():\n");
1733		fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
(gdb)
1734
1735		fprintf(ofp, "def trace_end():\n");
1736		fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
1737
1738		while ((event = trace_find_next_event(pevent, event))) {
1739			fprintf(ofp, "def %s__%s(", event->system, event->name);
1740			fprintf(ofp, "event_name, ");
1741			fprintf(ofp, "context, ");
1742			fprintf(ofp, "common_cpu,\n");
1743			fprintf(ofp, "\tcommon_secs, ");


- Arnaldo
