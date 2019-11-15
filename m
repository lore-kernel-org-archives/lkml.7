Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03947C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4BF20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk1bCJy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKOVva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:51:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42974 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKOVva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:51:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so5554524plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4L2/iaYCHtQuZ1FhR25DdmhnGguSECxaN67Qc8cZeKo=;
        b=Qk1bCJy1WvrzFblTFkc+1+/w0kBkwccSLO9sIssItCp9fSfmA4CqBOaxdvHW5M0cJ2
         3CeYLyJmQPjgp5uXir+uyZS/70ANvaakNHBmckfkGaj0Z2mSPK6vnn7ymfWNlddm1QKM
         tFE+KtnaPbDpspT56Do3I89+dp60r14cL3Svo1typn1bSALkyBpgJ9dYUSfncWa/9kJW
         wXcvecKLIuLOl05+/cGvRy/UPeBbDRs6ev+8rrb96XmdAUNgZWt2EZjq3glPfqEJ2CK4
         yPQ/1iuY6hIEXFU24V/4lUIMnBDIt2abkyTjMPDH/8doCWInp7McD7VPuy6yp7ZgXNsq
         m68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4L2/iaYCHtQuZ1FhR25DdmhnGguSECxaN67Qc8cZeKo=;
        b=Hk3+U3s/gyxaslc/9NKf2nms0iyVqo+D860BkjWa1URnZ6KY81m047ElsqodvbGa/K
         ZiV+Bku5a3aaIC7r5teQ9EByStkb61E/ruoQclGTWnFCYPfC4LddJdLUC1BQ5cC7VHoh
         YsGqvyU2uArkGpBKwb36zw30qJVB0/F7FH7y4YhMjDJwUlIPB4i4A1JxghmQtSgab/+t
         Dzntqu+q4M7e3NtWMeXwwxeqawgbn8kIggM0Yc3Vm/9RZH4iVI7WMy3AveP/I1Z56Buw
         vzAgJdhv/2/LIYpDgtJbkCBaa72pmfSyIKTJWZcAnyPI16hJbByic+jqFpvLDcLvK43j
         s5Iw==
X-Gm-Message-State: APjAAAXKlyFxTgQfMlh7MdkBrGi77lp8mhUco34MkPQGpuJis7Z6fxjU
        MA0zrxff1A+nL4kKCJa+xQtkHqBv
X-Google-Smtp-Source: APXvYqxtfgTnumK0jEr0kda/qgqSxQm6Pcx8wr7zDduK8fb1e9qEK5EiHc+U5k5PmG/OhR+8vSSwAg==
X-Received: by 2002:a17:90a:4fe6:: with SMTP id q93mr22395857pjh.88.1573854689313;
        Fri, 15 Nov 2019 13:51:29 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::8ac1])
        by smtp.gmail.com with ESMTPSA id q70sm14756115pjq.26.2019.11.15.13.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:51:28 -0800 (PST)
Date:   Fri, 15 Nov 2019 13:51:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 1/2] ftrace: Add modify_ftrace_direct()
Message-ID: <20191115215125.mbqv7taqnx376yed@ast-mbp.dhcp.thefacebook.com>
References: <20191114194636.811109457@goodmis.org>
 <20191114194738.938540273@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114194738.938540273@goodmis.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 02:46:37PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a new function modify_ftrace_direct() that will allow a user to update
> an existing direct caller to a new trampoline, without missing hits due to
> unregistering one and then adding another.
> 
> Link: https://lore.kernel.org/r/20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h |  6 ++++
>  kernel/trace/ftrace.c  | 78 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 55647e185141..73eb2e93593f 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -250,6 +250,7 @@ static inline void ftrace_free_mem(struct module *mod, void *start, void *end) {
>  extern int ftrace_direct_func_count;
>  int register_ftrace_direct(unsigned long ip, unsigned long addr);
>  int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
> +int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
>  struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
>  #else
>  # define ftrace_direct_func_count 0
> @@ -261,6 +262,11 @@ static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
>  {
>  	return -ENODEV;
>  }
> +static inline int modify_ftrace_direct(unsigned long ip,
> +				       unsigned long old_addr, unsigned long new_addr)
> +{
> +	return -ENODEV;
> +}
>  static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
>  {
>  	return NULL;
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 82ef8d60a42b..834f3556ea1e 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5160,6 +5160,84 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
> +
> +static struct ftrace_ops stub_ops = {
> +	.func		= ftrace_stub,
> +};
> +
> +/**
> + * modify_ftrace_direct - Modify an existing direct call to call something else
> + * @ip: The instruction pointer to modify
> + * @old_addr: The address that the current @ip calls directly
> + * @new_addr: The address that the @ip should call
> + *
> + * This modifies a ftrace direct caller at an instruction pointer without
> + * having to disable it first. The direct call will switch over to the
> + * @new_addr without missing anything.
> + *
> + * Returns: zero on success. Non zero on error, which includes:
> + *  -ENODEV : the @ip given has no direct caller attached
> + *  -EINVAL : the @old_addr does not match the current direct caller
> + */
> +int modify_ftrace_direct(unsigned long ip,
> +			 unsigned long old_addr, unsigned long new_addr)
> +{
> +	struct ftrace_func_entry *entry;
> +	struct dyn_ftrace *rec;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&direct_mutex);
> +	entry = __ftrace_lookup_ip(direct_functions, ip);
> +	if (!entry) {
> +		/* OK if it is off by a little */
> +		rec = lookup_rec(ip, ip);
> +		if (!rec || rec->ip == ip)
> +			goto out_unlock;
> +
> +		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
> +		if (!entry)
> +			goto out_unlock;
> +
> +		ip = rec->ip;
> +		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
> +	}
> +
> +	ret = -EINVAL;
> +	if (entry->direct != old_addr)
> +		goto out_unlock;
> +
> +	/*
> +	 * By setting a stub function at the same address, we force
> +	 * the code to call the iterator and the direct_ops helper.
> +	 * This means that @ip does not call the direct call, and
> +	 * we can simply modify it.
> +	 */
> +	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = register_ftrace_function(&stub_ops);
> +	if (ret) {
> +		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
> +		goto out_unlock;
> +	}
> +
> +	entry->direct = new_addr;
> +
> +	/*
> +	 * By removing the stub, we put back the direct call, calling
> +	 * the @new_addr.
> +	 */
> +	unregister_ftrace_function(&stub_ops);
> +	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);

Thanks a lot for implementing it.
Switching to iterator just to modify the call.. hmm.
So "call direct_bpf_A" gets replaced to "call ftrace_stub" to do the iterator
only to patch "call direct_bpf_B" later. I'm struggling to see why do that when
arch can provide call to call rewrite easily. x86 and others have such ability
already. I don't understand why you want to sacrifice simplicity here.
Anyway with all 3 apis (register, modify, unreg) it looks complete.
I'll start playing with it on Monday.

