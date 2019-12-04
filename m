Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7229C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E31D2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfLDO0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfLDO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:26:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5907820675;
        Wed,  4 Dec 2019 14:26:42 +0000 (UTC)
Date:   Wed, 4 Dec 2019 09:26:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Silence an uninitialized variable warning
Message-ID: <20191204092640.692c95af@gandalf.local.home>
In-Reply-To: <20191126121934.kuolgbm55dirfbay@kili.mountain>
References: <20191126121934.kuolgbm55dirfbay@kili.mountain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 15:19:34 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Smatch complains that "ret" could be uninitialized if we don't enter the
> loop.  I don't know if that's possible, but it's nicer to return a
> literal zero instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/trace/trace_syscalls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 73140d80dd46..63528f458826 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -286,7 +286,7 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
>  		offset += sizeof(unsigned long);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)

The current code has this:

static int __init syscall_enter_define_fields(struct trace_event_call *call)
{
	struct syscall_trace_enter trace;
	struct syscall_metadata *meta = call->data;
	int ret;
	int i;
	int offset = offsetof(typeof(trace), args);

	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
				 FILTER_OTHER);
	if (ret)
		return ret;

	for (i = 0; i < meta->nb_args; i++) {
		ret = trace_define_field(call, meta->types[i],
					 meta->args[i], offset,
					 sizeof(unsigned long), 0,
					 FILTER_OTHER);
		offset += sizeof(unsigned long);
	}

	return ret;
}


How can ret possibly be uninitialized?

-- Steve
