Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC963C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA1222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xaz3DKIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfIZST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:19:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIZST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:19:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so2286027pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwyCUh4vE6obyl0Uml7Jcy5ZjJpXpKyocOmzzlkfujU=;
        b=xaz3DKIfmn8kKC45CH5m8BLQu4lagfl8chgRa2wId1yl5gwgQmjcjtj/VP1XZORFAI
         N2WDdQytOK51TUXDbMsXKNVGzLU6cDQYcgntnC1SbW1zL/1CefDr9rsAzLAwrlEkNkQW
         Hvyp7ctzgnasHa0heqoJxDdiYDgFPy/kXEUSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwyCUh4vE6obyl0Uml7Jcy5ZjJpXpKyocOmzzlkfujU=;
        b=s/PysC85VctVWcNlmYwBzXd3m5e6vpHbALL5FqJAUuJULFVv3kl56QmF8kcRBg2yCV
         9XP76bwuMd9OF2okrfoJSRrfFdC26DxaE+pfsO1Q9i5UqBoNgpVKOmAcW8EKNoHS01xA
         O4FlcgkwRD74iQFTLCGhh22aqJN0ybqc/Z7WEFzpml2uT2E0zOaqX7zBDggc9yvV+BAE
         vSdvk+6YD7aGkWGSA1xri1dL9LutkDJwJ23goGbWsDaxo/S1YNuaO5N5JSS7yvg8NDjw
         VxaVYrShFkPxPbZTB4S/zsvfrK1kq5w+NjP5FBaNs9hkR6Fts0udg7ut8UlS5mlhmhr1
         LYYA==
X-Gm-Message-State: APjAAAUGpDhGtUOcWZclnQ+wJg+W6pacRoMsqXkMJd6elF1fBThNkR9z
        5XVZRsEkUtge3xz4kOZrxV0d8Q==
X-Google-Smtp-Source: APXvYqzRZr2ftWsladCpeSSAfMzjP5x+7Qb5H+Dw5lQVE9yM9qBHDaCp6+GWtGwb0/C3k5dOXfr18A==
X-Received: by 2002:a62:112:: with SMTP id 18mr5292931pfb.156.1569521996300;
        Thu, 26 Sep 2019 11:19:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j128sm5486886pfg.51.2019.09.26.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:19:55 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:19:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:dev.2019.09.23a 62/77] kernel/rcu/tree.c:2882
 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
Message-ID: <20190926181954.GC99154@google.com>
References: <20190924080510.GL20699@kadam>
 <CAEXW_YQYDom3AwWR1AUSCw5VvFzc6KrBH0KbuTvhkJ3OoxBfCg@mail.gmail.com>
 <20190924160348.GF2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924160348.GF2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:03:48AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 24, 2019 at 08:15:12AM -0400, Joel Fernandes wrote:
> > On Tue, Sep 24, 2019 at 4:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> > > head:   97de53b94582c208ee239178b208b8e8b9472585
> > > commit: 39676bb72323718a9e7bab1ba9c4a68319a96f62 [62/77] rcu: Add support for debug_objects debugging for kfree_rcu()
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > smatch warnings:
> > > kernel/rcu/tree.c:2882 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
> > >   Locked on:   line 2867
> > >   Unlocked on: line 2882
> > >
> > > git remote add rcu https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > git remote update rcu
> > > git checkout 39676bb72323718a9e7bab1ba9c4a68319a96f62
> > > vim +2882 kernel/rcu/tree.c
> > >
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2850) void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2851) {
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2852)        unsigned long flags;
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2853)        struct kfree_rcu_cpu *krcp;
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2854)
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2855)        head->func = func;
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2856)
> > > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2857         local_irq_save(flags);  // For safely calling this_cpu_ptr().
> > >                                                                 ^^^^^^^^^^^^^^^^^^^^^
> > > IRQs disabled.
> > >
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2858)        krcp = this_cpu_ptr(&krc);
> > > ff8db005e371cb Paul E. McKenney        2019-09-19  2859         if (krcp->initialized)
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2860)                spin_lock(&krcp->lock);
> > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2861)
> > > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2862         // Queue the object but don't yet schedule the batch.
> > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2863)        if (debug_rcu_head_queue(head)) {
> > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2864)                // Probable double kfree_rcu(), just leak.
> > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2865)                WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2866)                          __func__, head);
> > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2867)                return;
> > >
> > > Need to re-enable before returning.
> > 
> > Right. At this point the system has a bug anyway since it is a
> > double-free. But yes, no reason to introduce more bugs. Will fix.
> > Thank you, Dan!
> 
> What Joel said!
> 
> As long as I am doing several other reports anyway...
> 
> How does the to-be-squashed patch below look?

Hi Paul,

Sorry for the late reply due to the conference..

This patch looks Ok, the code in your tree though is slightly different mine
I think because you reworked the kfree_rcu() code for working during early
boot.

After my talk tomorrow, I will go through your rcu/dev tree in detail to
review the reworks you did in detail.

Let me know if you have the kfree_rcu() changes in a separate topic branch,
as well. So it will make reviewing easier.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 39af4c08038a8a6a7b1c9804fdd2c1921d583222
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Sep 24 09:02:00 2019 -0700
> 
>     squash! rcu: Add support for debug_objects debugging for kfree_rcu()
>     
>     [ paulmck: Fix IRQ per kbuild test robot <lkp@intel.com> feedback. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 921daa7..edb7539 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2870,7 +2870,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		// Probable double kfree_rcu(), just leak.
>  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>  			  __func__, head);
> -		return;
> +		goto unlock_return;
>  	}
>  	head->func = func;
>  	head->next = krcp->head;
> @@ -2883,6 +2883,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>  	}
>  
> +unlock_return:
>  	if (krcp->initialized)
>  		spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
