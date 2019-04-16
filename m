Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872AAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8A20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k44v1PNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfDPNLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:11:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45464 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfDPNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bv3JqS1h0FfkOhLZWJeILwPGrFooc02SKas4ytoJty4=; b=k44v1PNZTEplQhsJMbRsF+2uH
        HkH49yFNsW0eXYekJzQMIk4yYNewlajCjCycTQRF3bsmeUA2RSUYPxw/v7lMMvsNsgP3WswNLxba2
        Pq+OxiQBKfs5t3tj4eKbv0DaNx2Q1TvP0IXVkttSI/asTfN6S5oiFiBsuDDDQalPrvvMLmmyg+q2m
        lL4oJZsNmPEOqwS6s9bAIwsKWT5yNSJbegrfDrVy9qNvBNYEJC+jovCNmjNUVjUeKq27f7Ct8dQoD
        p5GuLwVPa/ZWc/vtpq18spp329ZrGp15LxZGcrpHBeBX7i28B5RK9WQCa6x51ryU5DimUIEiQZwiM
        4jjH2DsGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGNrO-0002bs-DD; Tue, 16 Apr 2019 13:10:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D6D629B5EFAF; Tue, 16 Apr 2019 15:10:47 +0200 (CEST)
Date:   Tue, 16 Apr 2019 15:10:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip 0/2] locking/rwsem: Rwsem rearchitecture part 2
 follow-up patches
Message-ID: <20190416131047.GW11158@hirez.programming.kicks-ass.net>
References: <20190415205829.32707-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415205829.32707-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:58:27PM -0400, Waiman Long wrote:
> This series contain 2 follow-up patches to alleviate the performance
> regression found in the page_fault1 test of the will-it-scale benchmark.
> This does not recover all the lost performance, but reclaim a sizeable
> portion of it.
> 
> The regression was found on an Intel system. I have run the test on
> an AMD system. The regression wasn't seen there.  There are only minor
> variations in performance. Perhaps the page fault path is quite different
> between Intel and AMD systems.

Can you please just fold this back into the appropriate patches? Trying
to review all the back and forth is painful.
