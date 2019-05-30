Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263D7C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0071525384
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfE3EXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:23:42 -0400
Received: from foss.arm.com ([217.140.101.70]:57936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbfE3EXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:23:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 105F1374;
        Wed, 29 May 2019 21:23:37 -0700 (PDT)
Received: from [10.162.40.143] (p8cg001049571a15.blr.arm.com [10.162.40.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED62B3F5AF;
        Wed, 29 May 2019 21:23:30 -0700 (PDT)
Subject: Re: [PATCH V5 0/3] arm64/mm: Enable memory hot remove
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, mhocko@suse.com,
        ira.weiny@intel.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, james.morse@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com
References: <1559121387-674-1-git-send-email-anshuman.khandual@arm.com>
 <20190529150611.fc27dee202b4fd1646210361@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c6e3af6e-27f4-ec3e-5ced-af4f62a9cdff@arm.com>
Date:   Thu, 30 May 2019 09:53:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190529150611.fc27dee202b4fd1646210361@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2019 03:36 AM, Andrew Morton wrote:
> On Wed, 29 May 2019 14:46:24 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This series enables memory hot remove on arm64 after fixing a memblock
>> removal ordering problem in generic __remove_memory() and one possible
>> arm64 platform specific kernel page table race condition. This series
>> is based on latest v5.2-rc2 tag.
> 
> Unfortunately this series clashes syntactically and semantically with
> David Hildenbrand's series "mm/memory_hotplug: Factor out memory block
> devicehandling".  Could you and David please figure out what we should
> do here?
> 

Hello Andrew,

I was able to apply the above mentioned V3 series [1] from David with some changes
listed below which tests positively on arm64. These changes assume that the arm64
hot-remove series (current V5) gets applied first.

Changes to David's series

A) Please drop (https://patchwork.kernel.org/patch/10962565/) [v3,04/11]

	- arch_remove_memory() is already being added through hot-remove series

B) Rebase (https://patchwork.kernel.org/patch/10962575/) [v3, 06/11]

	- arm64 hot-remove series adds CONFIG_MEMORY_HOTREMOVE wrapper around
	  arch_remove_memory() which can be dropped in the rebased patch

C) Rebase (https://patchwork.kernel.org/patch/10962589/) [v3, 09/11]

	- hot-remove series moves arch_remove_memory() before memblock_[free|remove]()
	- So remove_memory_block_devices() should be moved before arch_remove_memory()
	  in it's new position

David,

Please do let me know if the plan sounds good or you have some other suggestions.

- Anshuman

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=123133 
