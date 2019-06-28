Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B32208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561719842;
	bh=617G/COSgHc1PxFQNtQ74y+onsCaA4vkrdPfIUClF1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OEPen1SRye0M6YKi4u/Jt+WhMU9gmbxtrKGImbi9wkV1REZ0OSRP2jvAzJHt/u+b6
	 nQi1O6U4wr5BC2/PHyeHnmM0yFNeM+M1W796SsLOMfASjJ3piEPnaKw4NLxRmllNeT
	 GaekmnZg5NZmdBl9hbqh3l1ma/xBhjiiSOla3J4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfF1LEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfF1LEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:04:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BDC20645;
        Fri, 28 Jun 2019 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561719839;
        bh=617G/COSgHc1PxFQNtQ74y+onsCaA4vkrdPfIUClF1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oO+e/+SF6aE/wnCBgn1fDu34odP5B+RANepyWNkxGB52xVZ7bGJ1ngBcg15zCG/8t
         9QlRt0pjssRmzV+p1NBwA5yewiLXiC7Qd2B2RFRPB9nNJd/L8UcynncrcNxh2v+Z+Y
         VLBQukF2ihVI61tOymZp2ILpyERFrnguU9yPna5o=
Date:   Fri, 28 Jun 2019 12:03:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Yuyang Du <duyuyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: clean up #ifdef checks
Message-ID: <20190628110353.ijd42pbhqfsdsi2n@willie-the-truck>
References: <20190628102919.2345242-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628102919.2345242-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jun 28, 2019 at 12:29:03PM +0200, Arnd Bergmann wrote:
> As Will Deacon points out, CONFIG_PROVE_LOCKING implies TRACE_IRQFLAGS,
> so the conditions I added in the previous patch, and some others in the
> same file can be simplified by only checking for the former.
> 
> No functional change.
> 
> Fixes: 886532aee3cd ("locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/locking/lockdep.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Thanks for following up on this. I think it makes the code easier to read,
so:

Acked-by: Will Deacon <will@kernel.org>

Will
