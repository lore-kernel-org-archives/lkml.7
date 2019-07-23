Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB966C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C971D21921
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbfGWMLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:11:25 -0400
Received: from foss.arm.com ([217.140.110.172]:53734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfGWMLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:11:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 450DC337;
        Tue, 23 Jul 2019 05:11:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 261F03F71F;
        Tue, 23 Jul 2019 05:11:23 -0700 (PDT)
Date:   Tue, 23 Jul 2019 13:11:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Takao Indoh <indou.takao@jp.fujitsu.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        QI Fuli <qi.fuli@fujitsu.com>,
        Takao Indoh <indou.takao@fujitsu.com>
Subject: Re: [PATCH 2/2] arm64: tlb: Add boot parameter to disable TLB flush
 within the same inner shareable domain
Message-ID: <20190723121120.GB16928@arrakis.emea.arm.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617143255.10462-3-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617143255.10462-3-indou.takao@jp.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:32:55PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao@fujitsu.com>
> 
> This patch adds new boot parameter 'disable_tlbflush_is' to disable TLB
> flush within the same inner shareable domain for performance tuning.
> 
> In the case of flush_tlb_mm() *without* this parameter, TLB entry is
> invalidated by __tlbi(aside1is, asid). By this instruction, all CPUs within
> the same inner shareable domain check if there are TLB entries which have
> this ASID, this causes performance noise, especially at large-scale HPC
> environment, which has more than thousand nodes with low latency
> interconnect.
> 
> When this new parameter is specified, TLB entry is invalidated by
> __tlbi(aside1, asid) only on the CPUs specified by mm_cpumask(mm).
> Therefore TLB flush is done on minimal CPUs and performance problem does
> not occur.
> 
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Signed-off-by: Takao Indoh <indou.takao@fujitsu.com>
[...]
> +void flush_tlb_mm(struct mm_struct *mm)
> +{
> +	if (disable_tlbflush_is)
> +		on_each_cpu_mask(mm_cpumask(mm), ipi_flush_tlb_mm,
> +				 (void *)mm, true);
> +	else
> +		__flush_tlb_mm(mm);
> +}

Could we try instead to call a _nosync variant here when
cpumask_weight() is 1 or the *IS if greater than 1 and avoid the IPI?

Will tried this in the past but because of the task placement after
fork()+execve(), I think we always ended up with a weight of 2 in the
child process. Your first patch "solves" this by flushing the TLBs on
context switch (bar the CnP case). Can you give it a try to see if it
improves things? At least it's a starting point for further
investigation.

I fully agree with Will that we don't want two different TLB handling
implementations in the arm64 kernel and even less desirable to have a
command line option.

Thanks.

-- 
Catalin
