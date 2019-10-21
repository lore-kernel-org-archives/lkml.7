Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858562084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zgDfAzKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJUOJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:09:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eGE87WasWvAZRrliofAskcX6jOVuVTgdyEc8K2kaY9E=; b=zgDfAzKxJll3WnPmislBw4XlD
        jvA92XRULfcDJU2Wc2VcX2mmnQYAkO29N/ZaXZULMlwY/T+zsSojytnCQhOYhd/JUIi0P6luvqP8X
        sPTPlKdQSe+F11Qap2TMrxmIezEHa+gpuhUtHETlK2UZmP6HEL6rIUM3TPIw4ZJV2pujfhc9G/Pdm
        HBzx4aEKxynzo+mQnu/1VnGaHWsBlMIvI3OowVJ5wGe4OTlTswauQfzqgXyGx6bF3NYlkLV8YpDHH
        x1AoNa+S00Hx1OumvMrqYyACCW5SmWznuXU5zIOz4+yKfz5xcuyYIwJZ3IXEKVA1bpgobJ55SBHfM
        Uz612X0Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMYND-0005k7-JC; Mon, 21 Oct 2019 14:09:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1D1D301124;
        Mon, 21 Oct 2019 16:08:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15C52238D26BD; Mon, 21 Oct 2019 16:09:26 +0200 (CEST)
Date:   Mon, 21 Oct 2019 16:09:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog/softlockup: Report the same softlockup
 regularly
Message-ID: <20191021140926.GH1817@hirez.programming.kicks-ass.net>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-3-pmladek@suse.com>
 <20191021124339.GE1817@hirez.programming.kicks-ass.net>
 <20191021134038.fz2cdpxrd3p3yhb7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021134038.fz2cdpxrd3p3yhb7@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:40:38PM +0200, Petr Mladek wrote:
> On Mon 2019-10-21 14:43:39, Peter Zijlstra wrote:
> > On Mon, Aug 19, 2019 at 12:47:31PM +0200, Petr Mladek wrote:
> > > Softlockup report means that there is no progress on the given CPU. It
> > > might be a "short" affair where the system gets recovered. But often
> > > the system stops being responsive and need to get rebooted.
> > > 
> > > The softlockup might be root of the problems or just a symptom. It might
> > > be a deadlock, livelock, or often repeated state.
> > > 
> > > Regular reports help to distinguish different situations. Fortunately,
> > > the watchdog is finally able to show correct information how long
> > > softlockup_fn() was not scheduled.
> > > 
> > > Report before this patch:
> > > 
> > > [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]
> > > 
> > > And after this patch:
> > > 
> > > [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
> > > [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
> > > [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
> > > [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
> > > 
> > > Note that the horrible code never really worked before the accounting
> > > was fixed. The last working timestamp was regularly lost by the many
> > > touch*watchdog() calls.
> > 
> > So what's the point of patch 1? Just confusing people?
> 
> I was not sure what was the expected behavior. The code actually
> looked like only the first report was wanted. But it probably never
> worked that way.

Not that I can remember at least :-) I normally don't bother with the
actual time, and if I do then I look at the printk timestamps to figure
out how long thing've been stuck.

But this is indeed nicer..

> Should I squash the two patches and send it again, please?

Probably makes sense to squash it. That also avoids having to ever
expose that ugleh :-)

