Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A85C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD72343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567525921;
	bh=T5a1ez2ux8+0oJEFqwpQn5ghrrqmBPmpHkNpLA34zhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sa5H0teARipjjlHy5anRNpIBrZr3/jVjTeiJSC8MogQJIpPl9IdPcca3Pn2uWFNVD
	 5glJGe4Eh5b/uq23f+N+kBbrF6cbGJgyvl5Q85PNtUTSyfqwDwKA6p3zlJTRdL+3cp
	 hH2+S8/u2Y9ktC0nAGSG4cH6/aT9x4yQnOHbWRMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfICPwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:52:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44474 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:52:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id u14so9990892ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbZGYf3OM74TDoZcG4y1Mo3Qe7dm90Zsdt+bqnPSAQI=;
        b=NfkWCRoRsGlKw3xdjMaVldpa586an4pWg7h4VWCWhYSlcEHn++uHuPt48P8rFcZbYK
         W5w8X+o2iBB6KzG7FvEZXB7fw0wp5nCxwNZAHLN66OG9o3AyF7JTsIzq0T9arTknwldF
         3CvUol2k6c8RCQgu2YbTlJg3M8g2QYwkRrkhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbZGYf3OM74TDoZcG4y1Mo3Qe7dm90Zsdt+bqnPSAQI=;
        b=NqK5VY7zCqSFXVXUXpnMo032+s80SMyfYzOSHyDiSPmX7Ln5cxKyp0WKdx6vZlBOoQ
         k01UvNMCXXvwD/iqdnqWtd7eUaNIkkFJKQNx8Qw9ZE8buw9f4T6eEiGY/wqBFMog4OJ4
         e5bQIx2iPdIFqmlwNd1QVF6+fMzkDav7XS/Hq9TEatR3XwiMdw/eIqKs6govq4mw/47/
         r/7FUZpCZuYnOfi4Ka2iVlooflWYB6y3ZYknNnkE8c5ErPlRyJib23oZ31C7Zu47mEof
         Xz+9TJHNODuMLRUeqS2r+4agTArtj4CzbJtm2oJY/NnJVpfAc98YITXYN6m8BJ41kBip
         mRQg==
X-Gm-Message-State: APjAAAVi9TC0PmTwSgS3Nm9cN5+hWX/Kk8WziZR/dgpv1P6LpRoyboxD
        Im45xHR3rC5yjsr3v0P3tUf+lLfg/20=
X-Google-Smtp-Source: APXvYqyPrTpQe5qEeuWFylDVP6Jp1yLkSzf/J1MyJ7lXQ2fU9AvR/f8cCEyEW2Kh/vmR0zNP1pgYTw==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr4084508ljo.131.1567525917831;
        Tue, 03 Sep 2019 08:51:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d28sm2218751lfq.88.2019.09.03.08.51.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 08:51:57 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 7so7029659ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:51:57 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr20175666lji.52.1567525496143;
 Tue, 03 Sep 2019 08:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 08:44:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ_tZXQkovVked+nEsZhZqGVNnKmoy3b699dycZqCdKA@mail.gmail.com>
Message-ID: <CAHk-=wgQ_tZXQkovVked+nEsZhZqGVNnKmoy3b699dycZqCdKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] task: Making tasks on the runqueue rcu protected
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 9:50 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I have split this work into 3 simple patches, so the code is straight
> forward to review and so that if any mistakes slip in it is easy to
> bisect them.  In the process of review what it takes to remove
> task_rcu_dereference I found yet another user of tasks on the
> runqueue in rcu context; the rcuwait_event code.  That code only needs
> it now unnecessary limits removed.

Looks very good to me.

I think PeterZ is right that the rcu_assign_pointer() in [PATCH 2/3]
could be a RCU_INIT_POINTER() due to condition #3 in the
RCU_INIT_POINTER rules. The initialization of the pointer value simply
has nothing to do with what the pointer points to - we're just
switching it to another case.

That said, it won't affect any of the core architectures much, because
smp_store_release() isn't that expensive (it's just a compiler barrier
on x86, it's a cheap instruction on arm64, and it should be very cheap
on any other architecture too unless they do insane things - even on
powerpc, which is about the worst case for any barriers, it's just an
lwsync).

It might be good to have Paul _look_ at it, and because of the minimal
performance impact I don't worry about it too much if it happens
later, but it should be something we keep in mind.

                  Linus
