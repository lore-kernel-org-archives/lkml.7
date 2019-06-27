Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29461C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BB9208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF0Ogj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfF0Ogj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:36:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66EC520828;
        Thu, 27 Jun 2019 14:36:38 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:36:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] ftrace: Expose __ftrace_replace_code()
Message-ID: <20190627103636.21122b0d@gandalf.local.home>
In-Reply-To: <0d09c94f19332b13707109f41cd15b6e0c45d120.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <0d09c94f19332b13707109f41cd15b6e0c45d120.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 16:53:51 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> While over-riding ftrace_replace_code(), we still want to reuse the
> existing __ftrace_replace_code() function. Rename the function and
> make it available for other kernel code.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  include/linux/ftrace.h | 1 +
>  kernel/trace/ftrace.c  | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e97789c95c4e..fa653a561da5 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -456,6 +456,7 @@ ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable);
>  /* defined in arch */
>  extern int ftrace_ip_converted(unsigned long ip);
>  extern int ftrace_dyn_arch_init(void);
> +extern int ftrace_replace_code_rec(struct dyn_ftrace *rec, int enable);
>  extern void ftrace_replace_code(int enable);
>  extern int ftrace_update_ftrace_func(ftrace_func_t func);
>  extern void ftrace_caller(void);
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 5710a6b3edc1..21d8e201ee80 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2351,8 +2351,8 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
>  		return (unsigned long)FTRACE_ADDR;
>  }
>  
> -static int
> -__ftrace_replace_code(struct dyn_ftrace *rec, int enable)
> +int
> +ftrace_replace_code_rec(struct dyn_ftrace *rec, int enable)

Make this a single line, as it removes static and "__" which should
keep it normal.

Other than that,

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  {
>  	unsigned long ftrace_old_addr;
>  	unsigned long ftrace_addr;
> @@ -2403,7 +2403,7 @@ void __weak ftrace_replace_code(int mod_flags)
>  		if (rec->flags & FTRACE_FL_DISABLED)
>  			continue;
>  
> -		failed = __ftrace_replace_code(rec, enable);
> +		failed = ftrace_replace_code_rec(rec, enable);
>  		if (failed) {
>  			ftrace_bug(failed, rec);
>  			/* Stop processing */
> @@ -5827,7 +5827,7 @@ void ftrace_module_enable(struct module *mod)
>  		rec->flags = cnt;
>  
>  		if (ftrace_start_up && cnt) {
> -			int failed = __ftrace_replace_code(rec, 1);
> +			int failed = ftrace_replace_code_rec(rec, 1);
>  			if (failed) {
>  				ftrace_bug(failed, rec);
>  				goto out_loop;

