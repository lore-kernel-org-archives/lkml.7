Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ay/7cip6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCLOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:37:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44677 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfCLOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:37:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so2950965wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRTF81XNeQwjJa5bhQu6Xf+1EuYh+2bPe7EUzUpU52g=;
        b=ay/7cip6wu0tI10WzvwNE1MQAcjNhmixLZczxHyaG4Qkg8wYfW/JogftocehntIDSj
         5Nm/JJP8ToZSt/XDPlYpoKnUhKdQ1n+dgSgTwQj0/x/q00TtdQWBtcUtT6aQsMzL9eqC
         Eg1mR97fXDxSdWAQQ7FCiaO+Eg/+tiyrdClDdShzvVbTlyNwQLnA5Ko97ineMWhykWGZ
         TzuYE0yAB/K/v8t7Yaog6VeB5o4taXmzw1DOR44DsgcLuvz4OnmXa8zgEzq544B0B/ww
         oTIr01rd8och48LGaqWz+QImRZrRRQ1IauwVECxswlnjwuaKQNaUohZJzW2zNVqg8PKX
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRTF81XNeQwjJa5bhQu6Xf+1EuYh+2bPe7EUzUpU52g=;
        b=uSdRGJMeIz+hGfxkh6g4Rl6IL6YlX0vXvPb+Q6Z3dD5PzP8j6O5duuNXMHcIh5Odzk
         6+NQE82mjflmKvcUfOGIXkJXO1ZQywssj1oKneqRCvrhGMwAl0rxaGev0aZS7TDt3z/B
         EVs1yNlaL1LurF6oaJklZTlJ6Nll+t3eGrsmuZaIwO+urkCUx66mTxSmVYNl8k7T3TYD
         Zhe1+dh/qvKTkLWpYihrYmYkcM4AleUzcvMTskTz0tg2vzo+GvtLPqyuNjphCgIsq7uS
         bqpOJ8/Q5pTi3UoEpqxr9Ol+exOeD6bmG39FepHjQb+IQOJ9ghzQd7Blty/iee0zimHH
         06MA==
X-Gm-Message-State: APjAAAVWIvxSw6FrkE1miV0vXpr9+aJIMuJoYxgum5jkvq+htg9YsSPP
        GX9WEZcgfJhIvDXoIC69zSqDHyGqx+KElD8qnQkuWQ==
X-Google-Smtp-Source: APXvYqxxDHcCV4tu5+bbr5nTTs4Fjpw4uzgDe4ZydUl+ewLp7rm7wgfT68Q7s24XlcwrVqOLXHNgARRYtsPNzWpe/iA=
X-Received: by 2002:a5d:40c5:: with SMTP id b5mr24653747wrq.107.1552401430345;
 Tue, 12 Mar 2019 07:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
In-Reply-To: <20190312080532.GE5721@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Mar 2019 07:36:58 -0700
Message-ID: <CAJuCfpFToMiU8pyjA5QDduG0V8-UZSq1EesstFRUC6_YvbDDQA@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:05 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 11-03-19 15:15:35, Suren Baghdasaryan wrote:
> > On Mon, Mar 11, 2019 at 1:46 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 01:10:36PM -0700, Suren Baghdasaryan wrote:
> > > > The idea seems interesting although I need to think about this a bit
> > > > more. Killing processes based on failed page allocation might backfire
> > > > during transient spikes in memory usage.
> > >
> > > This issue could be alleviated if tasks could be killed and have their pages
> > > reaped faster. Currently, Linux takes a _very_ long time to free a task's memory
> > > after an initial privileged SIGKILL is sent to a task, even with the task's
> > > priority being set to the highest possible (so unwanted scheduler preemption
> > > starving dying tasks of CPU time is not the issue at play here). I've
> > > frequently measured the difference in time between when a SIGKILL is sent for a
> > > task and when free_task() is called for that task to be hundreds of
> > > milliseconds, which is incredibly long. AFAIK, this is a problem that LMKD
> > > suffers from as well, and perhaps any OOM killer implementation in Linux, since
> > > you cannot evaluate effect you've had on memory pressure by killing a process
> > > for at least several tens of milliseconds.
> >
> > Yeah, killing speed is a well-known problem which we are considering
> > in LMKD. For example the recent LMKD change to assign process being
> > killed to a cpuset cgroup containing big cores cuts the kill time
> > considerably. This is not ideal and we are thinking about better ways
> > to expedite the cleanup process.
>
> If you design is relies on the speed of killing then it is fundamentally
> flawed AFAICT. You cannot assume anything about how quickly a task dies.
> It might be blocked in an uninterruptible sleep or performin an
> operation which takes some time. Sure, oom_reaper might help here but
> still.

That's what I was considering. This is not a silver bullet but
increased speed would not hurt.

> The only way to control the OOM behavior pro-actively is to throttle
> allocation speed. We have memcg high limit for that purpose. Along with
> PSI, I can imagine a reasonably working user space early oom
> notifications and reasonable acting upon that.

That makes sense and we are working in this direction.

> --
> Michal Hocko
> SUSE Labs

Thanks,
Suren.
