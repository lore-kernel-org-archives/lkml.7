Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A6AC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F82067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F75GqaZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfDYMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:38:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XqVA4owxqT27GNJpHmX8jhJ7/6kEV8Pt0Cjgq247ZIA=; b=F75GqaZ0A6oPqiHXXkcqEZUNy
        vN01oasCTw2hO5T9WYTYsdpmSmeGKxDjRjvWjehCxQsfVQPbjhNnENhneodcpMFfI8+HBvhMG9lgr
        cbQkgELPK0JM/PpPR0GcpEjgjSlCD3GzDkwNSlglBVXoLtKogsozflGgLCqljE8oIJT/Mme2M8kDF
        4FDiRrYhzpFqmy3jixzpzyXjxzPsM9aQuLiC3cqRrcA9VkHhhE9rl1v9hmAEGKDFmrDmkPxvtY3xd
        kQb6UAhbvH0GHU/XsiZX0mrrlE34FkEoPk48GH7xB96C53vevv5ihBdHs54mutkR94Qq9prQQ+NWK
        KqdqHFx5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJddd-0007Bc-Lv; Thu, 25 Apr 2019 12:38:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 179AE29C42D01; Thu, 25 Apr 2019 14:38:04 +0200 (CEST)
Date:   Thu, 25 Apr 2019 14:38:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] x86 / CPU: Add cpu isolation flag for avoiding
 disturbance from aperfmperf IPI
Message-ID: <20190425123804.GU4038@hirez.programming.kicks-ass.net>
References: <155618921176.2006.3031084313219003524.stgit@buzz>
 <20190425114503.GP4038@hirez.programming.kicks-ass.net>
 <8b54ebf5-7daf-2760-7210-e0e945014c9e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b54ebf5-7daf-2760-7210-e0e945014c9e@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:27:12PM +0300, Konstantin Khlebnikov wrote:
> On 25.04.2019 14:45, Peter Zijlstra wrote:
> > On Thu, Apr 25, 2019 at 01:46:51PM +0300, Konstantin Khlebnikov wrote:
> > > Sensitive workloads like DPDK polling do not like any interrupts.
> > > 
> > > This patch adds flag 'freq' for boot option 'isolcpu': isolcpu=freq,<cpus>.
> > > 
> > > Users like show_cpuinfo() fallback to frequency from generic cpufreq
> > > policy if arch-specific requesting method returns 0.
> > 
> > Then don't touch that sysfs file?
> 
> What sysfs file?

/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

> I mean many applications read /proc/cpuinfo and this triggers IPI to all cpus.

Argh, I missed it was wired into that too :/

> > I really hate having an option for just this.
> > 
> 
> This could be generalized to 'isolate cpu from unnecessary IPI'.
> Something like mm pagevec drain also could be avoided.

Well, that should be a default feature of nohz full, no additional flags
required.
