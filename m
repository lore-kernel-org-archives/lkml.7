Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D5C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F40218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfGCVv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:51:29 -0400
Received: from verein.lst.de ([213.95.11.211]:55501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfGCVv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:51:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C562368B05; Wed,  3 Jul 2019 23:51:26 +0200 (CEST)
Date:   Wed, 3 Jul 2019 23:51:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190703215126.GA17366@lst.de>
References: <20190703184502.16234-1-hch@lst.de> <20190703184502.16234-5-hch@lst.de> <ec5e86a4-4a60-0dd5-797c-41b21e3a091a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5e86a4-4a60-0dd5-797c-41b21e3a091a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 01:46:02PM -0700, Ralph Campbell wrote:
> You can delete the comment "With the old API the driver must ..."
> (not visible in the patch here).

Sure.

> I suggest moving the two assignments:
> 	range->default_flags = 0;
> 	range->pfn_flags_mask = -1UL;
> to just above the "again:" where the other range.xxx fields are
> initialized in nouveau_svm_fault().

For now I really just want to move the code around.  As Jason pointed
out the flow will need some major rework, and I'd rather not mess
with little things like this for now.  Especially as I assume Jerome
must have an update to the proper API ready given that he both
wrote that new API and the nouveau code.

> You can delete this comment (only the first line is visible here)
> since it is about the "old API".

Ok.

> Also, it should return -EBUSY not -EAGAIN since it means there was a
> range invalidation collision (similar to hmm_range_fault() if
> !range->valid).

Yes, probably.


>> @@ -515,15 +517,14 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
>>     	ret = hmm_range_fault(range, block);
>
> nouveau_range_fault() is only called with "block = true" so
> could eliminate the block parameter and pass true here.

Indeed.

>
>>   	if (ret <= 0) {
>> -		if (ret == -EBUSY || !ret) {
>> -			/* Same as above, drop mmap_sem to match old API. */
>> -			up_read(&range->vma->vm_mm->mmap_sem);
>> -			ret = -EBUSY;
>> -		} else if (ret == -EAGAIN)
>> +		if (ret == 0)
>>   			ret = -EBUSY;
>> +		if (ret != -EAGAIN)
>> +			up_read(&range->vma->vm_mm->mmap_sem);
>
> Can ret == -EAGAIN happen if "block = true"?

I don't think so, we can remove that.

> Generally, I prefer the read_down()/read_up() in the same function
> (i.e., nouveau_svm_fault()) but I can see why it should be here
> if hmm_range_fault() can return with mmap_sem unlocked.

Yes, in the long run this all needs a major cleanup..


>>   @@ -718,8 +719,8 @@ nouveau_svm_fault(struct nvif_notify *notify)
>>   						NULL);
>>   			svmm->vmm->vmm.object.client->super = false;
>>   			mutex_unlock(&svmm->mutex);
>> +			up_read(&svmm->mm->mmap_sem);
>>   		}
>> -		up_read(&svmm->mm->mmap_sem);
>>   
>
> The "else" case should check for -EBUSY and goto again.

It should if I were trying to fix this.  But this is just code
inspection and I don't even have the hardware, so I'll have to leave
that for someone who can do real development on the driver.
