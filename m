Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA8D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qn6WJ4jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKKRwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:52:55 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:35160 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:52:55 -0500
Received: by mail-il1-f170.google.com with SMTP id z12so12892540ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxpQr+dia9IqKsQkLC2r2q0hxYEWq0JKYn0HyGqco2A=;
        b=Qn6WJ4jP6os+r/cocp+3Nn/6ERvGDTCL2cYO2coyzwnsqVszKRHYejKFAGmAONNudS
         UX/f/QXWhV9H5NNrMbP9IJJ27BAw03fQjE7nzELH/zFzpDiD7MIvjlQPYF5mvOiliSRf
         N68/rNZ3zUOwf4QIPQcl5SuWLe2/3/AJdtBQIA5ltKxAHdTXTWudwHsO6B50PMEslWTG
         z4UgMtSNJQ8SI3Ae3aA6TuwKgvDhfRhG2HHpdZn+YUkig33GV+USvCGQnLEuelgRXSSR
         CDUt3P36Iwu7ztcsMl+fodD5Gy97y+H6C8XgCQSe9/8BuozNct3mu3tdlyMr+oa/cUks
         TYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxpQr+dia9IqKsQkLC2r2q0hxYEWq0JKYn0HyGqco2A=;
        b=JMI561XCdk/ZkjOJZxQHiUp6djYFW/eWNl9b5xcWA3B4VIso/7kycv+yksNyvGzuhs
         OaOVK5vZyHeLaFbT1/LQxUR1fcshp3T7RHghQGN2SXt0TQyjvGPX8B2WTZrWBiJgWJAS
         qfb49oatxL3cfFmY8QkDcPquEGzqQF7kC7D1BJSO+QvWFgKiQGe1MrLXWhJOJYuli0RN
         JkRuODrVHIhGja8Egn+zoypGSHdJavawq6RA8O+bey+qH1k3mX8/09SAyrKMW8ecuy+d
         U9/NAKHyF8wIkzw/5CofOYH06X3jlyV7cFyS21utAxE07ml7UHkf8LMjqsH0h824Pzaf
         GyoQ==
X-Gm-Message-State: APjAAAXxbBVMyJQK21RNunbfLVbkyOCj8cQiQumXNXwI6wzhcUiGxlEX
        fc9vIj30Bpi8ELRRs0HobwdMCLTkKPZPQ1vv2zetlw==
X-Google-Smtp-Source: APXvYqy+kA2+IPweRX537l0eE3LzjXhIh4uaecrJhFmEYQk1GjPm4ev6+X67C7JTy6D4l8U2slZIa2mBm/ByZpvgLjE=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr30027628ilo.58.1573494773987;
 Mon, 11 Nov 2019 09:52:53 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org> <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
In-Reply-To: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 09:52:41 -0800
Message-ID: <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 8:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 7:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > I dislike the explicit annotation approach, because it shifts the
> > burden of proving correctness from the automatic verifier to the
> > programmer.
>
> Yes.
>
> However, sometimes explicit annotations are very useful as
> documentation and as showing of intent even if they might not change
> behavior or code generation.
>
> But they generally should never _replace_ checking - in fact, the
> annotations themselves should hopefully be checked for correctness
> too.
>
> So a good annotation would implicitly document intent, but it should
> also be something that we can check being true, so that we also have
> the check that reality actually _matches_ the intent too. Because
> misleading and wrong documentation is worse than no documentation at
> all.
>
> Side note: an example of a dangerous annotation is the one that Eric
> pointed out, where a 64-bit read in percpu_counter_read_positive()
> could be changed to READ_ONCE(), and we would compile it cleanly, but
> on 32-bit it wouldn't actually be atomic.
>
> We at one time tried to actually verify that READ/WRITE_ONCE() was
> done only on types that could actually be accessed atomically (always
> ignoring alpha because the pain is not worth it), but it showed too
> many problems.
>
> So now we silently accept things that aren't actually atomic. We do
> access them "once" in the sense that we don't allow the compiler to
> reload it, but it's not "once" in the LKMM sense of one single value.
>
> That's ok for some cases. But it's actually a horrid horrid thing from
> a documentation standpoint, and I hate it, and it's dangerous.
>
>                 Linus

I was hoping to cleanup the 'easy cases'  before looking at more serious issues.

But it looks like even the ' easy cases'  are not that easy.

Now I wonder what to do with the ~400 KCSAN reports sitting in
pre-moderation queue.
