Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A26206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDxI/Dco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfDYWIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:08:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34567 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfDYWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:08:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id n17so824378vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ak1U3Odv0aZPvdj1RHbAifHko/b4UA9d9R+tGHvT3SU=;
        b=NDxI/Dcoa+z67Sw2V2npnR0n2nLQk/jE/p+glUFhp+cEzHige6Tbre3ctX/y6SQsig
         uug5O/szCEt1CHnTkfEAKjSDYGjryb1jVsODR+WNT9t1Njq+1+d+IbaAfSFAXWbJhIW7
         BDCBKeeOC735mWGztzLTOm/fI6a0oASUIKxY2/TWciNDCtilbeyY9tCHkDYjHji0a3AT
         dcvi/Wn4JxpbmHjKlrjtbaY0JJQrnwVhANH5YDQnjvHZh6axscx2KPMqJc/qubAkke6k
         wmDmIB6QhJmgpMEmroR+dTcuH0nZjZY5TD85mI+ckK+jCzhUbjK7zB1df4fsXioARDSP
         riXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak1U3Odv0aZPvdj1RHbAifHko/b4UA9d9R+tGHvT3SU=;
        b=QPg6zF0nv5NKJDvnZqt53y+CXtnM42EhS4b2cBln6+oQujYlFR/kWEUgsV69zhFsjb
         yID0n7PoL/PxjmCjD2cGkU5xkK7VfH9gHcwuWIKD6Fo32fVgGSem4CpFAu82ntG2Em2n
         t2IwrYxeyrs8lt65kP0Jsf+N7J08BYtWsgTbFlJeicAh2DBZ23GVJpPihumQcRqwjbuD
         CFr9Qr0R4b2OgqH0Q66ZoNYHwPizR7+JJSS6af6m2rqQdQ0rKLSEbONhfhAkRvNQV7LW
         ++iLNTIxjOAoIPU1lVZyvRh84vxXH2xdxM+nGQzIc29BWENUa4VUK0h7x7rI/rW9YX0k
         HpGg==
X-Gm-Message-State: APjAAAVbtPfBwXtwPlqImO50rzq8mQtacnCQxvTui1TQQS6yOfYfYgZM
        7IwgwKqwVN7yqaOeer4sXufNoV8aBw/DS+9+OUHVsA==
X-Google-Smtp-Source: APXvYqwLL0ulWY6/Shu+Q4KVbH0+78P/TfqZ3tyM6WydYeim1KubcCWrOF9d6Qa2yTBisiySibskanzuWAjB/2wbBrY=
X-Received: by 2002:a67:ea0a:: with SMTP id g10mr21694902vso.77.1556230079881;
 Thu, 25 Apr 2019 15:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org> <20190425212917.yotnir4uqgpnh764@brauner.io>
In-Reply-To: <20190425212917.yotnir4uqgpnh764@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 25 Apr 2019 15:07:48 -0700
Message-ID: <CAKOZueuPeqnWVCv8NnQNyStWBQLybkr2qqtfQ0MjzsfSQDymzg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Add selftests for pidfd polling
To:     Christian Brauner <christian@brauner.io>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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

On Thu, Apr 25, 2019 at 2:29 PM Christian Brauner <christian@brauner.io> wrote:
> This timing-based testing seems kinda odd to be honest. Can't we do
> something better than this?

Agreed. Timing-based tests have a substantial risk of becoming flaky.
We ought to be able to make these tests fully deterministic and not
subject to breakage from odd scheduling outcomes. We don't have
sleepable events for everything, granted, but sleep-waiting on a
condition with exponential backoff is fine in test code. In general,
if you start with a robust test, you can insert a sleep(100) anywhere
and not break the logic. Violating this rule always causes pain sooner
or later.

Other thoughts: IMHO, using poll(2) instead of epoll would simplify
the test code, and I think we can get away with calling
pthread_exit(3) instead of SYS_exit.
