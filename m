Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D84D25605
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IObnS4Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE3HiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:38:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43719 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:38:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so3215923qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4maX8l5l7zxqXpvb7GBDy3cvUeNR3LgJtCZ3+Mtu/zs=;
        b=IObnS4WwDgXEcSl2mzx38IGgBkv2XERkmVIojRuiswXqH5M+L4E+vwKpl2sS0ktYUd
         bxeIYm9eBNLUr4B6oVKMPSVByBvelsfeqgmf1LbVRJAdhBh9Aye4MXQB+qmz1KVty1Jp
         n8AX7sqtR4EhD37R8U8hBZuyanEu5ZcxyJtNhMZFwPe5Azo6OaNnwDX50bhTOnzTcPuo
         GzcYV9k+78TXLkA/9XKWD4XkjwauRHDuNFaQztK4d2S7qpzoXvYhi+BZ0RqGGQ/5fiyP
         diUwLc1pZ3L/laT1awq55Yasz5R4DspcyainhY7NWced+q318j0d7UXZ9aHzW4WlqNAV
         /0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4maX8l5l7zxqXpvb7GBDy3cvUeNR3LgJtCZ3+Mtu/zs=;
        b=gdr/tNIfYlHMQVmvtxcpzKcF7KGTcN3lSaV0XLQq9fFB7P9LgDXGKYw1UKFY9qAWby
         Lq6rX4GldDBH1X5AxrmbUvxZMYQ2slqMXZSLBfpVLZYmwj17CFfJqhpEtGj9oreRxySs
         2rHOrIdbmZdMl4iQI5lo/s2kjJ8mHV8ouiZ9GCYj0RV9r0Qun7zJcepLDEq6pE18geIC
         E0nOKGMkn+dLTral96omCjA/vBcQfV1RMUcNvVFo0rfsE7cL7uxFW4QeSWEThhIns5pZ
         E5MWwggpZGhDLnbafZfJqNUtDApRaLkEYClfcRnH+0ve8KjueLWfpgtP2sLFMvxL6hP9
         kgpQ==
X-Gm-Message-State: APjAAAWOonnnysVH3AVRBzHwjcm/6AKOH2N+2n3BKjr8rvOs+I1T9bHa
        JlQ5V3HoV3haot6Ack2Zcvv6pFCmzOB1qCFz4qQ=
X-Google-Smtp-Source: APXvYqxbJTb6/Jdyc59jeVZpyMXG+FQa/CO673FUbHk5o1Gmo0AmZnLPQ0uvs3HDPPy7mO5OD/NcIflZGyvm6mxdKzc=
X-Received: by 2002:a37:9c8:: with SMTP id 191mr1801707qkj.341.1559201881785;
 Thu, 30 May 2019 00:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190516080015.16033-1-duyuyang@gmail.com> <20190516080015.16033-12-duyuyang@gmail.com>
 <20190529114451.GA12812@tardis>
In-Reply-To: <20190529114451.GA12812@tardis>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Thu, 30 May 2019 15:37:50 +0800
Message-ID: <CAHttsrZ962Gw_6OA6J6GEhAx06yV70B5PEzqGEaYGDNSy57-3A@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] locking/lockdep: Adjust lockdep selftest cases
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        paulmck@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Wed, 29 May 2019 at 19:44, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> > @@ -424,7 +424,7 @@ static void rwsem_ABBA2(void)
> >       ML(Y1);
> >       RSL(X1);
> >       RSU(X1);
> > -     MU(Y1); // should fail
> > +     MU(Y1); // should NOT fail
>
> I'm afraid you get this wrong ;-) reader of rwsem is non-recursive if I
> understand correctly, so case like:
>
>         Task 0                  Task 1
>
>         down_read(A);
>                                 mutex_lock(B);
>
>                                 down_read(A);
>         mutex_lock(B);
>
> can be a deadlock, if we consider a third independent task:
>
>         Task 0                  Task 1                  Task 2
>
>         down_read(A);
>                                 mutex_lock(B);
>                                                         down_write(A);
>                                 down_read(A);
>         mutex_lock(B);
>
> in this case, Task 1 can not get it's lock for A, therefore, deadlock.

Well, yes. This situation is damn counterintuitive and looks
suboptimal, but I guess I can understand why this is done so. It is a
shame read locks are not 100% concurrent. I wish I were bright enough
to have figured this out on my own.

Ok, now this perhaps can be easily remedied. it is merely a matter
that finally I can set straight the lock exclusiveness table, and then
from there the only change seems to be now only recursive-read locks
are no deadlock.

Thanks,
Yuyang
