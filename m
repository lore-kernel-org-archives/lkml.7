Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0224C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfB1J1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:27:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfB1J1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:27:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40C8CE9A20594D511267;
        Thu, 28 Feb 2019 17:27:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 17:27:01 +0800
Subject: Re: [PATCH] staging: rtl8712: assign initial value to a static
 variable in r8712_efuse_pg_packet_write()
To:     Greg KH <greg@kroah.com>
References: <20190227033322.127177-1-maowenan@huawei.com>
 <20190228080454.GA8210@kroah.com>
CC:     <Larry.Finger@lwfinger.net>, <florian.c.schilhabel@googlemail.com>,
        <straube.linux@gmail.com>, <kernel-janitors@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <a7826f72-adb1-a7be-4397-64cd79d6ec67@huawei.com>
Date:   Thu, 28 Feb 2019 17:26:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190228080454.GA8210@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/28 16:04, Greg KH wrote:
> On Wed, Feb 27, 2019 at 11:33:22AM +0800, Mao Wenan wrote:
>> repeat_times is a static variable, but each time when it enters
>> r8712_efuse_pg_packet_write(), it is set to zero,
>> this value is not consistent with last calling, so next behavior
>> is not our expect.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/staging/rtl8712/rtl8712_efuse.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
>> index 8bc45ffd3029..3e8421255170 100644
>> --- a/drivers/staging/rtl8712/rtl8712_efuse.c
>> +++ b/drivers/staging/rtl8712/rtl8712_efuse.c
>> @@ -358,7 +358,7 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
>>  	u8 pg_header = 0;
>>  	u16 efuse_addr = 0, curr_size = 0;
>>  	u8 efuse_data, target_word_cnts = 0;
>> -	static int repeat_times;
>> +	static int repeat_times = 0;
>>  	int sub_repeat;
>>  	u8 bResult = true;
>>  
>> @@ -368,7 +368,6 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
>>  		return false;
>>  	pg_header = MAKE_EFUSE_HEADER(offset, word_en);
>>  	target_word_cnts = calculate_word_cnts(word_en);
>> -	repeat_times = 0;
>>  	efuse_addr = 0;
>>  	while (efuse_addr < efuse_available_max_size) {
>>  		curr_size = r8712_efuse_get_current_size(padapter);
> 
> This patch does not apply to my tree at all.
> 
> And are you sure this is correct?

sorry, my base tree is wrong, this fix is invalid.

> 
> greg k-h
> 
> .
> 

