Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2102FC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E654621744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxAmX5GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEIKML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:12:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34571 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:12:10 -0400
Received: by mail-io1-f65.google.com with SMTP id g84so1192782ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xgses+TIdzaI9yt59q3h+UsOZwveq16nUB5ccuxI8FU=;
        b=RxAmX5GVAUo3hXQYwg3dPu3Q9Varjm1hYAUEw1ayyij3jCaD3T90ZnSFYVqDnO4Jd9
         VSKU/sNrphohVRznZkoYjrnZBY7kU5AlYA3x/iJ1PgxgHJdlifFggTh8lDFNtgW1Dc7p
         zkA26ZamrAWGFwvArytvJrwM9TaSTmoyKF6n+EwGOEfoA9EUnvdvKDO9xtQdDGF37K7z
         idYdH2cLH0RJcwExk6kxhASAUZ0/R7axkT5/QXsH8SIhGGwyKqFJAeZNjMNFyBkURgVd
         5wVpYwnSmc4MXDwKHwZymEqazstWztqRc1KViKjpHjA8wHBlmrZty9VTH872pdawPIJx
         V3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xgses+TIdzaI9yt59q3h+UsOZwveq16nUB5ccuxI8FU=;
        b=T6bfskvnYHtnfuHwZNJX3051DSr+BYNd0tk7LUYVA8BGhSXZsIMMyQnSvdLCh8zIPt
         +/a2xKe1J0lHa8JFgP+vQnR5tvmm2SOMhXyO5TdEn73gTmpgIfV711Q8+aIHcVQpQGDJ
         lEORh1tjNpLQcBt+i6em+Mn2F45aTQo+V3duUzM73zMre8zdMKSvL0xzmBRH/yrNHrkS
         2867fs8j6j6Znz2J5pmDj8J5TtGZxgluqKd1G44Bq62M9WVJCgaPxPqsQC7JTkZX014E
         F8IpHyBc6BYaiQRaYTxoH7EDEHgGV7NSKMGfCNqbDLavi5q7R/r+H0rnLRqEhG/qphIK
         t3/Q==
X-Gm-Message-State: APjAAAVtEO7gmPD2cbYuyHF/yagmSDnIIX3RJsahItd4NzEbzZDg8K5n
        7I+aPjUJZjFMJ+koXPACkehQBqwNHp6pF1gYgWQQNg==
X-Google-Smtp-Source: APXvYqxd70Xrt+pA6K9WN4S6IMIE0rw4KJus77FSRLXOePxsWEZOyfXKNufr5siKIWHWXL6YIETEwcXNHBr3p5oZbOc=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr1720583iom.282.1557396729132;
 Thu, 09 May 2019 03:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003beebd0588492456@google.com> <20190509095724.GG18914@techsingularity.net>
In-Reply-To: <20190509095724.GG18914@techsingularity.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 May 2019 12:11:57 +0200
Message-ID: <CACT4Y+Yt6U0C7UJqp4b_v=-_csDn81S7BEJKhudSDeK0-fFDQw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in isolate_freepages_block
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     syzbot <syzbot+d84c80f9fe26a0f7a734@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 07, 2019 at 02:50:05AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    baf76f0c slip: make slhc_free() silently accept an error p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16dbe6cca00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d84c80f9fe26a0f7a734
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
>
> How reproducible is it and can the following (compile tested only) patch
> be tested please? I'm thinking it's a similar class of bug to 6b0868c820ff
> ("mm/compaction.c: correct zone boundary handling when resetting pageblock
> skip hints")

Hi Mel,

The info about reproducibility is always available on the dashboard:

> > dashboard link: https://syzkaller.appspot.com/bug?extid=d84c80f9fe26a0f7a734

So far it happened only 3 times which is not very frequent, 1 crash
every few days. syzbot did not come up with a reproducer so far.
If you think this should fix the bug, commit the patch, syzbot will
close the bug and then notify us again if the crash will happen again
after the patch reaches all tested trees.



> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3319e0872d01..ae4d99d31b61 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1228,7 +1228,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
>
>         /* Pageblock boundaries */
>         start_pfn = pageblock_start_pfn(pfn);
> -       end_pfn = min(start_pfn + pageblock_nr_pages, zone_end_pfn(cc->zone));
> +       end_pfn = min(start_pfn + pageblock_nr_pages, zone_end_pfn(cc->zone) - 1);
>
>         /* Scan before */
>         if (start_pfn != pfn) {
> @@ -1239,7 +1239,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
>
>         /* Scan after */
>         start_pfn = pfn + nr_isolated;
> -       if (start_pfn != end_pfn)
> +       if (start_pfn < end_pfn)
>                 isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>
>         /* Skip this pageblock in the future as it's full or nearly full */
