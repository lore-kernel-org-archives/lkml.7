Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA987C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F0321670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiHFXmnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfIDRsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:48:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfIDRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=otnoETpjjFh9EvRiSspHwCA0zg+B9ubZI5YSFz3UZL0=; b=KiHFXmnts9lTbw0V+M2cXk3de
        Sd5DCWSUl+tOGPpCe91zuSD5gQ04C8Ll8Wb2oO9gdor/2VulCtG/mXoETzqgAduIcSi0wrhiGH02K
        iYSspvZQLr+qL3H7CAfTiYl0XNQ25X4fk3eRNmXYmw9zfYahP5Ups7TCPFmY6PISTzb7DI62bcsNt
        YpIo/TNrTIydf+Ob82WdH9DexO51N0dGFSaAYqpwWLSC95SPXn5PonFjsUeE6iKwKtvV7jmPRVn7a
        FlfVSVFSXwGSvaumtEomJhdeXQwW0337JeJwD+FhpsRTN9jW0K8JWw3tLFmh5OhC83CoeuWsvFCkW
        NnBb57g3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5ZOc-0001Ah-Sz; Wed, 04 Sep 2019 17:48:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B81AD30116F;
        Wed,  4 Sep 2019 19:48:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6854229DB9F8B; Wed,  4 Sep 2019 19:48:41 +0200 (CEST)
Date:   Wed, 4 Sep 2019 19:48:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904174841.GW2332@hirez.programming.kicks-ass.net>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <20190904143711.zorh2whdapymc5ng@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904143711.zorh2whdapymc5ng@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:37:11PM +0100, Qais Yousef wrote:

> I managed to hook into sched_switch to get the nr_running of cfs tasks via
> eBPF.
> 
> ```
> int on_switch(struct sched_switch_args *args) {
>     struct task_struct *prev = (struct task_struct *)bpf_get_current_task();
>     struct cgroup *prev_cgroup = prev->cgroups->subsys[cpuset_cgrp_id]->cgroup;
>     const char *prev_cgroup_name = prev_cgroup->kn->name;
> 
>     if (prev_cgroup->kn->parent) {
>         bpf_trace_printk("sched_switch_ext: nr_running=%d prev_cgroup=%s\\n",
>                          prev->se.cfs_rq->nr_running,
>                          prev_cgroup_name);
>     } else {
>         bpf_trace_printk("sched_switch_ext: nr_running=%d prev_cgroup=/\\n",
>                          prev->se.cfs_rq->nr_running);
>     }
>     return 0;
> };
> ```
> 
> You can do something similar by attaching to the sched_switch tracepoint from
> a module and a create a new event to get the nr_running.
> 
> Now this is not as accurate as your proposed new tracepoint in terms where you
> sample nr_running, but should be good enough?

The above is after deactivate() and gives an up-to-date count for
decrements. Attach something to trace_sched_wakeup() to get the
increment update.
