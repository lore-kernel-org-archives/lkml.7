Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BBC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B472464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfLEMai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:30:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfLEMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:30:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAA31F8FBE18B222A32A;
        Thu,  5 Dec 2019 20:30:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 20:30:26 +0800
Subject: Re: [PATCH] tty: omap-serial: remove set but unused variable
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
References: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
 <20191205121310.GA389695@kroah.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <64810841-5e07-c346-01f3-dfd40a3f2df0@huawei.com>
Date:   Thu, 5 Dec 2019 20:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20191205121310.GA389695@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/5 20:13, Greg KH wrote:
> On Thu, Dec 05, 2019 at 08:04:36PM +0800, Xiongfeng Wang wrote:
>> Fix the following warning:
>> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
>> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/tty/serial/omap-serial.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 6420ae5..54ee3ae 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>>  {
>>  	unsigned int flag;
>> -	unsigned char ch = 0;
>>  
>>  	if (likely(lsr & UART_LSR_DR))
>> -		ch = serial_in(up, UART_RX);
>> +		serial_in(up, UART_RX);
> 
> Shouldn't you be doing something with 'ch'?

Sorry, my original thought is trying not to modify the existing logic.
I will look into the mechanism to see if I need to check 'ch'.

Thanks,
Xiongfeng

> 
> 
> .
> 

