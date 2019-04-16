Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51620223F0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tG0zFPI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfDPOSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:18:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ai8WgkRP0VJHOWJwhXwI7N3qj5XvSYllTNSj3maOh+A=; b=tG0zFPI1QFl3L9VIzQpgY0EVE
        HUDT+d6HdpDWYZd5E8XS4AQ1s/Sub9ioRMJE9WfhCi0MKits3y25aLhWk3JHF/3RFKjEShaW0trp6
        2nvnQk6YB1Eisyf663ETWEd5iTEKClNkx2zTUhobD17VPNI+huMLns0C8sLnzrHRlQ6UkStn06Frx
        MrovZroKL4iEko21jowiDS8q6Ft0quWeyfB6erJejxfre80N27U6pGKXuAwbugVT4TSXe7BAISwlW
        U3RIa2h0X46AhmDY/5nmbSbCNRg4k4MdW1HeZbNyVJByHm8ORaEJYHV78IT/91D05HMY4nlBorjhQ
        UAt5bgEEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGOuk-0003V7-5d; Tue, 16 Apr 2019 14:18:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFC5C29AC1639; Tue, 16 Apr 2019 16:18:20 +0200 (CEST)
Date:   Tue, 16 Apr 2019 16:18:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 04/16] locking/rwsem: Implement a new locking scheme
Message-ID: <20190416141820.GO4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-5-longman@redhat.com>
 <20190416132218.GJ12232@hirez.programming.kicks-ass.net>
 <f6ec3b2e-5a23-d447-cf7d-459f81f5fce4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ec3b2e-5a23-d447-cf7d-459f81f5fce4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 09:32:38AM -0400, Waiman Long wrote:
> On 04/16/2019 09:22 AM, Peter Zijlstra wrote:
> > On Sat, Apr 13, 2019 at 01:22:47PM -0400, Waiman Long wrote:
> >> +#define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
> > The above doesn't seem to make it more readable or shorter.
> 
> Fair enough. I can remove that macro.

I did the same for the HANDOFF patch but seem to have misplaced the
delta and have already refreshed the patch.
