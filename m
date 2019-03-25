Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E677C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F9F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553477028;
	bh=QLE/muGLqp4ExMEy7KCJ6i4T1iu323BEk1k+JhCCWGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LyXYhjBDNKt+TOJGqPf+0PEJ/bMUYB4w9LcCznm+VT1/oKi+ECKcIxas5Pv44KY6t
	 kcBLUPlhugiSw8qp7Kgxv83jKPKKWJG9w+Km0t21Rp/C2tERSslFypr+aZwBdnQCiG
	 oUsicSMH12TgZ4lAe4cq2drjylV1J1tl6zPIYtmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCYBXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:23:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45299 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfCYBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:23:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so6284561ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wf9yYyFx5XQycNPtTrNCRc9C90M0oW6GSIu1pC1YItI=;
        b=e7jdEUyW3sYQ481V5uCwd0nHFZrOLlPdAmWu2ViiO7nkllP8t8muZrXYkTqJzUTTJX
         EXfrZiDE/2CbKNS/1W1CU56XDBYV7+t0NaQJ6K02ZTiWYXa/JgAXwDv+5p2oSIBgzKfr
         3HSdu1dDi/ZMK7h69Ghn4ZtJ37EaKRqtoYQ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wf9yYyFx5XQycNPtTrNCRc9C90M0oW6GSIu1pC1YItI=;
        b=fLC40H6+zF5lNhxeOYqoWo+6H04L3I8gB4JGDPRUz3nBz86w6pEX2OapY5y58uLceO
         XV/eb5FcC4DCPcHz0l9eBFm4yyP/egxuIheZPaaK+IEXXhBarUTUBKfS6iKw2OpbxEMr
         mj2blcfnE8RbTCmq15vPV57eKhWReAgAqLXE6B/nocDdjlCsEP8Nv9rSuIBRKp8ZAzoH
         7U3UkKcElr+4aU2S7ONHc30LMvCWzndB5zDv0jDyKEgfSzefZ8Zb+W2KTVjryPAARpkL
         WBoznoQ6UHYIKWPuKFL0AotCEuonloG70YEkO7zDvWGWm0imi1C4Oc3ejNiIhtEwzsEc
         w9Xw==
X-Gm-Message-State: APjAAAWLrwRLGNV522aYjOIg4u8JOO0EVvJ73cwr74kUtzBu2S8eg1b+
        EHVgr/6FNZwOLhdcNxN95BBL3hQLQeI=
X-Google-Smtp-Source: APXvYqz1M7x+pEX4CdBEisxCB3TLJFjMLnBhOB+qPspxRgYWGKKqMMc4p7WZC4YsnSEiiGSUZctnTQ==
X-Received: by 2002:a2e:1510:: with SMTP id s16mr11481023ljd.62.1553477022453;
        Sun, 24 Mar 2019 18:23:42 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t18sm3072356ljg.64.2019.03.24.18.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 18:23:41 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h16so1821567ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:23:40 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr2863776lji.94.1553477020489;
 Sun, 24 Mar 2019 18:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com>
In-Reply-To: <0000000000006946d2057bbd0eef@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 18:23:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
Message-ID: <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

Al, this one seems real and also seems pretty nasty from a vfs
interface standpoint.

On Wed, Nov 28, 2018 at 9:40 AM syzbot
<syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com> wrote:
>
> BUG: KASAN: use-after-free in lookup_last fs/namei.c:2269 [inline]
> BUG: KASAN: use-after-free in path_lookupat.isra.43+0x9f8/0xc00  fs/namei.c:2318
> ...
>   lookup_last fs/namei.c:2269 [inline]
>   path_lookupat.isra.43+0x9f8/0xc00 fs/namei.c:2318

Ok, path lookup using RCU.

> Allocated by task 9424:
>   kstrdup+0x39/0x70 mm/util.c:49
>   bpf_symlink+0x26/0x140 kernel/bpf/inode.c:356

It's the symlink data for the bpf filesystem. Fair enough.

> Freed by task 9425:
>   kfree+0xcf/0x230 mm/slab.c:3817
>   bpf_evict_inode+0x11f/0x150 kernel/bpf/inode.c:565
>   evict+0x4b9/0x980 fs/inode.c:558
>   iput_final fs/inode.c:1550 [inline]
>   iput+0x674/0xa90 fs/inode.c:1576
>   do_unlinkat+0x733/0xa30 fs/namei.c:4069

.. and the path lookup is racing with the final unlink.

We actually RCU-delay the inode freeing itself, but when we do the
final iput(), the "evict()" function is called synchronously.

Now, the simple fix would seem to just RCU-delay the kfree() of the
symlink data in bpf_evict_inode(). Maybe that's the right thing to do.
I'd call it trivial, except you'd need to have that rcu head to attach
it to, making it slightly less trivial. I guess the kmalloc could just
malloc that too.

But it does strike me that this might be a generic issue. I wonder how
many other filesystems do this?

Alexei, Daniel - the "proper" fix right is probably one of four cases:

 (a) rcu-delay the freeing, and use simple_symlink_inode_operations().
No set_delayed_call() needed, because it stays around for the inode
lifetime, but the RCU-delaying is still needed for lookup.

or

 (b) put the symlink in a page, and use page_symlink_inode_operations
for that inode, where we have a "struct delayed_call" and get a page
ref

or

 (c) put the symlink in the inode itself, and then use that
simple_symlink_inode_operations (and now the RCU-delaying of the inode
protects it).

of

 (d) make a special getlink() that does "copy symlink,
set_delayed_call(done, kfree_link, copy)"

but I do wonder if we should perhaps just make
simple_symlink_inode_operations do that (d) case for people.

Al, comments? At the very least, if we don't make
simple_symlink_inode_operations() do that, we should have a *big*
comment that if it's not part of the inode data, it needs to be
RCU-delayed.

Or maybe we could add a final inode callback function for "rcu_free"
that is called as the RCU-delayed freeing of the inode itself happens?
And then people could hook into that for freeing the inode->i_link
data.

So many choices.. But the current situation seems unnecessarily
complex for the filesystem, and isn't really documented.

Our documentation currently says for get_link(): "If the body won't go
away until the inode is gone, nothing else is needed", which is wrong
(or at least very misleading, since the last "inode is gone" callback
we have is that evict() function).

               Linus
