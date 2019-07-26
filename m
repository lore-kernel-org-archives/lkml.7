Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F26C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6B421734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSxV5e5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfGZQ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:26:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44167 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfGZQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:26:20 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so105853512iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49yfm4zari4iNgyc4c8iUnGnNiF8H5iDhklR2GX7QUY=;
        b=oSxV5e5bNKAEOl0HwhKJhFqS6oocpVP8oUntBD5al/WdfjqqJtsIfjWUwUDx29tEVj
         Ocox6SNSxTgTxci3S8uus+9f4v048jOPUOqwuyvdGpFBolmfQvjuixpWQTQ5t5g8nuwr
         Sy9w9ffMso7C/QX4f1ZEvHSPRs5SJNYv6cimfjMXpAyHuG6KjU7Rsm1uupYDv1xHZZxm
         U9VXVqwxnRXp45lR+vyNSgiPcH8dTiR7z+dw7MCbH2Yt6OKPOLKCfrRN86ogxLxP1o2E
         CbNgCMUgLLBu374M3UiEjVmgk6BDWDqRqVAPodQaRsA6oqmCQhhul6kJGPCrPdH4BVfB
         3cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49yfm4zari4iNgyc4c8iUnGnNiF8H5iDhklR2GX7QUY=;
        b=QGQS5wLoGvbM4QV+tpCeSQutCHhlRIIMX2zDcMwA+RWQ6k4eNm8EtsoD8kIwHi7Huq
         ylrmXGNp1jGrlJW6PuEo+mA0pGJCHQxu7k9dtg+Gc5LuH9dgshb1fGB0RkylOf63+OJA
         wQgfx2hGBWQ1fyLF6H+YsUFYC080Q/Rowk7aC4SvJf0vuYtxwwV5iBQ0vom8vIV/Dfsn
         AUEpiSdRCpRmqYqt1KqOjhvyVHXfpufRX4wnjhwpLoK5xj110YvZsWo/cfo90Aykpdx0
         MM5A02IKY2gTVNYnTYceLJT3dlMKPz+nxtwry/arM0CdooL450w9gOysM/X6bQTSPbNp
         DiYg==
X-Gm-Message-State: APjAAAXgjzhVEpwZnidEMOFiwelAqgPrOK9eN+WR6WY189e37d7v84ho
        1I3VOmJXOdIqVqx0AN/tj1+6VpJ/JRGFmgctkPfmiw==
X-Google-Smtp-Source: APXvYqyjf4GbmLPhL55X+s5p3TCQUBLJfRXVKJ2wZzfFHaTvxUziKKWb5psRA8Z3KyOrSCo3gRDt5OcQAS+5PqQqTdQ=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr65658210ior.231.1564158379700;
 Fri, 26 Jul 2019 09:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052ad6b058e722ba4@google.com> <20190726130013.GC2368@arrakis.emea.arm.com>
 <CACT4Y+b5H4jvY34iT2K0m6a2HCpzgKd3dtv+YFsApp=-18B+pw@mail.gmail.com>
 <20190726155732.GA30211@e109758.arm.com> <CACT4Y+Zf-p7CTRZd8x+2ymAXho2tM_5hLCn3ODJXPVuocMxwbw@mail.gmail.com>
 <20190726161530.GE2368@arrakis.emea.arm.com>
In-Reply-To: <20190726161530.GE2368@arrakis.emea.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jul 2019 18:26:08 +0200
Message-ID: <CACT4Y+bDSnocDe_VB4VhXaJv+q83YMnvpn+KCuW3hENiBfCNTw@mail.gmail.com>
Subject: Re: memory leak in vq_meta_prefetch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     syzbot <syzbot+a871c1e6ea00685e73d7@syzkaller.appspotmail.com>,
        alexandre.belloni@free-electrons.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, nicolas.ferre@atmel.com,
        Rob Herring <robh@kernel.org>, sre@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 6:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Wed, Jul 24, 2019 at 12:18:07PM -0700, syzbot wrote:
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15fffef4600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a871c1e6ea00685e73d7
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127b0334600000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609e94600000
> > > > > >
> > > > > > The bug was bisected to:
> > > > > >
> > > > > > commit 0e5f7d0b39e1f184dc25e3adb580c79e85332167
> > > > > > Author: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > > > Date:   Wed Mar 16 13:19:49 2016 +0000
> > > > > >
> > > > > >     ARM: dts: at91: shdwc binding: add new shutdown controller documentation
> > > > >
> > > > > That's another wrong commit identification (a documentation patch should
> > > > > not cause a memory leak).
> > > > >
> > > > > I don't really think kmemleak, with its relatively high rate of false
> > > > > positives, is suitable for automated testing like syzbot. You could
> > > >
> > > > Do you mean automated testing in general, or bisection only?
> > > > The wrong commit identification is related to bisection only, but you
> > > > generalized it to automated testing in general. So which exactly you
> > > > mean?
> > >
> > > I probably meant both. In terms of automated testing and reporting, if
> > > the false positives rate is high, people start ignoring the reports. So
> > > it requires some human checking first (or make the tool more robust).
> [...]
> > Do you have any data points wrt automated testing in general? This
> > disagrees with what I see.
>
> I'm fine with automated testing in general. Just that automated
> reporting for kmemleak could be improved a bit to reduce the false
> positives (e.g. run it a few times to confirm that it is a real leak).


I did a bunch of various external measures in syzkaller to improve
kmemleak quality. As far as I see the current rate is close to 100%
true positives. We already have 40 leaks (>50%) fixed.

Though, kmemleak can be improved too (stop-the-world, etc what we
discussed). That would make kmemleak directly usable e.g. during
unit-testing, something that's badly needed for kernel.


> Just to be clear, I'm not talking about syzbot in general, it's a great
> tool, only about improving kmemleak reporting and bisecting.
