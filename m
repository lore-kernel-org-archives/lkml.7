Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883220895
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574277541;
	bh=XasgMmL+6L+gCEnWMimC+DM0YA+gD8SLj+MyqPAl1K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDpNtG3qm67IfXw8zo+l/48+VRWqEt34Z7tLzISTvL+EOFVVK240ttLWOnbBf7AG1
	 ciEaUpudl0p8au8kkqy7NmTNYgRlkXDj4kdTdn57NV2Z9Zh0xC74pFhFZ+KuhOQMfj
	 N0Tq9G3oni40MoCzIhCuIrA4gAV+oTE3HOo48oqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfKTTTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfKTTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:19:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 419D020855;
        Wed, 20 Nov 2019 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574277539;
        bh=XasgMmL+6L+gCEnWMimC+DM0YA+gD8SLj+MyqPAl1K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKhlFyx2VvlREMPb1ZKfmeG5RHQrELs31dNJfOKV4NNq2nx3T7VQjH242byza8B5/
         YaSezsM0ViEcpq5/JbfHTrjsbftz7m/yFldaxBpcXgUubgpHGuTJ3c7Pd3VRD7n7ZT
         HaUT9c2RRMRbS4nxlz9hnPtl8GzIckRNMPTaRJKw=
Date:   Wed, 20 Nov 2019 19:18:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        maz@kernel.org
Subject: Re: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
Message-ID: <20191120191854.GG4799@willie-the-truck>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
 <20191114163948.GA5158@willie-the-truck>
 <14773d6b-96d5-b894-7fc4-17c54f15ee30@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14773d6b-96d5-b894-7fc4-17c54f15ee30@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:14:07AM +0000, Suzuki K Poulose wrote:
> On 11/14/2019 04:39 PM, Will Deacon wrote:
> > On Thu, Nov 14, 2019 at 02:59:13PM +0000, Suzuki K Poulose wrote:
> > > This series adds workaround for Arm erratum 1542418 which affects
> > > Cortex-A77 cores (r0p0 - r1p0). Affected cores may execute stale
> > > instructions from the L0 macro-op cache violating the
> > > prefetch-speculation-protection guaranteed by the architecture.
> > > This happens when the when the branch predictor bases its predictions
> > > on a branch at this address on the stale history due to ASID or VMID
> > > reuse.
> > 
> > Two immediate questions:
> > 
> >   1. Can we disable the L0 MOP cache?
> Yes, but it hurts performance.
> 
> >   2. Can we invalidate the branch predictor? If Spectre-v2 taught us
> >      anything it's that removing those instructions was a mistake!
> 
> The workaround suggested is actually invalidating the branch history
> but in a costly way. I am unaware of any.
> > Moving on...
> > 
> > Have you reproduced this at top-level? If I recall the
> > prefetch-speculation-protection, it's designed to protect against the
> > case where you have a direct branch:
> 
> No, see below.
> 
> > 
> > addr:	B	foo
> > 
> > and another CPU writes out a new function:
> > 
> > bar:
> > 	insn0
> > 	...
> > 	insnN
> > 
> > before doing any necessary maintenance and then patches the original
> > branch to:
> > 
> > addr:	B	bar
> > 
> > The idea is that a concurrently executing CPU could mispredict the original
> > branch to point at 'bar', fetch the instructions before they've been written
> > out and then confirm the prediction by looking at the newly written branch
> > instruction. Even without the prefetch-speculation-protection, that's
> > fairly difficult to achieve in practice: you'd need to be doing something
> > like reusing memory to hold the instructions so that the initial
> > misprediction occurs.
> > 
> > How does A77 stop this from occurring when the ASID is not reallocated (e.g.
> > the example above)? Is the MOP cache flushed somehow?
> 
> IIUC, The MOP cache is flushed on I-cache invalidate, thus it is fine.	

Hmm, so this is interesting. Does that mean we could do a local I-cache
invalidation in check_and_switch_context() at the same as doing the local
TLBI after a rollover?

I still don't grok the failure case, though, because assuming A77 has IDC=0,
then won't you see the I-cache maintenance from userspace anyway?

Will
