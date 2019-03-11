Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19288C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71C42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx0tOjH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCKMzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:55:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44406 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:55:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id g1so3783524otj.11;
        Mon, 11 Mar 2019 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjRDh4ky7Pn/jY4wlA16VBNGdh5xpSfShrnXXpefjYA=;
        b=Gx0tOjH7fUxrWVo0gvNz2AU7P+fq0VN0weB8+iR5VUg1AmXv37+dIgAJ4/HIJaWIG1
         OKb8vTbgCdZvMC2Vb+vxfXnGbJMGXGGelQnJz2VG7DHmT2her5P2C/ORzTQgEaki+F/B
         it3qDyyYyoJ1eDqaxbCfDCrST0xlTkXX/T2emN+C48NYCRImoklGmROAoeK66gptSAI0
         NezvuqvWzCORVhydHKmNCljTu0kAQM0RWmr76hfiFlX60fGYs21cvj3c3IjMffcm7qLi
         ZWOdsXT0Sqit5Z+kxgFrpUdRZPHRwIe1o7sIEw8u6WOpEmiQ+DF/kfDsJ3VjkYpeNnBa
         wNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=XjRDh4ky7Pn/jY4wlA16VBNGdh5xpSfShrnXXpefjYA=;
        b=d3XdimZJ4PjfiF8y3GMLjOQJR2B+bZogYj4CUHuJFuR0Xu3w5OtxZ1OPURZkx4XJya
         Ok4G/f70H5RKhalGhX8xb58NNHOukh59e8PGg4prRclkA1kRsdG4TfQMQ6pDIHjID64x
         Nh4bw4Z+/72MFzOej0PqWXEw+0ldbEYbdPvPSA/RLCGOK6rrkFdQeKPqTuzYRnkdnq4E
         +RovtYNBDLSX/eavVVoktXX1og8C8Ggwusq1iS472lp0mYemm6S9hCAqXpKFUt19XImT
         STGE6xopHLs8G4uZLLsDYfSAVDKy13yyFQAiRGMjEUKOTjg0usoEfT6XzOxQUBAIapTV
         FfMA==
X-Gm-Message-State: APjAAAUIOSmzRxBAUH1IcmGyAw8bKSOGE87DtzW29fyt8SEVdORdGFl7
        bhvMD+ZdhCfdZ8+2wIiqmv6OE3A=
X-Google-Smtp-Source: APXvYqxpsAhaOOFG2v8heO45MrcYkrZma9uQeKG5NjozkFf3rN6IQj7FcjP9Y4jvb+a6fQM02S7PpQ==
X-Received: by 2002:a9d:66f:: with SMTP id 102mr20644425otn.340.1552308902394;
        Mon, 11 Mar 2019 05:55:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id l63sm2277352oia.47.2019.03.11.05.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 05:55:01 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:dd3c:1d89:d3d4:f9e3])
        by serve.minyard.net (Postfix) with ESMTPSA id 45FC7180001;
        Mon, 11 Mar 2019 12:55:01 +0000 (UTC)
Date:   Mon, 11 Mar 2019 07:54:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ipmi: fix sleep-in-atomic in free_user at cleanup SRCU
 user->release_barrier
Message-ID: <20190311125459.GA3498@minyard.net>
Reply-To: minyard@acm.org
References: <155229854905.2133.15708039732382992559.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155229854905.2133.15708039732382992559.stgit@buzz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:02:29PM +0300, Konstantin Khlebnikov wrote:
> free_user() could be called in atomic context.
> 
> This patch uses non-sleeping cleanup_srcu_struct_quiesced(). At this stage
> atomic refcount is zero, thus all read-sections should have been ended.

Thanks, I have this in my tree.

-corey

> 
> Example:
> 
>  BUG: sleeping function called from invalid context at kernel/workqueue.c:2856
>  in_atomic(): 1, irqs_disabled(): 0, pid: 177, name: ksoftirqd/27
>  CPU: 27 PID: 177 Comm: ksoftirqd/27 Not tainted 4.19.25-3 #1
>  Hardware name: AIC 1S-HV26-08/MB-DPSB04-06, BIOS IVYBV060 10/21/2015
>  Call Trace:
>   dump_stack+0x5c/0x7b
>   ___might_sleep+0xec/0x110
>   __flush_work+0x48/0x1f0
>   ? try_to_del_timer_sync+0x4d/0x80
>   _cleanup_srcu_struct+0x104/0x140
>   free_user+0x18/0x30 [ipmi_msghandler]
>   ipmi_free_recv_msg+0x3a/0x50 [ipmi_msghandler]
>   deliver_response+0xbd/0xd0 [ipmi_msghandler]
>   deliver_local_response+0xe/0x30 [ipmi_msghandler]
>   handle_one_recv_msg+0x163/0xc80 [ipmi_msghandler]
>   ? dequeue_entity+0xa0/0x960
>   handle_new_recv_msgs+0x15c/0x1f0 [ipmi_msghandler]
>   tasklet_action_common.isra.22+0x103/0x120
>   __do_softirq+0xf8/0x2d7
>   run_ksoftirqd+0x26/0x50
>   smpboot_thread_fn+0x11d/0x1e0
>   kthread+0x103/0x140
>   ? sort_range+0x20/0x20
>   ? kthread_destroy_worker+0x40/0x40
>   ret_from_fork+0x1f/0x40
> 
> Fixes: 77f8269606bf ("ipmi: fix use-after-free of user->release_barrier.rda")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: stable@vger.kernel.org # 4.18
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index e8ba67834746..c35f2bcbaa23 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1260,7 +1260,12 @@ EXPORT_SYMBOL(ipmi_get_smi_info);
>  static void free_user(struct kref *ref)
>  {
>  	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
> -	cleanup_srcu_struct(&user->release_barrier);
> +
> +	/*
> +	 * Cleanup without waiting. This could be called in atomic context.
> +	 * Refcount is zero: all read-sections should have been ended.
> +	 */
> +	cleanup_srcu_struct_quiesced(&user->release_barrier);
>  	kfree(user);
>  }
>  
> 
