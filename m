Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E64C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5760D2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567538350;
	bh=5m0ykfbU4ELSpG03ITz5JA0D8XI+hnTEAvrRMWhBUho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x5LF378nc1s4V2iQ9ZN0rAvOFsz1gKJIkOOf80+cmxIR84UnQiGg4bE/auKVCghfs
	 rdGGNO+p5mHJx4gBw36ttXyKyU8pn/Z9OIqFt/7DqYDsInLjSlIvwY84+tHLP4zmnI
	 Qfviv4DAqNP7hKD/fD+8MfbGgjREWWCFvzPfL86U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfICTTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:19:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33350 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfICTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:19:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so57778ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXKsFyNBonWGTzgiWa7X2sp4xS2276GWiu2RwjDMmwo=;
        b=Is4gPX7c6Ej9NzLlvqbYQ9aWDZEMN0P6CD7HWO7Ni7nXPQWKH2IU8UjXeoUxIa5YvN
         wo1arBAaA3/vZjpuDmcCdDDhRWqJaE8vzgq5dv50RsVcVs7jBkBshlF8f3SamD9RpiK8
         pejlaeYxZiFJZZ1w9Qz4wTizQ7+Vqz3a9EgW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXKsFyNBonWGTzgiWa7X2sp4xS2276GWiu2RwjDMmwo=;
        b=ZoqnWAaSto2NXanscqhiSZmrTp3XI+Yh9PN4aKauCwqPDIbJjwMbHMXz7zfkth1pQH
         8cy8Kdi097Dxb7GzioH1d2w61ODN7+OcNWdoXfKwO2ztFEsKCpViNc5yAKj0csC+4Y6H
         o8YrRTzpI9wH+TZXcI63msm0DDHPrpI/+IDjugXxSlX8xA/f8O790QAs46DPU6xoSZ9X
         B/1ZWgn8JXmWpl5ovlilKxrt97mGTsVbQRs4rUMAsWhEJ3f9mcTrFiWDKLUvf+HE4oDu
         D85VL/dohhIdz3aQbiEKwkWWscSXeJTm+p5WzNmK9HlS8xcB6JuzEizhltDED0JnMPAg
         cMPw==
X-Gm-Message-State: APjAAAWtGhNMsuuh9sQbTw1prqYErEDc/BNl6fCBfZKf7zc1YwtueLF6
        ju3UW7rRzniUAh3YxtVA9oWiTnh7Be0=
X-Google-Smtp-Source: APXvYqzc5WsCsV2tA57HrxiPEKkJsV1A2+wnUax6LLtkacGXVC8Y9Yo0jCVm5PxtnX1sxWAYmlIPww==
X-Received: by 2002:a2e:8658:: with SMTP id i24mr19374388ljj.188.1567538346283;
        Tue, 03 Sep 2019 12:19:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b205sm3512250lfg.72.2019.09.03.12.19.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:19:04 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l14so17219928lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:19:03 -0700 (PDT)
X-Received: by 2002:a2e:8507:: with SMTP id j7mr7074105lji.156.1567538343274;
 Tue, 03 Sep 2019 12:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net> <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org> <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
In-Reply-To: <874l1tp7st.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 12:18:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
Message-ID: <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 11:13 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I think this is where I am looking a things differently than you and
> Peter.  Why does it have to be ___schedule() that changes the value
> in the task_struct?  Why can't it be something else that changes the
> value and then proceeds to call schedule()?

No, I think we're in violent agreement here: it's _not_ necessary
schedule that changes any values at all. The values behind the pointer
are live both before - and even more so _after_ - we put the process
on the percpu rq.

> What is the size of the window of changes that is relevant?

It's not the _size_ of the window that is relevant. It's the _direction_.

A "smp_store_release()" is only an ordering wrt previous changes. Why
would _previous_ changes be special? They aren't. In many ways, the
task struct before it is on the runqueue is fairly static. It's only
_after_ it is on the runqueue that the process starts doing things to
its own data structures.

> If we use RCU_INIT_POINTER if there was something that changed
> task_struct and then called schedule() what ensures that a remote cpu
> that has a stale copy of task_struct cached will update it's cache
> after following the new value rq->curr?  Don't we need
> rcu_assign_pointer to get that guarantee?

Why are those "before you called schedule" modifications special?

It's _way_ more likely that the task struct fields will change _after_
it was scheduled in.

So in many ways, the scheduling point isn't really the most natural
place for a barrier. It's just an event. But it's not clear why
"changes before that" should be synchronized or be a special case. The
process was visible other ways long before it's being actively run.

So why add a barrier to the scheduler when it's not clear that it makes sense?

Now, if you can point to some particular field where that ordering
makes sense for the particular case of "make it active on the
runqueue" vs "look up the task from the runqueue using RCU", then I do
think that the whole release->acquire consistency makes sense.

But it's not clear that such a field exists, particularly when this is
in no way the *common* way to even get a task pointer, and other paths
do *not* use the runqueue as the serialization point.

See what I'm saying?

Is the runqueue addition point special for synchronization? I don't
see it, and it historically has never been.

But *IF* it is, then yes, then rcu_assign_pointer() would make sense.

                    Linus
