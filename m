Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90672070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fwlOmLl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCDXgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:36:05 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17623 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:36:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7db65b0003>; Mon, 04 Mar 2019 15:35:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 15:36:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 15:36:03 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 23:36:03 +0000
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling
 paths
From:   John Hubbard <jhubbard@nvidia.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
CC:     "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <20190303165550.GB27123@iweiny-DESK2.sc.intel.com>
 <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f73f326b-1ef3-075a-ca11-88d0d881dacb@nvidia.com>
Date:   Mon, 4 Mar 2019 15:36:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551742556; bh=LUypKyWAgSGyWeHvdhOBpuLWhC2w577ik03jidPipkE=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fwlOmLl0bA1eSZQSHtrtyySK3uXtyYQNojUOe98wUXJuDL0XQXYZx5dI+BUXIkkUE
         io0h06ZVgQ5wgEDK7p+XIJVPQ6G/OwNmqo269Ob8b2+kDDwCuMuYABBIPrgB1eDcCW
         vyTLErz7dXLyE93JSquox3by49k4sUg+OU+6bBagQBO1ie7qJnaz8BpNitzoZT0b6b
         nU9IHAf19k8bqcdaQjDFYmDAvK978fFxrzopTxp2LSk9NIQQGiI5bgR61Mtirmfi1I
         hlB5MC1721tALbWwhAe2ZP8NFT6SjUD8/Ysnez4F/7IA8uatSL40zNlLMB2vVfGEHp
         vkqcqkjgAYRbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 3:11 PM, John Hubbard wrote:
> On 3/3/19 8:55 AM, Ira Weiny wrote:
>> On Sun, Mar 03, 2019 at 11:52:41AM +0200, Artemy Kovalyov wrote:
>>>
>>>
>>> On 02/03/2019 21:44, Ira Weiny wrote:
>>>>
>>>> On Sat, Mar 02, 2019 at 12:24:35PM -0800, john.hubbard@gmail.com wrote:
>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>>>
>>>>> ...
>>>>> 3. Dead code removal: the check for (user_virt & ~page_mask)
>>>>> is checking for a condition that can never happen,
>>>>> because earlier:
>>>>>
>>>>>      user_virt = user_virt & page_mask;
>>>>>
>>>>> ...so, remove that entire phrase.
>>>>>
>>>>>   		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
>>>>>   		mutex_lock(&umem_odp->umem_mutex);
>>>>>   		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
>>>>> -			if (user_virt & ~page_mask) {
>>>>> -				p += PAGE_SIZE;
>>>>> -				if (page_to_phys(local_page_list[j]) != p) {
>>>>> -					ret = -EFAULT;
>>>>> -					break;
>>>>> -				}
>>>>> -				put_page(local_page_list[j]);
>>>>> -				continue;
>>>>> -			}
>>>>> -
>>>>
>>>> I think this is trying to account for compound pages. (ie page_mask could
>>>> represent more than PAGE_SIZE which is what user_virt is being incrimented by.)
>>>> But putting the page in that case seems to be the wrong thing to do?
>>>>
>>>> Yes this was added by Artemy[1] now cc'ed.
>>>
>>> Right, this is for huge pages, please keep it.
>>> put_page() needed to decrement refcount of the head page.
>>
>> You mean decrement the refcount of the _non_-head pages?
>>
>> Ira
>>
> 
> Actually, I'm sure Artemy means head page, because put_page() always
> operates on the head page. 
> 
> And this reminds me that I have a problem to solve nearby: get_user_pages
> on huge pages increments the page->_refcount *for each tail page* as well.
> That's a minor problem for my put_user_page() 
> patchset, because my approach so far assumed that I could just change us
> over to:
> 
> get_user_page(): increments page->_refcount by a large amount (1024)
> 
> put_user_page(): decrements page->_refcount by a large amount (1024)
> 
> ...and just stop doing the odd (to me) technique of incrementing once for
> each tail page. I cannot see any reason why that's actually required, as
> opposed to just "raise the page->_refcount enough to avoid losing the head
> page too soon".
> 
> However, it may be tricky to do this in one pass. Probably at first, I'll have
> to do this horrible thing approach:
> 
> get_user_page(): increments page->_refcount by a large amount (1024)
> 
> put_user_page(): decrements page->_refcount by a large amount (1024) MULTIPLIED
>                  by the number of tail pages. argghhh that's ugly.
> 

I see that this is still not stated quite right.

...to clarify, I mean to leave the existing behavior alone. So it would be
the call sites (not put_user_page as the above says) that would be doing all
that decrementing. The call sites know how many decrements are appropriate.

Unless someone thinks of a clever way to clean this up in one shot. I'm not
really seeing any way.

thanks,
-- 
John Hubbard
NVIDIA
