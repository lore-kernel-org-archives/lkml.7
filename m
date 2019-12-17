Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA8C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B0A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLQBWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:22:33 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:47750 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:22:33 -0500
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 0BC1ABC6;
        Tue, 17 Dec 2019 09:22:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.30.14] (42.17.110.36.static.bjtelecom.net [36.110.17.42])
        by smtp.263.net (postfix) whith ESMTP id P20510T140147972622080S1576545740921042_;
        Tue, 17 Dec 2019 09:22:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f54d02cd2c5f8334c6d5cfe055826e0c>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: lvlisong@emindsoft.com.cn
X-SENDER-IP: 36.110.17.42
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or disable
 irq sharing based on isa or pci bus
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
 <20191213105033.GT32742@smile.fi.intel.com>
 <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
 <20191216095120.GN32742@smile.fi.intel.com>
From:   Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <2c4cba36-5833-ca08-4153-2061edf33186@emindsoft.com.cn>
Date:   Tue, 17 Dec 2019 09:22:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191216095120.GN32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/16 下午5:51, Andy Shevchenko wrote:
> On Mon, Dec 16, 2019 at 10:27:23AM +0800, Chen Gang wrote:
>> Thank you for your reply.
>>
>> I guess, this patch has to be refactored to match the related linux
>> versions. And excuse me, my orignal hardware environments has been gone,
>> so I can not give the new refactored patch additional test.
>>
>> It is necessary to continue discussing and reviewing this patch to let
>> it be known completely, but I guess I am not the suitable persion to
>> refactor the patch.
> 
> Yeah, you may refactor it, but please mention in the comment (the text going
> after '---' line) that you are not able to test it. At least for maintainer it
> may be a crucial point either to take your change or not.
> 

OK, I shall try to refactor the patch within this weekend in the latest
linux-next tree.

I should abey the GPL license, so it is my duty to send my modification
to upstream and try my best to let the patch OK. If the patch can not be
merged, I can understand (especially, the patch is too late).

>> On 2019/12/13 下午6:50, Andy Shevchenko wrote:
>>> On Fri, Dec 13, 2019 at 01:17:17PM +0800, chengang@emindsoft.com.cn wrote:
> 
>>>>  				aux |= inb(addr[i] + DATA_PORT) << 8;
>>>>  				if (aux != io_address)
>>>>  					continue;
>>>
>>>> -
>>>
>>> What the point?
> 
> (1)
> 
>>>> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
>>>> +				set_icsr(addr[i], k);
>>>> +#endif
>>>>  				fintek_8250_exit_key(addr[i]);
>>>>  				*key = keys[j];
>>>>  				*index = k;
>>>> @@ -179,53 +212,6 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
>>>>  	return -ENODEV;
>>>>  }
>>>>  
>>
>> In my case at that time, for fintex irq sharing, it needed additional
>> initinalization, or it could not work well. I wrote the related code
>> based on the fintek data-sheet which was downloaded from internet.
> 
> I guess it's an answer to the (1). Though in (1) I simple meant the removal
> of blank line (see, I emphasized the excerpt I'm commenting with blank lines
> before and after).
> 

Oh, sorry, I missunderstood. For me, reserving the original blank line
is OK.

>>>> -static int
>>>> -fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>>>
>>> Why did you move this function?
>>> It's now not only hard to follow what has been changed, and to review.
>>>
>>>> --- a/drivers/tty/serial/8250/8250_pnp.c
>>>> +++ b/drivers/tty/serial/8250/8250_pnp.c
>>>> @@ -438,8 +438,13 @@ static int
>>>>  serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>>>>  {
>>>>  	struct uart_8250_port uart, *port;
>>>> -	int ret, line, flags = dev_id->driver_data;
>>>> +	int ret, line, flags;
>>>>  
>>>
>>
>> I thought locating the main probe function at the end of the source file
>> was better for normal code reading (maybe it need be a seperate patch).
> 
> Yes, it needs to be in a separated (preparatory) patch.
> 
>> But if we don't mind, we can still remain its orignal position.
> 
> I do mind, sorry. The rule of thumb is one logical change per patch.
> 

OK, in the latest linux tree, if necessary, I will send 2 patches.

>>>> +#if IS_BUILTIN(CONFIG_SERIAL_8250_FINTEK)
>>>> +	if (!fintek_8250_probe(dev, dev_id))
>>>> +		return 0;
>>>> +#endif
>>>> +	flags = dev_id->driver_data;
>>>
>>> Oh, I don't like this.
>>> It needs a bit more refactoring done first.
>>>
>>> The idea that we are not going to pollute generic driver(s) with quirks anymore
>>> (only when it's really unavoidable).
>>>
>>
>> At that time, for me, I could not get any new better ways in a short
>> time, and the issue had to be fixed in time, so the code was not good
>> engough.
> 
> It's not an excuse to put hacks in the code that will make maintenance hard.
> The usual case is such situations is that author of the fix do:
> 
> - provide a fix (perhaps ugly one)
> - refactor and clean up the code
> 
> So at the result we have keep maintainable piece in kernel.
> This is by the way my main motivation to NAK this change.
> 
>> At present, Linux version has been changed much, welcome any one to
>> refactor it for current linux version or another related old linux
>> versions if this patch is valuable more or less.
> 
> Then it's no go for this patch, sorry.
> 

Yes, refactoring and cleaning up the code is the patch sender's
resposibility.

And thank you for reviewing the patch.


