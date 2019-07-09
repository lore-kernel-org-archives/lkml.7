Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87485C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526832087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfGITvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfGITvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:51:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C412087F;
        Tue,  9 Jul 2019 19:51:18 +0000 (UTC)
Date:   Tue, 9 Jul 2019 15:51:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 4/4] trace: introduce trace event injection
Message-ID: <20190709155117.7cab28aa@gandalf.local.home>
In-Reply-To: <20190525165802.25944-5-xiyou.wangcong@gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
        <20190525165802.25944-5-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Cong,

I finally got around to looking at these patches. Sorry for such a long
time, I've been terribly busy :-(

BTW, it's best to look at how other commits in a subsystem do their
subject lines. The subsystem is "tracing" not "trace", and Linus
prefers to have the first letter after that capitalized. For example, I
changed your subject to:

 "tracing: Introduce trace event injection"


On Sat, 25 May 2019 09:58:02 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> For example, for the net/net_dev_queue tracepoint, we can inject:
> 
>   INJECT=/sys/kernel/debug/tracing/events/net/net_dev_queue/inject
>   echo "" > $INJECT
>   echo "name='test'" > $INJECT
>   echo "name='test' len=1024" > $INJECT

I think you meant "dev='test'" not "name='test'"

>   cat /sys/kernel/debug/tracing/trace
>   ...
>    <...>-614   [000] ....    36.571483: net_dev_queue: dev= skbaddr=00000000fbf338c2 len=0
>    <...>-614   [001] ....   136.588252: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=0
>    <...>-614   [001] .N..   208.431878: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=1024
> 
> Triggers could be triggered as usual too:
> 
>   echo "stacktrace if len == 1025" > /sys/kernel/debug/tracing/events/net/net_dev_queue/trigger
>   echo "len=1025" > $INJECT
>   cat /sys/kernel/debug/tracing/trace
>   ...
>       bash-614   [000] ....    36.571483: net_dev_queue: dev= skbaddr=00000000fbf338c2 len=0
>       bash-614   [001] ....   136.588252: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=0
>       bash-614   [001] .N..   208.431878: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=1024
>       bash-614   [001] .N.1   284.236349: <stack trace>
>  => event_inject_write
>  => vfs_write
>  => ksys_write
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe  
> 
> The only thing that can't be injected is string pointers as they
> require constant string pointers, this can't be done at run time.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  kernel/trace/Makefile              |   1 +
>  kernel/trace/trace.h               |   1 +
>  kernel/trace/trace_events.c        |   4 +
>  kernel/trace/trace_events_inject.c | 330 +++++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 kernel/trace/trace_events_inject.c
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..3c7bbacf4c18 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
>  endif
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
> +obj-$(CONFIG_EVENT_TRACING) += trace_events_inject.o
>  obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
>  obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
>  obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 1974ce818ddb..69b5ce0ad597 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1583,6 +1583,7 @@ extern struct list_head ftrace_events;
>  
>  extern const struct file_operations event_trigger_fops;
>  extern const struct file_operations event_hist_fops;
> +extern const struct file_operations event_inject_fops;
>  
>  #ifdef CONFIG_HIST_TRIGGERS
>  extern int register_trigger_hist_cmd(void);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 98df044d34ce..d23d6d6685e7 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2018,6 +2018,10 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  	trace_create_file("format", 0444, file->dir, call,
>  			  &ftrace_event_format_fops);
>  
> +	if (call->event.type && call->class->reg)
> +		trace_create_file("inject", 0200, file->dir, file,
> +				  &event_inject_fops);
> +
>  	return 0;
>  }
>  
> diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> new file mode 100644
> index 000000000000..cdd7db7f2724
> --- /dev/null
> +++ b/kernel/trace/trace_events_inject.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * trace_events_inject - trace event injection
> + *
> + * Copyright (C) 2019 Cong Wang <cwang@twitter.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/ctype.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/rculist.h>
> +
> +#include "trace.h"
> +
> +static int
> +trace_inject_entry(struct trace_event_file *file, void *rec, int len)
> +{
> +	struct trace_event_buffer fbuffer;
> +	struct ring_buffer *buffer;
> +	int written = 0;
> +	void *entry;
> +
> +	buffer = file->tr->trace_buffer.buffer;
> +	ring_buffer_nest_start(buffer);

I'm curious about why you added the ring_buffer_nest_start().

> +
> +	entry = trace_event_buffer_reserve(&fbuffer, file, len);
> +	if (entry) {
> +		memcpy(entry, rec, len);
> +		written = len;
> +		trace_event_buffer_commit(&fbuffer);
> +	}
> +
> +	ring_buffer_nest_end(buffer);
> +	return written;
> +}
> +
> +static int
> +parse_field(char *str, struct trace_event_call *call,
> +	    struct ftrace_event_field **pf, u64 *pv)
> +{
> +	struct ftrace_event_field *field;
> +	char *field_name;
> +	int s, i = 0;
> +	char *p;
> +	int len;
> +	u64 val;
> +
> +	if (!str[i])
> +		return 0;
> +	/* First find the field to associate to */
> +	while (isspace(str[i]))
> +		i++;
> +	s = i;
> +	while (isalnum(str[i]) || str[i] == '_')
> +		i++;
> +	len = i - s;
> +	if (!len)
> +		return -EINVAL;
> +
> +	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
> +	if (!field_name)
> +		return -ENOMEM;
> +	field = trace_find_event_field(call, field_name);
> +	kfree(field_name);
> +	if (!field)
> +		return -ENOENT;
> +
> +	*pf = field;
> +	p = strchr(str + i, '=');
> +	if (!p)
> +		return -EINVAL;
> +	i = p + 1 - str;
> +	while (isspace(str[i]))
> +		i++;
> +	s = i;
> +	if (isdigit(str[i]) || str[i] == '-') {
> +		char num_buf[24];	/* Big enough to hold an address */

Do you really need this buffer? See below.

> +		int ret;
> +
> +		/* Make sure the field is not a string */
> +		if (is_string_field(field))
> +			return -EINVAL;
> +
> +		if (str[i] == '-')
> +			i++;
> +
> +		/* We allow 0xDEADBEEF */
> +		while (isalnum(str[i]))
> +			i++;
> +
> +		len = i - s;
> +		/* 0xfeedfacedeadbeef is 18 chars max */
> +		if (len >= sizeof(num_buf))
> +			return -EINVAL;
> +
> +		strncpy(num_buf, str + s, len);
> +		num_buf[len] = 0;

Instead of using num_buf[], as str is already modified in the else
statement, we could do:

		char *num;
		char c;

		num = str + s;
		c = str[i];
		str[i] = '\0';
		[..]
			ret = kstrtoll(num, 0, &val);
		[..]
		str[i] = c;


> +
> +		/* Make sure it is a value */
> +		if (field->is_signed)
> +			ret = kstrtoll(num_buf, 0, &val);
> +		else
> +			ret = kstrtoull(num_buf, 0, &val);
> +		if (ret)
> +			return ret;
> +
> +		*pv = val;
> +		return i;
> +	} else if (str[i] == '\'' || str[i] == '"') {
> +		char q = str[i];
> +
> +		/* Make sure the field is OK for strings */
> +		if (!is_string_field(field))
> +			return -EINVAL;
> +
> +		for (i++; str[i]; i++) {

Should we allow for \' and \"?

			if (str[i] == '\\' && str[i + 1]) {
				i++;
				continue;
			}


> +			if (str[i] == q)
> +				break;
> +		}
> +		if (!str[i])
> +			return -EINVAL;
> +
> +		/* Skip quotes */
> +		s++;
> +		len = i - s;
> +		if (len >= MAX_FILTER_STR_VAL)
> +			return -EINVAL;
> +
> +		*pv = (unsigned long)(str + s);
> +		str[i] = 0;
> +		/* go past the last quote */
> +		i++;
> +		return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int trace_get_entry_size(struct trace_event_call *call)
> +{
> +	struct ftrace_event_field *field;
> +	struct list_head *head;
> +	int size = 0;
> +
> +	head = trace_get_fields(call);
> +	list_for_each_entry(field, head, link)

Add a '{' for the loop. We only allow for removing braces for non
complex statements.


> +		if (field->size + field->offset > size)
> +			size = field->size + field->offset;
> +
> +	return size;
> +}
> +
> +static void *trace_alloc_entry(struct trace_event_call *call, int *size)
> +{
> +	int entry_size = trace_get_entry_size(call);
> +	struct ftrace_event_field *field;
> +	struct list_head *head;
> +	void *entry = NULL;
> +
> +	/* We need an extra '\0' at the end. */
> +	entry = kzalloc(entry_size + 1, GFP_KERNEL);
> +	if (!entry)
> +		return NULL;
> +
> +	head = trace_get_fields(call);
> +	list_for_each_entry(field, head, link) {
> +		if (!is_string_field(field))
> +			continue;
> +		if (field->filter_type == FILTER_STATIC_STRING)
> +			continue;
> +		if (field->filter_type == FILTER_DYN_STRING) {
> +			u32 *str_item;
> +			int str_len = 0;
> +			int str_loc = entry_size & 0xffff;
> +
> +			str_item = (u32 *)(entry + field->offset);
> +			*str_item = (str_len << 16) | str_loc;
> +		} else {
> +			char **paddr;
> +
> +			paddr = (char **)(entry + field->offset);
> +			*paddr = "";
> +		}
> +	}
> +
> +	*size = entry_size + 1;
> +	return entry;
> +}
> +
> +#define INJECT_STRING "STATIC STRING CAN NOT BE INJECTED"
> +
> +static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
> +{
> +	struct ftrace_event_field *field;
> +	unsigned long irq_flags;
> +	void *entry = NULL;
> +	int entry_size;
> +	u64 val;
> +	int len;
> +
> +	entry = trace_alloc_entry(call, &entry_size);
> +	*pentry = entry;
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	local_save_flags(irq_flags);
> +	tracing_generic_entry_update(entry, call->event.type, irq_flags,
> +				     preempt_count());
> +
> +	while ((len = parse_field(str, call, &field, &val)) > 0) {
> +		if (is_function_field(field))
> +			return -EINVAL;
> +
> +		if (is_string_field(field)) {
> +			char *addr = (char *)(unsigned long) val;
> +
> +			if (field->filter_type == FILTER_STATIC_STRING) {
> +				strlcpy(entry + field->offset, addr, field->size);
> +			} else if (field->filter_type == FILTER_DYN_STRING) {
> +				u32 *str_item;
> +				int str_len = strlen(addr) + 1;
> +				int str_loc = entry_size & 0xffff;
> +
> +				entry_size += str_len;
> +				*pentry = krealloc(entry, entry_size, GFP_KERNEL);
> +				entry = *pentry;
> +				if (!entry)
> +					return -ENOMEM;

Add a comment here that states that *pentry gets freed by the caller
even on error, otherwise, to a reviewer this looks like a possible
memory leak. Or worse, we add a new caller that doesn't free it.
Perhaps we should add a comment above the function.

> +
> +				strlcpy(entry + (entry_size - str_len), addr, str_len);
> +				str_item = (u32 *)(entry + field->offset);
> +				*str_item = (str_len << 16) | str_loc;
> +			} else {
> +				char **paddr;
> +
> +				/* TODO: can we find the constant string? */

Honestly, char * is dangerous in tracing. Because the time you read the
pointer, what you pointed at during the recording could be long gone. I
really should have them removed in the code. In other words, don't
worry about pointer strings and such.

You can keep this as is.

> +				paddr = (char **)(entry + field->offset);
> +				*paddr = INJECT_STRING;
> +			}
> +		} else {
> +			switch (field->size) {
> +			case 1: {
> +				u8 tmp = (u8) val;
> +
> +				memcpy(entry + field->offset, &tmp, 1);
> +				break;
> +			}
> +			case 2: {
> +				u16 tmp = (u16) val;
> +
> +				memcpy(entry + field->offset, &tmp, 2);
> +				break;
> +			}
> +			case 4: {
> +				u32 tmp = (u32) val;
> +
> +				memcpy(entry + field->offset, &tmp, 4);
> +				break;
> +			}
> +			case 8:
> +				memcpy(entry + field->offset, &val, 8);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +
> +		str += len;
> +	}
> +
> +	if (len < 0)
> +		return len;
> +
> +	return entry_size;
> +}
> +
> +static ssize_t
> +event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
> +		   loff_t *ppos)
> +{
> +	struct trace_event_call *call;
> +	struct trace_event_file *file;
> +	int err = -ENODEV, size;
> +	void *entry = NULL;
> +	char *buf;
> +
> +	if (cnt >= PAGE_SIZE)
> +		return -EINVAL;
> +
> +	buf = memdup_user_nul(ubuf, cnt);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +	strim(buf);
> +
> +	mutex_lock(&event_mutex);
> +	file = event_file_data(filp);
> +	if (file) {
> +		call = file->event_call;
> +		size = parse_entry(buf, call, &entry);
> +		if (size < 0)
> +			err = size;
> +		else
> +			err = trace_inject_entry(file, entry, size);
> +	}
> +	mutex_unlock(&event_mutex);
> +
> +	kfree(entry);
> +	kfree(buf);
> +
> +	if (err < 0)
> +		return err;
> +
> +	*ppos += err;
> +	return cnt;
> +}
> +
> +static ssize_t
> +event_inject_read(struct file *file, char __user *buf, size_t size,
> +		  loff_t *ppos)
> +{
> +	return -EPERM;
> +}
> +
> +const struct file_operations event_inject_fops = {
> +	.open = tracing_open_generic,
> +	.read = event_inject_read,
> +	.write = event_inject_write,
> +};
> +

The rest looks fine. Note, I'm sorry for the late response, but as the
merge window opened, I'll probably wait till after the merge window
closes before adding this.

That said, I'll apply the first three patches and get them in this
merge window, as they are mostly clean ups.

Thanks!

-- Steve
