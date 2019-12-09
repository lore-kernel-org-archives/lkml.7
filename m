Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A2DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A02072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575883099;
	bh=QPhCQGgPlsZoF+9Uo4UxgRWRQ4YiRdtsJ2G+EEfINjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WyxkRahA+kzm9M89WI1ST28VJHe9/1FdTM4lJze/sL3sg2fYdb1EeXECWkULkdf5m
	 eRZ0JhUA/4R4P0tf3aGSTU6VSypoldxo8UkmhbN4IhS9u5sk7Fu+cvSGrH9EhQoEaP
	 ojyW/iLum7MUq3rv0ChYi4z3hkgQPMDRN3OdBnlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLIJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:18:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:18:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so15325416wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IS3pzt+Ib31mmxy98sFHUkI7fZbLlkAMt9njzwJQhPY=;
        b=hQK8QkZWR50NbK/dup+4H7Q9lZeQzbkYHPSNEAVLW4mNs1x0EoKHiTJjsCQpkwH8At
         CReqpLPbfM3H8I6zZ7MKVMmtfrTFa8ExF6dVuNpKEHKEdofAiDdZyVAF5QAbfdeap+j3
         oBzdnyeohChP7jPWlKJfr9Y5IPpBF8/dJtFmuXZHV+FVGvmnalof57hStCm/VyQV2C58
         BhJUQkT3jC/se9gpGWZc2p475HqDoE1iQVDjjAxOUia3O7mdaMj5rAOi2CTB8IxjqW9S
         OprvGaLMKsZjLoBBmMgwm2Qw462wXM77LQL64bBffN9GclwHdI4S2GAmKDFGrAeFd2IL
         vmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IS3pzt+Ib31mmxy98sFHUkI7fZbLlkAMt9njzwJQhPY=;
        b=iN0PVtKdhPHT/OmkB5dzV0fSxUuJ7Kw/urssFVZ5prNhQT2vnTySQCvERqQ203+f4i
         eiMYvLNoqhrpfSiuQlLRT0t4N1e4S5ZM/7W1Ro7v1dP8z7BijRJb6FozQcpx7In84TYi
         68vaNxpwutQXQJ5eygMGozxLGz8r8nD+tPJOA8zD3rBMSAOmovj6IMhGc/o5E+GV2GGp
         qsgbz6IhpgM5SqXc/nuMO+OK6QNkW5Z9yLNCr1lva64eTZjlXJFNtFJtu6wt/rF1F8fi
         pRpZ41HkaMYgAss6aJxfqWKqIbuidhKfWy7z70fQmZ24N4rZR2A8s00yA2m/iRdni9Lq
         0GqQ==
X-Gm-Message-State: APjAAAVWXWd+fnh2CazAMBoh3yCBS9QtGKd0pRNDYtY5tKQwq3SPqXfg
        vk7A6tuGUNEdjKgVkSC7OqA=
X-Google-Smtp-Source: APXvYqzxl732HSaQK64bPM/+v7BWairgiSkB15NhNiWmPCKWS1PvYeFtTMnJNMgbu4fVHMThi0DfMQ==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr990862wrr.82.1575883096213;
        Mon, 09 Dec 2019 01:18:16 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v4sm11240657wml.2.2019.12.09.01.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:18:15 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:18:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
Message-ID: <20191209091813.GA41320@gmail.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The reason it is buggy is that wait_event_interruptible_exclusive()
> does this (inside the __wait_event() macro that it expands to):
> 
>                 long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);
> 
>                 if (condition)
>                         break;
>                 if (___wait_is_interruptible(state) && __int) {
>                         __ret = __int;
>                         goto __out;
> 
> and the thing is, if does that "__ret = __int" case and returns
> -ERESTARTSYS, it's possible that the wakeup event has already been
> consumed, because we've added ourselves as an exclusive writer to the
> queue. So it _says_ it was interrupted, not woken up, and the wait got
> cancelled, but because we were an exclusive waiter, we might be the
> _only_ thing that got woken up, and the wakeup basically got forgotten
> - all the other exclusive waiters will remain waiting.

So the place that detects interruption is prepare_to_wait_event():

long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state)
{
        unsigned long flags;
        long ret = 0;

        spin_lock_irqsave(&wq_head->lock, flags);
        if (signal_pending_state(state, current)) {
                /*
                 * Exclusive waiter must not fail if it was selected by wakeup,
                 * it should "consume" the condition we were waiting for.
                 *
                 * The caller will recheck the condition and return success if
                 * we were already woken up, we can not miss the event because
                 * wakeup locks/unlocks the same wq_head->lock.
                 *
                 * But we need to ensure that set-condition + wakeup after that
                 * can't see us, it should wake up another exclusive waiter if
                 * we fail.
                 */
                list_del_init(&wq_entry->entry);
                ret = -ERESTARTSYS;
        } else {
                if (list_empty(&wq_entry->entry)) {
                        if (wq_entry->flags & WQ_FLAG_EXCLUSIVE)
                                __add_wait_queue_entry_tail(wq_head, wq_entry);
                        else
                                __add_wait_queue(wq_head, wq_entry);
                }
                set_current_state(state);
        }
        spin_unlock_irqrestore(&wq_head->lock, flags);

        return ret;
}

I think we can indeed lose an exclusive event here, despite the comment 
that argues that we shouldn't: if we were already removed from the list 
then list_del_init() does nothing and loses the exclusive event AFAICS.

This logic was introduced in this commit 3 years ago:

  b1ea06a90f52: ("sched/wait: Avoid abort_exclusive_wait() in ___wait_event()")
  eaf9ef52241b: ("sched/wait: Avoid abort_exclusive_wait() in __wait_on_bit_lock()")

Before that commit we simply did this:

 long prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
        unsigned long flags;
-
-       if (signal_pending_state(state, current))
-               return -ERESTARTSYS;

Which was safe in the sense that it didn't touch the waitqueue in case of 
interruption. Then it used abort_exclusive_wait(), which got removed in 
eaf9ef52241b, to pass on any leftover wakeups:

-void abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait, void *key)
-{
-       unsigned long flags;
-
-       __set_current_state(TASK_RUNNING);
-       spin_lock_irqsave(&q->lock, flags);
-       if (!list_empty(&wait->task_list))
-               list_del_init(&wait->task_list);
-       else if (waitqueue_active(q))
-               __wake_up_locked_key(q, TASK_NORMAL, key);
-       spin_unlock_irqrestore(&q->lock, flags);
-}
-EXPORT_SYMBOL(abort_exclusive_wait);

Note how the wakeup is passed along to another exclusive waiter (if any) 
via the __wake_up_locked_key() call.

Oleg?

> I dunno. Maybe this is fundamental to the interface? We do not have a 
> lot of users that mix "interruptible" and "exclusive". In fact, I see 
> only two cases that care about the return value, but at least the fuse 
> use does seem to have exactly this problem with potentially lost 
> wakeups because the ERESTARTSYS case ends up eating a wakeup without 
> doing anything about it.

I don't think it's fundamental to the interface.

In fact I'd argue that it's fundamental to the interface to *not* lose 
exclusive events.

> Looks like the other user - the USB gadget HID thing - also has this
> buggy pattern of believing the return value, and losing a wakeup
> event.
> 
> Adding Miklos and Felipe to the cc just because of the fuse and USB
> gadget potential issues, but this is mainly a scheduler maintainer
> question.
> 
> It's possible that I've misread the wait-event code. PeterZ?

I think your analysis is correct, and I think the statistical evidence is 
also overwhelming that the interface is buggy: if we include your new 
usecase then 3 out of 3 attempts got it wrong. :-)

So I'd argue we should fix the interface and allow the 'simple' use of 
reliable interruptible-exclusive waitqueues - i.e. reintroduce the 
abort_exclusive_wait() logic?

Thanks,

	Ingo
