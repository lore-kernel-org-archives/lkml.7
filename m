Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAACC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D1A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STIu7ueW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCKWPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:15:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35485 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:15:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id t18so578602wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnI0fUcdzJqZU/DTruBcUGekoe8aZHTHc7dj/1D9pDo=;
        b=STIu7ueW7L5p2TzqtAmcSxV3KguqBPhLN6KQwuyu1G/VOQH2p4moWrluTFiiebcZm1
         2ophhi5lSUP4fDVmfI0KcWubjRj4LCAlzmeJpYEmsP8nYT5i/q68XwmRJFtefA3K0hda
         59PwzZAiKgBJhKbu6DUDWiNTBR5KSaJ3JNjZLRz3uD2vNTvh2EwFVcQW1x/KYks26Me8
         QAYi7AzGhCn/NCSVOfTrKslxmO1dYD4CN+rMR2EYg6sLjWKTb/33PHxfLgv3BOunhxmf
         RnTqLJ618Y737n7uyVNi0p/Js7fLX03g6gLEgh7tXJqfFwPDOUwY9NPzq6Qblqg0aLsj
         vSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnI0fUcdzJqZU/DTruBcUGekoe8aZHTHc7dj/1D9pDo=;
        b=kPv75sWErRbQgPXpK9lddF72ZUxn41Dah/4X6TFa1n1DXK+aK8LIlNjbQ/cWfnRKwH
         kHIqSVPD4ppu6Uen+hXkF/2+Y57q5xDlQM3zcaZer9G/wJCmxmDyBBPpofSwB2JkxOkv
         mU6ZIV4mLsiDdnx7UkYumTlv0RRZ6P8VWvYrjLsWpFdfj0IKvMvboTf+0CUxQFasNXGm
         LanQyNIGqqK34GHQu6H9e+62RNT3uGl7ZDdcYjbje50paxHrex6GvftB5nF8jUYE9e68
         oZuj9+g+g/uL0DqnYm4/PsggTmkxTRGPTCya3DScd6zHzDyI+X3jg9pqgSa+sXHZ4Hhh
         HXuA==
X-Gm-Message-State: APjAAAVyN4rjyjKhYM4u9ZZX92bnSuIVsLax7md2YbDYEpNSg2ZcsdQs
        UGv/tWxyjYbzXupOBCl5/q2HD8SpE09KcswsxjP9dA==
X-Google-Smtp-Source: APXvYqzBPV7OZeaIUoX8OaAcEt5nnkBCXbML20FxMXjDLjGWNCMW1qTFcwXaA28SNy5pChjGUFMWmTrpLR8E9AbMQ+M=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr19405040wrp.150.1552342546588;
 Mon, 11 Mar 2019 15:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com> <20190311204626.GA3119@sultan-box.localdomain>
In-Reply-To: <20190311204626.GA3119@sultan-box.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Mar 2019 15:15:35 -0700
Message-ID: <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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

On Mon, Mar 11, 2019 at 1:46 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Mon, Mar 11, 2019 at 01:10:36PM -0700, Suren Baghdasaryan wrote:
> > The idea seems interesting although I need to think about this a bit
> > more. Killing processes based on failed page allocation might backfire
> > during transient spikes in memory usage.
>
> This issue could be alleviated if tasks could be killed and have their pages
> reaped faster. Currently, Linux takes a _very_ long time to free a task's memory
> after an initial privileged SIGKILL is sent to a task, even with the task's
> priority being set to the highest possible (so unwanted scheduler preemption
> starving dying tasks of CPU time is not the issue at play here). I've
> frequently measured the difference in time between when a SIGKILL is sent for a
> task and when free_task() is called for that task to be hundreds of
> milliseconds, which is incredibly long. AFAIK, this is a problem that LMKD
> suffers from as well, and perhaps any OOM killer implementation in Linux, since
> you cannot evaluate effect you've had on memory pressure by killing a process
> for at least several tens of milliseconds.

Yeah, killing speed is a well-known problem which we are considering
in LMKD. For example the recent LMKD change to assign process being
killed to a cpuset cgroup containing big cores cuts the kill time
considerably. This is not ideal and we are thinking about better ways
to expedite the cleanup process.

> > AFAIKT the biggest issue with using this approach in userspace is that
> > it's not practically implementable without heavy in-kernel support.
> > How to implement such interaction between kernel and userspace would
> > be an interesting discussion which I would be happy to participate in.
>
> You could signal a lightweight userspace process that has maximum scheduler
> priority and have it kill the tasks it'd like.

This what LMKD currently is - a userspace RT process.
My point was that this page allocation queue that you implemented
can't be implemented in userspace, at least not without extensive
communication with kernel.

> Thanks,
> Sultan

Thanks,
Suren.
