Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9F20693
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfHADI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:08:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfHADI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:08:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E54F5344;
        Wed, 31 Jul 2019 20:08:26 -0700 (PDT)
Received: from [10.163.1.81] (unknown [10.163.1.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E31B33F575;
        Wed, 31 Jul 2019 20:08:20 -0700 (PDT)
Subject: Re: [RFC 1/2] mm/sparsemem: Add vmem_altmap support in
 vmemmap_populate_basepages()
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
 <1561697083-7329-2-git-send-email-anshuman.khandual@arm.com>
 <20190731161047.ypye54x5c5jje5sq@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a753a841-c344-c708-fccd-39d838637bcb@arm.com>
Date:   Thu, 1 Aug 2019 08:39:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190731161047.ypye54x5c5jje5sq@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2019 09:40 PM, Will Deacon wrote:
> On Fri, Jun 28, 2019 at 10:14:42AM +0530, Anshuman Khandual wrote:
>> Generic vmemmap_populate_basepages() is used across platforms for vmemmap
>> as standard or as fallback when huge pages mapping fails. On arm64 it is
>> used for configs with ARM64_SWAPPER_USES_SECTION_MAPS applicable both for
>> ARM64_16K_PAGES and ARM64_64K_PAGES which cannot use huge pages because of
>> alignment requirements.
>>
>> This prevents those configs from allocating from device memory for vmemap
>> mapping as vmemmap_populate_basepages() does not support vmem_altmap. This
>> enables that required support. Each architecture should evaluate and decide
>> on enabling device based base page allocation when appropriate. Hence this
>> keeps it disabled for all architectures to preserve the existing semantics.
> 
> This commit message doesn't really make sense to me. There's a huge amount
> of arm64-specific detail, followed by vague references to "this" and
> "those" and "that" and I lost track of what you're trying to solve.

Hmm, will clean up.

> 
> However, I puzzled through the code and I think it does make sense, so:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> assuming you rewrite the commit message.

Thanks, will do.

> 
> However, this has a dependency on your hot remove series which has open
> comments from Mark Rutland afaict.

Yeah it has dependency on the hot-remove series. The only outstanding issue
there being whether to call free_empty_tables() in vmemmap tear down path
or not. Mark had asked for more details regarding the implications in cases
where free_empty_tables() is called or is not called. I did evaluate those
details recently and we should be able to take a decision sooner.
