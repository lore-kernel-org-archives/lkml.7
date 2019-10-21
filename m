Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BFC21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IK53TzyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfJUMnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:43:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfJUMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W208iAKhnrpYar+NC/MwFXKY50BC0Ke2j8viCg/6BJc=; b=IK53TzyGP6fZNTe/sYUuLGQlr
        KoMfMOuvY283bNFipmCZ+0ZkKLFxg7TBaXLNCm6pkTmBSooLGXO+Nmm6rplsQpux0hdnkBjVtk91x
        /3E5InJBbufuxowUc2iYB+e9yZhryGWuBbEcMdSkX97rF/nknRTnC1E9aGWXfvFNfErQ+XeMiFkRS
        f+7J2agIavBb+1yjXvoD3ipae+YfLUBF5qfkm1YbztjlLAL8xNDYRf1MJ808tGghTKXNf9/4mUyNW
        INzo+CZKGm7vxfyvW8dREntcAteccVimFnZjid7VZs/jzAu4lN5DdzjB2+GHvq6eojhmuU9gAvdvV
        Z6jpsfSuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMX2C-0004WQ-MF; Mon, 21 Oct 2019 12:43:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56472301124;
        Mon, 21 Oct 2019 14:42:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D5E12022BA17; Mon, 21 Oct 2019 14:43:39 +0200 (CEST)
Date:   Mon, 21 Oct 2019 14:43:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog/softlockup: Report the same softlockup
 regularly
Message-ID: <20191021124339.GE1817@hirez.programming.kicks-ass.net>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819104732.20966-3-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:47:31PM +0200, Petr Mladek wrote:
> Softlockup report means that there is no progress on the given CPU. It
> might be a "short" affair where the system gets recovered. But often
> the system stops being responsive and need to get rebooted.
> 
> The softlockup might be root of the problems or just a symptom. It might
> be a deadlock, livelock, or often repeated state.
> 
> Regular reports help to distinguish different situations. Fortunately,
> the watchdog is finally able to show correct information how long
> softlockup_fn() was not scheduled.
> 
> Report before this patch:
> 
> [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]
> 
> And after this patch:
> 
> [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
> [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
> [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
> [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
> 
> Note that the horrible code never really worked before the accounting
> was fixed. The last working timestamp was regularly lost by the many
> touch*watchdog() calls.

So what's the point of patch 1? Just confusing people?
