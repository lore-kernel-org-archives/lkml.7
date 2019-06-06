Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5178C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9890020868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfFFJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:41:58 -0400
Received: from foss.arm.com ([217.140.101.70]:44012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfFFJl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:41:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C26341;
        Thu,  6 Jun 2019 02:41:57 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2E53F690;
        Thu,  6 Jun 2019 02:41:56 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:41:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <jglauber@marvell.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Glauber <jglauber@cavium.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [PATCH] lockref: Limit number of cmpxchg loop retries
Message-ID: <20190606094154.GB6795@fuggles.cambridge.arm.com>
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190605134849.28108-1-jglauber@marvell.com>
 <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
 <20190606080317.GA10606@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606080317.GA10606@hc>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:03:27AM +0000, Jan Glauber wrote:
> On Wed, Jun 05, 2019 at 01:16:46PM -0700, Linus Torvalds wrote:
> > On Wed, Jun 5, 2019 at 6:49 AM Jan Glauber <jglauber@cavium.com> wrote:
> > >
> > > Add an upper bound to the loop to force the fallback to spinlocks
> > > after some time. A retry value of 100 should not impact any hardware
> > > that does not have this issue.
> > >
> > > With the retry limit the performance of an open-close testcase
> > > improved between 60-70% on ThunderX2.
> > 
> > Btw, did you do any kind of performance analysis across different
> > retry limit values?
> 
> I tried 15/50/100/200/500, results were largely identical up to 100.
> For SMT=4 a higher retry value might be better, but unless we can add a
> sysctl value 100 looked like a good compromise to me.

Perhaps I'm just getting confused pre-morning-coffee, but I thought the
original complaint (and the reason for this patch even existing) was that
when many CPUs were hammering the lockref then performance tanked? In which
case, increasing the threshold as the number of CPUs increases seems
counter-intuitive to me because it suggests that the larger the system,
the harder we should try to make the cmpxchg work.

Will
