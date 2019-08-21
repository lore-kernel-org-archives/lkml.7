Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CEC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E547205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NG7dyf/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfHUKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:35:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfHUKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mcCiCkntPqc52B7pLWHckSdaZwhyO1Uh85e0UXVgkVY=; b=NG7dyf/pm/Yc92A0MpxHzdYJP
        hNKjd6JZdTL4nSc3XFs8uMQbzkUO5uIm9t5TqPXDDbVkWjJNunjMWIDv/j6DFofuhP0hdEEQ1TlBz
        0dCfISp1pBExvdEnJ8/O55eRJ01jmRIc1V8tl0gK1daYP765ix8ktArEhTDDOMXVUY4imSQJqpTFh
        vOj+MBZFkDxB8pMDnbwprDPYxTpGRjL/F6s6CXkV72muMSSAyaZSx8Mk4DfFWPmc4ukWMkATKNFm9
        GiAIPY9jrrEcM68C7pBS4aTH1EM/7tA+LZDMA/N4lfJbNW7SknRMt/D5lCXG28Qp190OE8HUOSR7W
        7ZGhlEC3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0NxD-0003U8-0z; Wed, 21 Aug 2019 10:34:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6F0E305F65;
        Wed, 21 Aug 2019 12:34:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B6B720A21FCB; Wed, 21 Aug 2019 12:34:56 +0200 (CEST)
Date:   Wed, 21 Aug 2019 12:34:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] sched: define a function to report the number of
 context switches on a CPU
Message-ID: <20190821103456.GY2349@hirez.programming.kicks-ass.net>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
 <20190820093827.GF2332@hirez.programming.kicks-ass.net>
 <CY4PR21MB0741F33BBC800C0774CB8C15CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0741F33BBC800C0774CB8C15CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:20:48AM +0000, Long Li wrote:
> >>>Subject: Re: [PATCH 1/3] sched: define a function to report the number of
> >>>context switches on a CPU
> >>>
> >>>On Mon, Aug 19, 2019 at 11:14:27PM -0700, longli@linuxonhyperv.com
> >>>wrote:
> >>>> From: Long Li <longli@microsoft.com>
> >>>>
> >>>> The number of context switches on a CPU is useful to determine how
> >>>> busy this CPU is on processing IRQs. Export this information so it can
> >>>> be used by device drivers.
> >>>
> >>>Please do explain that; because I'm not seeing how number of switches
> >>>relates to processing IRQs _at_all_!
> 
> Some kernel components rely on context switch to progress, for example
> watchdog and RCU. On a CPU with reasonable interrupt load, it
> continues to make context switches, normally a number of switches per
> seconds. 

That isn't true; RCU is perfectly fine with a single task always running
and not making context switches, and so is the watchdog.
