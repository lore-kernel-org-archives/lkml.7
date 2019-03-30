Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B539C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299272184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfC3Hqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:46:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfC3Hqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:46:53 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hA8hP-0007AF-Dw; Sat, 30 Mar 2019 08:46:43 +0100
Date:   Sat, 30 Mar 2019 08:46:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: INFO: rcu detected stall in corrupted (3)
In-Reply-To: <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
References: <000000000000b08190058543449f@google.com> <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1078579579-1553932003=:2476"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1078579579-1553932003=:2476
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 30 Mar 2019, Tetsuo Handa wrote:

> On 2019/03/30 7:34, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    8c2ffd91 Linux 5.1-rc2
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15099d2b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=65cecdd27b726c261799
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3c67d200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4f317200000
> > 
> > Bisection is inconclusive: the bug happens on the oldest tested release.
> 
> This reproducer does sched_setattr(SCHED_DEADLINE) with bogus value, as with
> a reproducer for "INFO: rcu detected stall in sys_sendfile64" did.
> 
> sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_DEADLINE */,
> sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=65535,
> sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
>
> #syz invalid

Marking this invalid is not really the right thing to do. Bogus deadline
parameters should not cause RCU stalls. They either need to be rejected or
handled gracefully.

Thanks,

	tglx
--8323329-1078579579-1553932003=:2476--
