Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2FC206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsXOElIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCELoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:44:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCELoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4d3uPbgoW9Ou/9nQNRQtXaXcNQF6nLUyGCwHg1/4rbA=; b=JsXOElIlqmnYFV7/f8EQm/0lB
        mcOr44rCm5GcYTWMkoOC7/i3AIIbYAGT7INJ/hZ+fWi1XgX/6AOcE43wx8SaRFyAnu/hXp6tUzAa1
        MTx9qvH9wzpaDMTYq2I3BjBZSzTAqs2j8226yVi3xoNsqHR5VPPik0pzNfLywCWWGf94ztsb8NuUK
        ioVu07TgUGOcToGvJ1bTiMyMCxzEv0hxXuXoEBMJMTzhpnmcfkILFADYHoA1JHqo81Sk4FJ8CnmU2
        TmKn8mw9Cdd38vtv97nUGUBEbB+DBuJapQoQQGOtRUDLydetHx3O4S5Dt7x4OEIiYg9bWzMUFxLWI
        ddIHCJdxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h18US-0002av-MM; Tue, 05 Mar 2019 11:44:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7285B202883B6; Tue,  5 Mar 2019 12:44:06 +0100 (CET)
Date:   Tue, 5 Mar 2019 12:44:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190305114406.GV32494@hirez.programming.kicks-ass.net>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6357319.Iupbu3ldGQ@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> I will need to recompute sg_cpu->min in sugov_limits().

So there's still an open question; do we want that ->min thing to depend
on available frequencies _at_all_ ?

I'm thinking it might be a good thing to have the iowait boost curve be
independent of all that.

Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
for it to reach 1024 (max). While now the curve depends on how wide the
gap is between min_freq and max_freq. And it seems weird to have this
behaviour depend on that. To me at least.

Now, I don't know if 128/9 is the right curve, it is just a random
number I pulled out of a hat. But it seems to make more sense than
depending on frequencies.


