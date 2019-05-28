Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EFA21473
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfE1PsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfE1PsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:48:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864E82133F;
        Tue, 28 May 2019 15:48:23 +0000 (UTC)
Date:   Tue, 28 May 2019 11:48:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] trace: Avoid memory leak in predicate_parse()
Message-ID: <20190528114821.2302dabd@gandalf.local.home>
In-Reply-To: <20190528154338.29976-1-tomasbortoli@gmail.com>
References: <20190528104400.388e4c3f@gandalf.local.home>
        <20190528154338.29976-1-tomasbortoli@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 17:43:38 +0200
Tomas Bortoli <tomasbortoli@gmail.com> wrote:

> In case of errors, predicate_parse() goes to the out_free label
> to free memory and to return an error code.
> 
> However, predicate_parse() does not free the predicates of the
> temporary prog_stack array, thence leaking them.

Thanks, I applied this and I'm running it through my tests. But just an
FYI, when sending updated patches please add a "v2" to the subject:

 [PATCH v2] tracing: Avoid memory leak in predicate_parse()

That way struggling maintainers like myself don't get confused about
which patch to apply ;-)

Thanks!

-- Steve


> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
> ---
>  kernel/trace/trace_events_filter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 05a66493a164..ecfa6f0f1c7e 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -427,7 +427,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>  	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
>  	if (!op_stack)
>  		return ERR_PTR(-ENOMEM);
> -	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
> +	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
>  	if (!prog_stack) {
>  		parse_error(pe, -ENOMEM, 0);
>  		goto out_free;
> @@ -578,6 +578,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>  out_free:
>  	kfree(op_stack);
>  	kfree(inverts);
> +	for (i = 0; prog_stack[i].pred; i++)
> +		kfree(prog_stack[i].pred);
>  	kfree(prog_stack);
>  	return ERR_PTR(ret);
>  }

