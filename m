Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAA2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfFRIol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:44:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729180AbfFRIok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:44:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 740B877E6ECFBD1401EE;
        Tue, 18 Jun 2019 16:44:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 16:44:30 +0800
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
 <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
 <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com>
 <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com>
 <CAErSpo5cqJCZjt6QqMNZ6_n=G-_WxFeERnsESOMxsdr1P-6JLg@mail.gmail.com>
 <9e8b6971-3189-9d4b-de9a-ff09f859f4f6@huawei.com>
 <CAErSpo4DemDWtnP2Gtram9tfQ0CaN9Na9_Gxk6Qk+nG5+JLuzA@mail.gmail.com>
CC:     <xuwei5@huawei.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <539835d3-770c-285c-0c49-ae15ceaa3079@huawei.com>
Date:   Tue, 18 Jun 2019 09:44:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAErSpo4DemDWtnP2Gtram9tfQ0CaN9Na9_Gxk6Qk+nG5+JLuzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>

- zhichang personal mail

>> It's now on my todo list.
>>
>> I'll need advice on how to test this for hot-pluggable host bridges.
>>
>>>
>>> Could you just move the logic_pio_register_range() call farther down
>>> in hisi_lpc_probe()?  IIUC, once logic_pio_register_range() returns,
>>> an inb() with the right port number will try to access that port, so
>>> we should be prepared for that, i.e., maybe this in the wrong order to
>>> begin with?
>>
>> No, unfortunately we can't. The reason is that we need the logical PIO
>> base for that range before we enumerate the children of that host. We
>> need that base address for "translating" the child bus addresses to
>> logical PIO addresses.
>

Hi Bjorn,

> Ah, yeah, that makes sense.  I think.  We do assume that we know all
> the MMIO and I/O port translations before enumerating devices.  It's
> *conceivable* that could be changed someday since we don't actually
> need the translations until a driver claims the device,

We actually need them before a driver claims the device.

The reason is that when we create that child platform device we set the 
device's IORESOURCE_IO resources according to the translated logic PIO 
addresses, and not the host bus address. This is what makes the host 
transparent to the child device driver.

and it would
> gain some flexibility if we didn't have to program the host bridge
> windows until we know how much space is required.  But I don't see
> that happening anytime soon.
>
> Bjorn
>
> .
>

BTW, as you may have noticed, in v3 I said I would drop this patch and 
fix it all properly.

My problem is that I need to ensure that the new logical PIO unregister 
function works ok for hot-pluggable host bridges. I need to get some way 
to test this. Advice?

Thanks,
John




