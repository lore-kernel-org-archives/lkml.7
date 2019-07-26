Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C42C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DB1216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfGZP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:57:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfGZP5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:57:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C6C3152D;
        Fri, 26 Jul 2019 08:57:37 -0700 (PDT)
Received: from e109758.arm.com (unknown [10.1.39.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50BC73F71F;
        Fri, 26 Jul 2019 08:57:35 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:57:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+a871c1e6ea00685e73d7@syzkaller.appspotmail.com>,
        alexandre.belloni@free-electrons.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, nicolas.ferre@atmel.com,
        Rob Herring <robh@kernel.org>, sre@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: memory leak in vq_meta_prefetch
Message-ID: <20190726155732.GA30211@e109758.arm.com>
References: <00000000000052ad6b058e722ba4@google.com>
 <20190726130013.GC2368@arrakis.emea.arm.com>
 <CACT4Y+b5H4jvY34iT2K0m6a2HCpzgKd3dtv+YFsApp=-18B+pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b5H4jvY34iT2K0m6a2HCpzgKd3dtv+YFsApp=-18B+pw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 05:20:55PM +0200, Dmitry Vyukov wrote:
> On Fri, Jul 26, 2019 at 3:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Jul 24, 2019 at 12:18:07PM -0700, syzbot wrote:
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15fffef4600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a871c1e6ea00685e73d7
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127b0334600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609e94600000
> > >
> > > The bug was bisected to:
> > >
> > > commit 0e5f7d0b39e1f184dc25e3adb580c79e85332167
> > > Author: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > Date:   Wed Mar 16 13:19:49 2016 +0000
> > >
> > >     ARM: dts: at91: shdwc binding: add new shutdown controller documentation
> >
> > That's another wrong commit identification (a documentation patch should
> > not cause a memory leak).
> >
> > I don't really think kmemleak, with its relatively high rate of false
> > positives, is suitable for automated testing like syzbot. You could
> 
> Do you mean automated testing in general, or bisection only?
> The wrong commit identification is related to bisection only, but you
> generalized it to automated testing in general. So which exactly you
> mean?

I probably meant both. In terms of automated testing and reporting, if
the false positives rate is high, people start ignoring the reports. So
it requires some human checking first (or make the tool more robust).

W.r.t. bisection, the false negatives (rather than positives) will cause
the tool to miss the problematic commit and misreport. I'm not sure you
can make the reporting deterministic on successive runs given that you
changed the kernel HEAD (for bisection). But it may get better if you
have a "stopscan" kmemleak option which freezes the machine during
scanning (it has been discussed in the past but I really struggle to
find time to work on it; any help appreciated ;)).

-- 
Catalin
