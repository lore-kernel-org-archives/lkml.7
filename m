Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C95208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfFQRDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:03:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfFQRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:03:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CAA28;
        Mon, 17 Jun 2019 10:03:31 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C2A03F738;
        Mon, 17 Jun 2019 10:03:30 -0700 (PDT)
Date:   Mon, 17 Jun 2019 18:03:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Takao Indoh <indou.takao@jp.fujitsu.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        QI Fuli <qi.fuli@fujitsu.com>,
        Takao Indoh <indou.takao@fujitsu.com>, peterz@infradead.org
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Message-ID: <20190617170328.GJ30800@fuggles.cambridge.arm.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takao,

[+Peter Z]

On Mon, Jun 17, 2019 at 11:32:53PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao@fujitsu.com>
> 
> I found a performance issue related on the implementation of Linux's TLB
> flush for arm64.
> 
> When I run a single-threaded test program on moderate environment, it
> usually takes 39ms to finish its work. However, when I put a small
> apprication, which just calls mprotest() continuously, on one of sibling
> cores and run it simultaneously, the test program slows down significantly.
> It becomes 49ms(125%) on ThunderX2. I also detected the same problem on
> ThunderX1 and Fujitsu A64FX.

This is a problem for any applications that share hardware resources with
each other, so I don't think it's something we should be too concerned about
addressing unless there is a practical DoS scenario, which there doesn't
appear to be in this case. It may be that the real answer is "don't call
mprotect() in a loop".

> I suppose the root cause of this issue is the implementation of Linux's TLB
> flush for arm64, especially use of TLBI-is instruction which is a broadcast
> to all processor core on the system. In case of the above situation,
> TLBI-is is called by mprotect().

On the flip side, Linux is providing the hardware with enough information
not to broadcast to cores for which the remote TLBs don't have entries
allocated for the ASID being invalidated. I would say that the root cause
of the issue is that this filtering is not taking place.

> This is not a problem for small environment, but this causes a significant
> performance noise for large-scale HPC environment, which has more than
> thousand nodes with low latency interconnect.

If you have a system with over a thousand nodes, without snoop filtering
for DVM messages and you expect performance to scale in the face of tight
mprotect() loops then I think you have a problem irrespective of this patch.
What happens if somebody runs I-cache invalidation in a loop?

> To fix this problem, this patch adds new boot parameter
> 'disable_tlbflush_is'.  In the case of flush_tlb_mm() *without* this
> parameter, TLB entry is invalidated by __tlbi(aside1is, asid). By this
> instruction, all CPUs within the same inner shareable domain check if there
> are TLB entries which have this ASID, this causes performance noise. OTOH,
> when this new parameter is specified, TLB entry is invalidated by
> __tlbi(aside1, asid) only on the CPUs specified by mm_cpumask(mm).
> Therefore TLB flush is done on minimal CPUs and performance problem does
> not occur. Actually I confirm the performance problem is fixed by this
> patch.

Other than my comments above, my overall concern with this patch is that
it introduces divergent behaviour for our TLB invalidation flow, which is
undesirable from both maintainability and usability perspectives. If you
wish to change the code, please don't put it behind a command-line option,
but instead improve the code that is already there. However, I suspect that
blowing away the local TLB on every context-switch may have hidden costs
which are only apparent with workloads different from the contrived case
that you're seeking to improve. You also haven't taken into account the
effects of virtualisation, where it's likely that the hypervisor will
upgrade non-shareable operations to inner-shareable ones anyway.

Thanks,

Will
