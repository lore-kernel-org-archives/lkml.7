Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273320693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToQpN1nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfDZTfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:35:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43828 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDZTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:35:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id n16so1563216uae.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WATsd3UqXoXpbwyAriLf8lYSkx71OaMFlFNZiq1bdpg=;
        b=ToQpN1nH067QlOMRClecTcoz5tc2bKjASoIrVK4JqKOzaEkSn3CtTnXA2pX2qpnHSN
         JxcggYMQN33NM7pyoCBL54aaSx1X0pb7alCtoNemekODZo/OElnojAgJdVQWG9YQRlg2
         zR0jpRtl88/65fMP/DdQIiiCsfoSPtPc/Gp70OCDBuXNbs3LMckeQ05IUTIWM3BBg1U2
         ZvvOa/O7VAIeKPP673/8k37ccmp+eBJ3yi8bNlwe0Yr+lRFlEhrRv1IzYverZ8rQvoCE
         kbcEIWjWFl003O1P/Kt3AMeSHLn7ilindydLuU3maNGoyjswk0Z1OYuuIJmlfHOC/Wc0
         4PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WATsd3UqXoXpbwyAriLf8lYSkx71OaMFlFNZiq1bdpg=;
        b=AjlgxYvx8HH0XMTgnMin9jZXKBdkPDermnqaJBIf5smmJECleDybXzcq09NbvlzdUb
         zlKyMyf248LGe8QsQ9kGOPpFvtqerV2AgJLb3F97/i1UiQ9YaqSMvs9BXipRM2ts+suY
         LRi2FBNzUj88g2jxE3cs7v+8VMwy5iNRMR+TmjehkCqnQrLr7T9eY9Mayy03NfIW1eLI
         4CWRda6fJDJZv2+orneppgkYb0pNbJ9q0N5soYx3xsuI+YzWwiUFu86KEVOa9NfNsHyG
         tt0qqVLL7dYiTZOx8HIPly9cx+Fphc3LmcCXp4hr56uP83B8NuS1t0bY7MSV344YMeO8
         R9BQ==
X-Gm-Message-State: APjAAAVcT92rmbXTFdWjLEzkyRApfHhQFMkO+wMw85ZtWYOat4M7Wdo4
        ssCQKSJ6ABVNTXpWi/zHzAxH+KeagqzWkFaeqWv/VQ==
X-Google-Smtp-Source: APXvYqzpKmOugosFSsRqPJFIZXf4ZQAJFg5KS4Aodc7eXTgRFayBazVlDEN26AcpYboxUCiIJftT2C5ciYJ5IL+6adg=
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr13767383uam.85.1556307352005;
 Fri, 26 Apr 2019 12:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org> <20190425212917.yotnir4uqgpnh764@brauner.io>
 <CAKOZueuPeqnWVCv8NnQNyStWBQLybkr2qqtfQ0MjzsfSQDymzg@mail.gmail.com> <20190426172602.GD261279@google.com>
In-Reply-To: <20190426172602.GD261279@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 26 Apr 2019 12:35:40 -0700
Message-ID: <CAKOZuetFw9MnZCrXbcFTCFD9Jq8bZwzdcEi_OYHMMv2R_sgNNA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Add selftests for pidfd polling
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Jann Horn <jann@thejh.net>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Murray <timmurray@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:26 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Apr 25, 2019 at 03:07:48PM -0700, Daniel Colascione wrote:
> > On Thu, Apr 25, 2019 at 2:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > This timing-based testing seems kinda odd to be honest. Can't we do
> > > something better than this?
> >
> > Agreed. Timing-based tests have a substantial risk of becoming flaky.
> > We ought to be able to make these tests fully deterministic and not
> > subject to breakage from odd scheduling outcomes. We don't have
> > sleepable events for everything, granted, but sleep-waiting on a
> > condition with exponential backoff is fine in test code. In general,
> > if you start with a robust test, you can insert a sleep(100) anywhere
> > and not break the logic. Violating this rule always causes pain sooner
> > or later.
>
> I prefer if you can be more specific about how to redesign the test. Please
> go through the code and make suggestions there. The tests have not been flaky
> in my experience.

You've been running them in an ideal environment.

Some tests do depend on timing like the preemptoff tests,
> that can't be helped. Or a performance test that calculates framedrops.

Performance tests are *about* timing. This is a functional test. Here,
we care about sequencing, not timing, and using a bare sleep instead
of sleeping with a condition check (see below) is always flaky.

> In this case, we want to make sure that the poll unblocks at the right "time"
> that is when the non-leader thread exits, and not when the leader thread
> exits (test 1), or when the non-leader thread exits and not when the same
> non-leader previous did an execve (test 2).

Instead of sleeping, you want to wait for some condition. Right now,
in a bunch of places, the test does something like this:

do_something()
sleep(SOME_TIMEOUT)
check(some_condition())

You can replace each of these clauses with something like this:

do_something()
start_time = now()
while(!some_condition() && now() - start_time < LONG_TIMEOUT)
  sleep(SHORT_DELAY)
check(some_condition())

This way, you're insensitive to timing, up to LONG_TIMEOUT (which can
be something like a minute). Yes, you can always write
sleep(LARGE_TIMEOUT) instead, but a good, robust value of LONG_TIMEOUT
(which should be tens of seconds) would make the test take far too
long to run in the happy case.

Note that this code is fine:

check(!some_condition())
sleep(SOME_REASONABLE_TIMEOUT)
check(!some_condition())

It's okay to sleep for a little while and check that something did
*not* happen, but it's not okay for the test to *fail* due to
scheduling delays. The difference is that
sleeping-and-checking-that-something-didn't-happen can only generate
false negatives when checking for failures, and it's much better from
a code health perspective for a test to sometimes fail to detect a bug
than for it to fire occasionally when there's no bug actually present.

> These are inherently timing related.

No they aren't. We don't care how long these operations take. We only
care that they happen in the right order.

(Well, we do care about performance, but not for the purposes of this
functional test.)

> Yes it is true that if this runs in a VM
> and if the VM CPU is preempted for a couple seconds, then the test can fail
> falsely. Still I would argue such a failure scenario of a multi-second CPU
> lock-up can cause more serious issues like RCU stalls, and that's not a test
> issue. We can increase the sleep intervals if you want, to reduce the risk of
> such scenarios.
>
> I would love to make the test not depend on timing, but I don't know how.

For threads, implement some_condition() above by opening a /proc
directory to the task you want. You can look by death by looking for
zombie status in stat or ESRCH.

If you want to test that poll() actually unblocks on exit (as opposed
to EPOLLIN-ing immediately when the waited process is already dead),
do something like this:

- [Main test thread] Start subprocess, getting a pidfd
- [Subprocess] Wait forever
- [Main test thread] Start a waiter thread
- [Waiter test thread] poll(2) (or epoll, if you insist) on process exit
- [Main test thread] sleep(FAIRLY_SHORT_TIMEOUT)
- [Main test thread] Check that the subprocess is alive
- [Main test thread] pthread_tryjoin_np (make sure the waiter thread
is still alive)
- [Main test thread] Kill the subprocess (or one of its threads, for
testing the leader-exit case)
- [Main test thread] pthread_timedjoin_np(LONG_TIMEOUT) the waiter thread
- [Waiter test thread] poll(2) returns and thread exits
- [Main test thread] pthread_join returns: test succeeds (or the
pthread_timedjoin_np fails with ETIMEOUT, it means poll(2) didn't
unblock, and the test should fail).

Tests that sleep for synchronization *do* end up being flaky. That the
flakiness doesn't show up in local iterative testing doesn't mean that
the test is adequately robust.
