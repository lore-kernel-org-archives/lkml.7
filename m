Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A8720854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bMYCIroi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCNDTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:19:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16784 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCNDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:19:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c89c8450000>; Wed, 13 Mar 2019 20:19:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 20:19:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 20:19:31 -0700
Received: from [10.2.175.16] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Mar
 2019 03:19:31 +0000
Subject: Re: [PATCH v3 1/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <20190306235455.26348-2-jhubbard@nvidia.com>
 <20190312153033.GG1119@iweiny-DESK2.sc.intel.com>
 <c9c80511-0805-a877-af6f-b769c6dcb111@nvidia.com>
 <20190313144941.GA23350@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c29ddfcc-ce1d-f4bd-7e0d-905b6f92ecc7@nvidia.com>
Date:   Wed, 13 Mar 2019 20:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313144941.GA23350@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552533573; bh=8/FESUTll/7HXtBTMTTiOUp3okh43kK5SAPTWHHLwRg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bMYCIroiLhtLgP5RD406L4RZ9r+wOTIToldbo1EQJPFCYWmUfroe4suZ8m8ZDjJ8l
         VM21eJpIEFgno268ZPf359z+FDlWnEPginnpJomfLAtcu3GXvZlEkc0/ArWh91XvUs
         CRtEw+YPsXaorRoLfYMwizU/eZgKRRjFcVefqF8p98v0mWlXbXTRG3cDqYFJe3MaTZ
         eRogMcX3yIHOwOPTW0rrOEv+87wsuLkV3o/IrZ1s9EqPFjf21c+4R8GfVU9O0LEisw
         Q1W1wYAS6UWtj2f/ceWun2FGe8t4WK5H3QQrAoyrhTwfh4V9+oUeWSvJklWMdKIelY
         5tc/s+hECaeUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 7:49 AM, Ira Weiny wrote:
> On Tue, Mar 12, 2019 at 05:38:55PM -0700, John Hubbard wrote:
>> On 3/12/19 8:30 AM, Ira Weiny wrote:
>>> On Wed, Mar 06, 2019 at 03:54:55PM -0800, john.hubbard@gmail.com wrote:
>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>>
>>>> Introduces put_user_page(), which simply calls put_page().
>>>> This provides a way to update all get_user_pages*() callers,
>>>> so that they call put_user_page(), instead of put_page().
>>>
>>> So I've been running with these patches for a while but today while ramping up
>>> my testing I hit the following:
>>>
>>> [ 1355.557819] ------------[ cut here ]------------
>>> [ 1355.563436] get_user_pages pin count overflowed
>>
>> Hi Ira,
>>
>> Thanks for reporting this. That overflow, at face value, means that we've
>> used more than the 22 bits worth of gup pin counts, so about 4 million pins
>> of the same page...
> 
> This is my bug in the patches I'm playing with.  Somehow I'm causing more puts
> than gets...  I'm not sure how but this is for sure my problem.
> 
> Backing off to your patch set the numbers are good.

Now that's a welcome bit of good news!

> 
> Sorry for the noise.
> 
> With the testing I've done today I feel comfortable adding
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> 
> For the main GUP and InfiniBand patches.
> 
> Ira
> 

OK, I'll add your tested-by tag to patches 1, 2, 4, 5 (the numbering refers
to the "RFC v2: mm: gup/dma tracking" posting [1]) in my repo [2], and they'll 
show up in the next posting. (Patch 3 is already upstream, and patch 6 is
documentation that needs to be rewritten entirely.)

[1] https://lore.kernel.org/r/20190204052135.25784-1-jhubbard@nvidia.com

[2] https://github.com/johnhubbard/linux/tree/gup_dma_core

thanks,
-- 
John Hubbard
NVIDIA
