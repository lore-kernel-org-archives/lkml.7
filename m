Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB137C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39982086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbfHBHvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:51:36 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50242 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfHBHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:51:36 -0400
Received: from [192.168.1.109] ([176.167.178.124])
        by mwinf5d45 with ME
        id k7rX2000A2hRaC0037rXnD; Fri, 02 Aug 2019 09:51:32 +0200
X-ME-Helo: [192.168.1.109]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Aug 2019 09:51:32 +0200
X-ME-IP: 176.167.178.124
Subject: Re: [PATCH] HID: usbhid: Use GFP_KERNEL instead of GFP_ATOMIC when
 applicable
To:     wharms@bfs.de
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190801074759.32738-1-christophe.jaillet@wanadoo.fr>
 <5D42B98B.40900@bfs.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <36fe1980-9b92-084d-f9db-fac07e624076@wanadoo.fr>
Date:   Fri, 2 Aug 2019 09:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D42B98B.40900@bfs.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (and sorry if you receive this email twice. I've used a web mail 
which sends HTML by default and it was rejected by ML)

Le 01/08/2019 à 12:06, walter harms a écrit :
> 
> 
> Am 01.08.2019 09:47, schrieb Christophe JAILLET:
>> There is no need to use GFP_ATOMIC when calling 'usb_alloc_coherent()'
>> here. These calls are done from probe functions and using GFP_KERNEL should
>> be safe.
>> The memory itself is used within some interrupts, but it is not a
>> problem, once it has been allocated.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/hid/usbhid/usbkbd.c   | 4 ++--
>>   drivers/hid/usbhid/usbmouse.c | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
>> index d5b7a696a68c..63e8ef8beb45 100644
>> --- a/drivers/hid/usbhid/usbkbd.c
>> +++ b/drivers/hid/usbhid/usbkbd.c
>> @@ -239,11 +239,11 @@ static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
>>   		return -1;
>>   	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
>>   		return -1;
>> -	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
>> +	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, &kbd->new_dma)))
>>   		return -1;
>>   	if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
>>   		return -1;
>> -	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
>> +	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, &kbd->leds_dma)))
>>   		return -1;
>>   
> 
> the kernel style is usually:
>   kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma);
>   if (!kbd->new)
> 	return -1;
> 

Searching with coccinelle with:
*   x = usb_alloc_coherent(..., <+... GFP_KERNEL ...+>, ...);
finds 67 files,

whereas:
*   x = usb_alloc_coherent(..., <+... GFP_ATOMIC ...+>, ...);
only finds 11 files.

> 
> in usbmouse.c this is done, any reason for the change here ?
> 

No real reason in fact, just to be consistent with surrounding code.

Unless some allocations are done within a spin_lock/spin_unlock, using 
both GFP_KERNEL and GFP_ATOMIC in the same function looks spurious to me.
Either there is a bug (GFP_KERNEL should be GFP_ATOMIC), or a useless 
constraint is given to the memory allocator.

CJ

> re,
>   wh
> 
>>   	return 0;
>> diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
>> index 073127e65ac1..c89332017d5d 100644
>> --- a/drivers/hid/usbhid/usbmouse.c
>> +++ b/drivers/hid/usbhid/usbmouse.c
>> @@ -130,7 +130,7 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
>>   	if (!mouse || !input_dev)
>>   		goto fail1;
>>   
>> -	mouse->data = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &mouse->data_dma);
>> +	mouse->data = usb_alloc_coherent(dev, 8, GFP_KERNEL, &mouse->data_dma);
>>   	if (!mouse->data)
>>   		goto fail1;
>>   
> 

