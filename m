Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0612083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCSNbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCSNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:31:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAD92083D;
        Tue, 19 Mar 2019 13:31:23 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:31:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        sramana@codeaurora.org, fweisbec@gmail.com, jolsa@redhat.com
Subject: Re: [PATCH] perf: fix use after free of perf_trace_buf
Message-ID: <20190319093122.70bfc751@gandalf.local.home>
In-Reply-To: <1552998060-5735-1-git-send-email-prsood@codeaurora.org>
References: <20190318151529.GT6058@hirez.programming.kicks-ass.net>
        <1552998060-5735-1-git-send-email-prsood@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 17:51:00 +0530
Prateek Sood <prsood@codeaurora.org> wrote:

> SyS_perf_event_open()
>   free_event()
>     _free_event()
>       tp_perf_event_destroy()
>         perf_trace_destroy()
>           perf_trace_event_unreg() //free perf_trace_buf
> 
> trace_cpu_frequency()
>   perf_trace_cpu()
>     perf_trace_buf_alloc() //access perf_trace_buf
> 
> 	CPU0					CPU1
> perf_trace_event_unreg()                perf_trace_cpu()
> 					head = (event_call->perf_events)
> 

But here there's a:

  tracepoint_synchronize_unregister();

Which is suppose to prevent this. Are you saying that the
tracepoint_synchronize_unregister() is broken?

-- Steve


> free_percpu(tp_event->perf_events)
> tp_event->perf_events = NULL
> --total_ref_count
> free_percpu(perf_trace_buf[i])
> perf_trace_buf[i] = NULL
> 
> 					raw_data = perf_trace_buf[rctx]
> 					memset(raw_data)
> 
> A potential race exists between access of perf_trace_buf from
> perf_trace_buf_alloc() and perf_trace_event_unreg(). This can
> result in perf_trace_buf[rctx] being NULL during access from memset()
> in perf_trace_buf_alloc().
> 
