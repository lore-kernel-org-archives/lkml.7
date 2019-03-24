Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59907C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A58320989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfCXSjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:39:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXSjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:39:47 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8824-0005GP-6C; Sun, 24 Mar 2019 19:39:44 +0100
Date:   Sun, 24 Mar 2019 19:39:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] scheduler updates for 5.1
In-Reply-To: <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903241929290.1798@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de> <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de> <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-358097516-1553452784=:1798"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-358097516-1553452784=:1798
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 24 Mar 2019, Linus Torvalds wrote:

> On Sun, Mar 24, 2019 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Second more careful attempt for this set of fixes:
> 
> What? No. It's the exact same garbage as last time, with no more care
> shown anywhere:
> 
>   kernel/sched/cpufreq_schedutil.c:346:26: note: in expansion of macro ‘min’
>      sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1,
> SCHED_CAPACITY_SCALE);
> 
> I told you *exactly* what the problem was the last time, and it's
> *exactly* the same now too.
> 
> Hmm. Looking closer, I see that the patch you *claim* to send me has
> "min_t()". But the tree I actually got has the same old garbage.
> 
> I suspect you didn't update the git repo properly or something.

Duh. Just did

git checkout sched-urgent-for-linus
git diff sched/urgent	-> empty
git diff origin/sched/urgent -> empty
git diff origin/sched-urgent-for-linus -> empty

Now doing a fresh clone from git.k.org (not ssh) shows me the stale commit
from last week.

I'm sure that I force pushed and my pull request script checks whether all
branches are up to date before creating the pull request mail. No idea at
all what went wrong.

I just force pushed the thing once more. The head commit is:

  b9a7b8831600: sched/fair: Skip LLC NOHZ logic for asymmetric systems

I'll add that to the pull request mail scripts in future.

It has propagated to gitweb now as well.

Thanks,

	tglx

--8323329-358097516-1553452784=:1798--
