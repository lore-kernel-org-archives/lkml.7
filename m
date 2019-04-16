Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B968C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB51223EA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uJcRR0v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfDPOSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:18:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lqJk8B1z7WsrVbN/AIY5pxzP/xd/p69LBwimCXdctj4=; b=uJcRR0v5GLXsxy1ONeAX6yWQY
        CLJIRtdmuzytkV6NyDnJAmZjquKL5vNPaqZ/HpbpnFRF75I5lME1noEimr6zivLY6HJDZa11KUOrI
        lyiv00u/v7Knu7K6kNWjbd0/0yg3QuhN6PQze1xRO9l2Gt4pX3on8I0Vrfof4q7gjJP6QddSX9AIp
        pYWtivIjiqCemHKzNY8Ne1iaLnelSHIxNeojk9lSDMFwsZMM+K6AgG5IzSSZzsDrxz/4viEaJq/l3
        bhSJp0BXMw3IuDoeuV4Jpo1hc6X/21Ih0NRXsitG3gZ6f6Pj5GG1LpEwfnuIv3hw6DlPWn1XBgr6W
        rtRQJM/MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGOuE-0003Bs-11; Tue, 16 Apr 2019 14:17:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B33D28B8C290; Tue, 16 Apr 2019 16:17:47 +0200 (CEST)
Date:   Tue, 16 Apr 2019 16:17:47 +0200
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
Message-ID: <20190416141747.GN4038@hirez.programming.kicks-ass.net>
References: <20190415205829.32707-1-longman@redhat.com>
 <20190416131047.GW11158@hirez.programming.kicks-ass.net>
 <4747d10b-e9a4-f453-ab4e-13fc984a4067@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4747d10b-e9a4-f453-ab4e-13fc984a4067@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 09:18:50AM -0400, Waiman Long wrote:
> On 04/16/2019 09:10 AM, Peter Zijlstra wrote:
> > On Mon, Apr 15, 2019 at 04:58:27PM -0400, Waiman Long wrote:
> >> This series contain 2 follow-up patches to alleviate the performance
> >> regression found in the page_fault1 test of the will-it-scale benchmark.
> >> This does not recover all the lost performance, but reclaim a sizeable
> >> portion of it.
> >>
> >> The regression was found on an Intel system. I have run the test on
> >> an AMD system. The regression wasn't seen there.  There are only minor
> >> variations in performance. Perhaps the page fault path is quite different
> >> between Intel and AMD systems.
> > Can you please just fold this back into the appropriate patches? Trying
> > to review all the back and forth is painful.
> 
> I will send out an update part 2 patch with patch 1 of this series
> merged into the writer spinning on reader patch. Patch 2 of this series
> will be a standalone one.

Hmm, in that case I can fold it back too. So hold off on sending it.

I thought #2 was a fixup for an earlier patch as well.
