Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E925CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5176920663
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443401AbfJRUHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440361AbfJRUEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:04:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC3E21D7C;
        Fri, 18 Oct 2019 20:04:39 +0000 (UTC)
Date:   Fri, 18 Oct 2019 16:04:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, George Spelvin <lkml@sdf.org>
Subject: Re: [PATCH v1 3/3] tracing: Use generic type for comparator
 function
Message-ID: <20191018160438.5a6ded3d@gandalf.local.home>
In-Reply-To: <20191007135656.37734-3-andriy.shevchenko@linux.intel.com>
References: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
        <20191007135656.37734-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Oct 2019 16:56:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

Hi Andy,

FYI, when sending more than one patch, you should have a cover letter.

Andrew,

Do you want to take this series?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Comparator function type, cmp_func_t, is defined in the types.h,
> use it in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/trace/ftrace.c       | 12 ++++++------
>  kernel/trace/trace_branch.c |  8 ++++----
>  kernel/trace/trace_stat.c   |  6 ++----
>  kernel/trace/trace_stat.h   |  2 +-
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 62a50bf399d6..3bf9e805c46c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -462,10 +462,10 @@ static void *function_stat_start(struct tracer_stat *trace)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  /* function graph compares on total time */
> -static int function_stat_cmp(void *p1, void *p2)
> +static int function_stat_cmp(const void *p1, const void *p2)
>  {
> -	struct ftrace_profile *a = p1;
> -	struct ftrace_profile *b = p2;
> +	const struct ftrace_profile *a = p1;
> +	const struct ftrace_profile *b = p2;
>  
>  	if (a->time < b->time)
>  		return -1;
> @@ -476,10 +476,10 @@ static int function_stat_cmp(void *p1, void *p2)
>  }
>  #else
>  /* not function graph compares against hits */
> -static int function_stat_cmp(void *p1, void *p2)
> +static int function_stat_cmp(const void *p1, const void *p2)
>  {
> -	struct ftrace_profile *a = p1;
> -	struct ftrace_profile *b = p2;
> +	const struct ftrace_profile *a = p1;
> +	const struct ftrace_profile *b = p2;
>  
>  	if (a->counter < b->counter)
>  		return -1;
> diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
> index 3ea65cdff30d..88e158d27965 100644
> --- a/kernel/trace/trace_branch.c
> +++ b/kernel/trace/trace_branch.c
> @@ -244,7 +244,7 @@ static int annotated_branch_stat_headers(struct seq_file *m)
>  	return 0;
>  }
>  
> -static inline long get_incorrect_percent(struct ftrace_branch_data *p)
> +static inline long get_incorrect_percent(const struct ftrace_branch_data *p)
>  {
>  	long percent;
>  
> @@ -332,10 +332,10 @@ annotated_branch_stat_next(void *v, int idx)
>  	return p;
>  }
>  
> -static int annotated_branch_stat_cmp(void *p1, void *p2)
> +static int annotated_branch_stat_cmp(const void *p1, const void *p2)
>  {
> -	struct ftrace_branch_data *a = p1;
> -	struct ftrace_branch_data *b = p2;
> +	const struct ftrace_branch_data *a = p1;
> +	const struct ftrace_branch_data *b = p2;
>  
>  	long percent_a, percent_b;
>  
> diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
> index 75bf1bcb4a8a..dd9960a2dd0c 100644
> --- a/kernel/trace/trace_stat.c
> +++ b/kernel/trace/trace_stat.c
> @@ -72,9 +72,7 @@ static void destroy_session(struct stat_session *session)
>  	kfree(session);
>  }
>  
> -typedef int (*cmp_stat_t)(void *, void *);
> -
> -static int insert_stat(struct rb_root *root, void *stat, cmp_stat_t cmp)
> +static int insert_stat(struct rb_root *root, void *stat, cmp_func_t cmp)
>  {
>  	struct rb_node **new = &(root->rb_node), *parent = NULL;
>  	struct stat_node *data;
> @@ -112,7 +110,7 @@ static int insert_stat(struct rb_root *root, void *stat, cmp_stat_t cmp)
>   * This one will force an insertion as right-most node
>   * in the rbtree.
>   */
> -static int dummy_cmp(void *p1, void *p2)
> +static int dummy_cmp(const void *p1, const void *p2)
>  {
>  	return -1;
>  }
> diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
> index 8786d17caf49..31d7dc5bf1db 100644
> --- a/kernel/trace/trace_stat.h
> +++ b/kernel/trace/trace_stat.h
> @@ -16,7 +16,7 @@ struct tracer_stat {
>  	void			*(*stat_start)(struct tracer_stat *trace);
>  	void			*(*stat_next)(void *prev, int idx);
>  	/* Compare two entries for stats sorting */
> -	int			(*stat_cmp)(void *p1, void *p2);
> +	cmp_func_t		stat_cmp;
>  	/* Print a stat entry */
>  	int			(*stat_show)(struct seq_file *s, void *p);
>  	/* Release an entry */

