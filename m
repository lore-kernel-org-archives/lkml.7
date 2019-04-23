Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E74C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AE820645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfDWQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfDWQ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F13B9ACEC;
        Tue, 23 Apr 2019 16:27:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 527F01E15B7; Tue, 23 Apr 2019 18:27:55 +0200 (CEST)
Date:   Tue, 23 Apr 2019 18:27:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Subject: Re: general protection fault in fanotify_handle_event
Message-ID: <20190423162755.GF9910@quack2.suse.cz>
References: <00000000000091becf0586d104c6@google.com>
 <000000000000d97b380586d1205f@google.com>
 <CAOQ4uxgbAQEok9AqnnVwqBrF=q0UBP6yQuvdG-WDVpHNk8Xi7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgbAQEok9AqnnVwqBrF=q0UBP6yQuvdG-WDVpHNk8Xi7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-04-19 12:33:02, Amir Goldstein wrote:
> On Thu, Apr 18, 2019 at 8:14 PM syzbot
> <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Thu Jan 10 17:04:37 2019 +0000
> >
> >      fanotify: cache fsid in fsnotify_mark_connector
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
> > start commit:   3f018f4a Add linux-next specific files for 20190418
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000
> >
> > Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
> > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> >

Hi Amir!

> It looks like lockless access to mark->connector is not safe as there is
> nothing preventing a reader from seeing a mark on object list without
> seeing the mark->connector assignment.

Yes, that seems to be possible.

> It made me wonder if (!mark->connector) check in fsnotify_put_mark() is safe.
> I couldn't find any call site where that would be a problem, but perhaps
> we should be more careful?

Why? That check is there really only to catch destruction of a mark that
was never attached (i.e., allocated but later never used due to some
error). Otherwise we should always have mark->connector set.

> Anyway, it seems that fsnotify_put_mark() uses the non NULL mark->connector
> as the indication that mark is on object list, so just assigning mark->connector
> before adding to object list won't do.
> 
> Since a reference of mark is our guaranty that mark->connector is not
> going away, I guess we could do opportunistic test for non NULL
> mark->connector from lockless path, if that fails, we check again
> with mark->lock held and if that fails something went wrong.
> 
> Another option is to teach fsnotify_first_mark() and fsnotify_next_mark()
> to skip over marks with NULL mark->connector.
> 
> What do you think? Did I over complicate this?

I'd prefer if we could make only fully initialized marks visible on
connector's list. Just to make things simple in the fast path of handling
events. So I'd just set mark->connector before adding mark to connector's
list and having smp_wmb() there to force ordering in
fsnotify_add_mark_list(). And we should use READ_ONCE() as a counter-part
to this in fanotify_get_fsid(). It is somewhat unfortunate that there are
three different ways how fsnotify_add_mark_list() can add mark to a list so
we may need to either repeat this in three different places or just use
some macro magic like:

#define fanotify_attach_obj_list(where, mark, conn, head) \
	do { \
		mark->connector = conn; \
		smp_wmb(); \
		hlist_add_##where##_rcu(&mark->obj_list, head); \
	} while (0)

And I would not really worry about fsnotify_put_mark() - if it ever sees
mark->connector set, mark really is on the connector's list and
fsnotify_put_mark() does the right thing (i.e. locks connector->lock if
needed).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
