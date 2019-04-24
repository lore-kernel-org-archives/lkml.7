Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1802175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfDXLqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:46:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfDXLqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:46:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0CC2AD7B;
        Wed, 24 Apr 2019 11:46:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 461F81E15B7; Wed, 24 Apr 2019 13:46:02 +0200 (CEST)
Date:   Wed, 24 Apr 2019 13:46:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Subject: Re: general protection fault in fanotify_handle_event
Message-ID: <20190424114602.GA29968@quack2.suse.cz>
References: <00000000000091becf0586d104c6@google.com>
 <000000000000d97b380586d1205f@google.com>
 <CAOQ4uxgbAQEok9AqnnVwqBrF=q0UBP6yQuvdG-WDVpHNk8Xi7A@mail.gmail.com>
 <20190423162755.GF9910@quack2.suse.cz>
 <CAOQ4uxj83NA0QYP_kqgyRWxicUuQHoPK+vcTLEN-+rL+Vwa2HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj83NA0QYP_kqgyRWxicUuQHoPK+vcTLEN-+rL+Vwa2HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-04-19 21:05:22, Amir Goldstein wrote:
> On Tue, Apr 23, 2019 at 7:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 19-04-19 12:33:02, Amir Goldstein wrote:
> > > On Thu, Apr 18, 2019 at 8:14 PM syzbot
> > > <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has bisected this bug to:
> > > >
> > > > commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Thu Jan 10 17:04:37 2019 +0000
> > > >
> > > >      fanotify: cache fsid in fsnotify_mark_connector
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
> > > > start commit:   3f018f4a Add linux-next specific files for 20190418
> > > > git tree:       linux-next
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000
> > > >
> > > > Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
> > > > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> > > >
> >
> 
> [...]
> 
> >
> > I'd prefer if we could make only fully initialized marks visible on
> > connector's list. Just to make things simple in the fast path of handling
> > events. So I'd just set mark->connector before adding mark to connector's
> > list and having smp_wmb() there to force ordering in
> > fsnotify_add_mark_list(). And we should use READ_ONCE() as a counter-part
> > to this in fanotify_get_fsid(). It is somewhat unfortunate that there are
> > three different ways how fsnotify_add_mark_list() can add mark to a list so
> > we may need to either repeat this in three different places or just use
> > some macro magic like:
> >
> > #define fanotify_attach_obj_list(where, mark, conn, head) \
> >         do { \
> >                 mark->connector = conn; \
> >                 smp_wmb(); \
> >                 hlist_add_##where##_rcu(&mark->obj_list, head); \
> >         } while (0)
> >
> > And I would not really worry about fsnotify_put_mark() - if it ever sees
> > mark->connector set, mark really is on the connector's list and
> > fsnotify_put_mark() does the right thing (i.e. locks connector->lock if
> > needed).
> >
> 
> Sounds good to me.
> 
> I was worried about fsnotify_put_mark() NOT seeing mark->connector set
> even though it is on the list (add mark; get lockless ref; remove
> mark; put lockless ref).
> Its subtle, not sure if possible.

Not possible for the cases it matters. fsnotify_put_mark() just decrements
the refcount. If someone is adding mark to the list, he is by definition
holding one reference so racing fsnotify_put_mark() cannot be dropping the
last one and so the result of the check doesn't really matter.

> I am assuming you will be sending the above patch to syzbot for testing.
> If you want me do help with anything please let me know.

OK, I'll write it and send it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
