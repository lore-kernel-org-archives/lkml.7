Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F36C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12ED2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R6U/Yor1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDZR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:26:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46839 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDZR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:26:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so2025832pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0R0zKKad1LluAuAg+aebvByAUW+gKKtAQn2bc3N5PBk=;
        b=R6U/Yor1OJkJyD71Twn7FGvpzVbGMhBazytbC3VNUXEY1uAXvIoLhg3yDyMCUSTaKS
         4h4gfSGMZ8Apcw7m0pTqhFANCL8EtLUz4gpJuv+4idLW/Soa4eF7Qeq8qYhrkksZ9TAP
         z5AD429/1jfxqVC406MgRJwx/yLWVpZ5/KJxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0R0zKKad1LluAuAg+aebvByAUW+gKKtAQn2bc3N5PBk=;
        b=GKo8jzTvQ5ts8wyAYgMZ7xHGtVBXHa9/yU71bpCzxQoqmuVBbNthOcnW8yDRtBImhH
         QmNCNskHXhrRqYWDrVwTrVKu6isdbpxaFI19mOT7oJ8NCon9/wVo0rTPqok+ekhZ5kgo
         hjOW3W8acMJu5IPLU0VExo3YsVUMccbUHo352ASICet4Zhhf/OMtItcweBkZ1fe7x4aA
         YTDTIbQBPwvQJo9Hd41nHnxUy0gxMjEqJXpmWdn90iKyPKk5bNfy8W2QQhHsxmrVhaKa
         zaB8uwBum0+eeDkaxpV8odgORgwdzA1NRuM6MHA0MGlc5pTOLnC8S4IIYwxSuDMNAy64
         PXWQ==
X-Gm-Message-State: APjAAAW6nwt2CaY4k82ECo0dXTflF0xhnxpYH5w4X8GeXpPlpPZhYc4I
        K9BA0WqWy007Klu2nxYwOFSKKg==
X-Google-Smtp-Source: APXvYqw/mw1DuGQHCZM5w5q9z8C6GS0EtuBkwpypEgMcOoNvUmm1bhVeIwOJMmSLBOE36SjULv+iQA==
X-Received: by 2002:a63:d349:: with SMTP id u9mr42447261pgi.83.1556299565072;
        Fri, 26 Apr 2019 10:26:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n26sm48563567pfi.165.2019.04.26.10.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:26:04 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:26:02 -0400
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
Message-ID: <20190426172602.GD261279@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org>
 <20190425212917.yotnir4uqgpnh764@brauner.io>
 <CAKOZueuPeqnWVCv8NnQNyStWBQLybkr2qqtfQ0MjzsfSQDymzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuPeqnWVCv8NnQNyStWBQLybkr2qqtfQ0MjzsfSQDymzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:07:48PM -0700, Daniel Colascione wrote:
> On Thu, Apr 25, 2019 at 2:29 PM Christian Brauner <christian@brauner.io> wrote:
> > This timing-based testing seems kinda odd to be honest. Can't we do
> > something better than this?
> 
> Agreed. Timing-based tests have a substantial risk of becoming flaky.
> We ought to be able to make these tests fully deterministic and not
> subject to breakage from odd scheduling outcomes. We don't have
> sleepable events for everything, granted, but sleep-waiting on a
> condition with exponential backoff is fine in test code. In general,
> if you start with a robust test, you can insert a sleep(100) anywhere
> and not break the logic. Violating this rule always causes pain sooner
> or later.

I prefer if you can be more specific about how to redesign the test. Please
go through the code and make suggestions there. The tests have not been flaky
in my experience. Some tests do depend on timing like the preemptoff tests,
that can't be helped. Or a performance test that calculates framedrops.

In this case, we want to make sure that the poll unblocks at the right "time"
that is when the non-leader thread exits, and not when the leader thread
exits (test 1), or when the non-leader thread exits and not when the same
non-leader previous did an execve (test 2).

These are inherently timing related. Yes it is true that if this runs in a VM
and if the VM CPU is preempted for a couple seconds, then the test can fail
falsely. Still I would argue such a failure scenario of a multi-second CPU
lock-up can cause more serious issues like RCU stalls, and that's not a test
issue. We can increase the sleep intervals if you want, to reduce the risk of
such scenarios.

I would love to make the test not depend on timing, but I don't know how. And
the tests caught issues that I had in my development flow, so the tests
worked quite well in my experience.

thanks,

 - Joel

