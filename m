Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C562FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA7206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKMVus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:50:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41778 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726979AbfKMVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:50:48 -0500
Received: (qmail 5977 invoked by uid 2102); 13 Nov 2019 16:50:47 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Nov 2019 16:50:47 -0500
Date:   Wed, 13 Nov 2019 16:50:47 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Elver <elver@google.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
In-Reply-To: <20191113213336.GA20665@google.com>
Message-ID: <Pine.LNX.4.44L0.1911131648010.1558-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Marco Elver wrote:

> An expression works fine. The below patch would work with KCSAN, and all
> your above examples work.
> 
> Re name: would it make sense to more directly convey the intent?  I.e.
> "this expression can race, and it's fine that the result is approximate
> if it does"?
> 
> My vote would go to something like 'smp_lossy' or 'lossy_race' -- but
> don't have a strong preference, and would also be fine with 'data_race'.
> Whatever is most legible.  Comments?

Lossiness isn't really relevant.  Things like sticky writes work 
perfectly well with data races; they don't lose anything.

My preference would be for "data_race" or something very similar
("racy"? "race_ok"?).  That's the whole point -- we know the
operation can be part of a data race and we don't care.

Alan Stern

