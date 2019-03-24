Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7148521741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCXAEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 20:04:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfCXAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 20:04:29 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7qci-0000yZ-IJ; Sun, 24 Mar 2019 01:04:24 +0100
Date:   Sun, 24 Mar 2019 01:04:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com>
cc:     andrea.parri@amarulasolutions.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: BUG: soft lockup in kvm_vm_release
In-Reply-To: <000000000000958aa50584c851b7@google.com>
Message-ID: <alpine.DEB.2.21.1903240058290.1798@nanos.tec.linutronix.de>
References: <000000000000958aa50584c851b7@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019, syzbot wrote:

> syzbot has bisected this bug to:
> 
> commit 80eb865768703c0f85a0603762742ae1dedf21f0
> Author: Andrea Parri <andrea.parri@amarulasolutions.com>
> Date:   Tue Nov 27 11:01:10 2018 +0000
> 
>    sched/fair: Clean up comment in nohz_idle_balance()

I.m pretty sure that this bisect is bogus. The commit changes a comment not
code.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1362209b200000
> start commit:   57902dc0 Merge tag 'riscv-for-linus-5.0-rc7' of git://git...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e2209b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1762209b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=6349a512c2938b2ad058
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14287e78c00000
> 
> Reported-by: syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com
> Fixes: 80eb86576870 ("sched/fair: Clean up comment in nohz_idle_balance()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If I understand that correctly, then the bisect does not try to revert the
commit which it identified on top of the tree where it started to bisect.

I think that'd be a reasonably simple to do extra data point, at least when
the commit reverts cleanly on head.

Thanks,

	tglx



