Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3345C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F1E2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nwXjlFGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfH2Nnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:43:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34092 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2Nnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:43:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so2105106pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8O7lhnhs/GhozIcB1ugTpsDb2mr6pWMLBUeErvb3feM=;
        b=nwXjlFGVUx1cFzlJ7gEBCuIaiKMJcA+hUBAomv/Z4pCZo4mPx8YhpLRN3g26xfxJ+7
         9QRRfuJ7BfK9GgZinrN9mQAIurv2wZAQfQigVFvx9dR3umMCZnH9VgYVGTTrPoS+CKMs
         aCTbJPRHsqOTXUNEwQh8uxQvWFhl3L94cGvok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8O7lhnhs/GhozIcB1ugTpsDb2mr6pWMLBUeErvb3feM=;
        b=YkLpWvT4gb+3vE37CDIkOb/rfeLNzd+EzNdJKKRmInWObUGqvawB6Z2EynHONx+A+7
         992EQ9cdCJd0eWetzCS8JWd1GjzhJOMTRZd+PJTHRg39iJxQWM35osRbDFxj7eq6gceG
         ohZva9gwOsS9xl/8hKbDNllgKFmxyegxMzssfsOUfrTRIgRPdvswXz8REa0pw1GCaogU
         fp/YJ9UxsaCSeBtMRqwLu9Yg+/yH9CWJfN7kvPQ+hQiTQnvZEHQjDOsRnKgwsY+MMhyS
         +ka/kCD3Yd5Y88b0kzu8u0Dk0apeRZkOL0Toigooxf6Hv4sn5kNfFzuneEHhsuxhbwDs
         GE2w==
X-Gm-Message-State: APjAAAWZJrs0IsJZLOP8fA2fqr0X1DwA3vEBfVRMxQmSLHW47RfXgaSl
        M+OXdI8x3/wSHw9ZUqKfIgPGeA==
X-Google-Smtp-Source: APXvYqzli0vhPeOpMg9J8oc5AVk7YRayffyKQ+wOsQHfxscS3A5S77unQugCEhiw9DVCPAWbqOUhXw==
X-Received: by 2002:a62:64d4:: with SMTP id y203mr11362397pfb.91.1567086211473;
        Thu, 29 Aug 2019 06:43:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 136sm2961503pfz.123.2019.08.29.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:43:30 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:43:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peikan Tsai <peikantsai@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829134329.GA63638@google.com>
References: <20190829054953.GA18328@mark-All-Series>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829054953.GA18328@mark-All-Series>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> Hi,
> 
> The allocated size for each binder_thread is 512 bytes by kzalloc.
> Because the size of binder_thread is fixed and it's only 304 bytes.
> It will save 208 bytes per binder_thread when use create a kmem_cache
> for the binder_thread.

Awesome change and observation!!!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

(Another thought: how did you discover this? Are you using some tools to look
into slab fragmentation?).

thanks,

 - Joel

> Signed-off-by: Peikan Tsai <peikantsai@gmail.com>
> ---
>  drivers/android/binder.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index dc1c83eafc22..043e0ebd0fe7 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -87,6 +87,8 @@ static struct dentry *binder_debugfs_dir_entry_root;
>  static struct dentry *binder_debugfs_dir_entry_proc;
>  static atomic_t binder_last_id;
> 
> +static struct kmem_cache *binder_thread_cachep;
> +
>  static int proc_show(struct seq_file *m, void *unused);
>  DEFINE_SHOW_ATTRIBUTE(proc);
> 
> @@ -4696,14 +4698,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
>  	thread = binder_get_thread_ilocked(proc, NULL);
>  	binder_inner_proc_unlock(proc);
>  	if (!thread) {
> -		new_thread = kzalloc(sizeof(*thread), GFP_KERNEL);
> +		new_thread = kmem_cache_zalloc(binder_thread_cachep,
> +					       GFP_KERNEL);
>  		if (new_thread == NULL)
>  			return NULL;
>  		binder_inner_proc_lock(proc);
>  		thread = binder_get_thread_ilocked(proc, new_thread);
>  		binder_inner_proc_unlock(proc);
>  		if (thread != new_thread)
> -			kfree(new_thread);
> +			kmem_cache_free(binder_thread_cachep, new_thread);
>  	}
>  	return thread;
>  }
> @@ -4723,7 +4726,7 @@ static void binder_free_thread(struct binder_thread *thread)
>  	BUG_ON(!list_empty(&thread->todo));
>  	binder_stats_deleted(BINDER_STAT_THREAD);
>  	binder_proc_dec_tmpref(thread->proc);
> -	kfree(thread);
> +	kmem_cache_free(binder_thread_cachep, thread);
>  }
> 
>  static int binder_thread_release(struct binder_proc *proc,
> @@ -6095,6 +6098,12 @@ static int __init binder_init(void)
>  	if (ret)
>  		return ret;
> 
> +	binder_thread_cachep = kmem_cache_create("binder_thread",
> +						 sizeof(struct binder_thread),
> +						 0, 0, NULL);
> +	if (!binder_thread_cachep)
> +		return -ENOMEM;
> +
>  	atomic_set(&binder_transaction_log.cur, ~0U);
>  	atomic_set(&binder_transaction_log_failed.cur, ~0U);
> 
> @@ -6167,6 +6176,7 @@ static int __init binder_init(void)
> 
>  err_alloc_device_names_failed:
>  	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
> +	kmem_cache_destroy(binder_thread_cachep);
> 
>  	return ret;
>  }
> --
> 2.17.1
> 
