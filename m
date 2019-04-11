Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725332184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:23:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfDKMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:23:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3516A4E833D5552888C9;
        Thu, 11 Apr 2019 20:23:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 20:23:50 +0800
Subject: Re: [PATCH -next] memstick: remove set but not used variable 'data'
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20190411025904.188152-1-yuehaibing@huawei.com>
 <CAPDyKFq8icX27w2FaLgTWtdV1MicfVO+rG_5sZT9n-5pT7iAWg@mail.gmail.com>
CC:     Will Deacon <will.deacon@arm.com>, Jens Axboe <axboe@kernel.dk>,
        "Omar Sandoval" <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <df3b6949-a54e-c887-742d-94cecbb7f5d4@huawei.com>
Date:   Thu, 11 Apr 2019 20:23:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq8icX27w2FaLgTWtdV1MicfVO+rG_5sZT9n-5pT7iAWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/11 19:01, Ulf Hansson wrote:
> On Thu, 11 Apr 2019 at 04:48, YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/memstick/host/jmb38x_ms.c: In function 'jmb38x_ms_issue_cmd':
>> drivers/memstick/host/jmb38x_ms.c:371:17: warning:
>>  variable 'data' set but not used [-Wunused-but-set-variable]
>>
>> It's never used since introduction and can be removed.
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Applied for next (to my mmc tree), thanks!
> 
> Next time, please post to linux-mmc as well.

Ok, Thanks!

> 
> Kind regards
> Uffe
> 
> 
>> ---
>>  drivers/memstick/host/jmb38x_ms.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
>> index e3a5af65dbce..acec09813419 100644
>> --- a/drivers/memstick/host/jmb38x_ms.c
>> +++ b/drivers/memstick/host/jmb38x_ms.c
>> @@ -368,7 +368,6 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
>>  static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
>>  {
>>         struct jmb38x_ms_host *host = memstick_priv(msh);
>> -       unsigned char *data;
>>         unsigned int data_len, cmd, t_val;
>>
>>         if (!(STATUS_HAS_MEDIA & readl(host->addr + STATUS))) {
>> @@ -400,8 +399,6 @@ static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
>>                         cmd |= TPC_WAIT_INT;
>>         }
>>
>> -       data = host->req->data;
>> -
>>         if (!no_dma)
>>                 host->cmd_flags |= DMA_DATA;
>>
>>
>>
> 
> .
> 

