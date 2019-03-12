Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D2E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amrURANU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCLNqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:46:12 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42636 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:46:11 -0400
Received: by mail-yw1-f67.google.com with SMTP id e76so2090325ywa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9o+ZRkqKfziSen8lPKKS3g4b+sPcaG2W3T+6uzEH9g=;
        b=amrURANUVN08ADXnnxxWasXpOUxyxp5dMTdRZhdlsTUqBXurp0Ma56c+nJgxdfQT/n
         4ob3IR3dt/041CJFWuyoaA/uB8WxO80ry2YKSeP9161NGGaP4Wine1dexnni0CyVc/ni
         pTmH8h465/sg6DwmTjSlkCD7m//oju951OCmBnucU8KgD6sC/abyjeO1uFQhYlZ1HF8A
         54d2nDMKPt2BBatRrIcfjCVXYiW4DeBd1e2WhjcXKSvyihEhAAauyWtIFZo1Mb3IZKFp
         2r8dIFMD+e9GHO8RgMcSxc+x83llphU0mksSc97Sne5pyDxu9oqrsi2KHijTVx/pDlu3
         W3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9o+ZRkqKfziSen8lPKKS3g4b+sPcaG2W3T+6uzEH9g=;
        b=fgWOj0CNF3B34V7qTQFwyRvjMLw68CHAiTtVUafBdo3rQyCAvJH6KjEdNp81Hvt9lG
         EbAK9s2+ICDb9/Z0fzjhSu9PcO2LAZ1kBdwF8ie9HLMWKLLR2vy7ZTRHitb016uA3JUu
         uQ8Ll14nh14LyK/TOgHm3dJOgiZ5vbU+9/NDInwCEgLGHQM1Rw9yQvAoELG2ucV+WDZU
         T521l1Ok6T2Q5tCjim3a8olervPn2Nnd5pZYv8CDsJrqQDb3iUU+yCgviTNdhWzOfbKo
         Yc1DCQDI+DUujf6JfRtjKUOpb93fOlhJxdmQRcMqhdAfSi70VJFp/3bY+++XYGR0JFSV
         OoWw==
X-Gm-Message-State: APjAAAVkpeMuTENSfb5Dq8JLtWQINncp4g8AziwiGtwcmBR6jg/GdZf4
        ZS1UUahgbhPMn1bpjDM9DfHkLpbdDGiC6eiUzx8skQ==
X-Google-Smtp-Source: APXvYqxLVjwTbEkLiEnQqelf1e6ZM2Rq3Ip9doTY9hdELEmrtmkYxYbEwYx9rIiOkqWDr5yTI5jssibFJwLhnlXV4mE=
X-Received: by 2002:a81:a047:: with SMTP id x68mr29403501ywg.349.1552398370146;
 Tue, 12 Mar 2019 06:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fd5780583d1433f@google.com> <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
 <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
 <20190311232541.db8571d2e3e0ca636785f31f@linux-foundation.org> <CACT4Y+Y0JdB-=yLLchw8icokn11iH2-XYoLJEOFKm6F88fJ3WQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Y0JdB-=yLLchw8icokn11iH2-XYoLJEOFKm6F88fJ3WQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Mar 2019 06:45:59 -0700
Message-ID: <CALvZod6ADEHE4_gFpod-gmXz0h3WjoOZE+cN2BCG20ORb2V5Qg@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:33 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 12, 2019 at 7:25 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 12 Mar 2019 07:08:38 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > On Tue, Mar 12, 2019 at 12:37 AM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > syzbot has bisected this bug to:
> > > > >
> > > > > commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > > > > Author: Shakeel Butt <shakeelb@google.com>
> > > > > Date:   Wed Jan 9 22:02:21 2019 +0000
> > > > >
> > > > >      memcg: schedule high reclaim for remote memcgs on high_work
> > > > >
> > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> > > > > start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> > > > > git tree:       linux-next
> > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > > > > userspace arch: amd64
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> > > > >
> > > > > Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> > > > > Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on
> > > > > high_work")
> > > >
> > > > The following patch
> > > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > > > might have fixed this.  Was it applied?
> > >
> > > Hi Andrew,
> > >
> > > You mean if the patch was applied during the bisection?
> > > No, it wasn't. Bisection is very specifically done on the same tree
> > > where the bug was hit. There are already too many factors that make
> > > the result flaky/wrong/inconclusive without changing the tree state.
> > > Now, if syzbot would know about any pending fix for this bug, then it
> > > would not do the bisection at all. But it have not seen any patch in
> > > upstream/linux-next with the Reported-by tag, nor it received any syz
> > > fix commands for this bugs. Should have been it aware of the fix? How?
> >
> > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch was
> > added to linux-next on Jan 10.  I take it that this bug was hit when
> > testing the entire linux-next tree, so we can assume that
> > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > does not fix it, correct?
> > In which case, over to Shakeel!
>
> Jan 10 is exactly when this bug was reported:
> https://groups.google.com/forum/#!msg/syzkaller-bugs/5YkhNUg2PFY/4-B5M7bDCAAJ
> https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
>
> We don't know if that patch fixed the bug or not because nobody tested
> the reproducer with that patch.
>
> It seems that the problem here is that nobody associated the fix with
> the bug report. So people looking at open bug reports will spend time
> again and again debugging this just to find that this was fixed months
> ago. syzbot also doesn't have a chance to realize that this is fixed
> and bisection is not necessary anymore. It also won't confirm/disprove
> that the fix actually fixes the bug because even if the crash will
> continue to happen it will look like the old crash just continues to
> happen, so nothing to notify about.
>
> Associating fixes with bug reports solves all these problems for
> humans and bots.

Should we add "Reported-by" for syzbot reports on linux-next patches
as well? Please note that these patches are in flux and might be
dropped or completely changed before merging into Linus tree.

Also should syzbot drop bug reports on older linux-next trees if it
can not be repro'ed in the latest linux-next tree? IMHO yes.

Shakeel
