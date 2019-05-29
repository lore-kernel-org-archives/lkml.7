Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C6923D53
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxMf8L/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfE2QUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:20:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/8pC2Hn7gRhW5G0Og5+C55SRZVyXqzKThTaGW0BzRQ8=; b=lxMf8L/aCTixIWRtMg98J3Lxt
        b8PXSgP46mpHZs2t+m6S/RKL0XHFa38ogoVlvoC18znOIEd1gMvcsgBdCBDbXlYVQkXeUoWaC+DhZ
        SoSzdUMeNKu1XbZVTJejnUAqRcOG0kWUyMkkprH79Mt/xlf+tql3yS97Ms+yC4PxuWjnWX+mOESMM
        yLsmhZFxczk5jGZS2KnhsWE1lFqFiuswbg8dzxQrNdEDA2RmFVblVO165V3b5hHcWhU2AdBe3AtXm
        qeLOteZs9n92QWvjeS8zm7To5ABvL7uMBkqQYrhVRSM90M1q4L46RnFsYOBDfIwZpReHQpgXF02+7
        f3hqBz0ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1J0-0002Dz-4p; Wed, 29 May 2019 16:19:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0751D201CF1CB; Wed, 29 May 2019 18:19:56 +0200 (CEST)
Date:   Wed, 29 May 2019 18:19:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
References: <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529143510.GA11154@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:35:10PM +0100, Will Deacon wrote:
> On Wed, May 29, 2019 at 03:25:15PM +0200, Peter Zijlstra wrote:
> > On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> > > On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> > 
> > > >  	if (user_mode(regs)) {
> > > 
> > > Hmm, so it just occurred to me that Mark's observation is that the regs
> > > can be junk in some cases. In which case, should we be checking for
> > > kthreads first?
> > 
> > task_pt_regs() can return garbage, but @regs is the exception (or
> > perf_arch_fetch_caller_regs()) regs, and for those user_mode() had
> > better be correct.
> 
> So what should we report for the idle task?

If an interrupt hits the idle task, @regs would be !user_mode(regs),
we'll find current->flags & PF_KTHREAD (idle not having passed through
exec()) and therefore we'll take ABI_NONE for the user regs.

Or am I not getting it?
