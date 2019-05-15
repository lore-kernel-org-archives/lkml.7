Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A31C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B8320862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOB4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:56:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35434 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfEOB4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:56:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60CE1374;
        Tue, 14 May 2019 18:56:32 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AED13F71E;
        Tue, 14 May 2019 18:56:23 -0700 (PDT)
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mhocko@suse.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
 <20190514154000.GA20935@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <107ce10f-622c-7914-6269-cff5509b084f@arm.com>
Date:   Wed, 15 May 2019 07:26:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190514154000.GA20935@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/14/2019 09:10 PM, Mark Rutland wrote:
> On Tue, May 14, 2019 at 02:30:05PM +0530, Anshuman Khandual wrote:
>> The arm64 pagetable dump code can race with concurrent modification of the
>> kernel page tables. When a leaf entries are modified concurrently, the dump
>> code may log stale or inconsistent information for a VA range, but this is
>> otherwise not harmful.
>>
>> When intermediate levels of table are freed, the dump code will continue to
>> use memory which has been freed and potentially reallocated for another
>> purpose. In such cases, the dump code may dereference bogus addressses,
>> leading to a number of potential problems.
>>
>> Intermediate levels of table may by freed during memory hot-remove, or when
>> installing a huge mapping in the vmalloc region. To avoid racing with these
>> cases, take the memory hotplug lock when walking the kernel page table.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Can we please move this after the next patch (which addresses the huge
> vmap case), and change the last paragraph to:
> 
>   Intermediate levels of table may by freed during memory hot-remove,
>   which will be enabled by a subsequent patch. To avoid racing with
>   this, take the memory hotplug lock when walking the kernel page table.
> 
> With that, this looks good to me.

Sure will do.
