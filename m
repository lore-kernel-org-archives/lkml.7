Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E796C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8A124676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLFHLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:11:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfLFHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:11:22 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 322B63A77FAC6FC516EA;
        Fri,  6 Dec 2019 15:11:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 15:11:11 +0800
Subject: Re: [PATCH] tty: omap-serial: remove set but unused variable
To:     Jiri Slaby <jslaby@suse.com>, Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <shubhrajyoti@ti.com>,
        "balbi@ti.com >> Felipe Balbi" <balbi@ti.com>
References: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
 <20191205121310.GA389695@kroah.com>
 <64810841-5e07-c346-01f3-dfd40a3f2df0@huawei.com>
 <0d5c4085-a6dc-ae06-34f2-7d4221baa5e9@suse.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <ad64f294-2d45-b65d-a861-f4c494909afe@huawei.com>
Date:   Fri, 6 Dec 2019 15:11:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0d5c4085-a6dc-ae06-34f2-7d4221baa5e9@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/5 20:39, Jiri Slaby wrote:
> On 05. 12. 19, 13:30, Xiongfeng Wang wrote:
>>
>>
>> On 2019/12/5 20:13, Greg KH wrote:
>>> On Thu, Dec 05, 2019 at 08:04:36PM +0800, Xiongfeng Wang wrote:
>>>> Fix the following warning:
>>>> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
>>>> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>>> ---
>>>>  drivers/tty/serial/omap-serial.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>>>> index 6420ae5..54ee3ae 100644
>>>> --- a/drivers/tty/serial/omap-serial.c
>>>> +++ b/drivers/tty/serial/omap-serial.c
>>>> @@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>>>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>>>>  {
>>>>  	unsigned int flag;
>>>> -	unsigned char ch = 0;
>>>>  
>>>>  	if (likely(lsr & UART_LSR_DR))
>>>> -		ch = serial_in(up, UART_RX);
>>>> +		serial_in(up, UART_RX);
>>>
>>> Shouldn't you be doing something with 'ch'?
>>
>> Sorry, my original thought is trying not to modify the existing logic.
>> I will look into the mechanism to see if I need to check 'ch'.
> 
> The change looks in fact correct, see:
> commit 9a12fcf8b1543c99ffcec3d61db86f0dea52dc9d
> Author: Shubhrajyoti D <shubhrajyoti@ti.com>
> Date:   Fri Sep 21 20:07:19 2012 +0530
> 
>     serial: omap: fix the reciever line error case
> 
> It also says: "This is recommended in the interrupt reset method in the
> table 23-246 of the omap4 TRM."
> 
> The character read is erroneous and should be apparently dropped. But
> you should add a comment about it, though.

Thanks a lot. I will add it in the comment and send another version.

Thanks,
Xiongfeng

> 
> thanks,
> 

