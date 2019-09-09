Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8464DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9B121920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfIIK76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:59:58 -0400
Received: from foss.arm.com ([217.140.110.172]:47812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390885AbfIIK74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:59:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C9C1000;
        Mon,  9 Sep 2019 03:59:55 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01DC3F71F;
        Mon,  9 Sep 2019 03:59:53 -0700 (PDT)
Date:   Mon, 9 Sep 2019 11:59:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?utf-8?Q?Hladk=C3=BD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190909105951.rycwzsaome4l5d5f@e107158-lin.cambridge.arm.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <20190904143711.zorh2whdapymc5ng@e107158-lin.cambridge.arm.com>
 <20190904174841.GW2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904174841.GW2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/19 19:48, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 03:37:11PM +0100, Qais Yousef wrote:
> 
> > I managed to hook into sched_switch to get the nr_running of cfs tasks via
> > eBPF.
> > 
> > ```
> > int on_switch(struct sched_switch_args *args) {
> >     struct task_struct *prev = (struct task_struct *)bpf_get_current_task();
> >     struct cgroup *prev_cgroup = prev->cgroups->subsys[cpuset_cgrp_id]->cgroup;
> >     const char *prev_cgroup_name = prev_cgroup->kn->name;
> > 
> >     if (prev_cgroup->kn->parent) {
> >         bpf_trace_printk("sched_switch_ext: nr_running=%d prev_cgroup=%s\\n",
> >                          prev->se.cfs_rq->nr_running,
> >                          prev_cgroup_name);
> >     } else {
> >         bpf_trace_printk("sched_switch_ext: nr_running=%d prev_cgroup=/\\n",
> >                          prev->se.cfs_rq->nr_running);
> >     }
> >     return 0;
> > };
> > ```
> > 
> > You can do something similar by attaching to the sched_switch tracepoint from
> > a module and a create a new event to get the nr_running.
> > 
> > Now this is not as accurate as your proposed new tracepoint in terms where you
> > sample nr_running, but should be good enough?
> 
> The above is after deactivate() and gives an up-to-date count for
> decrements. Attach something to trace_sched_wakeup() to get the
> increment update.

I just remembered that sched_switch and sched_wakeup aren't
EXPORT_TRACEPOINT*() so can't be attached to via out of tree module. But still
accessible via eBPF.

There has been several attempts to export these tracepoints but they were
NACKed because there was no in-kernel module that needed them.

https://lore.kernel.org/lkml/20150422130052.4996e231@gandalf.local.home/

--
Qais Yousef
