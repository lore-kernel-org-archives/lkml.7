Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCCC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5691A2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405917AbfHIIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:31:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:8745 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfHIIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:31:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 01:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="375132991"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2019 01:31:45 -0700
Date:   Fri, 9 Aug 2019 16:31:22 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap.c: refine find_vma_prev with rb_last
Message-ID: <20190809083122.GA32128@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190809001928.4950-1-richardw.yang@linux.intel.com>
 <d47ee469-8ff6-d212-9c4b-242079e281e8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47ee469-8ff6-d212-9c4b-242079e281e8@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:03:20AM +0200, Vlastimil Babka wrote:
>On 8/9/19 2:19 AM, Wei Yang wrote:
>> When addr is out of the range of the whole rb_tree, pprev will points to
>> the right-most node. rb_tree facility already provides a helper
>> function, rb_last, to do this task. We can leverage this instead of
>> re-implement it.
>> 
>> This patch refines find_vma_prev with rb_last to make it a little nicer
>> to read.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
>Nit below:
>
>> ---
>> v2: leverage rb_last
>> ---
>>  mm/mmap.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 7e8c3e8ae75f..f7ed0afb994c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2270,12 +2270,9 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>>  	if (vma) {
>>  		*pprev = vma->vm_prev;
>>  	} else {
>> -		struct rb_node *rb_node = mm->mm_rb.rb_node;
>> -		*pprev = NULL;
>> -		while (rb_node) {
>> -			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
>> -			rb_node = rb_node->rb_right;
>> -		}
>> +		struct rb_node *rb_node = rb_last(&mm->mm_rb);
>> +		*pprev = !rb_node ? NULL :
>> +			 rb_entry(rb_node, struct vm_area_struct, vm_rb);
>
>It's perhaps more common to write it like:
>*pprev = rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : NULL;
>

Do you prefer me to send v3 with this updated?

>>  	}
>>  	return vma;
>>  }
>> 

-- 
Wei Yang
Help you, Help me
