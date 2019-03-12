Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372F32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2Ny9Whd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCLOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:45:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36255 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCLOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:45:09 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so2319990iop.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8tjD9g6ECFtj58bueXZfoseG7B0ylHDzFv2iAyv4fM=;
        b=j2Ny9WhdjH/22/DqO/hEcrrNdeC8IgVny+r24d46gGtY/Fm2CDh5flqhM2XUvDP2cc
         O0/SeF03zZUQTibfHaFryMyd265qsta+lMBuWrO5I01JnDD4sYClYXE+QWIB81qSK3e6
         RByTEQ1GO54xIYlZO7FV/Qqh9M935IIvNcgFwd5NRmFN8UPqj8PhPUoNXIodn1HFOexQ
         y4+7ZgFbBH+E5jDMwn5wkKOysvpvAUPoknnYCpDAJj+2fjt5EJGzvcetGWEjp5gqcrPN
         41Lzq6pI5ALOxue4zvznNe2HwNJcRnrvp/rphZiwsVS2LbBe3ujyxdF3JWsA98wMhtw4
         RgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8tjD9g6ECFtj58bueXZfoseG7B0ylHDzFv2iAyv4fM=;
        b=avl828TYFk/UxJx4JIxCvz7JcjmJrXLHaJkzwtpj/PD0kR5eG/nURnxqXs4cgG0dvC
         h345VfLpSltNiI1lI/6AlNCWYTijlPjNRhLH1zigAYCPUyFVsMVZijJp9hyOtqBegk5P
         wK1c2bR9sfq0FXb+Kzb7OKVNAbvt10vCOJLFy+TO20uYOhMq15fr1Y0p+DlWgahh0tLg
         ofKg5Iv+qA9377p0NZR2nutSXQCsb8BjdlU2IvTfwAYYAP7IovjjJ7Km5GOEGRFoKghA
         GI2Bdz0W5zI0gDxl4KobtEayDfMykLsxDriGXVJOtmi1/9o7DfJA1uPBQ0nhsJtqi4L0
         aoDQ==
X-Gm-Message-State: APjAAAUSrq8sAQwM9SQgV0SVJa86eyyPHF7Scv/n7c+OA9Eo+AnzlzwX
        ZuVAmGHR5PQ+67MVQU2kvMWXtvaqU+IXPz/lrq/48w==
X-Google-Smtp-Source: APXvYqwmmu1BcEEiUW24WYGARs5ONMR3C5EQpLCqXyb/yQY1Irh1d5Z8g0Uhd54vJrGiSrIFZtGCNm5UACGj8tHWeVA=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr10669215ioa.282.1552401908362;
 Tue, 12 Mar 2019 07:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fd5780583d1433f@google.com> <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
 <CACT4Y+byKQSOCte3JS9XOnyr+aVSEFtBvLxG2-HUrZX3-82Hcg@mail.gmail.com>
 <20190311232541.db8571d2e3e0ca636785f31f@linux-foundation.org>
 <CACT4Y+Y0JdB-=yLLchw8icokn11iH2-XYoLJEOFKm6F88fJ3WQ@mail.gmail.com> <CALvZod6ADEHE4_gFpod-gmXz0h3WjoOZE+cN2BCG20ORb2V5Qg@mail.gmail.com>
In-Reply-To: <CALvZod6ADEHE4_gFpod-gmXz0h3WjoOZE+cN2BCG20ORb2V5Qg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 15:44:57 +0100
Message-ID: <CACT4Y+YtdVh7jKX6ieK+r6jAzE=i_WR8uJfuAq45VaHr2MEPKg@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
To:     Shakeel Butt <shakeelb@google.com>
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

On Tue, Mar 12, 2019 at 2:46 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Mar 12, 2019 at 1:33 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Mar 12, 2019 at 7:25 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 12 Mar 2019 07:08:38 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > On Tue, Mar 12, 2019 at 12:37 AM Andrew Morton
> > > > <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > syzbot has bisected this bug to:
> > > > > >
> > > > > > commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> > > > > > Author: Shakeel Butt <shakeelb@google.com>
> > > > > > Date:   Wed Jan 9 22:02:21 2019 +0000
> > > > > >
> > > > > >      memcg: schedule high reclaim for remote memcgs on high_work
> > > > > >
> > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> > > > > > start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> > > > > > git tree:       linux-next
> > > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> > > > > > userspace arch: amd64
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> > > > > >
> > > > > > Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> > > > > > Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on
> > > > > > high_work")
> > > > >
> > > > > The following patch
> > > > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > > > > might have fixed this.  Was it applied?
> > > >
> > > > Hi Andrew,
> > > >
> > > > You mean if the patch was applied during the bisection?
> > > > No, it wasn't. Bisection is very specifically done on the same tree
> > > > where the bug was hit. There are already too many factors that make
> > > > the result flaky/wrong/inconclusive without changing the tree state.
> > > > Now, if syzbot would know about any pending fix for this bug, then it
> > > > would not do the bisection at all. But it have not seen any patch in
> > > > upstream/linux-next with the Reported-by tag, nor it received any syz
> > > > fix commands for this bugs. Should have been it aware of the fix? How?
> > >
> > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch was
> > > added to linux-next on Jan 10.  I take it that this bug was hit when
> > > testing the entire linux-next tree, so we can assume that
> > > memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
> > > does not fix it, correct?
> > > In which case, over to Shakeel!
> >
> > Jan 10 is exactly when this bug was reported:
> > https://groups.google.com/forum/#!msg/syzkaller-bugs/5YkhNUg2PFY/4-B5M7bDCAAJ
> > https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> >
> > We don't know if that patch fixed the bug or not because nobody tested
> > the reproducer with that patch.
> >
> > It seems that the problem here is that nobody associated the fix with
> > the bug report. So people looking at open bug reports will spend time
> > again and again debugging this just to find that this was fixed months
> > ago. syzbot also doesn't have a chance to realize that this is fixed
> > and bisection is not necessary anymore. It also won't confirm/disprove
> > that the fix actually fixes the bug because even if the crash will
> > continue to happen it will look like the old crash just continues to
> > happen, so nothing to notify about.
> >
> > Associating fixes with bug reports solves all these problems for
> > humans and bots.
>
> Should we add "Reported-by" for syzbot reports on linux-next patches
> as well? Please note that these patches are in flux and might be
> dropped or completely changed before merging into Linus tree.

Reported-by will work, but may be confusing. It was discussed that for
squashed fixed Tested-by tag may be more appropriate and will also
work.
For dropped patches we don't have a better way other than marking it
as invalid for now.

> Also should syzbot drop bug reports on older linux-next trees if it
> can not be repro'ed in the latest linux-next tree? IMHO yes.

Please file an issue for this at:
https://github.com/google/syzkaller/issues
So far we don't have retesting in any form. Some bugs don't have
repros, so can't be retested. Any closing should probably happen after
long enough timeout to avoid spam, so bisection for them will most
likely happen anyway.
I can't promise any ETA for linux-next-specific work. Testing of
linux-next happens mostly because it's done on a rules not
significantly different from everything else (other trees, forks and
OSes).
