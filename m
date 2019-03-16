Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2D21904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO4HUFda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCPRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:31:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55362 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:31:58 -0400
Received: by mail-it1-f195.google.com with SMTP id z126so12080655itd.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYThlM/qCXw00qK9OcGbl490CqSKkPBQ60AjUWblE34=;
        b=KO4HUFdasxYjpZit8xzAdrzX3PBnIR59Q8mfN2yqzNNLtwCv/B5sGYk0aGAR40yauC
         o5DLvJL3OhvMW0yc6b1wcUs/qLwDFmNo8ROLYmtVRe4PDzCHn99q1IIUJTXtMBq39Y3K
         tGIu8ho1JVwOxhj1encTIOw6Uwoxtvw4q+fmnyPQQwdr5rxKsdiYP/8EQZ6cRn3ULUhU
         9FhpDsMPK2zlUeYao+qRvuPaXk0Y+ZUREdrvseBmAW6esd7lObxe9Uh5PkY4enhNE1R5
         1phbsPrW1YxF0wRNt7YgFU8HwgakmxfGxyCGxWs+zsl32RLVeJUV4EBQ8//+H3CiF9vR
         JkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYThlM/qCXw00qK9OcGbl490CqSKkPBQ60AjUWblE34=;
        b=XwV5o5k/vzEfaQJJqF7C25xC0Zy32AEgbR1WXS91++2sksRsnq94NSxlwFn23zOw/Q
         u8ceIu1TPkKOu/FNMIszxJikqVwiwj5mvea8qKv48WEoMVzUCh9hHFvi0NNRbAfNsINT
         BZgbmkkIi4Cfqp2UNybr83+z60vnbNHmhdF39NCrZEjiSUPhHATXpaRP9g5uV78h+Rjf
         H1BQhLkhrk2SJGVW1RDXOY/9ud4uBHbkz+gfgFO4cx+1vm/pgydgCmIzRd8taO10t8x0
         gV38vcKejsy8aflLt45wgb1Uwl0PbB1NmEVgysizasPFuW4a2Wd/68pGAbZLvy7UQ7eZ
         eaAA==
X-Gm-Message-State: APjAAAWh7oYcvTWmAhU8lZz2M7yM4UErcbArGHRpqy4yyDZwo/2wbYfa
        ENCkw0reWQ/bfFwBtA0eVgHXDjVr+0z+5nZFiAC0Mw==
X-Google-Smtp-Source: APXvYqwt3/NtY1q8kvFlPOBO8aAygdzNFbwruR4bWzyFB6EZq2v0Sr+JUDk4Sb3kyGisVrDfsJmtDtwpE8MdHJCY52o=
X-Received: by 2002:a24:3c53:: with SMTP id m80mr1087932ita.102.1552757516935;
 Sat, 16 Mar 2019 10:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain> <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
 <20190315180306.sq3z645p3hygrmt2@brauner.io> <20190315181324.GA248160@google.com>
 <20190315182426.sujcqbzhzw4llmsa@brauner.io> <20190315184903.GB248160@google.com>
In-Reply-To: <20190315184903.GB248160@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 16 Mar 2019 10:31:45 -0700
Message-ID: <CAJuCfpGp_9fE9MPGVCWjnTaeBE0K_Q22LS1pBqhp7zW2M=dbGw@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:49 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Mar 15, 2019 at 07:24:28PM +0100, Christian Brauner wrote:
> [..]
> > > why do we want to add a new syscall (pidfd_wait) though? Why not just use
> > > standard poll/epoll interface on the proc fd like Daniel was suggesting.
> > > AFAIK, once the proc file is opened, the struct pid is essentially pinned
> > > even though the proc number may be reused. Then the caller can just poll.
> > > We can add a waitqueue to struct pid, and wake up any waiters on process
> > > death (A quick look shows task_struct can be mapped to its struct pid) and
> > > also possibly optimize it using Steve's TIF flag idea. No new syscall is
> > > needed then, let me know if I missed something?
> >
> > Huh, I thought that Daniel was against the poll/epoll solution?
>
> Hmm, going through earlier threads, I believe so now. Here was Daniel's
> reasoning about avoiding a notification about process death through proc
> directory fd: http://lkml.iu.edu/hypermail/linux/kernel/1811.0/00232.html
>
> May be a dedicated syscall for this would be cleaner after all.

Ah, I wish I've seen that discussion before...
syscall makes sense and it can be non-blocking and we can use
select/poll/epoll if we use eventfd. I would strongly advocate for
non-blocking version or at least to have a non-blocking option.
Something like this:

evfd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
// register eventfd to receive death notification
pidfd_wait(pid_to_kill, evfd);
// kill the process
pidfd_send_signal(pid_to_kill, ...)
// tend to other things
...
// wait for the process to die
poll_wait(evfd, ...);

This simplifies userspace, allows it to wait for multiple events using
epoll and I think kernel implementation will be also quite simple
because it already implements eventfd_signal() that takes care of
waitqueue handling.

If pidfd_send_signal could be extended to have an optional eventfd
parameter then we would not even have to add a new syscall.

> > I have no clear opinion on what is better at the moment since I have
> > been mostly concerned with getting pidfd_send_signal() into shape and
> > was reluctant to put more ideas/work into this if it gets shutdown.
> > Once we have pidfd_send_signal() the wait discussion makes sense.
>
> Ok. It looks like that is almost in though (fingers crossed :)).
>
> thanks,
>
>  - Joel
>
