Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD022464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYpWAILn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgADMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 07:04:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgADMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 07:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578139453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdR3Vz6+ofuay9NZxSeucQOMq0Uj1CPcpO0WCc1v3G4=;
        b=AYpWAILnUB3UYVXxvquExK8/qraWmxpaw7m5tWmjgWIGTnnj1TDJRkW6pMxqIXRROcjqAl
        R/en58UfbytUhMHav5/H8kK9t/td76Lalqe8HpSDXYCCVjB75HAyhNcWZZI7wQfx9U+KSY
        ccgUbGwITCOuW1jAjVblWKLEQ0VppfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161--E6dYDsFN1KEH2fVCROwoA-1; Sat, 04 Jan 2020 07:04:09 -0500
X-MC-Unique: -E6dYDsFN1KEH2fVCROwoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DAA800D41;
        Sat,  4 Jan 2020 12:04:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 879C87DB25;
        Sat,  4 Jan 2020 12:03:54 +0000 (UTC)
Date:   Sat, 4 Jan 2020 20:03:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20200104120349.GA3810@ming.t460p>
References: <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
 <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
 <20191225004822.GA12280@ming.t460p>
 <72a6a738-f04b-3792-627a-fbfcb7b297e1@huawei.com>
 <20200103004625.GA5219@ming.t460p>
 <2b070d25-ee35-aa1f-3254-d086c6b872b1@huawei.com>
 <20200103112908.GA20353@ming.t460p>
 <e40ec76b-c9d7-2b2f-8257-d3ced0894260@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <e40ec76b-c9d7-2b2f-8257-d3ced0894260@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2020 at 11:50:51AM +0000, John Garry wrote:
> On 03/01/2020 11:29, Ming Lei wrote:
> > On Fri, Jan 03, 2020 at 10:41:48AM +0000, John Garry wrote:
> > > On 03/01/2020 00:46, Ming Lei wrote:
> > > > > > > d the
> > > > > > > DMA API more than an architecture-specific problem.
> > > > > > > 
> > > > > > > Given that we have so far very little data, I'd hold off any conclusion.
> > > > > > We can start to collect latency data of dma unmapping vs nvme_irq()
> > > > > > on both x86 and arm64.
> > > > > > 
> > > > > > I will see if I can get a such box for collecting the latency data.
> > > > > To reiterate what I mentioned before about IOMMU DMA unmap on x86, a key
> > > > > difference is that by default it uses the non-strict (lazy) mode unmap, i.e.
> > > > > we unmap in batches. ARM64 uses general default, which is strict mode, i.e.
> > > > > every unmap results in an IOTLB fluch.
> > > > > 
> > > > > In my setup, if I switch to lazy unmap (set iommu.strict=0 on cmdline), then
> > > > > no lockup.
> > > > > 
> > > > > Are any special IOMMU setups being used for x86, like enabling strict mode?
> > > > > I don't know...
> > > > BTW, I have run the test on one 224-core ARM64 with one 32-hw_queue NVMe, the
> > > > softlock issue can be triggered in one minute.
> > > > 
> > > > nvme_irq() often takes ~5us to complete on this machine, then there is really
> > > > risk of cpu lockup when IOPS is > 200K.
> > > 
> > > Do you have a typical nvme_irq() completion time for a mid-range x86 server?
> > 
> > ~1us.
> 
> Eh, so ~ x5 faster on x86 machine?! Seems some real issue here.
> 
> > 
> > It is done via bcc script, and ebpf itself may introduce some overhead.
> > 
> 
> Can you share the script/instructions? I would like to test on my machine. I
> assume you tested on an ThunderX2.

It should have been done easier by bpftrace than bcc, however it has bug in case
of too many cpu cores on arm64.

So I uses a modified hardirqs.py to do that, you can collect the latency
histogram via funclatency too.



Thanks,
Ming

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hardirqs.py"

#!/usr/bin/python
# @lint-avoid-python-3-compatibility-imports
#
# hardirqs  Summarize hard IRQ (interrupt) event time.
#           For Linux, uses BCC, eBPF.
#
# USAGE: hardirqs [-h] [-T] [-N] [-C] [-d] [interval] [outputs]
#
# Thanks Amer Ather for help understanding irq behavior.
#
# Copyright (c) 2015 Brendan Gregg.
# Licensed under the Apache License, Version 2.0 (the "License")
#
# 19-Oct-2015   Brendan Gregg   Created this.

from __future__ import print_function
from bcc import BPF
from time import sleep, strftime
import argparse

# arguments
examples = """examples:
    ./hardirqs            # sum hard irq event time
    ./hardirqs -d         # show hard irq event time as histograms
    ./hardirqs 1 10       # print 1 second summaries, 10 times
    ./hardirqs -NT 1      # 1s summaries, nanoseconds, and timestamps
"""
parser = argparse.ArgumentParser(
    description="Summarize hard irq event time as histograms",
    formatter_class=argparse.RawDescriptionHelpFormatter,
    epilog=examples)
parser.add_argument("-T", "--timestamp", action="store_true",
    help="include timestamp on output")
parser.add_argument("-N", "--nanoseconds", action="store_true",
    help="output in nanoseconds")
parser.add_argument("-C", "--count", action="store_true",
    help="show event counts instead of timing")
parser.add_argument("-d", "--dist", action="store_true",
    help="show distributions as histograms")
parser.add_argument("interval", nargs="?", default=99999999,
    help="output interval, in seconds")
parser.add_argument("outputs", nargs="?", default=99999999,
    help="number of outputs")
parser.add_argument("--ebpf", action="store_true",
    help=argparse.SUPPRESS)
args = parser.parse_args()
countdown = int(args.outputs)
if args.count and (args.dist or args.nanoseconds):
    print("The --count option can't be used with time-based options")
    exit()
if args.count:
    factor = 1
    label = "count"
elif args.nanoseconds:
    factor = 1
    label = "nsecs"
else:
    factor = 1000
    label = "usecs"
debug = 0

# define BPF program
bpf_text = """
#include <uapi/linux/ptrace.h>
#include <linux/irq.h>
#include <linux/irqdesc.h>
#include <linux/interrupt.h>

struct irq_key {
    u64 id;
    u64 slot;
};

BPF_HISTOGRAM(irq_rqs, struct irq_key, 512);

struct irq_info {
    u32 irq;
    u32 rqs;
    u64 start;
};

//at most 256 CPUs
//BPF_ARRAY(curr_irq, struct irq_info, 256);
BPF_HASH(curr_irq, u32, struct irq_info);

struct irq_sum_info {
    u64 total;
    u64 cnt;
    u64 rq_cnt;
};
BPF_HASH(irq, u32, struct irq_sum_info);

// time IRQ
int trace_start(struct pt_regs *ctx, struct irq_desc *desc)
{
    struct irq_info __info = {};
    struct irq_info *info = &__info;
    u32 id = bpf_get_smp_processor_id();

    info->irq = desc->irq_data.irq;
    info->start = bpf_ktime_get_ns();
    info->rqs = 0;

    curr_irq.update(&id, &__info);

    return 0;
}

int trace_completion(struct pt_regs *ctx)
{
    u32 irq_no;
    struct irq_sum_info *sum;
    struct irq_sum_info zero = {}; 
    u64 delta;
    struct irq_desc *desc = (struct irq_desc *)PT_REGS_PARM1(ctx);
    u32 id = bpf_get_smp_processor_id();
    struct irq_info *info = curr_irq.lookup(&id);

    if (!info)
        return 0;

    irq_no = info->irq;
    delta = bpf_ktime_get_ns() - info->start;

    if (irq_no != desc->irq_data.irq)
        bpf_trace_printk("irq not match: %d %d\\n", irq_no, desc->irq_data.irq);
    
    sum = irq.lookup_or_init(&irq_no, &zero);
    if (sum) {
        sum->total += delta;
        sum->cnt++;
        sum->rq_cnt += info->rqs;
    }

    struct irq_key ikey = {.id = irq_no, .slot = info->rqs};
    irq_rqs.increment(ikey);
    curr_irq.delete(&id);

    return 0;
}
int trace_rq(struct pt_regs *ctx, struct request *rq)
{
    u32 id = bpf_get_smp_processor_id();
    struct irq_info *info = curr_irq.lookup(&id);

    if (!info)
        return 0;

    info->rqs++;

    return 0;
}
"""

# code substitutions
if debug or args.ebpf:
    print(bpf_text)
    if args.ebpf:
        exit()

# load BPF program
b = BPF(text=bpf_text)

# these should really use irq:irq_handler_entry/exit tracepoints:
b.attach_kprobe(event="handle_irq_event_percpu", fn_name="trace_start")
b.attach_kretprobe(event="handle_irq_event_percpu", fn_name="trace_completion")
b.attach_kprobe(event="blk_mq_complete_request", fn_name="trace_rq")
print("Tracing hard irq event time... Hit Ctrl-C to end.")

# output
exiting = 0 if args.interval else 1
dist = b.get_table("irq")
irq_rqs = b.get_table("irq_rqs")

if args.timestamp:
    print("start time %-8s\n" % strftime("%H:%M:%S"), end="")
while (1):
    try:
        sleep(int(args.interval))
    except KeyboardInterrupt:
        exiting = 1

    print()
    if args.timestamp:
        print("end time %-8s\n" % strftime("%H:%M:%S"), end="")

    if args.dist:
        dist.print_log2_hist(label, "hardirq")
    else:
        print("%-10s %11s %11s %11s %11s %11s" % ("HARDIRQ", "TOTAL_TIME", "TOTAL_COUNT",
            "AVG_TIME", "RQS", "AVG_RQS"))
        for k, v in sorted(dist.items(), key=lambda dist: dist[1].total):
            print("%-10d %11d %11d %11d %11d %11d" % (k.value, v.total / factor, v.cnt,
                v.total / (factor * v.cnt),
                v.rq_cnt,
                v.rq_cnt / v.cnt))
    dist.clear()

    irq_rqs.print_linear_hist("rqs", "irq")
    irq_rqs.clear()

    countdown -= 1
    if exiting or countdown == 0:
        exit()

--3V7upXqbjpZ4EhLz--

