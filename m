Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6346218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:54:24 -0500
Received: from winnie.ispras.ru ([83.149.199.91]:10338 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbfLSPyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:54:24 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 10:54:24 EST
Received: from [10.10.3.121] (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id C893C203C1;
        Thu, 19 Dec 2019 18:45:39 +0300 (MSK)
Date:   Thu, 19 Dec 2019 18:45:39 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
cc:     Peter Zijlstra <peterz@infradead.org>, gcc-help@gcc.gnu.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jan Hubicka <hubicka@ucw.cz>
Subject: Re: [Q] ld: Does LTO reorder ro variables in two files?
In-Reply-To: <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
Message-ID: <alpine.LNX.2.20.13.1912191817440.18668@monopod.intra.ispras.ru>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain> <20191219131242.GK2827@hirez.programming.kicks-ass.net> <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Jan Hubicka, GCC LTO maintainer]

On Thu, 19 Dec 2019, Kirill Tkhai wrote:

> CC: gcc-help@gcc.gnu.org
> 
> Hi, gcc guys,
> 
> this thread starts here: https://lkml.org/lkml/2019/12/19/403
> 
> There are two const variables:
> 
>    struct sched_class idle_sched_class
> and
>    struct sched_class fair_sched_class,
> 
> which are declared in two files idle.c and fair.c.
> 
> 1)In Makefile the order is: idle.o fair.o
> 2)the variables go to the same ro section
> 3)there is no SORT(.*) keyword in linker script.
> 
> Is it always true, that after linkage &idle_sched_class < &fair_sched_class?

No, with LTO you don't have that guarantee. For functions it's more obvious,
GCC wants to analyze functions in reverse topological order so callees are
generally optimized before callers, and it will emit assembly as it goes, so
function ordering with LTO does not give much care to translation unit
boundaries. For variables it's a bit more subtle, GCC partitions all variables
and functions so it can hand them off to multiple compiler processes while doing
LTO. There's no guarantees about order of variables that end up in different
partitions.

There's __attribute__((no_reorder)) that is intended to enforce ordering even
with LTO (it's documented under "Common function attributes" but works for
global variables as well).

Alexander

> Thanks!
> Kirill
> 
> On 19.12.2019 16:12, Peter Zijlstra wrote:
> > On Thu, Dec 19, 2019 at 03:39:14PM +0300, Kirill Tkhai wrote:
> >> In kernel/sched/Makefile files, describing different sched classes, already
> >> go in the order from the lowest priority class to the highest priority class:
> >>
> >> idle.o fair.o rt.o deadline.o stop_task.o
> >>
> >> The documentation of GNU linker says, that section appears in the order
> >> they are seen during link time (see [1]):
> >>
> >>> Normally, the linker will place files and sections matched by wildcards
> >>> in the order in which they are seen during the link. You can change this
> >>> by using the SORT keyword, which appears before a wildcard pattern
> >>> in parentheses (e.g., SORT(.text*)).
> >>
> >> So, we may expect const variables from idle.o will go before ro variables
> >> from fair.o in RO_DATA section, while ro variables from fair.o will go
> >> before ro variables from rt.o, etc.
> >>
> >> (Also, it looks like the linking order is already used in kernel, e.g.
> >>  in drivers/md/Makefile)
> >>
> >> Thus, we may introduce an optimization based on xxx_sched_class addresses
> >> in these two hot scheduler functions: pick_next_task() and check_preempt_curr().
> >>
> >> One more result of the patch is that size of object file becomes a little
> >> less (excluding added BUG_ON(), which goes in __init section):
> >>
> >> $size kernel/sched/core.o
> >>          text     data      bss	    dec	    hex	filename
> >> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> >> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> > 
> > Does LTO preserve this behaviour? I've never quite dared do this exact
> > optimization.
> 
> 
