Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDAAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A8214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfoMu5DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKKSbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:31:55 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:41097 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKKSbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:31:53 -0500
Received: by mail-il1-f175.google.com with SMTP id q15so7854353ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWOXc+EiqcU5H2TykGQZYDpiMbC9s1fYB+z2D6AtvNM=;
        b=YfoMu5DKYfsR0tNMI8Y6oXFEmrxVnNwbVT6yQu1skXYBRqdUK+d7Nz1mUfzIaTxEOf
         LN7BdAHu+145MTzjapQ3ETRZ2DsWujz6s49PeX89txZlGlrxWEtw0DYkzCiv1fyF7EBX
         C9jJEhk1XFJBTMSaHN0xFQwLnlDmvmb3QlngHaNvJ4CV7KZvZuO4ZWDl0yJdS19a+bz0
         di5KbzXTFInAXCvWA87tDfct+ajuxct9GV9v8mPKgsi37A7vwMlWHKWU61zEWgibEcQh
         AJvL2G5JpTXuM0LhmCOOhvBHJ7p+nA4+6IWpi7BPbKrUm5B6e6KNFKvu7PTC1isc691x
         /4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWOXc+EiqcU5H2TykGQZYDpiMbC9s1fYB+z2D6AtvNM=;
        b=N8AFf0k7UimqqpFKNpUJZ2ZJCLEygBaHK59zGLdQRPDGlzSGiIhtKA3hZrUQo1FFnW
         vuBLMQL6R7XC9foHMlNLX8VogmEGuxXzJYgd0zhKOzkUZVbNU7II0RcI28yVhIWjinTx
         uto0hzYAP+DCbHnk/O9rY9kSREClhb4P3omeoZf6E3rRJO61Ir6fRokszD6uYw+ejwhH
         hRIIzQHlK7ijgKG4fjG+FltXrDl537MdE0SAU3JaRGJ4RMImnKF9rx7VfuYyaRxF3b9K
         n7fALXmiovfeHKZUvuVV+mBg2W6OW2vQyeKWjQsHM40W2EmJkteJ7FUhhCVLMamaNOnI
         +jRQ==
X-Gm-Message-State: APjAAAVQi8CGEiqZ0FhrdtqKnCE66NHLOnFUJyV4YM4NHPbqkEDoNa+z
        wm3weZibJXrHyTvttele8UPGafuUElLrS4hGaeOpX2fS
X-Google-Smtp-Source: APXvYqzUEvYRTJe9cbdvlByvu6y7i8FNldZVzZrF5+/xcHTKkSFGpd6n+38fNwnltLonPBMO+6mWdvpiAX5UueUgUnI=
X-Received: by 2002:a92:99cb:: with SMTP id t72mr28744656ilk.218.1573497112535;
 Mon, 11 Nov 2019 10:31:52 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com> <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
In-Reply-To: <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 10:31:40 -0800
Message-ID: <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:05 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 9:52 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Now I wonder what to do with the ~400 KCSAN reports sitting in
> > pre-moderation queue.
>
> So regular KASAN reports are fairly easy to deal with: they report
> actual bugs. They may be hard to hit, but generally there's no
> question about something like a use-after-free or whatever.
>
> The problem with KCSAN is that it's not clear how many of the reports
> have been actual real honest-to-goodness bugs that could cause
> problems, and how many of them are "this isn't actually a bug, but an
> annotation will shut up KCSAN".
>
> My gut feeling would be that it would be best to ignore the ones that
> are "an annotation will shut up KCSAN", and look at the ones that are
> real bugs.
>
> Is there a pattern to those real bugs? Is there perhaps a way to make
> KCSAN notice _that_ pattern in particular, and suppress the ones that
> are "we can shut these up with annotations that don't really change
> the code"?
>
> I think it would be much better for the kernel - and much better for
> KCSAN - if the problem reports KCSAN reports are real problems that
> can actually be triggered as problems, and that it behaves much more
> like KASAN in that respect.
>
> Yes, yes, then once the *real* problems have been handled, maybe we
> can expand the search to be "stylistic issues" and "in theory, this
> could cause problems with a compiler that did X" issues.
>
> But I think the "just annotate" thing makes people more likely to
> dismiss KCSAN issues, and I don't think it's healthy.
>

Problem is that KASAN/KCSAN stops as soon as one issue is hit,
regardless of it being a false positive or not.

(Same happens with LOCKDEP seeing only one issue, then disabling itself)

If we do not annotate the false positive, the real issues might be
hidden for years.

There is no pattern really, only a lot of noise (small ' bugs'  that
have no real impact)
