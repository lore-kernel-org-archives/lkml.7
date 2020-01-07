Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4DBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05FA214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578415059;
	bh=WeGdluQgbNifXIcTZEOneYUZCHV0JUafvBrW0LEXeYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=mVXlXSSksC/FvBP46OEfSQW++lzYZJ/7D2B23oYqSAdW8lEUS2b1Sx7P1lAvvqbWv
	 jy8JU5k/5eDmPUUyEOjKz/7/q62CyQ4DEhJIf0OfIGeKILXoi1VK2Wr4eHyJzDpWNN
	 X+rkB83oykxWaONRnjCeOLunwEDiW+Sf3AiUVnAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAGQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgAGQhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:37:37 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148F52080A;
        Tue,  7 Jan 2020 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578415056;
        bh=WeGdluQgbNifXIcTZEOneYUZCHV0JUafvBrW0LEXeYU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AZDKjoxPEWuA9mR5C2ga6nJunW5R1VeVUDi1CHJiJpL6J2qtA8qjPPrxi//0bl+J3
         TWPwmJ/WboG7dveyCvE5N5CTcgTBlDKQ2kjvCrP1jkcplWvWCwD9fxeoUhG/ja4ggT
         NWRLHueWXwJg6qrsCrKzDdYaHtlfIXiogLBUTnO4=
Message-ID: <1578415055.2816.2.camel@kernel.org>
Subject: Re: [PATCH -tip] tracing: trigger: Replace unneeded RCU-list
 traversals
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Date:   Tue, 07 Jan 2020 10:37:35 -0600
In-Reply-To: <157680910305.11685.15110237954275915782.stgit@devnote2>
References: <157680910305.11685.15110237954275915782.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2019-12-20 at 11:31 +0900, Masami Hiramatsu wrote:
> With CONFIG_PROVE_RCU_LIST, I had many suspicious RCU warnings
> when I ran ftracetest trigger testcases.
> 
> -----
>   # dmesg -c > /dev/null
>   # ./ftracetest test.d/trigger
>   ...
>   # dmesg | grep "RCU-list traversed" | cut -f 2 -d ] | cut -f 2 -d "
> "
>   kernel/trace/trace_events_hist.c:6070
>   kernel/trace/trace_events_hist.c:1760
>   kernel/trace/trace_events_hist.c:5911
>   kernel/trace/trace_events_trigger.c:504
>   kernel/trace/trace_events_hist.c:1810
>   kernel/trace/trace_events_hist.c:3158
>   kernel/trace/trace_events_hist.c:3105
>   kernel/trace/trace_events_hist.c:5518
>   kernel/trace/trace_events_hist.c:5998
>   kernel/trace/trace_events_hist.c:6019
>   kernel/trace/trace_events_hist.c:6044
>   kernel/trace/trace_events_trigger.c:1500
>   kernel/trace/trace_events_trigger.c:1540
>   kernel/trace/trace_events_trigger.c:539
>   kernel/trace/trace_events_trigger.c:584
> -----
> 
> I investigated those warnings and found that the RCU-list
> traversals in event trigger and hist didn't need to use
> RCU version because those were called only under event_mutex.
> 
> I also checked other RCU-list traversals related to event
> trigger list, and found that most of them were called from
> event_hist_trigger_func() or hist_unregister_trigger() or
> register/unregister functions except for a few cases.
> 
> Replace these unneeded RCU-list traversals with normal list
> traversal macro and lockdep_assert_held() to check the
> event_mutex is held.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

This patch looks fine to me, thanks for the fixes.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
>  kernel/trace/trace_events_hist.c    |   41
> ++++++++++++++++++++++++++---------
>  kernel/trace/trace_events_trigger.c |   20 +++++++++++++----
>  2 files changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 23b0195ac977..844f8325077f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1753,11 +1753,13 @@ static struct hist_field *find_var(struct
> hist_trigger_data *hist_data,
>  	struct event_trigger_data *test;
>  	struct hist_field *hist_field;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	hist_field = find_var_field(hist_data, var_name);
>  	if (hist_field)
>  		return hist_field;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			test_data = test->private_data;
>  			hist_field = find_var_field(test_data,
> var_name);
> @@ -1807,7 +1809,9 @@ static struct hist_field *find_file_var(struct
> trace_event_file *file,
>  	struct event_trigger_data *test;
>  	struct hist_field *hist_field;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			test_data = test->private_data;
>  			hist_field = find_var_field(test_data,
> var_name);
> @@ -3102,7 +3106,9 @@ static char *find_trigger_filter(struct
> hist_trigger_data *hist_data,
>  {
>  	struct event_trigger_data *test;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (test->private_data == hist_data)
>  				return test->filter_str;
> @@ -3153,9 +3159,11 @@ find_compatible_hist(struct hist_trigger_data
> *target_hist_data,
>  	struct event_trigger_data *test;
>  	unsigned int n_keys;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	n_keys = target_hist_data->n_fields - target_hist_data-
> >n_vals;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			hist_data = test->private_data;
>  
> @@ -5515,7 +5523,7 @@ static int hist_show(struct seq_file *m, void
> *v)
>  		goto out_unlock;
>  	}
>  
> -	list_for_each_entry_rcu(data, &event_file->triggers, list) {
> +	list_for_each_entry(data, &event_file->triggers, list) {
>  		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
>  			hist_trigger_show(m, data, n++);
>  	}
> @@ -5908,7 +5916,9 @@ static int hist_register_trigger(char *glob,
> struct event_trigger_ops *ops,
>  	if (hist_data->attrs->name && !named_data)
>  		goto new;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (!hist_trigger_match(data, test,
> named_data, false))
>  				continue;
> @@ -5992,10 +6002,12 @@ static bool have_hist_trigger_match(struct
> event_trigger_data *data,
>  	struct event_trigger_data *test, *named_data = NULL;
>  	bool match = false;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	if (hist_data->attrs->name)
>  		named_data = find_named_trigger(hist_data->attrs-
> >name);
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (hist_trigger_match(data, test,
> named_data, false)) {
>  				match = true;
> @@ -6013,10 +6025,12 @@ static bool hist_trigger_check_refs(struct
> event_trigger_data *data,
>  	struct hist_trigger_data *hist_data = data->private_data;
>  	struct event_trigger_data *test, *named_data = NULL;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	if (hist_data->attrs->name)
>  		named_data = find_named_trigger(hist_data->attrs-
> >name);
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (!hist_trigger_match(data, test,
> named_data, false))
>  				continue;
> @@ -6038,10 +6052,12 @@ static void hist_unregister_trigger(char
> *glob, struct event_trigger_ops *ops,
>  	struct event_trigger_data *test, *named_data = NULL;
>  	bool unregistered = false;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	if (hist_data->attrs->name)
>  		named_data = find_named_trigger(hist_data->attrs-
> >name);
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (!hist_trigger_match(data, test,
> named_data, false))
>  				continue;
> @@ -6067,7 +6083,9 @@ static bool hist_file_check_refs(struct
> trace_event_file *file)
>  	struct hist_trigger_data *hist_data;
>  	struct event_trigger_data *test;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			hist_data = test->private_data;
>  			if (check_var_refs(hist_data))
> @@ -6310,7 +6328,8 @@ hist_enable_trigger(struct event_trigger_data
> *data, void *rec,
>  	struct enable_trigger_data *enable_data = data-
> >private_data;
>  	struct event_trigger_data *test;
>  
> -	list_for_each_entry_rcu(test, &enable_data->file->triggers,
> list) {
> +	list_for_each_entry_rcu(test, &enable_data->file->triggers,
> list,
> +				lockdep_is_held(&event_mutex)) {
>  		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
>  			if (enable_data->enable)
>  				test->paused = false;
> diff --git a/kernel/trace/trace_events_trigger.c
> b/kernel/trace/trace_events_trigger.c
> index 2cd53ca21b51..40106fff06a4 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -501,7 +501,9 @@ void update_cond_flag(struct trace_event_file
> *file)
>  	struct event_trigger_data *data;
>  	bool set_cond = false;
>  
> -	list_for_each_entry_rcu(data, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
>  		if (data->filter || event_command_post_trigger(data-
> >cmd_ops) ||
>  		    event_command_needs_rec(data->cmd_ops)) {
>  			set_cond = true;
> @@ -536,7 +538,9 @@ static int register_trigger(char *glob, struct
> event_trigger_ops *ops,
>  	struct event_trigger_data *test;
>  	int ret = 0;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		if (test->cmd_ops->trigger_type == data->cmd_ops-
> >trigger_type) {
>  			ret = -EEXIST;
>  			goto out;
> @@ -581,7 +585,9 @@ static void unregister_trigger(char *glob, struct
> event_trigger_ops *ops,
>  	struct event_trigger_data *data;
>  	bool unregistered = false;
>  
> -	list_for_each_entry_rcu(data, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
>  		if (data->cmd_ops->trigger_type == test->cmd_ops-
> >trigger_type) {
>  			unregistered = true;
>  			list_del_rcu(&data->list);
> @@ -1497,7 +1503,9 @@ int event_enable_register_trigger(char *glob,
>  	struct event_trigger_data *test;
>  	int ret = 0;
>  
> -	list_for_each_entry_rcu(test, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
>  		test_enable_data = test->private_data;
>  		if (test_enable_data &&
>  		    (test->cmd_ops->trigger_type ==
> @@ -1537,7 +1545,9 @@ void event_enable_unregister_trigger(char
> *glob,
>  	struct event_trigger_data *data;
>  	bool unregistered = false;
>  
> -	list_for_each_entry_rcu(data, &file->triggers, list) {
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
>  		enable_data = data->private_data;
>  		if (enable_data &&
>  		    (data->cmd_ops->trigger_type ==
> 
