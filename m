Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C14C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B121880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD8vJIwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbfHHQea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:34:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35365 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:34:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so44400782otq.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CevGcpRgzGYUYkY1Qufxh/t6tKVinQDXW0qs501ljWk=;
        b=lD8vJIwHU04brpVPsZuuc+sFApJtNJOJioUN1Ziqb96dgduPrr0GvZe9PS+KzkQK9g
         IeV2c9HRN34L70pR84OQ6J9VZb2WYp1xdN/vb+dFw9loWSb3l7bp1EI9iqQCmG/6dZ4J
         pyj64xb6Db1gr7Yq1Y1T/ENGkkWoekSVRNl3JkGWoSiG1qGAK0JeCKltUbqtWZGDTTdL
         lsKG09Qsh5dZDb0VHMYZifVnVGaHGfQvy9Ce7V5bRVhhmLElXSO/gAy2u9CeZAOB+5tv
         svtTlFDgWO1Z5XxZBg/gO6/saSDQzejeQT/b5EB97OaOf1t0HhIDhMmnaA+CjTFaGl8c
         FuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CevGcpRgzGYUYkY1Qufxh/t6tKVinQDXW0qs501ljWk=;
        b=qeTLhlL48H8Fh+3zs6/EwIDZnmddXMcIrmmovHMUjXAiUSZ6pKkhliNkDJzjhUSQn9
         bsCu5K3VoEd5qulhtCFKp/AyOSWVZI83pbEMHjsSj9Jev8Z/DqhAJwRKLwjKEPN+jJ9T
         hkGABHMMW+uUYZKFQdlQAnBRe6gPGxYOsPUAjvgC/aQedNv0rdsJamOA3QUcfu06lLhV
         wlw/g2wRwHJA0M+QWyqg/rlm3iemVpf5Fl5cfaQJ2IeawVonFmTe4rHhy4zAYSb4riNh
         zlIgxDFUoTBvET003vtr7kNRslxmd+S+Fx6iIMC3xg1WJ2OnltaWadaRxuHmZr2qj/GL
         RsQw==
X-Gm-Message-State: APjAAAWKg6FrTgbTMuS+5wsZ5KMdJ13pNmR7wDPS11YDlGmrMD8n2HYN
        ixwX59kUYjIPaTWaCtFwJJdBPKKptvLlLQHq/h5mrw==
X-Google-Smtp-Source: APXvYqwcaNv0vzSVHagDyKD6rdlm96zsQZQ+/87RoINSAJesPxeFTIHAQRVZJ8CKRQBUYPYq+aWWwmWKc3gf5SmW5kE=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr14839283iop.58.1565282068876;
 Thu, 08 Aug 2019 09:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a9694d058f261963@google.com> <20190802200643.GA181880@google.com>
 <20190806082907.GI11812@dhcp22.suse.cz>
In-Reply-To: <20190806082907.GI11812@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 8 Aug 2019 18:34:16 +0200
Message-ID: <CACT4Y+YkecBfqkL8BZf0BrnX2ZrJccGe9g4MOFQYw88ehUwidA@mail.gmail.com>
Subject: Re: kernel BUG at mm/vmscan.c:LINE! (2)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        syzbot <syzbot+8e6326965378936537c3@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>, chris@zankel.net,
        dancol@google.com, Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, laoar.shao@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>, oleksandr@redhat.com,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, surenb@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tim Murray <timmurray@google.com>, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 10:29 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 03-08-19 05:06:43, Minchan Kim wrote:
> > On Fri, Aug 02, 2019 at 10:58:05AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    0d8b3265 Add linux-next specific files for 20190729
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1663c7d0600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ae96f3b8a7e885f7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8e6326965378936537c3
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c437c600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15645854600000
> > >
> > > The bug was bisected to:
> > >
> > > commit 06a833a1167e9cbb43a9a4317ec24585c6ec85cb
> > > Author: Minchan Kim <minchan@kernel.org>
> > > Date:   Sat Jul 27 05:12:38 2019 +0000
> > >
> > >     mm: introduce MADV_PAGEOUT
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1545f764600000
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1745f764600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1345f764600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> > > Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
> > >
> > > raw: 01fffc0000090025 dead000000000100 dead000000000122 ffff88809c49f741
> > > raw: 0000000000020000 0000000000000000 00000002ffffffff ffff88821b6eaac0
> > > page dumped because: VM_BUG_ON_PAGE(PageActive(page))
> > > page->mem_cgroup:ffff88821b6eaac0
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/vmscan.c:1156!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 1 PID: 9846 Comm: syz-executor110 Not tainted 5.3.0-rc2-next-20190729
> > > #54
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156
> >
> > My old version had PG_active flag clear but it seems to lose it with revising
> > patchsets. Thanks, Sizbot!
> >
> > >From 66d64988619ef7e86b0002b2fc20fdf5b84ad49c Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Sat, 3 Aug 2019 04:54:02 +0900
> > Subject: [PATCH] mm: Clear PG_active on MADV_PAGEOUT
> >
> > shrink_page_list expects every pages as argument should be no active
> > LRU pages so we need to clear PG_active.
>
> Ups, missed that during review.
>
> >
> > Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> > Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
>
> This is not a valid sha1 because it likely comes from linux-next. I
> guess Andrew will squash it into mm-introduce-madv_pageout.patch
>
> Just for the record
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> And thanks for syzkaller to exercise the new interface so quickly!

syzkaller don't have any new descriptions for MADV_PAGEOUT. It's just
the power of rand. If there is something more complex than just a
single flag, then it may benefit from explicit interface descriptions.


> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/vmscan.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 47aa2158cfac2..e2a8d3f5bbe48 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2181,6 +2181,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
> >               }
> >
> >               if (nid == page_to_nid(page)) {
> > +                     ClearPageActive(page);
> >                       list_move(&page->lru, &node_page_list);
> >                       continue;
> >               }
> > --
> > 2.22.0.770.g0f2c4a37fd-goog
>
> --
> Michal Hocko
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190806082907.GI11812%40dhcp22.suse.cz.
