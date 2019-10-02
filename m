Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D2C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F421920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfJBPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfJBPN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:13:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AB121920;
        Wed,  2 Oct 2019 15:13:26 +0000 (UTC)
Date:   Wed, 2 Oct 2019 11:13:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v7 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20191002111324.7590bf6d@gandalf.local.home>
In-Reply-To: <20190920152219.12920-2-viktor.rosendahl@gmail.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
        <20190920152219.12920-2-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 17:22:16 +0200
"Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com> wrote:

> This patch implements the feature that the tracing_max_latency file,
> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> notifications through the fsnotify framework when a new latency is
> available.
> 
> One particularly interesting use of this facility is when enabling
> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> together with the preempt/irqsoff tracers. This makes it possible to
> implement a user space program that can, with equal probability,
> obtain traces of latencies that occur immediately after each other in
> spite of the fact that the preempt/irqsoff tracers operate in overwrite
> mode.
> 
> This facility works with the hwlat, preempt/irqsoff, and wakeup
> tracers.
> 
> The tracers may call the latency_fsnotify() from places such as
> __schedule() or do_idle(); this makes it impossible to call
> queue_work() directly without risking a deadlock. The same would
> happen with a softirq,  kernel thread or tasklet. For this reason we
> use the irq_work mechanism to call queue_work().

Can fsnotify() be called from irq context? If so, why have the work
queue at all? Just do the work from the irq_work handler.

-- Steve

> 
> This patch creates a new workqueue. The reason for doing this is that
> I wanted to use the WQ_UNBOUND and WQ_HIGHPRI flags.  My thinking was
> that WQ_UNBOUND might help with the latency in some important cases.
> 
> If we use:
> 
> queue_work(system_highpri_wq, &tr->fsnotify_work);
> 
> then the work will (almost) always execute on the same CPU but if we are
> unlucky that CPU could be too busy while there could be another CPU in
> the system that would be able to process the work soon enough.
> 
> queue_work_on() could be used to queue the work on another CPU but it
> seems difficult to select the right CPU.
>
