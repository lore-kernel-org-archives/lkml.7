Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06918206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kRrrpxim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbfILRQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:16:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18978 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfILRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:16:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7a7d8d0000>; Thu, 12 Sep 2019 10:17:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Sep 2019 10:16:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Sep 2019 10:16:57 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Sep
 2019 17:16:57 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 12 Sep 2019 17:16:51 +0000
Subject: Re: [PATCH 1/4] mm/hmm: make full use of walk_page_range()
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
 <20190911222829.28874-2-rcampbell@nvidia.com> <20190912082613.GA14368@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <973b7159-513f-0776-668d-8ba1adf87f1c@nvidia.com>
Date:   Thu, 12 Sep 2019 10:16:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912082613.GA14368@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568308621; bh=0I/msTXMK3oeVIVr50/e/aSOEcjBKVeKIFb7hH02Hio=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kRrrpximNrle4ueUTW3i6O9Mb0HqYE3SBDqBD8uvc6Pk1mWY4I5cAXt9LeMFFnbUQ
         rPbvrrX80AI7hACgTF3cHGGmoLyY1fF8xdUTnIpP57+U+5o/qmkuje1REYgxux/tHo
         epw+5Jl8KJNz5hkr0Slxr8vkyWnuGEIaql8P7F2UXYkothY48LnIZ30eP/FQjOB6pB
         gAObbpf2n5+xP6fIRhEHSJ7RZnSaexO5cHoQ8IIegdQ59WsiLu29hkDVFSJQTAzeIv
         fw996tl3wwsXISYoWQd9OcLICHrROIYQbJsIdSGB0yVRwkRzQcW03EG0Zg+rQLB2ol
         UxoOO/UNTLxSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/19 1:26 AM, Christoph Hellwig wrote:
>> +static int hmm_pfns_fill(unsigned long addr,
>> +			 unsigned long end,
>> +			 struct hmm_range *range,
>> +			 enum hmm_pfn_value_e value)
> 
> Nit: can we use the space a little more efficient, e.g.:
> 
> static int hmm_pfns_fill(unsigned long addr, unsigned long end,
> 		struct hmm_range *range, enum hmm_pfn_value_e value)
> 
>> +static int hmm_vma_walk_test(unsigned long start,
>> +			     unsigned long end,
>> +			     struct mm_walk *walk)
> 
> Same here.
> 
>> +	if (!(vma->vm_flags & VM_READ)) {
>> +		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
> 
> There should be no need for the void cast here.
> 

OK. I'll post a v2 with the these changes.
Thanks for the reviews.
