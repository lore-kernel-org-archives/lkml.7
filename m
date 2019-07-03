Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F3C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A2C2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGCHKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:10:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfGCHKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:10:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BBCA1ED299731A1D55F;
        Wed,  3 Jul 2019 14:54:23 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 14:54:17 +0800
Subject: Re: [PATCH] staging: erofs: fix LZ4 limited bounced page mis-reuse
To:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Du Wei <weidu.du@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190630185846.16624-1-hsiangkao@aol.com>
 <dbd9e23d-3e76-8281-81f3-48680b4d0b9d@huawei.com>
 <e57f757f-2a61-3c5d-bf06-264cd1d00fef@huawei.com>
 <570e12d3-985e-3d5a-d7d4-cf0a072442fe@huawei.com>
 <9a199c2a-31be-5768-c5bd-dba69b99d99b@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <340a943e-a912-7937-9a1b-0ef66833c35f@huawei.com>
Date:   Wed, 3 Jul 2019 14:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <9a199c2a-31be-5768-c5bd-dba69b99d99b@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/3 14:51, Chao Yu wrote:
> Hi xiang,
> 
> On 2019/7/3 14:06, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2019/7/3 10:09, Gao Xiang wrote:
>>>
>>>
>>> On 2019/7/3 9:50, Chao Yu wrote:
>>>> On 2019/7/1 2:58, Gao Xiang wrote:
>>>>> From: Gao Xiang <gaoxiang25@huawei.com>
>>>>>
>>>>> Like all lz77-based algrithms, lz4 has a dynamically populated
>>>>> ("sliding window") dictionary and the maximum lookback distance
>>>>> is 65535. Therefore the number of bounced pages could be limited
>>>>> by erofs based on this property.
>>>>>
>>>>> However, just now we observed some lz4 sequences in the extreme
>>>>> case cannot be decompressed correctly after this feature is enabled,
>>>>> the root causes after analysis are clear as follows:
>>>>> 1) max bounced pages should be 17 rather than 16 pages;
>>>>> 2) considering the following case, the broken implementation
>>>>>    could reuse unsafely in advance (in other words, reuse it
>>>>>    less than a safe distance),
>>>>>    0 1 2 ... 16 17 18 ... 33 34
>>>>>    b             p  b         b
>>>>>    note that the bounce page that we are concerned was allocated
>>>>>    at 0, and it reused at 18 since page 17 exists, but it mis-reused
>>>>>    at 34 in advance again, which causes decompress failure.
>>>>>
>>>>> This patch resolves the issue by introducing a bitmap to mark
>>>>> whether the page in the same position of last round is a bounced
>>>>> page or not, and a micro stack data structure to store all
>>>>> available bounced pages.
>>>>>
>>>>> Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
>>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>>>> ---
>>>>>  drivers/staging/erofs/decompressor.c | 50 ++++++++++++++++------------
>>>>>  1 file changed, 28 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
>>>>> index 80f1f39719ba..1fb0abb98dff 100644
>>>>> --- a/drivers/staging/erofs/decompressor.c
>>>>> +++ b/drivers/staging/erofs/decompressor.c
>>>>> @@ -13,7 +13,7 @@
>>>>>  #define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
>>>>>  #endif
>>>>>  
>>>>> -#define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
>>>>> +#define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
>>>>>  #ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
>>>>>  #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
>>>>>  #endif
>>>>> @@ -35,19 +35,28 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>>>>>  	const unsigned int nr =
>>>>>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>>>>>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>>>>> -	unsigned long unused[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>>>>> -					  BITS_PER_LONG)] = { 0 };
>>>>> +	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>>>>> +					   BITS_PER_LONG)] = { 0 };
>>>>>  	void *kaddr = NULL;
>>>>> -	unsigned int i, j, k;
>>>>> +	unsigned int i, j, top;
>>>>>  
>>>>> -	for (i = 0; i < nr; ++i) {
>>>>> +	top = 0;
>>>>> +	for (i = j = 0; i < nr; ++i, ++j) {
>>>>>  		struct page *const page = rq->out[i];
>>>>> +		struct page *victim;
>>>>>  
>>>>> -		j = i & (LZ4_MAX_DISTANCE_PAGES - 1);
>>>>> -		if (availables[j])
>>>>> -			__set_bit(j, unused);
>>>>> +		if (j >= LZ4_MAX_DISTANCE_PAGES)
>>>>> +			j = 0;
>>>>> +
>>>>> +		/* 'valid' bounced can only be tested after a complete round */
>>>>> +		if (test_bit(j, bounced)) {
>>>>> +			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
>>>>> +			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
>>>>> +			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
>>>>
>>>> Maybe we can change 'i - LZ4_MAX_DISTANCE_PAGES' to 'j' directly for better
>>>> readability.
>>>
>>> OK, I think they are equivalent as well, will change for readability, retest and resend.
>>> Thanks for your suggestion :)
>>
>> I tested again and I observed that using j broke the logic and I think we cannot use j
>> to replace i - LZ4_MAX_DISTANCE_PAGES.
>>
>> Since bounced pages was marked according to the last round rather than the first round,
>> we cannot directly use the first round pages to push into the stack, e.g.
> 
> Yes, I can understand that, so the bitmap only indicate page in previous round
> is a new bounced page or a referenced bounced page, using page at last round is
> safe.
> 
> Anyway, thanks for the explanation below, and go ahead with current
> implementation. :)

Yes, thanks for the idea and taking time to review :)

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> 1)
>>     0 1 2 ... 16 17 18 ... 33 34
>>     p             b            b
>>
>> bounce page could be allocated from rq->out[17], and we could reuse it from rq->out[34], which
>> is not equal to rq->out[0].
>>
>> 2)
>>     0 1 2 ... 16 17 18  19  ... 33 34 35 36
>>       b              p   b                b
>> allocated in rq->out[1] j = 1, reuse it in rq->out[19] j = 2, reuse it again in rq->out[36] j = 2,
>> which is not equal to rq->out[2].
>>
>> I think the original patch is ok, and it cannot be replaced to rq->out[j].
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Otherwise, it looks good to me.
>>>>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> Thanks,
>>>>
>>>>> +		}
>>>>>  
>>>>>  		if (page) {
>>>>> +			__clear_bit(j, bounced);
>>>>>  			if (kaddr) {
>>>>>  				if (kaddr + PAGE_SIZE == page_address(page))
>>>>>  					kaddr += PAGE_SIZE;
>>>>> @@ -59,27 +68,24 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>>>>>  			continue;
>>>>>  		}
>>>>>  		kaddr = NULL;
>>>>> +		__set_bit(j, bounced);
>>>>>  
>>>>> -		k = find_first_bit(unused, LZ4_MAX_DISTANCE_PAGES);
>>>>> -		if (k < LZ4_MAX_DISTANCE_PAGES) {
>>>>> -			j = k;
>>>>> -			get_page(availables[j]);
>>>>> +		if (top) {
>>>>> +			victim = availables[--top];
>>>>> +			get_page(victim);
>>>>>  		} else {
>>>>> -			DBG_BUGON(availables[j]);
>>>>> -
>>>>>  			if (!list_empty(pagepool)) {
>>>>> -				availables[j] = lru_to_page(pagepool);
>>>>> -				list_del(&availables[j]->lru);
>>>>> -				DBG_BUGON(page_ref_count(availables[j]) != 1);
>>>>> +				victim = lru_to_page(pagepool);
>>>>> +				list_del(&victim->lru);
>>>>> +				DBG_BUGON(page_ref_count(victim) != 1);
>>>>>  			} else {
>>>>> -				availables[j] = alloc_pages(GFP_KERNEL, 0);
>>>>> -				if (!availables[j])
>>>>> +				victim = alloc_pages(GFP_KERNEL, 0);
>>>>> +				if (!victim)
>>>>>  					return -ENOMEM;
>>>>>  			}
>>>>> -			availables[j]->mapping = Z_EROFS_MAPPING_STAGING;
>>>>> +			victim->mapping = Z_EROFS_MAPPING_STAGING;
>>>>>  		}
>>>>> -		rq->out[i] = availables[j];
>>>>> -		__clear_bit(j, unused);
>>>>> +		rq->out[i] = victim;
>>>>>  	}
>>>>>  	return kaddr ? 1 : 0;
>>>>>  }
>>>>>
>> .
>>
