Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE04C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15529206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIcHMZmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCSN1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:27:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34390 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfCSN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:27:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so16598649edn.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DV0m7h5/PNeL/JGSwpuui2eZRt9q4waJX97/UQLPA54=;
        b=QIcHMZmLLOrIuE2f1YPYoaM6TtSO7WxdG57UrK3jgdH1kwOerfrvsfkcKTPtll5AEG
         WqNYfy/OzmWzbiOaPIh/9sDDoduyMr8TpHfkrIFdAxlHMGhxWI74OtMUeXGt7JkQfOze
         5Ynh1Rn2IJUhMpVBbESrPTgo4iRHGZrc9LLXLEDi1/UZYKwLJ5SO+fX5dqPH21SROmW+
         Ya2s1Oc+Z2vfqoOOzMG+/it5ys6K0w3Gz4WZr3+UvkM3Hglc7PKvj3U6jhtJc1BUCtVB
         g8hn6JfVjA55ObW57nmKHzJbIfafFmQgqClzcvyFDSGKIiEPaXvFZWdoWVZFZTqZycT9
         zfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DV0m7h5/PNeL/JGSwpuui2eZRt9q4waJX97/UQLPA54=;
        b=WFB/CEtwI7F4iBE/jzFeRphvz/hqL+GEW8GxokOE1L7HLG4jk3lmM0sZFVn8lCx6Mb
         fDsB5XNKKinyaM9xvRkZxdMGtVdfpHoycvcKiIfzDJhAZhsVsVOGHHbg2DZDBXc5XYTZ
         MDpXC9BBAZPQtItjP7JzDaP/habFU9UfJxX4ZLeMiroAKg7NQotIa8GIU0CfTsR6PB5x
         7xqLp9uw5dUstMJUJz2zPGI+tmY6p08ViU6yAIKflfILc+Tzg/qUf6paakfj9OxZEv7p
         /J+v1I7ekniwgzrrHZAWgXU/qIJWkOXnQtwwo6vGEer1KDHB/xjGXp9ke0tVRZ/w0bQU
         SDmw==
X-Gm-Message-State: APjAAAWtgRU+Smfpy1IE/F3WMEeXbru+QnRztvqIFcXWYk7jnieRgSp0
        heF74onF8C2b74P0osbt5QakO8tAvU0b5MnDwVvpVw==
X-Google-Smtp-Source: APXvYqyNj+wpFuaShdJcPSIxiz+qa8J4xrpqT/EpWtRzwlIVNbQsDiXrI++4U3CBuzOqk/QGB8fN6tU00Gpj58ZAKvM=
X-Received: by 2002:a17:906:482:: with SMTP id f2mr14215480eja.68.1553002065716;
 Tue, 19 Mar 2019 06:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
 <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
 <CACT4Y+YOWaU8s90joeGB4G1oc-GxrQSDnjpuFOuE4eJd5FHK3g@mail.gmail.com> <CAHk-=wj_+ObTogs75N++EigJ5RPpu8GL2ma0jasgJxG+t3oPPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj_+ObTogs75N++EigJ5RPpu8GL2ma0jasgJxG+t3oPPQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Mar 2019 14:27:32 +0100
Message-ID: <CACT4Y+ZA4L-x6cZWV6ZaG-2Z-V4MB9PkBQ1gfCCv5Qu=FFejFQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 9:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 17, 2019 at 10:12 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Please see https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
> > it should answer all of your questions. It does 2 and more.
> > And in this case it seems to be working as intended bisecting it to a
> > release tag.
>
> No, it's definitely not working as intended.
>
> You can see it in the bisect log - you don't actually have a single
> "git bisect bad" outside of the initial one that you start bisecting
> with. That's a pretty good sign of bisection being completely broken.
> Yes, it can happen in theory, but in general with a good bisection,
> you should see about as many "good" results as "bad".
>
> I bet that what's going on is that your initial "let's test every
> release" uses a _different_ process than the actual bisection itself
> does.
>
> So if I were you, I'd look at what syzbot does differently during
> bisection vs what it does for that initial "test each release". For
> example, does it do "make clean" in between each build in one case,
> but not the other? Does it do "make oldconfig" vs a fixed config
> generated from scratch every time? Because the fact that you first
> tested 4.10 bad using the "test each release", and then when you do
> bisection, the very commit *before* 4.10 is good (the only difference
> being the EXTRAVERSION and the tag) shows that something went wrong.


Well, this is intended behavior for some definition of intended.
The root cause of what happened here is that syzbot has to disable
CONFIG_USBIP_VHCI_HCD/CONFIG_BT_HCIVHCI when it crosses v4.10
boundary. It fixes boot on the release and otherwise no bisection will
succeed at all.
It's just happened so that this particular bug is dependent on these
exact configs and was introduced before v4.10. So it was bisected to
v4.10. And in this sense it is working as intended.

How would you define intended bisection behavior for the situation
when kernel is build/boot/test broken most of the time, even on
releases and even on recent releases? ;)
I guess the 100% fair answer is "the bug happens as far as we could
test (which is not too far)". And that's what I did initially, but the
result was way less useful than what we have now.

This and other details of the process are described here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
This was the first attempt at giving more transparency into the process.

I see 2 potential improvements:
1. (simpler) noting in the bisection log things like disabled configs,
cherry-picked fixes and other things necessary to repair kernel.
2. (harder) try to figure out that the bug actually depends on the
disabled config
I've added this to https://github.com/google/syzkaller/issues/1051
But for (2) I would first like to see that this is a common enough
problem rather then a one-off thing, because it's easier to say than
to implement that reliably and this can affect bugs completely
unrelated to the disabled configs due to unavoidable kernel crash
flakes (and then somebody will need to explain what happened to all
people asking).

And obviously doing some real testing before merging each commit into
any kernel tree would help tremendously with bisection long term ;)

Even v5.0 is boot broken if I try to enable more configs. So we will
need to disable more configs in bisection in future as we onboard them
to syzbot. The current points in time we need to disable various
configs suspiciously resemble when they were added to syzbot config...
