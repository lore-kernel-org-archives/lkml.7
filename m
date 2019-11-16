Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97020732
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKPAhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:37:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:57789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfKPAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:37:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 16:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,310,1569308400"; 
   d="scan'208";a="203534864"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2019 16:37:35 -0800
Date:   Sat, 16 Nov 2019 08:37:25 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linmiaohe <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, sfr@canb.auug.org.au,
        rppt@linux.ibm.com, jannh@google.com, steve.capper@arm.com,
        catalin.marinas@arm.com, aarcange@redhat.com,
        chenjianhong2@huawei.com, walken@google.com,
        dave.hansen@linux.intel.com, tiny.windzz@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
Message-ID: <20191116003725.GA18271@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
 <5277de34-ecb3-831e-c697-1fd3f66b45ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5277de34-ecb3-831e-c697-1fd3f66b45ba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:58:02PM +0100, David Hildenbrand wrote:
>On 15.11.19 07:36, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>
>I'm pro removing unnecessary jump labels.
>
>Subject: "mm: get rid of jump labels in find_mergeable_anon_vma()"
>
>> 
>> The odd jump label try_prev and none is not really need
>
>s/odd jump label/jump labels/
>
>s/is/are/
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
>Let me suggest the following instead:
>
>/* Try next first */
>near = vma->vm_next;
>if (near) {
>	anon_vma = reusable_anon_vma(near, vma, near);
>	if (anon_vma)
>		return anon_vma;
>}
>/* Try prev next */
>near = vma->vm_prev;
>if (near) {
>	anon_vma = reusable_anon_vma(near, vma, near);
>	if (anon_vma)
>		return anon_vma;
>}
>

Can we have an array with vma->vm_next and vma->vm_prev, then iterate on the
array?

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
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
