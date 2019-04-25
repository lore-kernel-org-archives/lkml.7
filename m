Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7231C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556179008;
	bh=0/ch1oWAq7qCcc5Y7CuuRNDPEeC8DEv3Xfr3XlwIIgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uhDb3XflEz1ZxLUotq+KsrojHPdN0a9/RogH/e+yMEiACzhNVz6kVEuGy0J575F0
	 SSGuoAk0rBElkz1e9Wo09Sj2hzlctHrkpV5+d/AibIZR1QirpxLyHsfbqEBtfElg5J
	 qhuCscmbbAhjY48UvR/lUVS/+sD2lmiXZmH8SeX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDYH4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfDYH4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:56:46 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4894F208E4;
        Thu, 25 Apr 2019 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556179005;
        bh=0/ch1oWAq7qCcc5Y7CuuRNDPEeC8DEv3Xfr3XlwIIgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3nryUeUBKPWngGvGY4ewSRwbV2EoW+ojjRfYpGrSmOPOMHyVDSlftvTavB6qJYfk
         kleLOLgwSwswNBWCvtxnEswUozHVwWR3G5O1SFNhWgu+83ppOqDlLla9LaPOwPsjZS
         REGyeeEzmJ8xpwaVDjfNVj+bSQsdoA4IeeNVAT48=
Date:   Thu, 25 Apr 2019 09:56:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org,
        syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 031/104] locking/lockdep: Add debug_locks check in
 __lock_downgrade()
Message-ID: <20190425075643.GA7745@kroah.com>
References: <20190424170839.996641496@linuxfoundation.org>
 <20190424170857.262137613@linuxfoundation.org>
 <36884649-83bb-67b6-168b-7b178ead7ddf@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36884649-83bb-67b6-168b-7b178ead7ddf@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:30:35AM +0900, Tetsuo Handa wrote:
> On 2019/04/25 2:08, Greg Kroah-Hartman wrote:
> > [ Upstream commit 71492580571467fb7177aade19c18ce7486267f5 ]
> > 
> > Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
> > warning right after a previous lockdep warning. It is likely that the
> > previous warning turned off lock debugging causing the lockdep to have
> > inconsistency states leading to the lock downgrade warning.
> > 
> > Fix that by add a check for debug_locks at the beginning of
> > __lock_downgrade().
> 
> Excuse me?
> 
> > 
> > Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Link: https://lkml.kernel.org/r/1547093005-26085-1-git-send-email-longman@redhat.com
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  kernel/locking/lockdep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index fb90ca3a296e..27de98428367 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3312,6 +3312,9 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
> >  	unsigned int depth;
> >  	int i;
> >  
> > +	if (unlikely(!debug_locks))
> > +		return 0;
> > +
> 
> This is __lock_set_class() function rather than __lock_downgrade() function.
> __lock_downgrade() is available in 4.12+.
> 
> For 3.18-stable, downgrade_write() is in kernel/locking/rwsem.c . Therefore,
> we should check whether adding this check into __lock_set_class() is what
> we want to do...

Ugh, this got backported incorrectly to 4.4.y as well, let me check
4.9.y...  Yup, that's wrong too.

As is 4.14.y.

As is 4.19.y.

Hey, I got it right in 5.0.y!

Ok, let me go drop this 3.18.y patch, and revert it from all of the
other trees for now as well, thanks for catching this.

greg k-h
