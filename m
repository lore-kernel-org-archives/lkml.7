Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED930C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B1621019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Wpc8uOrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEWGdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:33:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16451 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWGdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:33:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce63ecf0000>; Wed, 22 May 2019 23:33:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 23:33:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 May 2019 23:33:50 -0700
Received: from [10.2.169.219] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 06:33:49 +0000
Subject: Re: [PATCH 5/5] mm/hmm: Fix mm stale reference use in hmm_free()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506233514.12795-1-rcampbell@nvidia.com>
 <20190522233628.GA16137@ziepe.ca>
 <2938d2da-424d-786e-5486-1e4fa9f58425@nvidia.com>
 <20190523012504.GG15389@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0994464b-8e59-c227-0b67-00ddd9c83943@nvidia.com>
Date:   Wed, 22 May 2019 23:32:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523012504.GG15389@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558593231; bh=DMgMenbiYkWeMSHYgllY0KX56kuCMPb7MQ3jm5E4nqE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Wpc8uOrTOwt5LsR4mYCEpKSR3W18iqjaOJShap9QBNSQwpiwqktG7gS+nRRAeCNTI
         z51b+X+xRvcEzjdH497mx/qR//Y5p2pxbCAUnuQiDckr0CMcMgzIm321CP0j4qMwrK
         vTaVKBHknoV3n93dwec2nIJ24KUbd4FYrsXcHTeYrFFLmdecMoeWl+ysPIYGwwuf6p
         x7rc+PPigxXuBOWrXD4CtYYYzoj3C1a9gDQpfAgRx/XWDxCfJJnEeSbxeKZIPaiA7N
         lw9Ipfg+lCZqyxljJso/m4GFf3DalwjB2MR7RjPXqIBG9bqKgjuWm0gwLn7y5T3TYB
         P1hLkZoEPSR/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 6:25 PM, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 05:54:17PM -0700, Ralph Campbell wrote:
>>
>> On 5/22/19 4:36 PM, Jason Gunthorpe wrote:
>>> On Mon, May 06, 2019 at 04:35:14PM -0700, rcampbell@nvidia.com wrote:
>>>> From: Ralph Campbell <rcampbell@nvidia.com>
>>>>
>>>> The last reference to struct hmm may be released long after the mm_struct
>>>> is destroyed because the struct hmm_mirror memory may be part of a
>>>> device driver open file private data pointer. The file descriptor close
>>>> is usually after the mm_struct is destroyed in do_exit(). This is a good
>>>> reason for making struct hmm a kref_t object [1] since its lifetime spans
>>>> the life time of mm_struct and struct hmm_mirror.
>>>
>>>> The fix is to not use hmm->mm in hmm_free() and to clear mm->hmm and
>>>> hmm->mm pointers in hmm_destroy() when the mm_struct is
>>>> destroyed.
>>>
>>> I think the right way to fix this is to have the struct hmm hold a
>>> mmgrab() on the mm so its memory cannot go away until all of the hmm
>>> users release the struct hmm, hmm_ranges/etc
>>>
>>> Then we can properly use mmget_not_zero() instead of the racy/abnormal
>>> 'if (hmm->xmm == NULL || hmm->dead)' pattern (see the other
>>> thread). Actually looking at this, all these tests look very
>>> questionable. If we hold the mmget() for the duration of the range
>>> object, as Jerome suggested, then they all get deleted.
>>>
>>> That just leaves mmu_notifier_unregister_no_relase() as the remaining
>>> user of hmm->mm (everyone else is trying to do range->mm) - and it
>>> looks like it currently tries to call
>>> mmu_notifier_unregister_no_release on a NULL hmm->mm and crashes :(
>>>
>>> Holding the mmgrab fixes this as we can safely call
>>> mmu_notifier_unregister_no_relase() post exit_mmap on a grab'd mm.
>>>
>>> Also we can delete the hmm_mm_destroy() intrustion into fork.c as it
>>> can't be called when the mmgrab is active.
>>>
>>> This is the basic pattern we used in ODP when working with mmu
>>> notifiers, I don't know why hmm would need to be different.

+1 for the mmgrab() approach. I have never been able to see how these
various checks can protect anything, and refcounting it into place definitely
sounds like the right answer.


thanks,
-- 
John Hubbard
NVIDIA
