Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E4AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B8C2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEGRRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:17:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37376 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:17:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id u3so10241405otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9wTNkAOK0Q4lAuFt/sfS/LjQKpDg59u0F4E5sd+CsI=;
        b=nMACw8v8j0MsvwP15Ohyik61LcRQjcT8b7zK2TVN17+uxho1KWuhSqR6xkmX5oW5TN
         4rjvYst3gZAu+O18ll/rFt3CV/nOKcNyq5dURnZVNCAU4g0aYza0bDfQvDiNR6Jye4cE
         hRDPK4GFYBGqMggov0Dsfg1dPUuZn4ymRsoFd8U+OSSEAIu0RbX9oyPk+0BmIAEgQwR7
         PrT+CKOT3du//PGsKVioRkBrt4e2ZOrYRf4oZ4BQu3SmBe7NJqDqX+IE+xDtmOd9eN7+
         e1kMo0bPhLvMqzCDT5OwdxasL/d8+EsDIDM/iXxJ7+ItYf+mLUwn7xV+48Rd+Mnntgp4
         nKEQ==
X-Gm-Message-State: APjAAAVK93bajYLZtTSnbrnlV6uL0RA7pzg6j8jeZ85cv4ae3Id0Cncy
        GQQf9ytpuSSpeMxf7eAp5DM=
X-Google-Smtp-Source: APXvYqx4xD4T9EyjERPdqkpNFarhqKMZJ2bjl+TL0Qi4QVxwmB8ENcE4Li8DoRtFni5wwxEr70A6yA==
X-Received: by 2002:a9d:5882:: with SMTP id x2mr471197otg.49.1557249435730;
        Tue, 07 May 2019 10:17:15 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id y18sm2818116otq.36.2019.05.07.10.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:17:14 -0700 (PDT)
Date:   Tue, 7 May 2019 10:17:11 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507171711.GB12201@sultan-box.localdomain>
References: <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain>
 <20190507105826.oi6vah6x5brt257h@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507105826.oi6vah6x5brt257h@brauner.io>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:58:27PM +0200, Christian Brauner wrote:
> This is work that is ongoing and requires kernel changes to make it
> feasible. One of the things that I have been working on for quite a
> while is the whole file descriptor for processes thing that is important
> for LMKD (Even though I never thought about this use-case when I started
> pitching this.). Joel and Daniel have joined in and are working on
> making LMKD possible.
> What I find odd is that every couple of weeks different solutions to the
> low memory problem are pitched. There is simple_lkml, there is LMKD, and
> there was a patchset that wanted to speed up memory reclaim at process
> kill-time by adding a new flag to the new pidfd_send_signal() syscall.
> That all seems - though related - rather uncoordinated. Now granted,
> coordinated is usually not how kernel development necessarily works but
> it would probably be good to have some sort of direction and from what I
> have seen LMKD seems to be the most coordinated effort. But that might
> just be my impression.

LMKD is just Android's userspace low-memory-killer daemon. It's been around for
a while.

This patch (simple_lmk) is meant to serve as an immediate solution for the
devices that'll never see a single line of PSI code running on them, which
amounts to... well, most Android devices currently in existence. I'm more of a
cowboy who made this patch after waiting a few years for memory management
improvements on Android that never happened. Though it looks like it's going to
happen soon(ish?) for super new devices that'll have the privilege of shipping
with PSI in use.

On Tue, May 07, 2019 at 01:09:21PM +0200, Greg Kroah-Hartman wrote:
> > It's even more odd that although a userspace solution is touted as the proper
> > way to go on LKML, almost no Android OEMs are using it, and even in that commit
> > I linked in the previous message, Google made a rather large set of
> > modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
> > What's going on?
> 
> "almost no"?  Again, Android Go is doing that, right?

I'd check for myself, but I can't seem to find kernel source for an Android Go
device...

This seems more confusing though. Why would the ultra-low-end devices use LMKD
while other devices use the broken lowmemorykiller driver?

> > Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845.
> 
> Qualcomm should never be used as an example of a company that has any
> idea of what to do in their kernel :)

Agreed, but nearly all OEMs that use Qualcomm chipsets roll with Qualcomm's
kernel decisions, so Qualcomm has a bit of influence here.

> > If PSI were backported to 4.4, or even 3.18, would it really be used?
> 
> Why wouldn't it, if it worked properly?

For the same mysterious reason that Qualcomm and others cling to
lowmemorykiller, I presume. This is part of what's been confusing me for quite
some time...

> Please see the work that went into PSI and the patches around it.
> There's also a lwn.net article last week about the further work ongoing
> in this area.  With all of that, you should see how in-kernel memory
> killers are NOT the way to go.
> 
> > Regardless, even if PSI were backported, a full-fledged LMKD using it has yet to
> > be made, so it wouldn't be of much use now.
> 
> "LMKD"?  Again, PSI is in the 4.9.y android-common tree, so the
> userspace side should be in AOSP, right?

LMKD as in Android's low-memory-killer daemon. It is in AOSP, but it looks like
it's still a work in progress.

Thanks,
Sultan
