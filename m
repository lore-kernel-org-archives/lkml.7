Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4774FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A57215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfKHV5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:57:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57314 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726294AbfKHV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:57:32 -0500
Received: (qmail 7041 invoked by uid 2102); 8 Nov 2019 16:57:31 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Nov 2019 16:57:31 -0500
Date:   Fri, 8 Nov 2019 16:57:31 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
In-Reply-To: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911081649030.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Linus Torvalds wrote:

> On Fri, Nov 8, 2019 at 11:48 AM Marco Elver <elver@google.com> wrote:
> >
> > It's not explicitly aware of initialization or release. We rely on
> > compiler instrumentation for all memory accesses; KCSAN then sets up
> > "watchpoints" for sampled memory accesses, delaying execution, and
> > checking if a concurrent access is observed.
> 
> Ok.
> 
> > This same approach could be used to ignore "idempotent writes" where
> > we would otherwise report a data race; i.e. if there was a concurrent
> > write, but the data value did not change, do not report the race. I'm
> > happy to add this feature if this should always be ignored.
> 
> Hmm. I don't think it's valid in general, but it might be useful
> enough in practice, at least as an option to lower the false
> positives.

Minor point...

Can we please agree to call these writes something other than 
"idempotent"?  After all, any write to normal memory is idempotent in 
the sense that doing it twice has the same effect as doing it once 
(ignoring possible races, of course).

A better name would be "write-if-different" or "write-if-changed" (and
I bet people can come up with something even better if they try).  
This at least gets across the main idea, and using

	WRITE_IF_CHANGED(x, y);

to mean

	if (READ_ONCE(x) != y) WRITE_ONCE(x, y);

is a lot clearer than using WRITE_IDEMPOTENT(x, y).

Alan Stern

