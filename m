Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F9C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A0120656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3fMXxD/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAGJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:32:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48582 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+gyT597CSUb3vTF8vtNS0ogoC3uLxUkJ9SR8FBD625M=; b=3fMXxD/EMYJ8d0ZJI1DssRuSO
        RXnlTsdLu1NFF8Hy2n2/aGvsL5i4auhHTXtmaZFF3W1+MCaqP3C7usTxowV3MEqN6kYcEOw8iM+x5
        rmqGV91sqPXKjQmFXz+jdt00LIK4MINOqfG8QSyIlUcVWxiG1j+6c7dO6Gg3VMQmqHzqAcdVvRWJk
        t2NRTqdFAvUPQ9y5laCFGS5e7JNacKpgQmgvqJGPSf5AhvYm7P53UO/h7nhearv2pBIV/diZUCaFw
        zbwzZDCmhTIa0r9PPvDdGmXG0Gj/IgyAlnm/Gwt7L1V+IoaZ/EpE0E2EHBU7mUImDfw6fH5aNtyzj
        Rg+XNI0Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iolDk-0004hL-W6; Tue, 07 Jan 2020 09:32:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28656304A59;
        Tue,  7 Jan 2020 10:30:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91E3C2B48A33E; Tue,  7 Jan 2020 10:32:14 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:32:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Li <liwei391@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        huawei.libin@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: Reset watchdog on all CPUs while processing
 sysrq-t
Message-ID: <20200107093214.GV2844@hirez.programming.kicks-ass.net>
References: <20191226085224.48942-1-liwei391@huawei.com>
 <20200102144514.646df101@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102144514.646df101@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 02:45:14PM -0500, Steven Rostedt wrote:
> On Thu, 26 Dec 2019 16:52:24 +0800
> Wei Li <liwei391@huawei.com> wrote:
> 
> > Lengthy output of sysrq-t may take a lot of time on slow serial console
> > with lots of processes and CPUs.
> > 
> > So we need to reset NMI-watchdog to avoid spurious lockup messages, and
> > we also reset softlockup watchdogs on all other CPUs since another CPU
> > might be blocked waiting for us to process an IPI or stop_machine.
> 
> Have you had this triggered?
> 
> > 
> > Add to sysrq_sched_debug_show() as what we did in show_state_filter().
> > 
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > ---
> >  kernel/sched/debug.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index f7e4579e746c..879d3ccf3806 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -751,9 +751,16 @@ void sysrq_sched_debug_show(void)
> >  	int cpu;
> >  
> >  	sched_debug_header(NULL);
> > -	for_each_online_cpu(cpu)
> > +	for_each_online_cpu(cpu) {
> > +		/*
> > +		 * Need to reset softlockup watchdogs on all CPUs, because
> > +		 * another CPU might be blocked waiting for us to process
> > +		 * an IPI or stop_machine.
> > +		 */
> > +		touch_nmi_watchdog();
> > +		touch_all_softlockup_watchdogs();
> 
> This doesn't seem to hurt to add, thus.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!
