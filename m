Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271A2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90A820859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR84Z3nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE0Kyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:54:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42432 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0Kyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:54:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so11706354lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2n4gBNEt3oKhgRBGoBZWnyBBkiJxP3xEBbVU5SxBlY=;
        b=dR84Z3nuv3s5YOrQqiLB6Ix9wMQyT82iqcq3wrUTRa/kZxr+uBwRmuVxh7hx4Lj3FM
         KEhFHkxTmGv6Kam6nBU+3HqKorCFNvjw9OKzYn2VNr6iYG7Vd9fuyzf40YRt32xz2mSg
         bOlKoojrSHXP5UsyZ7jQAqUTsUqLpKSgzi5DR4/VRyJe0G/djkI1+RjUawiyvAvHZEv3
         3XP1nkgpkAxPkHG7+BRQVTg9/MdbHsZdjvMS8pi4eVrG7fJTgAEcOXKiSiV6YDPNq6jw
         6xUNJqhwJr+anTyRiB+gdR3lBXp1Y/etJgAXzlqqmzfgEdAxjIYaFfuQhg6wQqVmQwf3
         vXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2n4gBNEt3oKhgRBGoBZWnyBBkiJxP3xEBbVU5SxBlY=;
        b=gnAkhaXxUbFbmYFSXjLqTXc01TffCzh331d2HSTtVn6d21W7tZFUb9TEOZwHxQEuU3
         RzQWaI4bCoIWWgkTK4xVfoqi0WlDjvGcrI667h/9pWaqNjzFJ0BaxUAN0Tmp/OPSyFMF
         8ksEuDobjD+gTx2hof1K8gq9+GfKkvtyZjHk5QzOlbNIrfqInEAe5/HjnNIavAxW6Kdy
         iL62QDy7TRzp1o0KZwweO2qSVG7ywCy2mIzMt3P7/1+ZTgD/gGRk29icZFjr+/JN20bI
         IT/uqPZDWiMJO1bNzW5A6BG6Bgwp2D5lEPMvRGMn0QLqetb318rIaOh0L/dbIMf/WaTT
         4RLQ==
X-Gm-Message-State: APjAAAV/oNEeutnI7acJBWNIgziL8+1G97ngpDalg9bYpSh9SwZqCDRk
        WpslEPMdFcB+5i6PX3soEYcZzbsyBDb7kdZ0HEY=
X-Google-Smtp-Source: APXvYqxlu5SnIBVa0aUlRiEJtdFyNmXZap0vDJRssM/5GGdUmvTYcWWazIPXEdPkaGYaXb7kqt5b4zLGBxOPmONRBqE=
X-Received: by 2002:a19:9e46:: with SMTP id h67mr8374590lfe.120.1558954475111;
 Mon, 27 May 2019 03:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190524174918.71074b358001bdbf1c23cd77@gmail.com> <20190525150948.e1ff1a2a894ca8110abc8183@linux-foundation.org>
In-Reply-To: <20190525150948.e1ff1a2a894ca8110abc8183@linux-foundation.org>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Mon, 27 May 2019 12:54:23 +0200
Message-ID: <CAMJBoFNXVc3BBdEOsKTSHO51reHL93GPQNO4Tjkx+OaDcpb22g@mail.gmail.com>
Subject: Re: [PATCH] z3fold: add inter-page compaction
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Oleksiy.Avramchenko@sony.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 12:09 AM Andrew Morton
<akpm@linux-foundation.org> wrote:

<snip>
> Forward-declaring inline functions is peculiar, but it does appear to work.
>
> z3fold is quite inline-happy.  Fortunately the compiler will ignore the
> inline hint if it seems a bad idea.  Even then, the below shrinks
> z3fold.o text from 30k to 27k.  Which might even make it faster....

It is faster with inlines, I'll try to find a better balance between
size and performance in the next version of the patch though.

<snip>
> >
> > ...
> >
> > +static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
> > +                                                     bool lock)
> > +{
> > +     struct z3fold_buddy_slots *slots;
> > +     struct z3fold_header *zhdr;
> > +     unsigned int seq;
> > +     bool is_valid;
> > +
> > +     if (!(handle & (1 << PAGE_HEADLESS))) {
> > +             slots = handle_to_slots(handle);
> > +             do {
> > +                     unsigned long addr;
> > +
> > +                     seq = read_seqbegin(&slots->seqlock);
> > +                     addr = *(unsigned long *)handle;
> > +                     zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
> > +                     preempt_disable();
>
> Why is this done?
>
> > +                     is_valid = !read_seqretry(&slots->seqlock, seq);
> > +                     if (!is_valid) {
> > +                             preempt_enable();
> > +                             continue;
> > +                     }
> > +                     /*
> > +                      * if we are here, zhdr is a pointer to a valid z3fold
> > +                      * header. Lock it! And then re-check if someone has
> > +                      * changed which z3fold page this handle points to
> > +                      */
> > +                     if (lock)
> > +                             z3fold_page_lock(zhdr);
> > +                     preempt_enable();
> > +                     /*
> > +                      * we use is_valid as a "cached" value: if it's false,
> > +                      * no other checks needed, have to go one more round
> > +                      */
> > +             } while (!is_valid || (read_seqretry(&slots->seqlock, seq) &&
> > +                     (lock ? ({ z3fold_page_unlock(zhdr); 1; }) : 1)));
> > +     } else {
> > +             zhdr = (struct z3fold_header *)(handle & PAGE_MASK);
> > +     }
> > +
> > +     return zhdr;
> > +}
> >
> > ...
> >
> >  static unsigned short handle_to_chunks(unsigned long handle)
> >  {
> > -     unsigned long addr = *(unsigned long *)handle;
> > +     unsigned long addr;
> > +     struct z3fold_buddy_slots *slots = handle_to_slots(handle);
> > +     unsigned int seq;
> > +
> > +     do {
> > +             seq = read_seqbegin(&slots->seqlock);
> > +             addr = *(unsigned long *)handle;
> > +     } while (read_seqretry(&slots->seqlock, seq));
>
> It isn't done here (I think).

handle_to_chunks() is always called with z3fold header locked which
makes it a lot easier in this case. I'll add some comments in V2.

Thanks,
   Vitaly
