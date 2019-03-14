Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14A2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCNB52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:57:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfCNB52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:57:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 224F6F1C37253045D3E8;
        Thu, 14 Mar 2019 09:57:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Mar 2019
 09:57:20 +0800
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.ibm.com>
References: <20190219072743.13606-1-yanaijie@huawei.com>
 <1550595388.31902.133.camel@acm.org> <20190220151836.GA11695@infradead.org>
 <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
 <1552521077.45180.119.camel@acm.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0043eef5-0be1-a86b-d438-252e4ef274af@huawei.com>
Date:   Thu, 14 Mar 2019 09:57:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1552521077.45180.119.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/14 7:51, Bart Van Assche wrote:
> On Thu, 2019-02-21 at 16:53 +0800, Jason Yan wrote:
>> On 2019/2/20 23:18, Christoph Hellwig wrote:
>>> [fullquote removed, please follow proper mail etiquette]
>>>
>>> On Tue, Feb 19, 2019 at 08:56:28AM -0800, Bart Van Assche wrote:
>>>> regression in the SCSI sd driver due to the switch from the legacy block
>>>> layer to scsi-mq. The above patch introduces two atomic operations in the
>>>> hot path and hence would introduce a performance regression. I think this
>>>> can be avoided by making sure that sd_uninit_command() gets called before
>>>> the request tag is freed. What changes would be required to make the block
>>>> layer core call sd_uninit_command() before the request tag is freed? Would
>>>> introducing prep_rq_fn and unprep_rq_fn callbacks in struct blk_mq_ops and
>>>> making sure that the SCSI core sets these callback function pointers
>>>> appropriately be sufficient? Would such a change allow to simplify the NVMe
>>>> initiator driver? Are there any alternatives to this approach that are more
>>>> elegant?
>>>
>>> Additional indirect calls in the I/O fast path is something I'd rather
>>> avoid.  But I don't fully understand the problem yet - where do
>>> we release a disk reference from blk_update_request?
>>
>> When userspace close the fd after blk_update_request() and before
>> scsi_mq_uninit_cmd(), a disk reference will be released. It is not the
>> blk_update_request() directly released it.
>>
>> close
>>      ->sd_release
>>         ->scsi_disk_put
>>           ->scsi_disk_release
>>             ->disk->private_data = NULL;
>>
>> The userspace can close the fd because blk_update_request() returned the
>> last IO , the userspace application does not have to stuck on read() or
>> write(). The window is very small, but it can be reproduce every day
>> in our testcases. So I'm very curious why. One possible explanation is
>> that we enabled kernel preempt(CONFIG_PREEMPT).
>>
>> And why can't we move that release to __blk_mq_end_request?
> 
> Hi Jason,
> 
> What is the current status of this issue?
> 

Hi Bart,

I did not find any other approach that will not affect the hot path. I 
don't know if you guys have other suggestions?

> Thanks,
> 
> Bart.
> 
> .
> 

