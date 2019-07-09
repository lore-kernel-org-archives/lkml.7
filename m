Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBFC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF020861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGINxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:53:49 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49006 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfGINxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:53:48 -0400
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [131.188.30.118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 9B4BB241306;
        Tue,  9 Jul 2019 15:53:46 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id 838F9341CCE; Tue,  9 Jul 2019 15:53:46 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:53:46 +0200
From:   Thomas Preisner <linux@tpreisner.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Preisner <linux@tpreisner.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190709135346.r4m4izzhgk55kniy@stud.informatik.uni-erlangen.de>
References: <20190529104552.146fa97c@oasis.local.home>
 <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
 <20190617201627.647547c7@gandalf.local.home>
 <20190623120555.nka2357agpqovxla@stud.informatik.uni-erlangen.de>
 <20190626120412.662e8cf9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626120412.662e8cf9@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:04:12PM -0400, Steven Rostedt wrote:
> On Sun, 23 Jun 2019 14:05:55 +0200
> Thomas Preisner <linux@tpreisner.de> wrote:
> > I've created this tracer with kernel tailoring in mind since the
> > tailoring process of e.g. undertaker heavily benefits from a more
> > precise set of input data.
> > 
> > A "oneshot" option for the function tracer would be a viable
> > possibility. However, this may add a lot of overhead (performance wise)
> > in comparison to my current approach? After all, the use case of my
> > tracer would be some sort of kernel activity monitoring during "normal
> > usage" in order to get a grasp of (hopefully) all required kernel
> > functions.
> 
> Coming back from vacation and not having this threaded in my inbox,
> I have to ask (to help cache this back into my head), what was the
> "current approach" compared to the "oneshot" option, and why would it
> have better performance?

The current approach makes use of ftrace's profiling capabilities in
conjunction with a hashtable and preallocated memory for its entries.
When active, this oneshot-profiler will only perform lookups for ip and
parent_ip and insert those when necessary. Compared to the "oneshot"
option this allows to omit values that are not required for kernel
profiling such as interrupt flags, etc. However, I am not sure how huge
this may impact the performance.

Nonetheless, the profiling variant allows to remove duplicated entries
(due to there being one hashset per CPU core) before outputting its
gathered data. Additionally, it is independent of the ringbuffer which
may overflow due to other tracers being active (However, I am not sure
if or in which way different tracers are isolated from each other when
using the ringbuffer, so this may as well be false).

> > 
> > Also, there is no strong reason to add a new event type,
> > this was just a means of reducing the collected data (which may as well
> > be omitted since there is no real benefit).
> 
> +1
> 
> > 
> > My "oneshot tracer" actually collects and outputs every parent in order
> > to get a more thorough view on used kernel code. Therefore, I would
> > suggest to keep this functionality and maybe make it configurable
> > instead?
> 
> Configure which? (again, coming back from vacation, I need a refresher
> on this ;-)

In case you want to incorporate this oneshot functionality directly into
the function tracer as a new option it may be useful to allow
configuring the tracer's oneshot capabilities. This way, one could
disable tracing of a function after its first occurrence or instead keep
tracing enabled in order to get a better overview over where it was
called from (-> recording the parent_ip is also interesting).

Yours sincerely,
Thomas
