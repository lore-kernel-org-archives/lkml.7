Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454E1214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfJUJzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:55:12 -0400
Received: from [217.140.110.172] ([217.140.110.172]:47492 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfJUJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:55:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 269CA15EC;
        Mon, 21 Oct 2019 02:54:48 -0700 (PDT)
Received: from [10.163.1.2] (unknown [10.163.1.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E20F3F718;
        Mon, 21 Oct 2019 02:54:39 -0700 (PDT)
Subject: Re: [PATCH V9 2/2] arm64/mm: Enable memory hot remove
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     mark.rutland@arm.com, david@redhat.com, linux-mm@kvack.org,
        arunks@codeaurora.org, cpandya@codeaurora.org, ira.weiny@intel.com,
        will@kernel.org, steven.price@arm.com, valentin.schneider@arm.com,
        suzuki.poulose@arm.com, Robin.Murphy@arm.com, broonie@kernel.org,
        cai@lca.pw, ard.biesheuvel@arm.com, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, osalvador@suse.de,
        steve.capper@arm.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
 <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
 <20191010113433.GI28269@mbp> <f51cdb20-ddc4-4fb7-6c45-791d2e1e690c@arm.com>
 <20191018094825.GD19734@arrakis.emea.arm.com>
 <f5581644-42b7-097e-6a86-ba7db9d0b544@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6b5c96fe-cb3c-d0c2-e1f4-6ecd34be62a5@arm.com>
Date:   Mon, 21 Oct 2019 15:25:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f5581644-42b7-097e-6a86-ba7db9d0b544@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2019 03:23 PM, Anshuman Khandual wrote:
> 
> On 10/18/2019 03:18 PM, Catalin Marinas wrote:
>> On Fri, Oct 11, 2019 at 08:26:32AM +0530, Anshuman Khandual wrote:
>>> On 10/10/2019 05:04 PM, Catalin Marinas wrote:
>>>> Mark Rutland mentioned at some point that, as a preparatory patch to
>>>> this series, we'd need to make sure we don't hot-remove memory already
>>>> given to the kernel at boot. Any plans here?
>>> Hmm, this series just enables platform memory hot remove as required from
>>> generic memory hotplug framework. The path here is triggered either from
>>> remove_memory() or __remove_memory() which takes physical memory range
>>> arguments like (nid, start, size) and do the needful. arch_remove_memory()
>>> should never be required to test given memory range for anything including
>>> being part of the boot memory.
>> Assuming arch_remove_memory() doesn't (cannot) check, is there a risk on
> Platform can definitely enumerate boot memory ranges. But checking on it in
> arch_remove_memory() which deals with actual procedural details might not be
> ideal IMHO. Refusing a requested removal attempt should have been done up in
> the call chain. This will require making generic hot plug reject any removal
> request which falls within enumerated boot memory. IFAICS currently there is
> no generic way to remember which memory came as part of the boot process.
> Probably be a new MEMBLOCK flag will do.
> 
>> arm64 that, for example, one removes memory available at boot and then
>> kexecs a new kernel? Does the kexec tool present the new kernel with the
>> original memory map?
> I dont know, probably James can help here. But as I had mentioned earlier,
> the callers of remove_memory() should be able to control that. ACPI should
> definitely be aware about which ranges were part of boot memory and refrain
> from removing any subset, if the platform is known to have problems with
> any subsequent kexec operation because the way boot memory map get used.
> 
> Though I am not much aware about kexec internals, it should inherit the
> memory state at given point in time accommodating all previous memory hot
> and remove operations. As an example cloud environment scenario, memory
> resources might have increased or decreased during a guest lifetime, so
> when the guest needs to have new OS image why should not it have all the
> memory ? I dont know if it's feasible for the guest to expect previous hot
> add or remove operations to be played again after the kexec.
> 
> There is another fundamental question here. Is there a notion of a minimum
> subset of boot memory which cannot be hot removed no matter what ? If yes,
> how that is being conveyed to the kernel currently ?
> 
> The point is that all these need to be established between ACPI, EFI and
> kernel. AFAICS this problem is for MM subsystem (including the platform

s/is for/is not for/          ^^^^^^^^^^
