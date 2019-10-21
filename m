Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB243CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43D820882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfJUSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfJUSIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:08:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE8B2086D;
        Mon, 21 Oct 2019 18:07:57 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:07:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mingo@redhat.com, peterz@infradead.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191021140756.613a1bac@gandalf.local.home>
In-Reply-To: <20191021163426.9408-2-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
        <20191021163426.9408-2-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 17:34:19 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Architectures may need to perform special initialization of ftrace
> callsites, and today they do so by special-casing ftrace_make_nop() when
> the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
> patchable-function-entry), we don't have an mcount-like symbol and don't
> want a synthetic MCOUNT_ADDR, but we may need to perform some
> initialization of callsites.
> 
> To make it possible to separate initialization from runtime
> modification, and to handle cases without an mcount-like symbol, this
> patch adds an optional ftrace_init_nop() function that architectures can
> implement, which does not pass a branch address.
> 
> Where an architecture does not provide ftrace_init_nop(), we will fall
> back to the existing behaviour of calling ftrace_make_nop() with
> MCOUNT_ADDR.
> 
> At the same time, ftrace_code_disable() is renamed to
> ftrace_code_init_disabled() to make it clearer that it is intended to
> intialize a callsite into a disabled state, and is not for disabling a
> callsite that has been runtime enabled.

To make the name even better, let's just rename it to:

 ftrace_nop_initialization()

I think that may be the best description for it.

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Torsten Duwe <duwe@suse.de>
> ---
>  kernel/trace/ftrace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f296d89be757..afd7e210e595 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2493,15 +2493,22 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
>  	return &iter->pg->records[iter->index];
>  }
>  
> +#ifndef ftrace_init_nop
> +static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> +{
> +	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +}
> +#endif

Can you place the above in the ftrace.h header. That's where that would
belong.

#ifndef ftrace_init_nop
struct module;
static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
{
	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
}
#endif

-- Steve

> +
>  static int
> -ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
> +ftrace_code_init_disabled(struct module *mod, struct dyn_ftrace *rec)
>  {
>  	int ret;
>  
>  	if (unlikely(ftrace_disabled))
>  		return 0;
>  
> -	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +	ret = ftrace_init_nop(mod, rec);
>  	if (ret) {
>  		ftrace_bug_type = FTRACE_BUG_INIT;
>  		ftrace_bug(ret, rec);
> @@ -2943,7 +2950,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  			 * to the NOP instructions.
>  			 */
>  			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
> -			    !ftrace_code_disable(mod, p))
> +			    !ftrace_code_init_disabled(mod, p))
>  				break;
>  
>  			update_cnt++;

