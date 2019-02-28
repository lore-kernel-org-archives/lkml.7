Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467212084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CD2TxwtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfB1WLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:11:38 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17552 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfB1WLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:11:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c785c990000>; Thu, 28 Feb 2019 14:11:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 14:11:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Feb 2019 14:11:37 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Feb
 2019 22:11:37 +0000
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
 <44ffadb4-4235-76c9-332f-680dda5da521@nvidia.com>
 <67a79bb9-12b5-e668-abb1-ef91a9cbfea8@suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1f978daf-a037-e7e8-079f-80b421e663e1@nvidia.com>
Date:   Thu, 28 Feb 2019 14:11:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <67a79bb9-12b5-e668-abb1-ef91a9cbfea8@suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551391897; bh=lp0YkothahhdP4oQqOkXRwHxr5NEdq2Tk+d6kbvXpvs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CD2TxwtFekB+bBed5i0C1P4DuD2v5dgZN5qqtiUld50Q948O/cWRv7yuw5gs/TDEQ
         FR9v7o8SGJLGMEzBTYMb4VC1rjPp+RfJztcpEXyfH7kqwO2HurvKBogeltDkmhKdyV
         jSVGop4Ot6AWpm3d23F7Luig9XGcMjxBRgPac0ciDvobI8UI7gU8vqQoWxtvdTjZNn
         /uXzPbJqd8HuQYuqMhLg2j9AmqQVDYadRch9zSM2P/VIzyK0ZSKQ/omIEN6VJ6YEz5
         zbNC7GfJBfL7wTVavZe7xcODbD3Pe7sDxcfcQwTIdN/CMX5jcUeyM372zo+/Fkjkpw
         21BdF8AWj+V1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 1:56 PM, Vlastimil Babka wrote:
> On 2/28/2019 10:44 PM, John Hubbard wrote:
>> Instead of removing that function, let's change it, and add another
>> (since you have two cases: either a page* or a pgdat* is available),
>> and move it to where it can compile, like this:
>>
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 80bb6408fe73..cea3437f5d68 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1167,6 +1167,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
>>         return NODE_DATA(page_to_nid(page));
>>  }
>>  
>> +static inline spinlock_t *zone_lru_lock(pg_data_t *pgdat)
> 
> In that case it should now be named node_lru_lock(). zone_lru_lock() was a
> wrapper introduced to make the conversion of per-zone to per-node lru_lock smoother.
> 

Sounds good to me.

thanks,
-- 
John Hubbard
NVIDIA
