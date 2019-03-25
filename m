Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A952C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9EE20693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553550324;
	bh=kB9igm/FCAW80YnJMskcdFGh4XZxwEvYpPqFQaP+aBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SoHMvpdUghitlTAQKeESe/66IDDWbvgCFimKuOlGHMxrYKtnlnu1SysJVRmhjNV/M
	 gGtvJY28G5sf/e3TDWjXtmtdP95sKps4fEr6UnejlNsKmj6JAFLmfob4liC+whyhbI
	 jbGjKrHLmrPeHWikRkqbItPY4OfOFh+JnHHouK+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfCYVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:45:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36554 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:45:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so7138637lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyrGMeVONhvfWoKfN08XEzZDL45w36KigWKOTw1mc3I=;
        b=Uz0aIzxx/3EgWDjsNP/gnfIPI2LVbLni/Kmq7pLXtN7Ip3sVQMgxHR3LDF4zfNwEbJ
         eOAKhAIb+QUbOmu4vwn04d+2RgFG7hT04bLNwtW22w9kkJKfQ46cFKG2SwvQnIOV1Xyf
         /homDzyLih6emk2h3yM48/WKn/oFK/YFsuKek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyrGMeVONhvfWoKfN08XEzZDL45w36KigWKOTw1mc3I=;
        b=iQe1BZ/RTTbX+zg1etI+1c3+Ni9bWPeIz0E/atdW2cdQL12n/Gr7CC1eyL2pKGVIdy
         DJmXtXMtZxTBWd+eFqF19F4KvoNlMTsd+HYZloBJlCPjpwv9nwVxBN3ExhFPDzWvDlj/
         b7tMBT/h7eKr7B44TfSbYWsHhnMRdfXPZRxvoQus49slZv0HhWFz8ipDBBP/Ss2mLnrQ
         KcHKfvr2CY/Lab/6xk5MHyPBH7B/p5u8EcZu5pbKpGGbz0JmX5T7YnH9g6EyYdKu6zBZ
         n8lAzLydKLXmx0BByFZXWbDGtEGJ8muauu3HcWWSqGtbch5D8uvkW1UkHDaTkw0PkAQD
         Rw3A==
X-Gm-Message-State: APjAAAVbgxru1mgyfVcdJExS2qFhk40L+K5DIPcvJ8nGDmtZ9d0SisGE
        vfakMy2dqodH2Ptv8oezWlK5WWt9faE=
X-Google-Smtp-Source: APXvYqzh8wIdxzsbqFY0DIhkTDTMHAy092DXE6ZC4N8VYjVpeqQAUvTiX6jOBPgacehlAp90GsiA+w==
X-Received: by 2002:a19:9209:: with SMTP id u9mr14256463lfd.71.1553550317937;
        Mon, 25 Mar 2019 14:45:17 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c7sm3931498lja.90.2019.03.25.14.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:45:16 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id l7so9249329ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:45:16 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4509575ljh.135.1553550316377;
 Mon, 25 Mar 2019 14:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com> <20190325211405.GP2217@ZenIV.linux.org.uk>
In-Reply-To: <20190325211405.GP2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 14:45:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
Message-ID: <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 2:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Maybe, but we really need to come up with sane documentation on the
> entire drop_inode/evict_inode/destroy_inode/rcu_destroy_inode
> group ;-/

Yeah.

I actually think the "destroy_inode/rcu_destroy_inode" part is the
simplest one to understand: it's just tearing down the inode, and the
RCU part is (obviously, as shown by this thread) somewhat subtle, but
at the same time not really all that hard to explain: "inodes that can
be looked up through RCU lookup need to be destroyed with RCU delay".

I think drop_inode->evict_inode is arguably the much more subtle
stuff. That's the "we're not destroying things, we're making decisions
about the state" kind of thing.

And we actually don't have any documentation at all for those two.
Well, there's the "porting" thing, but..

> And I want to understand the writeback-related issues
> in ocfs2 and f2fs - the current kludges in those smell fishy.

I'm assuming you're talking about exactly that drop_inode() kind of subtlety.

At least for ocfs2, the whole "rcu_destroy_inode()" patch I sent out
would simplify things a lot. *All* that the ocfs2_destroy_inode()
function does is to schedule the inode freeing for RCU delay.

Assuming my patch is fine (as mentioned, it was entirely untested),
that patch would actually simplify that a lot. Get rid of
ocfs2_destroy_inode() entirely, and just make
ocfs2_rcu_destroy_inode() do that kmem_cache_free(). Mucho clean-up
(we have that ocfs2_rcu_destroy_inode() currently as
ocfs2_i_callback(), but with the ugly rcu-head interface).

> >       if (unlikely(inode_init_always(sb, inode))) {
> > -             if (inode->i_sb->s_op->destroy_inode)
> > +             if (inode->i_sb->s_op->destroy_inode) {
> >                       inode->i_sb->s_op->destroy_inode(inode);
> > -             else
> > +                     if (!inode->i_sb->s_op->rcu_destroy_inode)
> > +                             return NULL;
> > +             }
> > +             if (!inode->i_sb->s_op->rcu_destroy_inode ||
> > +                 !inode->i_sb->s_op->rcu_destroy_inode(inode))
> >                       kmem_cache_free(inode_cachep, inode);
>
> ITYM  i_callback(inode); here, possibly suitably renamed.

Yeah, I guess we could just call that i_callback() directly. I wrote
it that way because it was how the code was organized (it didn't call
i_callback() before either), but yes, it woudl avoid some duplicate
code to do it that way.

And yes, at that point we'd probably want to rename it too.

On the whole, looking at a few filesystems, I really think that
'rcu_destroy_inode()" would simplify several of them.  That ocfs2 case
I already mentioned, but looking around the exact same is trye in
v9fs, vxfs, dlmfs, hostfs, bfs, coda, fatfs, isofs, minix, nfs,
openprom, proc, qnx4, qnx6, sysv, befs, adfs, affs, efs, ext2, f2fs,
gfs2, hfs, hfsplus, hpfs, jffs2, nilfs, reiserfs, romfs, squashfs)

And in other filesystems that actually *do* have a real
destroy_inode() that does other things too, they still want the rcu
delayed part as well (eg btrfs, ceph, fuse, hugetlbfs, afs, ecryptfs,
ext4, jfs, organgefs, ovl, ubifs).

In fact, every single filesystem I looked at (and I looked at most)
would be simplified by that patch.

And for some it would make it easier to fix bugs in the process (ie
bpf) because they don't currently have that rcu delay and they need
it.

So looking at all the existing users of destroy_inode(), I really do
think we should have that rcu_destroy_inode() callback. Because that

 3 files changed, 28 insertions(+), 6 deletions(-)

will allow quite a lot of lines to be removed from low-level
filesystems with all the call_rcu() and callback container_of(head,
struct inode, i_rcu) noise just going away.

But yes, it would be good to have more documentation fo the drop/evict
phase. As mentioned, I think the destroy phase is actually the easy
one, with the RCU part being the most complex one that this would
actually simplify.

                   Linus
