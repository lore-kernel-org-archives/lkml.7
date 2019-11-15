Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FCC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520BD206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fERGMGun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOXif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:38:35 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16256 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:38:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcf36f70001>; Fri, 15 Nov 2019 15:38:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Nov 2019 15:38:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Nov 2019 15:38:31 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 23:38:31 +0000
Subject: Re: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
To:     David Hildenbrand <david@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <richardw.yang@linux.intel.com>, <sfr@canb.auug.org.au>,
        <rppt@linux.ibm.com>, <jannh@google.com>, <steve.capper@arm.com>,
        <catalin.marinas@arm.com>, <aarcange@redhat.com>,
        <chenjianhong2@huawei.com>, <walken@google.com>,
        <dave.hansen@linux.intel.com>, <tiny.windzz@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
 <5277de34-ecb3-831e-c697-1fd3f66b45ba@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b4d8cbf4-c553-2594-9d92-6d7e58eb246c@nvidia.com>
Date:   Fri, 15 Nov 2019 15:38:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5277de34-ecb3-831e-c697-1fd3f66b45ba@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573861111; bh=CqwX0NFi2jxdBUV037zt97imywMfzSOeWljkgkwL64o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fERGMGunwyYjKx1E1tXvp/kKBDDFe/hyMriNP6uV1DVcQnmzaFa+D72ufrHuGWcdZ
         ok6z+6HrsyBjadNBhOeHM48uXushcx3D4b57nGAVOh7WDBKsWLBVeLxg3Fp0ZUJWts
         s37w2RvdKjem8ulbp138pT53OmDmVapLFiUcqCLZg/bDatEkOdO3suz1tdVUiyBL6a
         081ltCmdgFNtqQcSmnr5OZoiRUuw4vedfRXYO7qtU1XjXallkVnAkln6oQMT3/bPRK
         Ipr94B5RZf7bG2+ufZkC6X6t74GxiYT2rW1MDEzp/HihZaJYYlo1Rj+W2xl//ioEHI
         Ajq8ixkKUWfcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 4:58 AM, David Hildenbrand wrote:
> On 15.11.19 07:36, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> I'm pro removing unnecessary jump labels.

Thank you, simpler code is good--all other things being equal. 
The  tradeoff is, as Qian points out: code churn and risk in critical 
code paths.

In this case, I'd claim it's OK to improve this one, because we
can likely get it right by visual inspection, and the pre-existing
code is quite poor. And being in the kernel does not necessarily give
weak code a free pass to remain there and incur maintenance and annoyance
costs until the end of time. :)

However, please spend equal time when you write your commit descriptions,
because that's also very important. Commit logs should also be clear!

> 
> Subject: "mm: get rid of jump labels in find_mergeable_anon_vma()"
> 
>>
>> The odd jump label try_prev and none is not really need

s/need/needed/

> 
> s/odd jump label/jump labels/
> 
> s/is/are/
> 
>> in func find_mergeable_anon_vma, eliminate them to
>> improve readability.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/mmap.c | 18 +++++++-----------
>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 4d4db76a07da..ab980d468a10 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1276,25 +1276,21 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
>>   */
>>  struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>>  {
>> -	struct anon_vma *anon_vma;
>> +	struct anon_vma *anon_vma = NULL;
>>  	struct vm_area_struct *near;
>>  
>>  	near = vma->vm_next;
>> -	if (!near)
>> -		goto try_prev;
>> -
>> -	anon_vma = reusable_anon_vma(near, vma, near);
>> +	if (near)
>> +		anon_vma = reusable_anon_vma(near, vma, near);>  	if (anon_vma)
>>  		return anon_vma;
> 
> Let me suggest the following instead:
> 
> /* Try next first */
> near = vma->vm_next;
> if (near) {
> 	anon_vma = reusable_anon_vma(near, vma, near);
> 	if (anon_vma)
> 		return anon_vma;
> }
> /* Try prev next */
> near = vma->vm_prev;
> if (near) {
> 	anon_vma = reusable_anon_vma(near, vma, near);
> 	if (anon_vma)
> 		return anon_vma;
> }
> 

Actually, it can be further simplified, because you don't need
that last "if" statement, because you're returning NULL after this.

So just return anon_vma there. (And adjust the comment block at the 
end, so that it's clear that anon_vma might be null.)


thanks,
-- 
John Hubbard
NVIDIA

>> -try_prev:
>> -	near = vma->vm_prev;
>> -	if (!near)
>> -		goto none;
>>  
>> -	anon_vma = reusable_anon_vma(near, near, vma);
>> +	near = vma->vm_prev;
>> +	if (near)
>> +		anon_vma = reusable_anon_vma(near, near, vma);
>>  	if (anon_vma)
>>  		return anon_vma;
>> -none:
>> +
>>  	/*
>>  	 * There's no absolute need to look only at touching neighbours:
>>  	 * we could search further afield for "compatible" anon_vmas.
>>
> 
> 
