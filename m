Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D93C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfFLJSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:18:53 -0400
Received: from mx.socionext.com ([202.248.49.38]:16186 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfFLJSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:18:53 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Jun 2019 18:18:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4152460629;
        Wed, 12 Jun 2019 18:18:51 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 12 Jun 2019 18:18:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E9C9F40376;
        Wed, 12 Jun 2019 18:18:50 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D2133120B25;
        Wed, 12 Jun 2019 18:18:50 +0900 (JST)
Subject: Re: [PATCH] serial: Fix an invalid comparing statement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
 <20190610165655.GA397@kroah.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <3b075194-9cea-6de9-31ed-b6dda1e87e9a@socionext.com>
Date:   Wed, 12 Jun 2019 18:18:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610165655.GA397@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/06/11 1:56, Greg Kroah-Hartman wrote:
> On Mon, May 27, 2019 at 02:01:27PM +0900, Sugaya Taichi wrote:
>> Drop the if-statement which refers to 8th bit field of u8 variable.
>> The bit field is no longer used.
>>
>> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
>> Reported-by: Colin Ian King <colin.king@canonical.com>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
>> index 949ab7e..d7207ab 100644
>> --- a/drivers/tty/serial/milbeaut_usio.c
>> +++ b/drivers/tty/serial/milbeaut_usio.c
>> @@ -56,7 +56,6 @@
>>   #define MLB_USIO_SSR_FRE		BIT(4)
>>   #define MLB_USIO_SSR_PE			BIT(5)
>>   #define MLB_USIO_SSR_REC		BIT(7)
>> -#define MLB_USIO_SSR_BRK		BIT(8)
>>   #define MLB_USIO_FCR_FE1		BIT(0)
>>   #define MLB_USIO_FCR_FE2		BIT(1)
>>   #define MLB_USIO_FCR_FCL1		BIT(2)
>> @@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
>>   		if (status & MLB_USIO_SSR_ORE)
>>   			port->icount.overrun++;
>>   		status &= port->read_status_mask;
>> -		if (status & MLB_USIO_SSR_BRK) {
>> -			flag = TTY_BREAK;
>> +		if (status & MLB_USIO_SSR_PE) {
>> +			flag = TTY_PARITY;
>>   			ch = 0;
>>   		} else
>> -			if (status & MLB_USIO_SSR_PE) {
>> -				flag = TTY_PARITY;
>> +			if (status & MLB_USIO_SSR_FRE) {
>> +				flag = TTY_FRAME;
>>   				ch = 0;
>> -			} else
>> -				if (status & MLB_USIO_SSR_FRE) {
>> -					flag = TTY_FRAME;
>> -					ch = 0;
>> -				}
>> +			}
>>   		if (flag)
>>   			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
>>   					 ch, flag);
> 
> While the code never actually supported Break, you are explicitly
> removing that logic now.  So shouldn't you instead _fix_ break handling?
> The code before and after your change does not work any differently, so
> this patch isn't really needed at this point.
> 

According to research, MLB_USIO_SSR_BRK was a remnant of old HW.
Since current one does not handle the Break, all logic related it should be
removed. I try to make a new fix patch.

Thanks,
Sugaya Taichi

> thanks,
> 
> greg k-h
> 

