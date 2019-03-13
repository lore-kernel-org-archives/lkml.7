Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AFA206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCMPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:47:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfCMPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01D71B117;
        Wed, 13 Mar 2019 15:47:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 425C31E3FE8; Wed, 13 Mar 2019 16:47:12 +0100 (CET)
Date:   Wed, 13 Mar 2019 16:47:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
Message-ID: <20190313154712.GJ9108@quack2.suse.cz>
References: <00000000000016f7d40583d79bd9@google.com>
 <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
 <20190313143503.GD9108@quack2.suse.cz>
 <CAGXu5j+_Ao_CU8DG9nrTbx5ioDkJUFw0cGcLBMWnvNLe_eFJ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+_Ao_CU8DG9nrTbx5ioDkJUFw0cGcLBMWnvNLe_eFJ4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 08:35:33, Kees Cook wrote:
> On Wed, Mar 13, 2019 at 7:35 AM Jan Kara <jack@suse.cz> wrote:
> > On Tue 12-03-19 23:26:22, Kees Cook wrote:
> > > On Mon, Mar 11, 2019 at 1:42 PM syzbot
> > > <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com> wrote:
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000
> > > > [...]
> > > > ------------[ cut here ]------------
> > > > Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> > > > from SLAB object 'fanotify_event' (offset 40, size 8)!
> > > > [...]
> > > >   copy_to_user include/linux/uaccess.h:151 [inline]
> > > >   copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
> > > >   copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]
> > >
> > > Looks like this is the fh/ext_fh union in struct fanotify_fid, field
> > > "fid" in struct fanotify_event. Given that "fid" is itself in a union
> > > against a struct path, I think instead of a whitelist using
> > > KMEM_CACHE_USERCOPY(), this should just use a bounce buffer to avoid
> > > leaving a whitelist open for path or ext_fh exposure.
> >
> > Do you mean to protect it from a situation when some other code (i.e. not
> > copy_fid_to_user()) would be tricked into copying ext_fh containing slab
> > pointer to userspace?
> 
> Yes. That's the design around the usercopy hardening. The
> "whitelisting" is either via code (with a bounce buffer, so only the
> specific "expected" code path can copy it), with a
> kmem_create_usercopy() range marking (generally best for areas that
> are not unions or when bounce buffers would be too big/slow), or with
> implicit whitelisting (via a constant copy size that cannot change at
> run-time, like: copy_to_user(dst, src, 6)).
> 
> In this case, since there are multiple unions in place and
> FANOTIFY_INLINE_FH_LEN is small, it seemed best to go with a bounce
> buffer.

OK, makes sense. I'll replace tha patch using kmem_create_usercopy() in my
tree with a variant you've suggested.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
