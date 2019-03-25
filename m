Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319BD20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538984;
	bh=NqaxeCG/ea9mYyDAC8FJpmTxF3UoHbqMgex0e27no8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BB61eIPfwKKA//qvWDW7pGCTBW6pEHwVO5u2LOGTjteDhzAI051W1fK+sLuFjJEuI
	 okSdRkj3u2unJwgtY3lwNxaGftMwMwjCR2e3h6maKbuBO5ubv5hmy/IkM/V8P6HUv+
	 TUywKh5a4qHaEKlwZKUBjfQgCzjdqQEXEHQxWqeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfCYSgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:36:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43866 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:36:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id g7so6759051lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6DQwypKBF9dmZfO6NUbZVbQzYYRpNxMxq/Erl2LSG0=;
        b=Luq5lMPb36/UOaaU524GIkqOJtb3MkAtb6ICJJrE/S6b+FWifjwXG7ZmnKqyUF6iqJ
         XcK4gq6S+9rOTRrMD9nLNgcwXC+YqPzDC3/0H8l827Y4nSmPPcaivxCvOC5GytPC7NSh
         4BYkUJrSxOqEgHLEmjkKKiJTVkDjA+HQyuymc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6DQwypKBF9dmZfO6NUbZVbQzYYRpNxMxq/Erl2LSG0=;
        b=HPbnIaFlN6snHKYnzrWrukyz3vDsNiIB1V7ZzI7CwA8ZO74QhkPQcBzdKREF/Zs8ju
         tp4khjVjhGkvDcxXC5CbY1sZml/ad7QQ6MjaegjKk3vNsGc49MMO4ry7aKAdvrC2nLxh
         FX0Me6ko+nV3eMMZn4Cno/KPNL/T1D8jWBr63EQbd48Mn3ROh5rv8HsMR3Dy/HSXuift
         e6yqRVFqEIjliGP31ODIFmqUwFt0YRAib4LRIJEf328f/kO3oGvrxa7MiNLigs84Zsu4
         22bBiYgojbvjGKIdvJSXHFCsmJ7+c5bt42TGNJGr4MDRuEZdPidLwzSZyiDcY9uFv21G
         Vmuw==
X-Gm-Message-State: APjAAAV0sL24xSH47YLPR3HwfJ3e6I6utz90l0mXck4YKZCaQXEbCyyN
        J1sPqlHJrHB6HkBqgbUHPNCHYGjdZdw=
X-Google-Smtp-Source: APXvYqyO3yjGrteDlEImfzK7Z1i/0ek50eskBvWP/QscFJuDTECtIVMkFthihvVQqB0QmiF4rn5PSg==
X-Received: by 2002:a19:d144:: with SMTP id i65mr11894354lfg.52.1553538978662;
        Mon, 25 Mar 2019 11:36:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l4sm3164766lfp.29.2019.03.25.11.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:36:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f23so8820961ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:36:17 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr14073990ljg.2.1553538977022;
 Mon, 25 Mar 2019 11:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
In-Reply-To: <20190325045744.GK2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 11:36:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
Message-ID: <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 9:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So we have 5 broken cases, all with the same kind of fix: move freeing
> into the RCU-delayed part of ->destroy_inode(); for debugfs and bpf
> that requires adding ->alloc_inode()/->destroy_inode(), rather than
> relying upon the defaults from fs/inode.c

The fact that we had five different broken filesystems does imply that
we should just make this much easier at the VFS layer instead of
forcing filesystems to cope with a bad interface.

> > Or maybe we could add a final inode callback function for "rcu_free"
> > that is called as the RCU-delayed freeing of the inode itself happens?
> > And then people could hook into that for freeing the inode->i_link
> > data.
>
> You mean, split ->destroy_inode() into immediate and RCU-delayed parts?
> There are filesystems where both parts are non-empty - we can't just
> switch all ->destroy_inode() work to call_rcu().

Right. Not just move the existing destroy_inode() - because as you
say, people may not be able to to do that in RCU contect, but split it
up, and add a "final_free_inode()" callback or something for the RCU
phase.

In fact, I suspect that *every* user of destroy_inode() already has to
have its own RCU callback to another final freeing function anyway.
Because they really shouldn't free the inode itself early. Maybe we
can just make that be a generic thing?

And no, it's not like the patch to the bpf filesystem looks
_horrible_, but I think the fact that the low-level filesystem needed
to do its own RCU-deferred thing (even if it wasn't doing any RCU on
its own, although bpf obviously has that in other areas) is kind of
wrong, and shows that our vfs interfaces are a bit awkward. Plus it's
not like it was just bpf that got this wrong.

It's also somewhat silly to add _another_ RCU callback when we already
have one for the inode.

                  Linus
