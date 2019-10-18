Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E3CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B71222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406497AbfJRJs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:48:57 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60118 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2404264AbfJRJs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93D4A3E8;
        Fri, 18 Oct 2019 02:48:30 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0C23F6C4;
        Fri, 18 Oct 2019 02:48:27 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:48:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH V9 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20191018094825.GD19734@arrakis.emea.arm.com>
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
 <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
 <20191010113433.GI28269@mbp>
 <f51cdb20-ddc4-4fb7-6c45-791d2e1e690c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51cdb20-ddc4-4fb7-6c45-791d2e1e690c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:26:32AM +0530, Anshuman Khandual wrote:
> On 10/10/2019 05:04 PM, Catalin Marinas wrote:
> > Mark Rutland mentioned at some point that, as a preparatory patch to
> > this series, we'd need to make sure we don't hot-remove memory already
> > given to the kernel at boot. Any plans here?
> 
> Hmm, this series just enables platform memory hot remove as required from
> generic memory hotplug framework. The path here is triggered either from
> remove_memory() or __remove_memory() which takes physical memory range
> arguments like (nid, start, size) and do the needful. arch_remove_memory()
> should never be required to test given memory range for anything including
> being part of the boot memory.

Assuming arch_remove_memory() doesn't (cannot) check, is there a risk on
arm64 that, for example, one removes memory available at boot and then
kexecs a new kernel? Does the kexec tool present the new kernel with the
original memory map?

I can see x86 has CONFIG_FIRMWARE_MEMMAP suggesting that it is used by
kexec. try_remove_memory() calls firmware_map_remove() so maybe they
solve this problem differently.

Correspondingly, after an arch_add_memory(), do we want a kexec kernel
to access it? x86 seems to use the firmware_map_add_hotplug() mechanism.

Adding James as well for additional comments on kexec scenarios.

> IIUC boot memory added to system with memblock_add() lose all it's identity
> after the system is up and running. In order to reject any attempt to hot
> remove boot memory, platform needs to remember all those memory that came
> early in the boot and then scan through it during arch_remove_memory().
> 
> Ideally, it is the responsibility of [_]remove_memory() callers like ACPI
> driver, DAX etc to make sure they never attempt to hot remove a memory
> range, which never got hot added by them in the first place. Also, unlike
> /sys/devices/system/memory/probe there is no 'unprobe' interface where the
> user can just trigger boot memory removal. Hence, unless there is a bug in
> ACPI, DAX or other callers, there should never be any attempt to hot remove
> boot memory in the first place.

That's fine if these callers give such guarantees. I just want to make
sure someone checked all the possible scenarios for memory hot-remove.

-- 
Catalin
