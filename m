Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2128C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D8020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCKJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfCKJdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 330BFAE60F11919CC8B3;
        Mon, 11 Mar 2019 17:33:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 17:33:49 +0800
Subject: Re: [PATCH] serial: sh-sci: Missing uart_unregister_driver() on error
 in sci_probe_single()
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20190308142310.112914-1-maowenan@huawei.com>
 <20190311072201.GA2434@kadam>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <ae1a9377-108d-bfd2-dad3-f2a2a91dd0ca@huawei.com>
Date:   Mon, 11 Mar 2019 17:33:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190311072201.GA2434@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/11 15:22, Dan Carpenter wrote:
> On Fri, Mar 08, 2019 at 10:23:10PM +0800, Mao Wenan wrote:
>> Add the missing uart_unregister_driver() before return
>> from sci_probe_single() in the error handling case.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/tty/serial/sh-sci.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 64bbeb7d7e0c..dde4eac9d222 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3254,8 +3254,10 @@ static int sci_probe_single(struct platform_device *dev,
>>  	mutex_unlock(&sci_uart_registration_lock);
>>  
>>  	ret = sci_init_single(dev, sciport, index, p, false);
>> -	if (ret)
>> +	if (ret) {
>> +		uart_unregister_driver(&sci_uart_driver);
>>  		return ret;
> 
> Why only this error path and not the next one?
> 
>> +	}
>>  
>>  	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>>  	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
>             ^^^^^^^^^^^^^^^^^^^^^
> This one.

yes, this one need it too. resend v2.
thank you.
> 
> regards,
> dan carpenter
> 
> 
> .
> 

