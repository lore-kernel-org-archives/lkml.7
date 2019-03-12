Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A021741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqE6AUsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfCLGIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:08:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32909 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCLGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:08:51 -0400
Received: by mail-it1-f193.google.com with SMTP id f186so1595372ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1JiQ1cf1uHp+tMakySvUAuKGEi8FGoygCN9wkQMXqw=;
        b=hqE6AUsrdIaw8AqgtLspHLAVKb5SxCwC13bRoQ+Z0wXsi36QiN13hYYns2oMwfN6qO
         Pc8GSslcZrTFHx+8t2295LkvYl28Oia+4xOaj0EUqW0xLreRAVcsNOiyvls9FHg5Hitw
         5PARefocPhP7I/YbPrPyxPfC518gAUgj23ET9aaCDOrZxUaVlesbZWpGxRwxd7jaE+5J
         wC0ypf6VGxVCc5XixFadnCaB1n5jJQu6rdgO5eE/wMwWsjUgKM7XGZMcg/8ZXv41k5Oo
         d8WmszRQ+rfKrZay/cpoqmTHKNlZjsJe0pTj6SN32Dv98bDzjmMIkX6VW08aG7bJB3XT
         xLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1JiQ1cf1uHp+tMakySvUAuKGEi8FGoygCN9wkQMXqw=;
        b=DFAuGlNbYoF2oG2I3KEkdYZjRvxLw9CQZB4Qq/A/5Y/PENk+MHi/eQMSK8oh6lhisl
         xxiB/c6uM4pJoD2/XmDU6h9d5tUEPAu6oWPBN7T/ziFfm4DpfmW3X70ilI4jFphoJNYY
         NdTOy4HeF5HhzwP83O7Ded59e/ZT38kSmo4BismsDESxKEIs8N7D8wc8SruTOgocKLti
         IUXjU7NBGgqS6HHn02Hnp7py/H20wUUHPd64PcmoGiCs94HtNkHgDZe2uFD07WsOs2kR
         hSZX6apjWXOFOuKOi6G5aT1zXmk6O1hF7j2Hb/6sb2C1l0n9MoZIDnzIf8gpHxWekd1A
         xdgg==
X-Gm-Message-State: APjAAAWx7eEgzsW0x2xXAApd5gmQTtHgRtLuHhAFuZdAdrcR7qCFf8Uh
        TO0gtU9FmexUSkVEB4iXfhLae9U49PjJhU0GtK6e8g==
X-Google-Smtp-Source: APXvYqyGXtnMS2ogIjE5olP/bMefqZZmG86bf7yTmNWT6Oi2bSZlY5OSUGoDZnJnkjBP5bwMQsCr5Os3poCp9xG8Zic=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr966026itl.166.1552370930231;
 Mon, 11 Mar 2019 23:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fd5780583d1433f@google.com> <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
In-Reply-To: <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 07:08:38 +0100
Message-ID: <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
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

On Tue, Mar 12, 2019 at 12:37 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > Author: Shakeel Butt <shakeelb@google.com>
> > Date:   Wed Jan 9 22:02:21 2019 +0000
> >
> >      memcg: schedule high reclaim for remote memcgs on high_work
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> > start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > userspace arch: amd64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> >
> > Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> > Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on
> > high_work")
>
> The following patch
> memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> might have fixed this.  Was it applied?

Hi Andrew,

You mean if the patch was applied during the bisection?
No, it wasn't. Bisection is very specifically done on the same tree
where the bug was hit. There are already too many factors that make
the result flaky/wrong/inconclusive without changing the tree state.
Now, if syzbot would know about any pending fix for this bug, then it
would not do the bisection at all. But it have not seen any patch in
upstream/linux-next with the Reported-by tag, nor it received any syz
fix commands for this bugs. Should have been it aware of the fix? How?

Thanks
