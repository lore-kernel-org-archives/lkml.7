Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E932CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2E21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPnwnv3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:07:17 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:44679 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:07:17 -0500
Received: by mail-il1-f177.google.com with SMTP id i6so17025843ilr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qmNJU/8i/AHYRLowbaJaGkE1pf99MU0Fm8e4I+JI0Y=;
        b=pPnwnv3YVdwiRnyPsDGGxdNvbSgcWNX7wPpXt/1YuUKOFpcsyzF+WY/N6zbmiBuWCE
         45mXuAF6aLBdDLTPAn9VLVo5qJ40hrv42lGyfc4U1pGIO2wmfn6VpeJAnY/zcVU4mh+s
         mVGzvDdnXYJMAN4lyDvpB1ni02yC9OzpwxbNGlWGHtQwZCQxxQzuDJTWnRu4jSj8xpX+
         eYqE+nGqB7r0lPY92UjTJylbr4yCBrlvlCMLaeqQ1Bs/sNeYkpRGlSU/L9qjVJRNd1Vl
         tsctlaHmh3RBbi8470QUu6ain1HAbYJkpMSf0v11tOj4wuXgcPrytSEYSa6w+iLzd+I8
         155w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qmNJU/8i/AHYRLowbaJaGkE1pf99MU0Fm8e4I+JI0Y=;
        b=kvmNP0Q+P/T1KqAlIWq/SpAH7HHnPb731TGG5o6qY3Cxxg7eZkXF9pt1IZmx1Ns0Rj
         axv7Eq0EdlZLo8HlU/yWzo7S+kQr7CR+psOeePyOXCPUSGoBE33eV+7T7jV9dGTrRJ/P
         YxMTdonm+ZPxxIHUIr6FEnbok33tJvnsubfKZN6N9j6cd/l3ZMmkvKUyUecH0WCFLCXV
         iF6QqnPbD71e9vA2yvLuHvSdhQfqTokjea+SLES361ATJ9en0kT6aoqtgLv/jQGXL2au
         2pit10kvFDoUgxTZ1CDv2yoOdGWenXpGPTV4rydzXsbDOs7+OJc9syTRoRD1cigXQHg1
         WI4w==
X-Gm-Message-State: APjAAAVieL0c0KH6FhRHD8Ck3BPvH4sa+L8m/DfBeFP93VDvadgcbD+7
        h1hin49DkmmxVI8Ryj5/1Mc1rnA+fj9CQ1qE86NQcA==
X-Google-Smtp-Source: APXvYqxP+SnV7PqhNBfIq1DNYMyiVSRBSDKNK0aTCIV13r9reLWBhYfhiGi6YhCfHr0TFuoHOEhWz9ojzXoZnHrDox8=
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr147642ili.269.1573596435824;
 Tue, 12 Nov 2019 14:07:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Nov 2019 14:07:03 -0800
Message-ID: <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tue, Nov 12, 2019 at 1:48 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 12 Nov 2019, Linus Torvalds wrote:
>
> > Honestly, my preferred model would have been to just add a comment,
> > and have the reporting tool know to then just ignore it. So something
> > like
> >
> > +               // Benign data-race on min_flt
> >                 tsk->min_flt++;
> >                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
> >
> > for the case that Eric mentioned - the tool would trigger on
> > "data-race", and the rest of the comment could/should be for humans.
> > Without making the code uglier, but giving the potential for a nice
> > leghibl.e explanation instead of a completely illegible "let's
> > randomly use WRITE_ONCE() here" or something like that.
>
> Just to be perfectly clear, then:
>
> Your feeling is that we don't need to tell the compiler anything at all
> about these races, because if a compiler generates code that is
> non-robust against such things then you don't want to use it for the
> kernel.
>

I would prefer some kind of explicit marking, instead of a comment.

Even if we prefer having a sane compiler, having these clearly
annotated can help
code readability quite a lot.

/*
 * To use when we are ok with minor races... bla bla bla
 */
static void inline add_relaxed(int *p, int x)
{
    x += __atomic_load_n(p, __ATOMIC_RELAXED);
    __atomic_store_n(p, x, __ATOMIC_RELAXED);
}

The actual implementation might depend on the compiler, and revert to something
without any constraint for old compilers  : *p += x;
