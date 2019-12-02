Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF4C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE992084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBKCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:02:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfLBKCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:02:42 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2998B39E9A46CA465067;
        Mon,  2 Dec 2019 10:02:39 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Dec 2019 10:02:38 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 10:02:38 +0000
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com>
 <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
 <CAM_iQpX3MKoBRvxqc-bJ0HvASNeZmvVCYhbT53maMy-rqy4eiw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9996d30c-e063-e74d-925f-4181c36ca764@huawei.com>
Date:   Mon, 2 Dec 2019 10:02:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAM_iQpX3MKoBRvxqc-bJ0HvASNeZmvVCYhbT53maMy-rqy4eiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2019 06:02, Cong Wang wrote:
> On Fri, Nov 29, 2019 at 5:24 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 29/11/2019 00:48, Cong Wang wrote:
>>> If the maganize is empty, iova_magazine_free_pfns() should
>>
>> magazine
> 
> Good catch!
> 
>>
>>> be a nop, however it misses the case of mag->size==0. So we
>>> should just call iova_magazine_empty().
>>>
>>> This should reduce the contention on iovad->iova_rbtree_lock
>>> a little bit.
>>>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>> ---
>>>    drivers/iommu/iova.c | 22 +++++++++++-----------
>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index cb473ddce4cf..184d4c0e20b5 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
>>>        kfree(mag);
>>>    }
>>>
>>> +static bool iova_magazine_full(struct iova_magazine *mag)
>>> +{
>>> +     return (mag && mag->size == IOVA_MAG_SIZE);
>>> +}
>>> +
>>> +static bool iova_magazine_empty(struct iova_magazine *mag)
>>> +{
>>> +     return (!mag || mag->size == 0);
>>> +}
>>> +
>>>    static void
>>>    iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>>>    {
>>>        unsigned long flags;
>>>        int i;
>>>
>>> -     if (!mag)
>>> +     if (iova_magazine_empty(mag))
>>
>> The only hot path we this call is
>> __iova_rcache_insert()->iova_magazine_free_pfns(mag_to_free) and
>> mag_to_free is full in this case, so I am sure how the additional check
>> helps, right?
> 
> This is what I mean by "a little bit" in changelog, did you miss it or
> misunderstand it? :)

I was concerned that in the fastpath we actually make things very 
marginally slower by adding a check which will fail.

Thanks,
John

> 
> Thanks.
> .
> 

