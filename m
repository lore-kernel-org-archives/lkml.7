Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88353C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D562218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSUHaqtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfE2NZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:25:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EYaFlFyeLMBFesChUym9zINCxmcRtLgVS6HK3VLLE6A=; b=bSUHaqtVdnZ9cKLtAH/Ig9+FN
        cbE9Ob57J9YdrTMD3420Y/qRX/l2f+0M32TbgQY2MAiNYsKNIFeF/GdlYUNcPopd/xYQQXdFLTnHI
        wbjbEi8YRWhtSbagCoOrgXjxD7+yTFaOCcZBve5Xy6uxMysUA7fCjntvoCszuy/LzG4o5DKRHLzIH
        v9I8s7M7Cr9ru/rzSk+7dlOfIl/DTXhzSei1yJBfOnLxTbHWcmSCg+HrW6YHsIm+JnpOAJXy/wAKU
        DYLfvPNXMkjgsB7OnAL2jA1n6N2gqP+ZckeXTxwE813SCNQKH3lci1Dv9cKQr06n6G4BQTb/6cXQX
        zVp6P5+WA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVyZy-0005FE-65; Wed, 29 May 2019 13:25:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28F8C201E233E; Wed, 29 May 2019 15:25:15 +0200 (CEST)
Date:   Wed, 29 May 2019 15:25:15 +0200
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
Message-ID: <20190529132515.GW2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529130521.GA11023@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:

> >  	if (user_mode(regs)) {
> 
> Hmm, so it just occurred to me that Mark's observation is that the regs
> can be junk in some cases. In which case, should we be checking for
> kthreads first?

task_pt_regs() can return garbage, but @regs is the exception (or
perf_arch_fetch_caller_regs()) regs, and for those user_mode() had
better be correct.
