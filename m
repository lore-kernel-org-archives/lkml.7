Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAFC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8467C208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 19:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEETeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 15:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfEETeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 15:34:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70552087F;
        Sun,  5 May 2019 19:34:48 +0000 (UTC)
Date:   Sun, 5 May 2019 15:34:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <mingo@redhat.com>
Subject: Re: [PATCH] ftrace: enable trampoline when rec count decrement to
 one
Message-ID: <20190505153447.594d4eab@oasis.local.home>
In-Reply-To: <1556969979-111047-1-git-send-email-cj.chengjian@huawei.com>
References: <1556969979-111047-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 19:39:39 +0800
Cheng Jian <cj.chengjian@huawei.com> wrote:

> Trampoline can only be enabled if there is only a single ops
> attached to it. If there's only a single callback registered
> to a function, and the ops has a trampoline registered for it,
> then we can call the trampoline directly. This is very useful
> for improving the performance of ftrace and livepatch.
> 
> But we always disable trampoline when unregister ftrace. So if
> you have registered multiple ftrace_ops at the same location,
> even if the other ones have been unregistered, you will no longer
> be able to use trampoline.
> 
> To fix it, set FTRACE_FL_TRAMP flag if rec count is decremented
> to one, and the ops that left has a trampoline.
> 
> Testing After this patch :
> 
> insmod livepatch_unshare_files.ko
> cat /sys/kernel/debug/tracing/enabled_functions
> 
> 	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0
> 
> echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
> echo function > /sys/kernel/debug/tracing/current_tracer
> cat /sys/kernel/debug/tracing/enabled_functions
> 
> 	unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x150
> 
> echo nop > /sys/kernel/debug/tracing/current_tracer
> cat /sys/kernel/debug/tracing/enabled_functions
> 
> 	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

Thanks for the patch. There was some race condition that prevented me
from doing this in the first place, but unfortunately, I don't remember
what that was :-/

I'll have to think about this before applying this patch.

Maybe there isn't a race condition, and I was just playing it safe, as
there was a race condition between switching from regs caller back to
non regs caller.

-- Steve


> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/trace/ftrace.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b920358..bdc29c2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1626,6 +1626,11 @@ static bool test_rec_ops_needs_regs(struct
> dyn_ftrace *rec) return  keep_regs;
>  }
>  
> +static struct ftrace_ops *
> +ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
> +static struct ftrace_ops *
> +ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops
> *ops); +
>  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  				     int filter_hash,
>  				     bool inc)
> @@ -1754,15 +1759,17 @@ static bool __ftrace_hash_rec_update(struct
> ftrace_ops *ops, }
>  
>  			/*
> -			 * If the rec had TRAMP enabled, then it
> needs to
> -			 * be cleared. As TRAMP can only be enabled
> iff
> -			 * there is only a single ops attached to it.
> -			 * In otherwords, always disable it on
> decrementing.
> -			 * In the future, we may set it if rec count
> is
> -			 * decremented to one, and the ops that is
> left
> -			 * has a trampoline.
> +			 * The TRAMP needs to be set only if rec
> count
> +			 * is decremented to one, and the ops that is
> +			 * left has a trampoline. As TRAMP can only
> be
> +			 * enabled if there is only a single ops
> attached
> +			 * to it.
>  			 */
> -			rec->flags &= ~FTRACE_FL_TRAMP;
> +			if (ftrace_rec_count(rec) == 1 &&
> +			    ftrace_find_tramp_ops_any(rec))
> +				rec->flags |= FTRACE_FL_TRAMP;
> +			else
> +				rec->flags &= ~FTRACE_FL_TRAMP;
>  
>  			/*
>  			 * flags will be cleared in
> ftrace_check_record() @@ -1955,11 +1962,6 @@ static void
> print_ip_ins(const char *fmt, const unsigned char *p)
> printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]); }
>  
> -static struct ftrace_ops *
> -ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
> -static struct ftrace_ops *
> -ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops
> *ops); -
>  enum ftrace_bug_type ftrace_bug_type;
>  const void *ftrace_expected;
>  

