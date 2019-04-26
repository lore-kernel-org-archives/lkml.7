Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE4AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CDC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nB+PjGkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfDZUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:31:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43754 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfDZUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:31:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so2119751pgu.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NRhCrgdcVtWSzkm+pdTS9sMArbFGolgpvwXOxwSyggQ=;
        b=nB+PjGkczsije8B8z+PDeI9W+4LEbce9e8Ktw9RPJx6QlQnXgZNKNdCKnWfM9DMk3m
         E1pA9YyO6kCQskSJNpGC3FBzccvhaYYzoyaUvO3uyAbu/miryUuxnj4OrZeYxXF3NIlP
         ffFU4pOj4trayV/gF0F/7yqY/xaDmLZGgogpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NRhCrgdcVtWSzkm+pdTS9sMArbFGolgpvwXOxwSyggQ=;
        b=ChzpVRY1ZP5n4tceypJSI8SaOAgzTHwFKt0mo2Q9elAaRuuQVZQqvyT+KUe8qpSRBr
         aGgoC/ZZ4eRanDz60ABcsTQMTWmtQjz3Np1mZL99O54KucI/KeEykzbM3P20vh74/K4Y
         iytMVJMhH73LuyMvqBs9pqkM0QbtzFir+HCCS8hhZ4ZHqe65sRc6LwWiFXodtRXtBLyF
         TPcEuk/zcnKYRzW8v62Okig0ADMtb32KEFZjU2HTZ9LixcxXIDHnDYpdwz2AZuU9LclF
         Ppfphbx4ZmFinOkSFLSXAlugNgLK0xQeBysO0oyAEyJXyrolQ/0mB0D01l07p1/MKMhf
         EUpg==
X-Gm-Message-State: APjAAAXTnqg2/OW/71lAUwJJEIE+zGHDk1i75Hc8BCJ32ToS/iumlPzC
        uttrPkLc8pckRK1/WTLXqIfQHg==
X-Google-Smtp-Source: APXvYqx7JKRqVJbHdVSOARDb9TZX4H+2KvxT6GNyldalr3zRo6Yhd5tScsXzT46pEn7Da5c6mYKQqw==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr45913798pgc.442.1556310676949;
        Fri, 26 Apr 2019 13:31:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u17sm35108711pfn.19.2019.04.26.13.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:31:15 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:31:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH v1 2/2] Add selftests for pidfd polling
Message-ID: <20190426203114.GA185553@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org>
 <20190425212917.yotnir4uqgpnh764@brauner.io>
 <CAKOZueuPeqnWVCv8NnQNyStWBQLybkr2qqtfQ0MjzsfSQDymzg@mail.gmail.com>
 <20190426172602.GD261279@google.com>
 <CAKOZuetFw9MnZCrXbcFTCFD9Jq8bZwzdcEi_OYHMMv2R_sgNNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetFw9MnZCrXbcFTCFD9Jq8bZwzdcEi_OYHMMv2R_sgNNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:35:40PM -0700, Daniel Colascione wrote:
> On Fri, Apr 26, 2019 at 10:26 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Apr 25, 2019 at 03:07:48PM -0700, Daniel Colascione wrote:
> > > On Thu, Apr 25, 2019 at 2:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > > This timing-based testing seems kinda odd to be honest. Can't we do
> > > > something better than this?
> > >
> > > Agreed. Timing-based tests have a substantial risk of becoming flaky.
> > > We ought to be able to make these tests fully deterministic and not
> > > subject to breakage from odd scheduling outcomes. We don't have
> > > sleepable events for everything, granted, but sleep-waiting on a
> > > condition with exponential backoff is fine in test code. In general,
> > > if you start with a robust test, you can insert a sleep(100) anywhere
> > > and not break the logic. Violating this rule always causes pain sooner
> > > or later.
> >
> > I prefer if you can be more specific about how to redesign the test. Please
> > go through the code and make suggestions there. The tests have not been flaky
> > in my experience.
> 
> You've been running them in an ideal environment.

One would hope for a reliable test environment.

> > In this case, we want to make sure that the poll unblocks at the right "time"
> > that is when the non-leader thread exits, and not when the leader thread
> > exits (test 1), or when the non-leader thread exits and not when the same
> > non-leader previous did an execve (test 2).
> 
> Instead of sleeping, you want to wait for some condition. Right now,
> in a bunch of places, the test does something like this:
> 
> do_something()
> sleep(SOME_TIMEOUT)
> check(some_condition())

No. I don't have anything like "some_condition()". My some_condition() is
just the difference in time.

> 
> You can replace each of these clauses with something like this:
> 
> do_something()
> start_time = now()
> while(!some_condition() && now() - start_time < LONG_TIMEOUT)
>   sleep(SHORT_DELAY)
> check(some_condition())
> 
> This way, you're insensitive to timing, up to LONG_TIMEOUT (which can
> be something like a minute). Yes, you can always write
> sleep(LARGE_TIMEOUT) instead, but a good, robust value of LONG_TIMEOUT
> (which should be tens of seconds) would make the test take far too
> long to run in the happy case.

Yes, but try implementing some_condition()  :-). It is easy to talk in the
abstract, I think it would be more productive if you can come up with an
implementation/patchh of the test itself and send a patch for that. I know
you wrote some pseudocode below, but it is a complex reimplementation that I
don't think will make the test more robust. I mean reading /proc/pid stat?
yuck :) You are welcome to send a patch though if you have a better
implementation.

> Note that this code is fine:
> 
> check(!some_condition())
> sleep(SOME_REASONABLE_TIMEOUT)
> check(!some_condition())
> 
> It's okay to sleep for a little while and check that something did
> *not* happen, but it's not okay for the test to *fail* due to
> scheduling delays. The difference is that

As I said, multi-second scheduling delay are really unacceptable anyway. I
bet many kselftest may fail on a "bad" system like that way, that does not
mean the test is flaky. If there are any reports in the future that the test
fails or is flaky, I am happy to address them at that time. The tests work
and catch bugs reliably as I have seen. We could also make the test task as
RT if scheduling class is a concern.

I don't think its worth bikeshedding about hypothetical issues.

thanks,

 - Joel

