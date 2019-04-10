Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0512075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iALlTgCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfDJI1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:27:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42561 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfDJI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:27:34 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so1344955ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EFYUc6OUPUODQebjyQkW2NWaIS/QyigdZFbzREV9Z8=;
        b=iALlTgCqIUSJWK/z1Qv6V1YWlow5lh/zf6YVgajh2cx1KHdDuu6BxUinHEezM7xjaL
         Vd5+7q05wDwyAvNbN+6Qgqvkn/aBBlV5h0LLVhqtLJTwFU9exQeIcGM3GqzzazZ91hJn
         DBcu0h5/GyU4x7Br/BEi5H+ovNrrfJirRggybWqDIQ0p/WxahgnYxxw8SYyaDW3vAyUT
         oGhbETxQzYGgGKZHeUE+GX7zLk7UgXdCSuIT7GwhguUVuPA1gmgWqzPRbr1iCqgvbgnt
         T/osAbJ4CaS1+SE5CXZBprTshnHFnAXJDEO3HTPf0Saek39zUK/HjmNOcB44ZdG9AZ1x
         sVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EFYUc6OUPUODQebjyQkW2NWaIS/QyigdZFbzREV9Z8=;
        b=ikjUYNz+G6iV9xwChN9CFFyTZmd0kAtAxbf5v2g97cpGD9zFnQz7bDPKSsUiF+hzYt
         Upu5+wdLqnbRYfibwpsnGD3OCAF0O24TVKbUiVswqhf5dr95Kxlq2rVL4bXAL8x1LtrP
         Eyq2J3HFESx765CCITeKCXUDLbO5kgYBgHFN3+nA9w+KiJU9uIxabTGNCQnDv7/IzrRS
         TOVvzmD3GScd82w83RdZnpaun6jWfiapOCLK+yoUIxUezyZf4KrNK9zk47QmztTkM8Hy
         2UB7Db+MrzPHBxRWipur6JXd8PTA+MswKwviVQDNQ7lL+FytqewUInlRmLn0KTMiNwMn
         jG0g==
X-Gm-Message-State: APjAAAUEM1oktBYLanJHUSVO8ZEuzjfjhcxKACD2hFONn5ohlkwpamfg
        zveIN93yplHouRgIO4JYMaNn+IcjBGRiloTwfv9xoFSjo/ny6g==
X-Google-Smtp-Source: APXvYqy5PdZFi5u+LVKRbdizOtKlB1BAkUcFr/hbtSagmQI75MejMmTfbIAjOM+wF2nslyi3JbNIj1qS0IGvAGyDAgA=
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr27121785iok.227.1554884852867;
 Wed, 10 Apr 2019 01:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk>
In-Reply-To: <20190410002603.GS2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 10:27:20 +0200
Message-ID: <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ian Kent <raven@themaw.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 2:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> > Bisection is inconclusive: the first bad commit could be any of:
>
> [snip the useless pile]
>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> > start commit:   [unknown
> > git tree:       linux-next
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If I'm not misreading the "crash report" there, it has injected an allocation
> failure in dentry allocation in d_make_root() from autofs_fill_super() (
>         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
>         root = d_make_root(root_inode);
> ) which has triggered iput() on the inode passed to d_make_root() (as it ought
> to).  At which point it stepped into some BUG_ON() in fs/inode.c, but I've
> no idea which one it is - line numbers do not match anything in linux-next
> or in mainline.  Reported line 1566 is
>                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> in all of them; as the matter of fact, the diff in fs/inode.c between
> -next and mainline is empty.
>
> There is a BUG_ON() several lines prior, and in 4.20 it used to be line 1566,
> so _probably_ that's what it is.  With that assumption, it's
>         BUG_ON(inode->i_state & I_CLEAR);
> IOW, we'd got I_CLEAR in the inode passed to d_make_root() there.  Which
> should not happen - the inode must have come from new_inode(), which
> gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
> is set only in clear_inode().  For autofs inodes that can come only
> from autofs_evict_inode(), called as ->evict() from evict_inode().
> Which should never ever be called for inode with positive ->i_count...
>
> It might be memory corruption; it might be a dangling inode pointer
> somewhere, it might be something else.
>
> To get any further we really need a confirmation of the identity of
> triggered BUG_ON().
>
> As an aside, your "sample crash reports" would've been much more useful if
> they went with commit SHA1 in question, especially when they contain line
> numbers.

Hi Al,

This is the commit for matching lines:

> HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> git tree:       linux-next

fs/inode.c:1566 points to:

void iput(struct inode *inode)
{
    ...
    BUG_ON(inode->i_state & I_CLEAR);


The dashboard page provides kernel git repository and commit for each crash.
