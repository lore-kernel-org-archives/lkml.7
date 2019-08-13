Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC6C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A458F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfHMF0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:26:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:47278 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfHMF0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:26:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 22:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="376185850"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 22:25:59 -0700
Date:   Tue, 13 Aug 2019 13:25:34 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: rb_parent is not necessary in __vma_link_list
Message-ID: <20190813052534.GA17131@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190813032656.16625-1-richardw.yang@linux.intel.com>
 <20190813033958.GB5307@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813033958.GB5307@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 08:39:58PM -0700, Matthew Wilcox wrote:
>On Tue, Aug 13, 2019 at 11:26:56AM +0800, Wei Yang wrote:
>> Now we use rb_parent to get next, while this is not necessary.
>> 
>> When prev is NULL, this means vma should be the first element in the
>> list. Then next should be current first one (mm->mmap), no matter
>> whether we have parent or not.
>> 
>> After removing it, the code shows the beauty of symmetry.
>
>Uhh ... did you test this?
>

I reboot successfully with this patch.

>> @@ -273,12 +273,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		next = prev->vm_next;
>>  		prev->vm_next = vma;
>>  	} else {
>> +		next = mm->mmap;
>>  		mm->mmap = vma;
>> -		if (rb_parent)
>> -			next = rb_entry(rb_parent,
>> -					struct vm_area_struct, vm_rb);
>> -		else
>> -			next = NULL;
>>  	}
>
>The full context is:
>
>        if (prev) {
>                next = prev->vm_next;
>                prev->vm_next = vma;
>        } else {
>                mm->mmap = vma;
>                if (rb_parent)
>                        next = rb_entry(rb_parent,
>                                        struct vm_area_struct, vm_rb);
>                else
>                        next = NULL;
>        }
>
>Let's imagine we have a small tree with three ranges in it.
>
>A: 5-7
>B: 8-10
>C: 11-13
>
>I would imagine an rbtree for this case has B at the top with A
>to its left and B to its right.
>
>Now we're going to add range D at 3-4.  'next' should clearly be range A.
>It will have NULL prev.  Your code is going to make 'B' next, not A.
>Right?

mm->mmap is not the rb_root.

mm->mmap is the first element in the ordered list, if my understanding is
correct.

-- 
Wei Yang
Help you, Help me
