Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451ABC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUW/RU8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfLQO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:56:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42817 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:56:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so7679026pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6meippeJPq3V/6dFbe3SNBZG6CocNU6mEMezHWgZAnI=;
        b=TUW/RU8QNy/fmc3Um1W4OXw9FEsshRo5S7hPpVF2jBHXiU7gAiSpW8OwcqgFWW21Sv
         3LrqFgpNeQljP9sVmJC8bprFtyjC8VYakcsKjsZNooDMViS6aXlMSZLcJMdjaGyTLOvD
         y0eOiRT/lEvJvIVGvi7NR0POyQK5YKRuS+pi6iyTLTYe6rq+vqsTzmqDmcIuivr5HE1S
         dr9hZ+BnTzUDN7wNJ5oG0lfd5RThr5Og906BOjdBOI7JD9nre+eh6MNjV1WmyXMETnO0
         hDltlSX54Ahs7slNK9bcy3zdF9eXz2oYLZa5ZHadANUmJj2W3/uvgZnJ6rqjB+OwvXJm
         oWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6meippeJPq3V/6dFbe3SNBZG6CocNU6mEMezHWgZAnI=;
        b=K38LsCH5hliy+QZI3SkIdNxzPiDYRMKDNbQ9p03L4TIeva5n+rXBagxBuisLzLM7C/
         7nstP65LgsnqspA4vLovej1QevZrBXvBob964x161Ya0t7bqc71RVNVoX5VKGNW5riVv
         7h27o55ot3AGB87yE3SISzFsR8ZEAM/8ebrHAjW4j91XkBfRGWSGXJ64e/RaI/oEtbSr
         ySExLIOdA5bdM+fV6JGhA3uFusqbOq8S2DmqW50A7k/raRr1/aoYBn7waBZX0eQgnEWy
         sx2yR/7PlKspXSEPz7ktByzWu5CsTBOTIFKq7u1UtW6cJhVXvLNpv70kksW8GPzvS40m
         u9iw==
X-Gm-Message-State: APjAAAXzrR6Oiu6ue67N2PxOE5JfxquNKsBTsQal/TcjskZ050hU6mw6
        5uzu9kGBPNxVgGM8JE5NXEc=
X-Google-Smtp-Source: APXvYqxQCOIMrmWSrXbDmjUz1OOxBLovYcpHFXOpdP1mRiJzqZH2SCvLHU48HDogJ7yPqULTXFd6yA==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr22317876pfi.260.1576594584275;
        Tue, 17 Dec 2019 06:56:24 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z13sm3856186pjz.15.2019.12.17.06.56.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 06:56:23 -0800 (PST)
Date:   Tue, 17 Dec 2019 22:56:20 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>, christian.brauner@ubuntu.com,
        peterz@infradead.org, mingo@kernel.org
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217145620.GA26585@cqw-OptiPlex-7050>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
 <20191217105042.GA21784@cqw-OptiPlex-7050>
 <20191217142515.GB23152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217142515.GB23152@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 03:25:15PM +0100, Oleg Nesterov wrote:
> On 12/17, chenqiwu wrote:
> >
> > @@ -728,6 +724,15 @@ void __noreturn do_exit(long code)
> >                 panic("Attempted to kill the idle task!");
> >
> >         /*
> > +        * If all threads of global init have exited, do panic imeddiately
> > +        * to get the coredump to find any clue for init task in userspace.
> > +        */
> > +       if (unlikely(is_global_init(tsk) &&
> > +               (atomic_read(&tsk->signal->live) == 1)))
> 
> Well, I guess this will work in practice, but in theory this is racy.
> 
> Suppose that signal->live == 2 and both threads exit in parallel. They
> both can see tsk->signal->live == 2 before atomic_dec_and_test().
> 
> If you are fine with this race I won't object, but please add a comment.
> 
> But why can't you simply do
> 
> 	--- x/kernel/exit.c
> 	+++ x/kernel/exit.c
> 	@@ -786,6 +786,8 @@ void __noreturn do_exit(long code)
> 		acct_update_integrals(tsk);
> 		group_dead = atomic_dec_and_test(&tsk->signal->live);
> 		if (group_dead) {
> 	+		if (unlikely(is_global_init(tsk)
> 	+			panic(...);
> 	 #ifdef CONFIG_POSIX_TIMERS
> 			hrtimer_cancel(&tsk->signal->real_timer);
> 			exit_itimers(tsk->signal);
> 
> ?
> 
> Oleg.
>

Oh, yeah, thanks for your reminds! But in fact, I think atomic_read()
can avoid the racy even if both threads exit in parallel, since it is
an atomic operation forever. I agree your simply modify, is there any
other questions?


