Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E912177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFneT7Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfCMIMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:12:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53457 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbfCMIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:12:48 -0400
Received: by mail-it1-f195.google.com with SMTP id x189so1433765itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOCnQSyICOjHIihXvleYcLez4NbqcA5J+kbiAScPb/M=;
        b=RFneT7IrnqSQ/794rwi5hPOHqGioI+7ey0G8A02r6RcC7i9aIYhtEhAGpaaNrE0ttc
         lda7mY1auh22NsRyANoBbUghKtooMVLSzUsgr43kKmOV0IOlCqLI9yA3cbpMXOYNsVwe
         LtMOEYgYkJLoV4MHYxlT/w+KGkBvIkNBM6knHxBj/Qfy0r4CoC986CIJGkzczOnSij+w
         V+kVKRGxgQ0IBSS3n6mkcrG5oVy1eTItdf1BKftQRshc0RmZvAlQrtpRRWWTxYr4i/32
         NlSXIjErjgZtFbpaTAH/6aMoRJEukgapYYuY5YgInh6tud36xJZai97kRXJix59G9tI7
         v83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOCnQSyICOjHIihXvleYcLez4NbqcA5J+kbiAScPb/M=;
        b=oImaCdb3vYIdTzV1hjXGzt4WT3SSRas7LqeZs/+fbrRuEukUStDKGw/CFfL5qvBNRw
         jUF60K92kKuh4ceXhMdVqKPgM4/3kOse0a5suGWMn7+uscHn/5rnYxRqWgwQJgacg5+R
         aETcmAc2ZFdJXnsejNBFa7RqkVK5TrjQTECgGdsAzUIxsQZOR7kvGGONX3pOblfxCdA9
         xPfp2BkSz5Abb6lPzSbxKDaaZXSZUxwZGy0bk3kxOwPHnrV2ISYkOhiLejUPddd0y+Ea
         FGzGqSx7J3jmxaTeOvmzGKgsiQpMQpr8n2WUBDf4uGzsHxaDnCxWBB6RKPL9DW1hacr5
         Y2/w==
X-Gm-Message-State: APjAAAXlW8x8vTVQrkupvf+K7V38QAezzg0CbqGhKyzjj7lqgiv3waJ1
        bb/TT25//Fquw72S8WZv3TZnnTsMtex+h4vt2iD0hQ==
X-Google-Smtp-Source: APXvYqwQCCsPmmtbNRDn+twvOX+qtilAK7cV2LlBXM6Z1SYVMVSrBXys1elUlKnwoMFin2KjLABaTQL+B/C+uf5kIKY=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr949206itl.166.1552464766439;
 Wed, 13 Mar 2019 01:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fd5780583d1433f@google.com> <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
 <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
 <20190311232541.db8571d2e3e0ca636785f31f@linux-foundation.org>
 <20190312064300.GB9123@sol.localdomain> <CACT4Y+Z1rkS5bf3x9Y+0ke=zZ+mM2F5+vN-JtSQpjD09STRNdw@mail.gmail.com>
 <20190312223113.GA38846@gmail.com>
In-Reply-To: <20190312223113.GA38846@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Mar 2019 09:12:35 +0100
Message-ID: <CACT4Y+ZWGYuEu0b7t=stYzD2hmfe0E2m0-o0KURa7tDjP+r7UA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:31 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Dmitry,
>
> On Tue, Mar 12, 2019 at 09:21:09AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > On Tue, Mar 12, 2019 at 7:43 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 11:25:41PM -0700, Andrew Morton wrote:
> > > > On Tue, 12 Mar 2019 07:08:38 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > > On Tue, Mar 12, 2019 at 12:37 AM Andrew Morton
> > > > > <akpm@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > > syzbot has bisected this bug to:
> > > > > > >
> > > > > > > commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > > > > > > Author: Shakeel Butt <shakeelb@google.com>
> > > > > > > Date:   Wed Jan 9 22:02:21 2019 +0000
> > > > > > >
> > > > > > >      memcg: schedule high reclaim for remote memcgs on high_work
> > > > > > >
> > > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> > > > > > > start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> > > > > > > git tree:       linux-next
> > > > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > > > > > > userspace arch: amd64
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> > > > > > >
> > > > > > > Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> > > > > > > Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on
> > > > > > > high_work")
> > > > > >
> > > > > > The following patch
> > > > > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > > > > > might have fixed this.  Was it applied?
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > > You mean if the patch was applied during the bisection?
> > > > > No, it wasn't. Bisection is very specifically done on the same tree
> > > > > where the bug was hit. There are already too many factors that make
> > > > > the result flaky/wrong/inconclusive without changing the tree state.
> > > > > Now, if syzbot would know about any pending fix for this bug, then it
> > > > > would not do the bisection at all. But it have not seen any patch in
> > > > > upstream/linux-next with the Reported-by tag, nor it received any syz
> > > > > fix commands for this bugs. Should have been it aware of the fix? How?
> > > >
> > > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch was
> > > > added to linux-next on Jan 10.  I take it that this bug was hit when
> > > > testing the entire linux-next tree, so we can assume that
> > > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > > > does not fix it, correct?
> > > >
> > > > In which case, over to Shakeel!
> > > >
> > >
> > > I don't understand what happened here.  First, the syzbot report doesn't say
> > > which linux-next version was tested (which it should), but I get:
> > >
> > > $ git tag --contains 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > > next-20190110
> > > next-20190111
> > > next-20190114
> > > next-20190115
> > > next-20190116
> > >
> > > That's almost 2 months old, yet this bug was just reported now.  Why?
> >
> > Hi Eric,
> >
> > This bug was reported on Jan 10:
> > https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > https://groups.google.com/forum/#!msg/syzkaller-bugs/5YkhNUg2PFY/4-B5M7bDCAAJ
> >
> > The start revision of the bisection process (provided) is the same
> > that was used to create the reproducer. The end revision and bisection
> > log are provided in the email.
> >
> > How can we improve the format to make it more clear?
> >
>
> syzbot started a new thread rather than sending the bisection result in the
> existing thread.  So I thought it was a new bug report, as did everyone else
> probably.

There were not In-reply-to headers in first few bisect reports. This
should be fixed now. E.g. this one should be properly threaded:
https://groups.google.com/forum/#!topic/syzkaller-bugs/r2t3i5E78Mw
