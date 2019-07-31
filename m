Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B384206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfGaQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:33:04 -0400
Received: from foss.arm.com ([217.140.110.172]:51206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbfGaQdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:33:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9B6337;
        Wed, 31 Jul 2019 09:33:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE8B3F71F;
        Wed, 31 Jul 2019 09:33:00 -0700 (PDT)
Date:   Wed, 31 Jul 2019 17:32:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
Message-ID: <20190731163258.GH39768@lakrids.cambridge.arm.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731153857.4045-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Generally, the cover letter should state up-front what the goal is (or
what problem you're trying to solve). It would be really helpful to have
that so that we understand what you're trying to achieve, and why.

Messing with the MMU is often fraught with danger (and very painful to
debug, as you are now aware), and so far we've tried to minimize the
number of places where we have to do so.

On Wed, Jul 31, 2019 at 11:38:49AM -0400, Pavel Tatashin wrote:
> Changelog from previous RFC:
> - Added trans_table support for both hibernate and kexec.
> - Fixed performance issue, where enabling MMU did not yield the
>   actual performance improvement.
> 
> Bug:
> With the current state, this patch series works on kernels booted with EL1
> mode, but for some reason, when elevated to EL2 mode reboot freezes in
> both QEMU and on real hardware.
> 
> The freeze happens in:
> 
> arch/arm64/kernel/relocate_kernel.S
> 	turn_on_mmu()
> 
> Right after sctlr_el2 is written (MMU on EL2 is enabled)
> 
> 	msr     sctlr_el2, \tmp1
> 
> I've been studying all the relevant control registers for EL2, but do not
> see what might be causing this hang:
> 
> MAIR_EL2 is set to be exactly the same as MAIR_EL1 0xbbff440c0400
> 
> TCR_EL2        0x80843510
> Enabled bits:
> PS      Physical Address Size. (0b100   44 bits, 16TB.)
> SH0     Shareability    11 Inner Shareable
> ORGN0   Normal memory, Outer Write-Back Read-Allocate Write-Allocate Cach.
> IRGN0   Normal memory, Inner Write-Back Read-Allocate Write-Allocate Cach.
> T0SZ    01 0000
> 
> SCTLR_EL2	0x30e5183f
> RES1    : Reserve ones
> M       : MMU enabled
> A       : Align check
> C       : Cacheability control
> SA      : SP Alignment check enable
> IESB    : Implicit Error Synchronization event
> I       : Instruction access Cacheability
> 
> TTBR0_EL2      0x1b3069000 (address of trans_table)
> 
> Any suggestion of what else might be missing that causes this freeze when
> MMU is enabled in EL2?
> 
> =====

> Here is the current data from the real hardware:
> (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> cpu_soft_restart()):
> 
> For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> was larger, than the improvements would be even greater, as time spent in
> relocation is proportional to the size of relocation.
> 
> Previously:
> kernel shutdown	0.022131328s
> relocation	0.440510736s
> kernel startup	0.294706768s

In total this takes ~0.76s...

> 
> Relocation was taking: 58.2% of reboot time
> 
> Now:
> kernel shutdown	0.032066576s
> relocation	0.022158152s
> kernel startup	0.296055880s

... and this takes ~0.35s

So do we really need this complexity for a few blinks of an eye?

Thanks,
Mark.
