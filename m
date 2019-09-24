Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E66C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83542146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yahCuT4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfIXMP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:15:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35060 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfIXMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:15:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so1823215qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=047KnQ6LdhsRxOhyWfYTMxQxy1h5WOedU8au5fznWn8=;
        b=yahCuT4MwNpleohZaQiHmCHhaUSWw5H4Pr5iiHh5pf13MCXAo/t00Gs9sjgw8G8Ah8
         oTUWPliQ1GIyrLzFj7zswmCgWB4PQ9lkFE5wNZNW797RInyr0oiCgArJTuQcTK1/UXsN
         shiys6Jm7JyT+EugqvB62cMPK5VJZBR5OJFJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=047KnQ6LdhsRxOhyWfYTMxQxy1h5WOedU8au5fznWn8=;
        b=GXLtVMdwkVrJ2R1TvHsYWhyLAUaSKXiIVPrPuB/pChgXoNpplRjF003a88VOYhhzOG
         lB0kDuwHgxMlJ3oBlA22tzebd1qtgkXUSVRdNAwEvSku5N8JSiS/Q02F4L2P8ZS0P5uI
         9HsJ1E51Kc5wXfgoSXAMsHvCxkVB7VVqZ5TpQnKzEmdhOA9HdZBwEUUvlAfVc2eS8SNF
         51Y7v7TotendWmyuFpSgv3u4POVKhw4sao5qzeHzo/8XwXX35jtoq1XZR1Vv5iW1ERx0
         2aTaBzUMhXSlo30WVrfSHTXORew3g0Te12lBTQ0CqFoabWTcb8SZ19PX2GBJdJXRywJ0
         x4Rw==
X-Gm-Message-State: APjAAAXQTQzuPtHoQ/GlUtqoYV8mGBbZWUHvQwDh8wd631d0ytqnqA+7
        OiEV0N/jsJkV2sE6/vRSjSDuka2isCTQy+Mj3QEBwQ==
X-Google-Smtp-Source: APXvYqyETTJ1oHwctWmFtDLNPyuQPTcOlouZPV07tYUkJn46RuzMegsjroBHplGfTeM1+v5oP9ywIUEPuWteuJ6BgGU=
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr2393360qta.269.1569327326371;
 Tue, 24 Sep 2019 05:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190924080510.GL20699@kadam>
In-Reply-To: <20190924080510.GL20699@kadam>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 24 Sep 2019 08:15:12 -0400
Message-ID: <CAEXW_YQYDom3AwWR1AUSCw5VvFzc6KrBH0KbuTvhkJ3OoxBfCg@mail.gmail.com>
Subject: Re: [rcu:dev.2019.09.23a 62/77] kernel/rcu/tree.c:2882
 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 4:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> head:   97de53b94582c208ee239178b208b8e8b9472585
> commit: 39676bb72323718a9e7bab1ba9c4a68319a96f62 [62/77] rcu: Add support for debug_objects debugging for kfree_rcu()
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/rcu/tree.c:2882 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
>   Locked on:   line 2867
>   Unlocked on: line 2882
>
> git remote add rcu https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git remote update rcu
> git checkout 39676bb72323718a9e7bab1ba9c4a68319a96f62
> vim +2882 kernel/rcu/tree.c
>
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2850) void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2851) {
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2852)        unsigned long flags;
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2853)        struct kfree_rcu_cpu *krcp;
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2854)
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2855)        head->func = func;
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2856)
> 87970ccf5a9125 Paul E. McKenney        2019-09-19  2857         local_irq_save(flags);  // For safely calling this_cpu_ptr().
>                                                                 ^^^^^^^^^^^^^^^^^^^^^
> IRQs disabled.
>
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2858)        krcp = this_cpu_ptr(&krc);
> ff8db005e371cb Paul E. McKenney        2019-09-19  2859         if (krcp->initialized)
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2860)                spin_lock(&krcp->lock);
> 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2861)
> 87970ccf5a9125 Paul E. McKenney        2019-09-19  2862         // Queue the object but don't yet schedule the batch.
> 39676bb7232371 Joel Fernandes (Google  2019-09-22  2863)        if (debug_rcu_head_queue(head)) {
> 39676bb7232371 Joel Fernandes (Google  2019-09-22  2864)                // Probable double kfree_rcu(), just leak.
> 39676bb7232371 Joel Fernandes (Google  2019-09-22  2865)                WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> 39676bb7232371 Joel Fernandes (Google  2019-09-22  2866)                          __func__, head);
> 39676bb7232371 Joel Fernandes (Google  2019-09-22  2867)                return;
>
> Need to re-enable before returning.

Right. At this point the system has a bug anyway since it is a
double-free. But yes, no reason to introduce more bugs. Will fix.
Thank you, Dan!
