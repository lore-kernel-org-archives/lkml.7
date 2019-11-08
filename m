Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD720C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE7E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEfiZj/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfKHRWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:22:54 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:34929 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:22:54 -0500
Received: by mail-il1-f175.google.com with SMTP id z12so5812828ilp.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCFuBzX0ssMEDdf5FEm7iYvhAqHfXgR1VUvfj9lOe/w=;
        b=CEfiZj/bsHwWAjk9E2+anUgIMAxbVSUOX+XJF2bZ0OcF0BZenHgQ0u67RQKxsSJVvO
         cg6auRE4K1Dd46AV9IDjw+fBDqbhIOvgtZ+xWLJSCCu7ESdlYcccDwf50l/5fKpJ98SU
         qu2KR81c1yXgqEMCFodWqnFqZnWA1GSDihhSmrcE97ct41ooi829D6bwXP4yixBHxOPR
         82Q1s9H/qJ44YK+ZDn1u9LMEaIEj2yNDLFqsg5PTSK9is2D2nmxrN7ZlqJUqvN89jCDH
         Z6dtGmWJoisrj5v4yiRnDtrVjKHAtkPbjKMzgkdxrde76DY/9Tx2bxjqD4hsArlMj+q+
         6A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCFuBzX0ssMEDdf5FEm7iYvhAqHfXgR1VUvfj9lOe/w=;
        b=AkPvyJfdoyrzeZF0a//SM5/n2DDGIwFUFD+fEewbSV/cP6cQIuREX1Hrf6w24zNt+g
         tmFneTHsq7+kXlekFUVPrs+v3CFpft60PIQO1QJGa891TVBAsi6AzC5vQ/Ko2P87uQzw
         syml8P/WQQMSsugXjRkwPeS7PnNgxn23FF7izDTjh9tONi+6lw1AcNTj0Blx1OSdCfF2
         iktSS2DoAH9Tvb02tPFFiGwxDm4C9vHu/vtzAejh79QIQ2pR16TLD0j7AaeHkVRYOfM+
         2qFcUWx7hdJsnbexLgzqtNtuST91m05tAjD4z2bwcUsxR1s2L7ToJCcjPiAo8ox4Dmol
         bFUA==
X-Gm-Message-State: APjAAAWqSLFVI+PagyUVd0eLbQqCwzNnRzN6JTD3OZzV/HdCDdbCAnPs
        kd1JuMxuBpRTRMrVr7oIp/5mtl1du9vjtYPPOfyqtw==
X-Google-Smtp-Source: APXvYqzUhTWVQWwZl8pu4w3UpG3z5Kvyp3soCrK0nJh9KxmLxN13e63bMlw9t1jl9c/rHz3FMSCFcELVM2qH6Nh1RWI=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr14651612ilc.168.1573233772737;
 Fri, 08 Nov 2019 09:22:52 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
In-Reply-To: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:22:41 -0800
Message-ID: <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 8, 2019 at 5:28 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > Linus, what do you think of the following fix ?
>
> I think it's incredibly ugly.
>
> I realize that avoiding the cacheline dirtying might be worth it, but
> I'd like to see some indication that it actually matters and helps
> from a performance angle. We've already dirtied memory fairly close,
> even if it might not share a cacheline (that structure is randomized,
> we've touched - or will touch - 'cred->usage') too.
>
> Honestly, I don't think get_cred() is even in a hotpath. Most cred use
> just use the current cred that doesn't need the 'get'. So the
> optimization looks somewhat questionable - for all we know it just
> makes things worse.
>
> I also don't like using a "WRITE_ONCE()" without a reason for it. In
> this case, the only "reason" is that KCSAN special-cases that thing.
> I'd much rather have some other way to mark it.
>
> So it just looks hacky to me.
>
> I like that people are looking at KCSAN, but I get a very strong
> feeling that right now the workarounds for KCSAN false-positives are
> incredibly ugly, and not always appropriate.
>
> There is absolutely zero need for a WRITE_ONCE() in this case. The
> code would work fine if the compiler did the zero write fifty times,
> and re-ordered it wildly. We have a flag that starts out set, and we
> clear it.  There's really no "write-once" about it.
>

Ok, so what do you suggest next ?

Declare KCSAN useless because too many false positives ?
