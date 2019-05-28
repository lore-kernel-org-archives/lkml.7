Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396DD214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l/LvPD5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfE1OBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:01:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfE1OBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RHFIELNrUiKWmxjlgPJ3LzHRq0bFqXpskNHoAt804ps=; b=l/LvPD5MyWWRIiU9Smo5YF9Nd
        xBFGXeALAK/XWxiLNt//wf+7kBkq/yHesupIddaDcnQwc9Xu6ypU8BnJyD4BT+QrJjDYiNwUOqrHU
        AcTqwDaQdhteBKquda44uagE5y7zAFPvPV7L3/zM2zUksn3i0S36x9dCYnr05JqjQIEGfayPx2VRe
        hHoC5iNnNzO46hMWPyzesh9xsiEc2eoDjbGfAgQxW5EDqEaTghHjp/rWXZ009dVpH5ZeOr32e6lx0
        SPCtBjSsTvjL8gf/4b/jNJaDf2JCVycdzYpn03O163Y9oyWu4RYrr1O7hsHWxfCqwUhQ6shULmiFs
        5EObilnNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcf3-0004OY-AW; Tue, 28 May 2019 14:01:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CED6620750761; Tue, 28 May 2019 16:01:03 +0200 (CEST)
Date:   Tue, 28 May 2019 16:01:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     will.deacon@arm.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190528140103.GT2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> When a kthread calls call_usermodehelper() the steps are:
>   1. allocate current->mm
>   2. load_elf_binary()
>   3. populate current->thread.regs
> 
> While doing this, interrupts are not disabled. If there is a perf
> interrupt in the middle of this process (i.e. step 1 has completed
> but not yet reached to step 3) and if perf tries to read userspace
> regs, kernel oops.
> 
> Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
> pt_regs are not set.
> 
> See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
> user process") for details.

Why the hell do we set current->mm before it is complete? Note that
normally exec() builds the new mm before attaching it, see exec_mmap()
in flush_old_exec().

Also, why did those PPC folks 'fix' this in isolation? And why didn't
you Cc them?
