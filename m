Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81AECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9021835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437028AbfJQRpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389827AbfJQRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:45:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D5B20820;
        Thu, 17 Oct 2019 17:45:34 +0000 (UTC)
Date:   Thu, 17 Oct 2019 13:45:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017134526.097f1490@gandalf.local.home>
In-Reply-To: <20191017154205.GC8974@kernel.org>
References: <20191017154205.GC8974@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 12:42:05 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> I'll try and continue later, but if you guys can take a look...
> 
> The first call in that loop:
> 
>   while ((event = trace_find_next_event(pevent, event)))
> 
> works and the event is valid, one of the sched: tracepoints, but then
> the next call returns this:
> 
> struct tep_event *trace_find_next_event(struct tep_handle *pevent,
>                                         struct tep_event *event)
> {
>         static int idx;
>         int events_count;
>         struct tep_event *all_events;
> 
>         all_events = tep_get_first_event(pevent);
>         events_count = tep_get_events_count(pevent);
>         if (!pevent || !all_events || events_count < 1)
>                 return NULL;
> 
>         if (!event) {
>                 idx = 0;
>                 return all_events;
>         }
> 
>         if (idx < events_count && event == (all_events + idx)) {
>                 idx++;
>                 if (idx == events_count)
>                         return NULL;
>                 return (all_events + idx);
>         }
> 
>         for (idx = 1; idx < events_count; idx++) {
>                 if (event == (all_events + (idx - 1)))
>                         return (all_events + idx);
>         }
>         return NULL;
> }
> 
> Oh, static int idx, oops, anyway, the all_events + idx returned for the
> second call to trace_find_next_event() fails, in a hurry now, will get
> back to this later.

Yeah, this is obviously broken. :-( 

I'll have a patch later today.

-- Steve
