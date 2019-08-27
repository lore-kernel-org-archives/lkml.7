Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24148C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E635620674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mVWKFws1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfH0UQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:16:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10286 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0UQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:16:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d658f8f0000>; Tue, 27 Aug 2019 13:16:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 13:16:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 13:16:13 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 20:16:13 +0000
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-3-rcampbell@nvidia.com>
 <20190827184157.GA24929@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <f5c1f198-4bdd-3c23-428f-764f894b9997@nvidia.com>
Date:   Tue, 27 Aug 2019 13:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190827184157.GA24929@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566936975; bh=62vGPIEVS329R8EcQsp55qtpEj1Wy2MdKSgth1zICoc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mVWKFws1HRjcwMU4KK1X7p1o8yonqFQ3zcqupn0zPr5oGsS/Nhvvd7U/tPbwZwAKu
         d4ZvKn9dlm8GRZaZo3GoGEUAhJEY4j2rxqDh9fRMAyKnIdpSvp/4gSN18uzPgTC3D+
         LCNkfwT6+mHkxzSajlnGlbb9pZwCxUSUmGk8cyg/TQvNQ3Yc4oI5+EhyMvw18cN9qG
         8gRZsKwWbJWVYUfmGLzf9oSNdx/aOV7wufOur1JtTdi8Ef46rMoQ09VwFP84JVX/x7
         Sv8gB56HOLq0NoOPFdlcxpEMIttHaJTgCBnTpEGfDbQrxsw5uIH+qeHcstowwDqfQR
         ENGgtWLuJWA7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/19 11:41 AM, Jason Gunthorpe wrote:
> On Fri, Aug 23, 2019 at 03:17:53PM -0700, Ralph Campbell wrote:
> 
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>   mm/hmm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 29371485fe94..4882b83aeccb 100644
>> +++ b/mm/hmm.c
>> @@ -292,6 +292,9 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsigned long end,
>>   	hmm_vma_walk->last = addr;
>>   	i = (addr - range->start) >> PAGE_SHIFT;
>>   
>> +	if (write_fault && walk->vma && !(walk->vma->vm_flags & VM_WRITE))
>> +		return -EPERM;
> 
> Can walk->vma be NULL here? hmm_vma_do_fault() touches it
> unconditionally.
> 
> Jason
> 
walk->vma can be NULL. hmm_vma_do_fault() no longer touches it
unconditionally, that is what the preceding patch fixes.
I suppose I could change hmm_vma_walk_hole_() to check for NULL
and fill in the pfns[] array, I just chose to handle it in
hmm_vma_do_fault().
