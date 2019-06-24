Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A0120663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kRGp38NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfFXSwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:52:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33854 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfFXSwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:52:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so15683396qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FdoCyudKahKj0SWzDQQDRaNFjjN47T56TpYdFnqFN6Q=;
        b=kRGp38NKS88PVk+PViUY9+FG3kBjzBKqSGfcz5+5Y/W1/Jr3BFxvcCOuP4Qw0e2AFh
         wyrqr51vZkMW0DZdoGKB/tmVWR/CceaUKmxuF/RVBO05jo34VAEDxe6UOfmG7RbiBNcK
         JgcXh21EPzd8g8mq2UI/qbk9CH2EdMoBLaxgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FdoCyudKahKj0SWzDQQDRaNFjjN47T56TpYdFnqFN6Q=;
        b=hlRvivR+Oi3vihn9ofk8/f+62UpbX5+xFhnLtp+WR28Qmtlo11xgXv7DeKuiIzQBuN
         egehYPQYA8LrKWi3h5dA5W+b4QP3wcHqIbkycEnTfLPPOCJVDVVxi/jFWm8TbZegYwbS
         P2qBPmHkPRR5d8oQ7z8njr0hAL6vztGBHBoQToVdAzn/GruFD5DHaLgw5F+CO10TMxTn
         qxG9TE91FPCnH+H+KQ9Kh34q6XEHAHIiExwpfRuAg19a4M/iktRyDZ1zP0/tafQvsc0w
         80RwCn/qLlp5A5f/hRE1FgqpmgRFE9lRzoerPdkqoHkRpFXropgg8Falrw79csY3Lckv
         VF5w==
X-Gm-Message-State: APjAAAW8qRT+WB5m4tiMxvxnOWdmBcjUhJuVTPrvItRT9kMCk2ZKVYJo
        S/6IbIHzmm2swVJNpRHWaUwf01Zk6k43ag==
X-Google-Smtp-Source: APXvYqzlPMsfW8n2Fv5r2ooDKckw1uxgUmNEhj3pMv44Vv4CLYlBzRSS8TeY1keIvJ9fHxuKW3rh7Q==
X-Received: by 2002:a0c:8705:: with SMTP id 5mr3904110qvh.32.1561402335797;
        Mon, 24 Jun 2019 11:52:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7176651qtb.43.2019.06.24.11.52.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:52:15 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:52:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     jannh@google.com, oleg@redhat.com, mathieu.desnoyers@efficios.com,
        willy@infradead.org, peterz@infradead.org, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, elena.reshetova@intel.com,
        keescook@chromium.org, kernel-team@android.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH RFC v2] Convert struct pid count to refcount_t
Message-ID: <20190624185214.GA211230@google.com>
References: <20190624184534.209896-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624184534.209896-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:45:34PM -0400, Joel Fernandes (Google) wrote:
> struct pid's count is an atomic_t field used as a refcount. Use
> refcount_t for it which is basically atomic_t but does additional
> checking to prevent use-after-free bugs.
> 
> For memory ordering, the only change is with the following:
>  -	if ((atomic_read(&pid->count) == 1) ||
>  -	     atomic_dec_and_test(&pid->count)) {
>  +	if (refcount_dec_and_test(&pid->count)) {
>  		kmem_cache_free(ns->pid_cachep, pid);
> 
> Here the change is from:
> Fully ordered --> RELEASE + ACQUIRE (as per refcount-vs-atomic.rst)
> This ACQUIRE should take care of making sure the free happens after the
> refcount_dec_and_test().
> 
> The above hunk also removes atomic_read() since it is not needed for the
> code to work and it is unclear how beneficial it is. The removal lets
> refcount_dec_and_test() check for cases where get_pid() happened before
> the object was freed.
> 
> Cc: jannh@google.com
> Cc: oleg@redhat.com
> Cc: mathieu.desnoyers@efficios.com
> Cc: willy@infradead.org
> Cc: peterz@infradead.org
> Cc: will.deacon@arm.com
> Cc: paulmck@linux.vnet.ibm.com
> Cc: elena.reshetova@intel.com
> Cc: keescook@chromium.org
> Cc: kernel-team@android.com
> Cc: kernel-hardening@lists.openwall.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> Changed to RFC to get any feedback on the memory ordering.

I had a question about refcount_inc().

As per Documentation/core-api/refcount-vs-atomic.rst , it says:

A control dependency (on success) for refcounters guarantees that
if a reference for an object was successfully obtained (reference
counter increment or addition happened, function returned true),
then further stores are ordered against this operation.

However, in refcount_inc() I don't see any memory barriers (in the case where
CONFIG_REFCOUNT_FULL=n). Is the documentation wrong?

get_pid() does a refcount_inc() but doesn't have any memory barriers either.

thanks,

 - Joel


> 
>  include/linux/pid.h | 5 +++--
>  kernel/pid.c        | 7 +++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 14a9a39da9c7..8cb86d377ff5 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PID_H
>  
>  #include <linux/rculist.h>
> +#include <linux/refcount.h>
>  
>  enum pid_type
>  {
> @@ -56,7 +57,7 @@ struct upid {
>  
>  struct pid
>  {
> -	atomic_t count;
> +	refcount_t count;
>  	unsigned int level;
>  	/* lists of tasks that use this pid */
>  	struct hlist_head tasks[PIDTYPE_MAX];
> @@ -69,7 +70,7 @@ extern struct pid init_struct_pid;
>  static inline struct pid *get_pid(struct pid *pid)
>  {
>  	if (pid)
> -		atomic_inc(&pid->count);
> +		refcount_inc(&pid->count);
>  	return pid;
>  }
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..89c4849fab5d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -37,7 +37,7 @@
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
> -#include <linux/proc_fs.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  
> @@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
>  		return;
>  
>  	ns = pid->numbers[pid->level].ns;
> -	if ((atomic_read(&pid->count) == 1) ||
> -	     atomic_dec_and_test(&pid->count)) {
> +	if (refcount_dec_and_test(&pid->count)) {
>  		kmem_cache_free(ns->pid_cachep, pid);
>  		put_pid_ns(ns);
>  	}
> @@ -210,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	}
>  
>  	get_pid_ns(ns);
> -	atomic_set(&pid->count, 1);
> +	refcount_set(&pid->count, 1);
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
