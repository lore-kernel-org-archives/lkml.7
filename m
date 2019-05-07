Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFCF2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="E+YVKccV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfEGK6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:58:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41573 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfEGK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:58:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so18296060edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HC/MUgf456zJfRJXUVVgg6o0d0M1B+L7QMi6llJ2Bo=;
        b=E+YVKccV3crljzyzQRgZ+qVmjGAxpSmba/m9j8r8NgrA34RUFop5bvNMjUbDwOuRNB
         b32+Jl/qjNWnlvTDYyTs/KeVx58V71F7zbu28ARzlDJFrza6g9g8Zi8OL55OmDTkgfSl
         1BGDJtAmk2ERpdEdX2xDcrPZ80zvjefZo+oei1Mm2khGrth/UBL1A1VFwvbheFqAlcQ8
         9JSttdgh0BDB+Z/aTtQZkNW6+cetIuH9iCeGfDRIqCOLydg98GdTqe6LAdP4iTh2ppDw
         LsM9hKBQMNpP2ECL1fjkX6fYcURKheF5cqWjXseRus2cycqTaunLSVR2osQqCa3I6n/H
         lrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HC/MUgf456zJfRJXUVVgg6o0d0M1B+L7QMi6llJ2Bo=;
        b=gv+gh3k7NK0cmBJGFAzud/Lo/uJrrETjZf6Z+M4uP/NBKRl9FTJwnu3MJVB61EGpaK
         hGEVqYr1ZUOjY1SkffZsOTJ2BMDByjRCwIUGb6uH9DiB/MJVg6RjUQowSfAjGb4HBv6n
         zyXUCe4UfFalju1IiQCx2mgQ+QZqGD4fe51oqBksuWovam9NHQi4rwpJvlAL3d/JMAn0
         uEhLK7BjKWJf3iW9TIhBTjwcnRNYaommgg6Jp+yeEeQFreuLk+7MzoC6Lj+f1CQCpe1I
         g8BKw/6IvzitrNYRlprL6rd1qyF/1w2Lj/Vl4r35T+y3JJFXld/qwu2DP6ELgqVLXSC9
         4u7A==
X-Gm-Message-State: APjAAAVoKjD60kao1abd1jkIzrRcQw4JShbnStUWKmjMjob37rBfLZ40
        HxKRXYo3hs0L3bl7EOwZ4ftSHw==
X-Google-Smtp-Source: APXvYqyHqFTcJpvyTuty9Yn2Sc9cm+BuGmLDrYq55IuT9aIRo5DWhxH0xy9+mtPoGye/4Y6Cby05tA==
X-Received: by 2002:a50:885b:: with SMTP id c27mr31844820edc.155.1557226709457;
        Tue, 07 May 2019 03:58:29 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id w14sm4048277eda.18.2019.05.07.03.58.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:58:28 -0700 (PDT)
Date:   Tue, 7 May 2019 12:58:27 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
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
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507105826.oi6vah6x5brt257h@brauner.io>
References: <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507081236.GA1531@sultan-box.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:12:36AM -0700, Sultan Alsawaf wrote:
> On Tue, May 07, 2019 at 09:43:34AM +0200, Greg Kroah-Hartman wrote:
> > Given that any "new" android device that gets shipped "soon" should be
> > using 4.9.y or newer, is this a real issue?
> 
> It's certainly a real issue for those who can't buy brand new Android devices
> without software bugs every six months :)
> 
> > And if it is, I'm sure that asking for those patches to be backported to
> > 4.4.y would be just fine, have you asked?
> >
> > Note that I know of Android Go devices, running 3.18.y kernels, do NOT
> > use the in-kernel memory killer, but instead use the userspace solution
> > today.  So trying to get another in-kernel memory killer solution added
> > anywhere seems quite odd.
> 
> It's even more odd that although a userspace solution is touted as the proper
> way to go on LKML, almost no Android OEMs are using it, and even in that commit

That's probably because without proper kernel changes this is rather
tricky to use safely (see below).

> I linked in the previous message, Google made a rather large set of
> modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
> What's going on?
> 
> Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845. If PSI were
> backported to 4.4, or even 3.18, would it really be used? I don't really
> understand the aversion to an in-kernel memory killer on LKML despite the rest
> of the industry's attraction to it. Perhaps there's some inherently great cost
> in using the userspace solution that I'm unaware of?
> 
> Regardless, even if PSI were backported, a full-fledged LMKD using it has yet to
> be made, so it wouldn't be of much use now.

This is work that is ongoing and requires kernel changes to make it
feasible. One of the things that I have been working on for quite a
while is the whole file descriptor for processes thing that is important
for LMKD (Even though I never thought about this use-case when I started
pitching this.). Joel and Daniel have joined in and are working on
making LMKD possible.
What I find odd is that every couple of weeks different solutions to the
low memory problem are pitched. There is simple_lkml, there is LMKD, and
there was a patchset that wanted to speed up memory reclaim at process
kill-time by adding a new flag to the new pidfd_send_signal() syscall.
That all seems - though related - rather uncoordinated. Now granted,
coordinated is usually not how kernel development necessarily works but
it would probably be good to have some sort of direction and from what I
have seen LMKD seems to be the most coordinated effort. But that might
just be my impression.

Christian
