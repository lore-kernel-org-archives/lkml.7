Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA10BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9420CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLQC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:27:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfLQC1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:27:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF19655929F85BFEED91;
        Tue, 17 Dec 2019 10:26:56 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 10:26:53 +0800
Message-ID: <5DF83CEC.5060002@huawei.com>
Date:   Tue, 17 Dec 2019 10:26:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Stultz <john.stultz@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
References: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com> <1576503511-27500-1-git-send-email-zhongjiang@huawei.com> <CALAqxLWAWc6NZDnixWhmHg6BtGHXTy6pZ6GXM0F=SkoYH8DiQw@mail.gmail.com>
In-Reply-To: <CALAqxLWAWc6NZDnixWhmHg6BtGHXTy6pZ6GXM0F=SkoYH8DiQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/17 5:13, John Stultz wrote:
> On Mon, Dec 16, 2019 at 5:43 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following sparse warning.
>>
>> drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds' was not declared. Should it be static?
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/dma-buf/dma-heap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
>> index 4f04d10..da2090e 100644
>> --- a/drivers/dma-buf/dma-heap.c
>> +++ b/drivers/dma-buf/dma-heap.c
>> @@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>>         return 0;
>>  }
>>
>> -unsigned int dma_heap_ioctl_cmds[] = {
>> +static unsigned int dma_heap_ioctl_cmds[] = {
>>         DMA_HEAP_IOC_ALLOC,
>>  };
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> This patch will collide with Andrew's _IOCTL_ naming change, but its a
> fairly simple thing to resolve.
>
> Sumit: If you're comfortable resolving the collision, please queue
> with the rest of the recent changes for drm-misc-next.
> Otherwise, I'm happy to submit the resolution I tested with here
> afterwards. Let me know.
As it is an fairly simple patch, I hope you can resolve the issue directly.

Thanks,
zhong jiang
> thanks
> -john
>
> .
>


