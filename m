Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B78C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226FE20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNOH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfKNOH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:07:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 185452070E;
        Thu, 14 Nov 2019 14:07:57 +0000 (UTC)
Date:   Thu, 14 Nov 2019 09:07:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 15/17] ftrace: Rework event_create_dir()
Message-ID: <20191114090755.7d6d4a31@gandalf.local.home>
In-Reply-To: <20191111132458.342979914@infradead.org>
References: <20191111131252.921588318@infradead.org>
        <20191111132458.342979914@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 14:13:07 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Rework event_create_dir() to use an array of static data instead of
> function pointers where possible.
> 
> The problem is that it would call the function pointer on module load
> before parse_args(), possibly even before jump_labels were initialized.
> Luckily the generated functions don't use jump_labels but it still seems
> fragile. It also gets in the way of changing when we make the module map
> executable.
> 
> The generated function are basically calling trace_define_field() with a
> bunch of static arguments. So instead of a function, capture these
> arguments in a static array, avoiding the function call.
> 
> Now there are a number of cases where the fields are dynamic (syscall
> arguments, kprobes and uprobes), in which case a static array does not
> work, for these we preserve the function call. Luckily all these cases
> are not related to modules and so we can retain the function call for
> them.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/infiniband/hw/hfi1/trace_tid.h  |    8 +-
>  drivers/infiniband/hw/hfi1/trace_tx.h   |    2 
>  drivers/lightnvm/pblk-trace.h           |    8 +-
>  drivers/net/fjes/fjes_trace.h           |    2 
>  drivers/net/wireless/ath/ath10k/trace.h |    6 -
>  fs/xfs/scrub/trace.h                    |    6 -
>  fs/xfs/xfs_trace.h                      |    4 -
>  include/linux/trace_events.h            |   18 +++++
>  include/trace/events/filemap.h          |    2 
>  include/trace/events/rpcrdma.h          |    2 
>  include/trace/trace_events.h            |   64 ++++++-------------
>  kernel/trace/trace.h                    |   31 ++++-----
>  kernel/trace/trace_entries.h            |   66 +++++--------------
>  kernel/trace/trace_events.c             |   20 +++++-
>  kernel/trace/trace_events_hist.c        |    8 ++
>  kernel/trace/trace_export.c             |  106 +++++++++++---------------------
>  kernel/trace/trace_kprobe.c             |   16 ++++
>  kernel/trace/trace_syscalls.c           |   50 ++++++---------
>  kernel/trace/trace_uprobe.c             |    9 ++
>  net/mac80211/trace.h                    |   28 ++++----
>  net/wireless/trace.h                    |    6 -
>  21 files changed, 213 insertions(+), 249 deletions(-)
> 
> 
