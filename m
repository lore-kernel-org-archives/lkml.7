Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1828E215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hk7GVMY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfJARyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:54:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14255 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfJARyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:54:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9392df0000>; Tue, 01 Oct 2019 10:54:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Oct 2019 10:54:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Oct 2019 10:54:31 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Oct
 2019 17:54:30 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 1 Oct 2019 17:54:30 +0000
Subject: Re: [PATCH] mm/thp: make set_huge_zero_page() return void
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190930195528.32553-1-rcampbell@nvidia.com>
 <20191001115239.dqodyji3r32zjkea@box>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <68b384ac-b311-6ea2-81ad-053ff7f3ba64@nvidia.com>
Date:   Tue, 1 Oct 2019 10:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191001115239.dqodyji3r32zjkea@box>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569952479; bh=BaVcfmO77CbSRF4xJ7ENR7iiC1TjdAOn8cbtscDfEog=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hk7GVMY2RbARRj+8vRGwRTIBWLlV+9xU34GGzQ5cW09C2Qa5u557QOWPQQhETeelM
         VLy3eVJ4QwizyOgL08VCQECqRTuxumtTzbHwnYp+af7ROVQBkzB6baK7wctS5Tg+cD
         u/hPye4SjWz3+DyCUontM8dUS7BGYa/z8mNhUAUtT+SCmljMjehqG3I7S5p2GyiQP2
         wHZIbWckPspTZIbV7IavKO4Menqj+M36VOOihk8uryvkLu9nhO7uoQj3sXpnL1HyMu
         059FiPMNyImJ0gNZQs35B0icbqnXkltg3n0W4TJRMdfJtZaubpO8Qqdr6gyUVRLAoa
         i/FCypcgiro2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/19 4:52 AM, Kirill A. Shutemov wrote:
> On Mon, Sep 30, 2019 at 12:55:28PM -0700, Ralph Campbell wrote:
>> The return value from set_huge_zero_page() is never checked so simplify
>> the code by making it return void.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   mm/huge_memory.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c5cb6dcd6c69..6cf0ee65538d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -686,20 +686,18 @@ static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
>>   }
>>   
>>   /* Caller must hold page table lock. */
>> -static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>> +static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>>   		struct vm_area_struct *vma, unsigned long haddr, pmd_t *pmd,
>>   		struct page *zero_page)
>>   {
>>   	pmd_t entry;
>> -	if (!pmd_none(*pmd))
>> -		return false;
>> +
> 
> Wat? So you just bindly overwrite whatever is there?
> 
> NAK.

No, the only two places it is called from are 
do_huge_pmd_anonymous_page() which has the pmd_lock()
and already checked pmd_none() is true and
copy_huge_pmd() where the destination page table
is being filled in with no other threads accessing it.
I guess I should have put this analysis in the changelog.

Still, I guess putting a pmd_none() check in copy_huge_pmd()
as future proofing new callers of copy_huge_pmd() would
make sense.

>>   	entry = mk_pmd(zero_page, vma->vm_page_prot);
>>   	entry = pmd_mkhuge(entry);
>>   	if (pgtable)
>>   		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>   	set_pmd_at(mm, haddr, pmd, entry);
>>   	mm_inc_nr_ptes(mm);
>> -	return true;
>>   }
>>   
>>   vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> -- 
>> 2.20.1
>>
>>
> 
