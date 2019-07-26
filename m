Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23808C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F921852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/SemTMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfGZQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:05:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:05:46 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so105713968iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoOpJrER5lkg8Em3wVFNio3C8LuUFynD4kdmk02EVZ0=;
        b=K/SemTMCiXyHQbxfV2/uM8winVoyG6FtMvMdX/B+Oqq2d1DvUDoowKjgxlbhSDPVEP
         6N2KrxCjCa3L6kPlOHoOmcyt4p29enh4lTg2fySZvfq2wqMET4gI9XXsxGYZQ30Zgxpx
         1Yd6fx1meAwrU3ECP7TW7HHVeOujY4aD4OjAWxDNBjmUMU8gThZsy3oReR5/++8YoNjg
         9YtuwFes1R2FIKfjGXpy8bFLIVBn75lR8c8VZYeGaDyXzPNEgxkWlL6wjU4v0Qch10d4
         xXy75iwQ/8GTCO7xHgzprutgoPpUT5Cs21giNQHKN69g1Xz2CFHIezxUic9NvJFMkz/a
         yw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoOpJrER5lkg8Em3wVFNio3C8LuUFynD4kdmk02EVZ0=;
        b=D7pId7iJdKHlpf7jTPJVu+ubXj1dVufI20767Xu1lIPJMiG1rCCvSQeiYHY7aXsVT9
         KCIzae6g6bBSJPRvyWDLHfkqt4myGU5TJe1axT1YtRSzyapR/a9dlSWITDSbwhU7XpjJ
         2E1VpcBy9abELGlIg48NVBREw7nXW2CT1nyQtlHgJpseWrv/PKY9CSX0sL0JDbAL9Zk0
         IrU0bgsyJWXxMiwvkFm1RDIJAuIaY+DsdSk4rwE5/qf3UwVckscV1MT0AFpVD4k4AZcc
         QqqgUwL0GIGbRdPxFms/5myLsaFa58Chx4CCTR4PoPDNBxkjForX61a469TuGo6vRfDH
         scDA==
X-Gm-Message-State: APjAAAW3nCAoJ8RizhmaZXieLx7QucLi6vzDRDpxP11DK7+mRMfJRz3U
        AnPrFGNeRvhhmg04X7tBD8/gMCCSG2lfSiGkXDZC3Q==
X-Google-Smtp-Source: APXvYqx1DMdxq/O+3koIzpoMVm15SRd82G8zIAIH2kBNUwLkI3sjNquWgQypNmv9GFwq6RmdFU5SwnkJU44a6givHcA=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr61984828ioa.138.1564157145336;
 Fri, 26 Jul 2019 09:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052ad6b058e722ba4@google.com> <20190726130013.GC2368@arrakis.emea.arm.com>
 <CACT4Y+b5H4jvY34iT2K0m6a2HCpzgKd3dtv+YFsApp=-18B+pw@mail.gmail.com> <20190726155732.GA30211@e109758.arm.com>
In-Reply-To: <20190726155732.GA30211@e109758.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jul 2019 18:05:32 +0200
Message-ID: <CACT4Y+Zf-p7CTRZd8x+2ymAXho2tM_5hLCn3ODJXPVuocMxwbw@mail.gmail.com>
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

On Fri, Jul 26, 2019 at 5:57 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jul 26, 2019 at 05:20:55PM +0200, Dmitry Vyukov wrote:
> > On Fri, Jul 26, 2019 at 3:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, Jul 24, 2019 at 12:18:07PM -0700, syzbot wrote:
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15fffef4600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a871c1e6ea00685e73d7
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127b0334600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609e94600000
> > > >
> > > > The bug was bisected to:
> > > >
> > > > commit 0e5f7d0b39e1f184dc25e3adb580c79e85332167
> > > > Author: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > Date:   Wed Mar 16 13:19:49 2016 +0000
> > > >
> > > >     ARM: dts: at91: shdwc binding: add new shutdown controller documentation
> > >
> > > That's another wrong commit identification (a documentation patch should
> > > not cause a memory leak).
> > >
> > > I don't really think kmemleak, with its relatively high rate of false
> > > positives, is suitable for automated testing like syzbot. You could
> >
> > Do you mean automated testing in general, or bisection only?
> > The wrong commit identification is related to bisection only, but you
> > generalized it to automated testing in general. So which exactly you
> > mean?
>
> I probably meant both. In terms of automated testing and reporting, if
> the false positives rate is high, people start ignoring the reports. So
> it requires some human checking first (or make the tool more robust).
>
> W.r.t. bisection, the false negatives (rather than positives) will cause
> the tool to miss the problematic commit and misreport. I'm not sure you
> can make the reporting deterministic on successive runs given that you
> changed the kernel HEAD (for bisection). But it may get better if you
> have a "stopscan" kmemleak option which freezes the machine during
> scanning (it has been discussed in the past but I really struggle to
> find time to work on it; any help appreciated ;)).


Do you have any data points wrt automated testing in general? This
disagrees with what I see.

For bisection, I agree. Need to look at the data we got over the past
days when it become enabled. But I suspect that, yes, false positives,
flakes, and other true leaks can make it infeasible.
