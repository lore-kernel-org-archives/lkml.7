Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBAE2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x4x2vc6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfDPRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:37:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rY30XL8+ypP0Pufcsv2Q3EE2EU/yIGQk8HBVJ0EQZHA=; b=x4x2vc6TlE98U3X5q8/uGI7/ZJ
        HBaixrIn0oxfvX/ejs9xd7blZwGdCu3Mwt9oBuXo02PUHvgMtKimBIGbEyhj32A/3WpUxpZQmPBM4
        UVznDYrfjRB6Veski24sMu5Q2qmRsCmnrUttrS/7l+aUh6JX2WtXiUCdSTlsMTUtiaaQkkgKUf4Sg
        TOxBBbS10v2be5FsYXDD9jj9V9kqaVLlDLIiegxymdG5iro27P8LBXNywhIz1qaeQUFelMJ1F9PS7
        W+LelW0Qdr6Ao67WyM0AXZQ2a2V8e9YjGK7i2kBD6opN9VebZ1EPE2hZIVkE1+QjVGZl+sXePPw/s
        muXAm8Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGS11-0004h4-9K; Tue, 16 Apr 2019 17:37:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E3DA29B27D87; Tue, 16 Apr 2019 19:37:00 +0200 (CEST)
Date:   Tue, 16 Apr 2019 19:37:00 +0200
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
Message-ID: <20190416173700.GQ4038@hirez.programming.kicks-ass.net>
References: <20190415205829.32707-1-longman@redhat.com>
 <20190416131047.GW11158@hirez.programming.kicks-ass.net>
 <4747d10b-e9a4-f453-ab4e-13fc984a4067@redhat.com>
 <20190416141747.GN4038@hirez.programming.kicks-ass.net>
 <18af71ce-1ef3-c6cd-4088-3b2a9bf0016e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18af71ce-1ef3-c6cd-4088-3b2a9bf0016e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:03:10PM -0400, Waiman Long wrote:
> On 04/16/2019 10:17 AM, Peter Zijlstra wrote:
> > On Tue, Apr 16, 2019 at 09:18:50AM -0400, Waiman Long wrote:
> >> On 04/16/2019 09:10 AM, Peter Zijlstra wrote:
> >>> On Mon, Apr 15, 2019 at 04:58:27PM -0400, Waiman Long wrote:
> >>>> This series contain 2 follow-up patches to alleviate the performance
> >>>> regression found in the page_fault1 test of the will-it-scale benchmark.
> >>>> This does not recover all the lost performance, but reclaim a sizeable
> >>>> portion of it.
> >>>>
> >>>> The regression was found on an Intel system. I have run the test on
> >>>> an AMD system. The regression wasn't seen there.  There are only minor
> >>>> variations in performance. Perhaps the page fault path is quite different
> >>>> between Intel and AMD systems.
> >>> Can you please just fold this back into the appropriate patches? Trying
> >>> to review all the back and forth is painful.
> >> I will send out an update part 2 patch with patch 1 of this series
> >> merged into the writer spinning on reader patch. Patch 2 of this series
> >> will be a standalone one.
> > Hmm, in that case I can fold it back too. So hold off on sending it.
> >
> > I thought #2 was a fixup for an earlier patch as well.
> 
> #2 is a performance fix.

Of this patch?

206038 N T Apr 13 Waiman Long     (7.5K) ├─>[PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer

Fixes should have a Fixes: tag. And if the patch it fixes isn't a commit
yet, the patch should be refreshed to not need a fix.
