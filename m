Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06744C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20FA21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfK9Qs3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfDSTbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:31:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfDSTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EeK/UKGIlkcrqy9X052/pZ9M/vDBfGLns9hKVfQ8IQQ=; b=jfK9Qs3qnJDlHfY7Orm1Fyq3a
        gb4IbW9elW1czyt1dp25Z02CHzCyRLRDGOUQD9Sh6ZBltx3Y/iFY1bfEkcTSLVyUaH0aN1r7qEMq7
        IPUeglqHLzMEWszL2aj2mZLXy5EEDMgdyBoZKv7bt/cRLs1Yh4/lk+8zaCz3AF181P///tm/AXtyL
        nUGR5udDJKK6taam8rUe3j6hsPhRCxQ9bwomXNORdHGi446XX6SMRBqwlFsRQ1HVXzYg+5gi/8rGZ
        VGP6Mra0JlRQtOvihaTNnvuTf25XJRXyfk21CLtoSd7bUiJl+ky2ktiCJJksd2sT7cXy3GXh7mueQ
        1vuLSvOKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHTMR-0005n8-Ul; Fri, 19 Apr 2019 13:15:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 997EB29BF0BFE; Fri, 19 Apr 2019 15:15:22 +0200 (CEST)
Date:   Fri, 19 Apr 2019 15:15:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190419131522.GW14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-15-longman@redhat.com>
 <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419130304.GV14281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 03:03:04PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 19, 2019 at 02:02:07PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 19, 2019 at 12:26:47PM +0200, Peter Zijlstra wrote:
> > > I thought of a horrible horrible alternative:
> > 
> > Hurm, that's broken as heck. Let me try again.
> 
> So I can't make that scheme work, it all ends up wanting to have
> cmpxchg().
> 
> Do we have a performance comparison somewhere of xadd vs cmpxchg
> readers? I tried looking in the old threads, but I can't seem to locate
> it.
> 
> We need new instructions :/ Or more clever than I can muster just now.

In particular, an (unsigned) saturation arithmetic variant of XADD would
be very nice to have at this point.
