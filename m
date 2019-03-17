Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB26C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2322082F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPRRBZOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCQRMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:12:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36772 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCQRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 13:12:01 -0400
Received: by mail-io1-f67.google.com with SMTP id f6so12335717iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKTGZirHvXg0mL+MZtw9VD2kXy5vdJTHvYOi+gvZfms=;
        b=LPRRBZOTdbgb760SZEI0rZV4xweT/LpWpZwk11UukjU2FsVlCs6U6ozMat1IvDhiuY
         +pCUQTD/gbdIYrVr8nYQfyw3U34/QDHSM43hvmYo6CDcisLo7aoVc65asks3fY6Tz4Ru
         taCHTBFg8l8AUISygnmDxTMjFNopbLNv1P6wzbXLpho2+0HnqMojiD+6oW3UOf8p120K
         SPqMGxL9SVqWu2TUUKhP9YuExsiEMRjjY7++QNUkzmydCbK5Uuih7FjnSzzcI4FUu/XE
         Mz91kpyt/V86VwJ/LTcGp531TRRBg3FaD+h0ikiHMX1kQZyhhdLW6OlckRm5EP6KBilU
         h/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKTGZirHvXg0mL+MZtw9VD2kXy5vdJTHvYOi+gvZfms=;
        b=aBxGYam/H5uo0a5s9C0LUvhxDMP6hG6tkEkIrAvGlVf5Q3MftIKwO+lghvWOoteu7+
         R9W7no2cx1e3wYMxmjA5VHjZd7xp7gY4w4/Wxn0jLJwnw0gDo8S65XCl+PIEVySyJrFd
         xd8riHTPgJiqMPzhpjVX+HeMnGw7FA0v0u9+RwjEfEzyk3g9IzbFP9KbkFWjBndvlLCv
         rJ0VMRyk7hvmklC44dVllWap9t9WeIDEKt9TliAQoJh2/1uonZLOtGKuVE7G3lYeS1L0
         PrRwKSBmmeWQat943hvjJxDWlAAIRDofSkrghB4diMBRAfPMsiMZYo3VZZLt8EbLkWhh
         5WTg==
X-Gm-Message-State: APjAAAUwpk8CBjyeNMwqHbYMekUsM6VyEsTE2mGRXygeJpFlb2RRgdAf
        reiQF7cQgpl0BmlmgMojCfFpdGuKwtXgNCIRueAk7g==
X-Google-Smtp-Source: APXvYqwWZaGM/h3nyiJeRVtdjOCOhbeq8JkuEQFehkCEo24VY/6Lv12t4pEPrGKPoENsPHKHOm8zGSm605juz/X2Dgc=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr7534152ioa.282.1552842720774;
 Sun, 17 Mar 2019 10:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
 <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 17 Mar 2019 18:11:49 +0100
Message-ID: <CACT4Y+YOWaU8s90joeGB4G1oc-GxrQSDnjpuFOuE4eJd5FHK3g@mail.gmail.com>
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

On Sun, Mar 17, 2019 at 5:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 17, 2019 at 3:43 AM syzbot
> <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Feb 19 22:34:00 2017 +0000
>
> Heh. Yeah, I doubt it.
>
> It would probably be good if syzbot did some confidence testing before
> bisecting.
>
> Don't get me wrong, "git bisect" is absolutely wonderful and has done
> a ton to help us fix bugs, but bisection has one major downside: if
> the bug you are bisecting isn't 100% repeatable, the bisection will go
> off into the random weeds and give completely nonsensical results.
> They won't even be *close*. What makes bisection so powerful is also
> what makes it then completely random if there's even *one* mistaken
> bisection point.
>
> So it would probably be good to test each bisection point at least
> twice, and if they don't agree, report it as being unbisectable rather
> than give a random "this is what introduced the problem".
>
> Hmm?


Hi Linus,

Please see https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
it should answer all of your questions. It does 2 and more.
And in this case it seems to be working as intended bisecting it to a
release tag.
