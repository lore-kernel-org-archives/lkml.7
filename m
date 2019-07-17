Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBEEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAAF21849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbfGQRvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:51:50 -0400
Received: from foss.arm.com ([217.140.110.172]:49652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfGQRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780D528;
        Wed, 17 Jul 2019 10:51:49 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D173F71F;
        Wed, 17 Jul 2019 10:51:44 -0700 (PDT)
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
Date:   Wed, 17 Jul 2019 18:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 16/07/2019 17:56, Pavel Tatashin wrote:
> Added identity mapped page table, and keep MMU enabled while
> kernel is being relocated from sparse pages to the final
> destination during kexec.

The 'tl;dr' version of this: I strongly urge you to start with the hibernate code that
already covers all these known corner cases. x86 was not a good starting point.


After a quick skim:

This will map 'nomap' regions of memory with cacheable attributes. This is a non-starter.
These regions were described by firmware as having content that was/is written with
different attributes. The attributes must match whenever it is mapped, otherwise we have a
loss of coherency. Mapping this stuff as cacheable means the CPU can prefetch it into the
cache whenever it likes.
It may be important that we do not ever map some of these regions, even though its
described as memory. On AMD-Seattle the bottom page of memory is reserved by firmware for
its own use; it is made secure-only, and any access causes an
external-abort/machine-check. UEFI describes this as 'Reserved', and we preserve this in
the kernel as 'nomap'. The equivalent DT support uses memreserve, possibly with the
'nomap' attribute.

Mapping a 'new'/unknown region with cacheable attributes can never be safe, even if we
trusted kexec-tool to only write the kernel to memory. The host may be using a bigger page
size causing more memory to become cacheable than was intended.
Linux's EFI support rounds the UEFI memory map to the largest support page size, (and
winges about firmware bugs).
If we're allowing kexec to load images in a region not described as IORESOURCE_SYSTEM_RAM,
that is a bug we should fix.

The only way to do this properly is to copy the linear mapping. The arch code has lots of
complex code to generate it correctly at boot, we do not want to duplicate it.
(this is why hibernate copies the linear mapping)


These patches do not remove the running page tables from TTBR1. As you overwrite the live
page tables you will corrupt the state of the CPU. The page-table walker may access things
that aren't memory, cache memory that shouldn't be cached (see above), and allocate
conflicting entries in the TLB.

You cannot use the mm page table helpers to build an idmap on arm64. The mm page table
helpers have a compile-time VA_BITS, and we support systems where there is no memory below
1<<VA_BITS. (crazy huh!). Picking on AMD-Seattle again: if you boot a 4K 39bit VA kernel,
the idmap will have more page table levels than the page table helpers can build. This is
why there are special helpers to load the idmap, and twiddle TCR_EL1.T0SZ.
You already need to copy the linear-map, so using an idmap is extra work. You want to work
with linear-map addresses, you probably need to add the field to the appropriate structure.

The kexec relocation code still runs at EL2. You can't use a copy of the linear map here
as there is only one TTBR on v8.0, and you'd need to setup EL2 as its been torn back to
the hyp-stub. This is the reason hibernate posts EL2 in a holding pen while it rewrites
all of memory, then calls back to fixup EL2. Keeping the rewrite phase at EL1 means it
doesn't need independently tweaking/testing. You need to do something similar, either
calling EL2 to start the new image, or disabling the MMU at EL1 to start the new image there.

You will need to alter the relocation code to do nothing for kdump, as no relocation is
required and building page-tables is extra work where the kernel may croak, preventing us
from reaching kdump.

Finally, having this independent idmap machinery isn't desirable from a maintenance
perspective. Please start with the hibernate code that already solves a very similar
problem, as it already has most of these problems covered.


> This patch series works in terms, that I can kexec-reboot both in QEMU

I wouldn't expect Qemu's emulation of the MMU and caches to be performance accurate.


> and on a physical machine. However, I do not see performance improvement
> during relocation. The performance is just as slow as before with disabled
> caches.

> Am I missing something? Perhaps, there is some flag that I should also
> enable in page table? Please provide me with any suggestions.

Some information about the physical machine you tested this on would help.
I'm guessing its v8.0, and booted at EL2....


Thanks,

James
