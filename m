Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124ACC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD276206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfETKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:53:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfETKxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:53:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D68B38C3F3409373927E;
        Mon, 20 May 2019 18:53:19 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 18:53:15 +0800
Subject: Re: [RESEND PATCH] intel_th: msu: Fix unused variable warning on
 arm64 platform
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
References: <1558333597-63774-1-git-send-email-zhangshaokun@hisilicon.com>
 <87woilwjli.fsf@ashishki-desk.ger.corp.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <46480fe3-8639-c6a3-4acf-e7db2a6157b5@hisilicon.com>
Date:   Mon, 20 May 2019 18:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <87woilwjli.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2019/5/20 17:39, Alexander Shishkin wrote:
> Shaokun Zhang <zhangshaokun@hisilicon.com> writes:
> 
>> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
>> drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’ [-Wunused-variable]
>>   int ret = -ENOMEM, i;
>>                      ^
>> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
>> drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’ [-Wunused-variable]
>>   int i;
>>       ^
>> Fix this compiler warning on arm64 platform.
> 
> Thank you for taking care of this.
> 
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  drivers/hwtracing/intel_th/msu.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
>> index 81bb54fa3ce8..833a5a8f13ad 100644
>> --- a/drivers/hwtracing/intel_th/msu.c
>> +++ b/drivers/hwtracing/intel_th/msu.c
>> @@ -780,7 +780,10 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
>>  static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
>>  {
>>  	struct msc_window *win;
>> -	int ret = -ENOMEM, i;
>> +	int ret = -ENOMEM;
>> +#ifdef CONFIG_X86
>> +	int i;
>> +#endif
> 
> Can you factor it out into its own function? And one for the other
> memory type? So we can maybe keep it to just one #ifdef like
> 

Got it, I will update it in next version soon.

Thanks,
Shaokun

> #ifdef CONFIG_X86
> void msc_buffer_set_uc()
> { ... }
> void msc_buffer_set_wb()
> { ... }
> #else /* !X86 */
> static void msc_buffer_set_uc() {}
> static void msc_buffer_set_wb() {}
> #endif
> 
> Thanks,
> --
> Alex
> 
> .
> 

