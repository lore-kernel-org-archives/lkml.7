Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D53C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61641214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfLLOUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:20:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729392AbfLLOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:20:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ECD4EA4312FAC6B1B3DC;
        Thu, 12 Dec 2019 22:20:12 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 22:20:11 +0800
Message-ID: <5DF24C9B.7030402@huawei.com>
Date:   Thu, 12 Dec 2019 22:20:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <linux@roeck-us.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to 'extcon_get_state'
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com> <20191212090132.GC31345@kuha.fi.intel.com> <5DF20530.2040509@huawei.com> <20191212092805.GA1375559@kroah.com> <5DF20B18.4020601@huawei.com> <20191212111805.GD31345@kuha.fi.intel.com> <20191212122053.GA1541203@kroah.com> <20191212124937.GE31345@kuha.fi.intel.com>
In-Reply-To: <20191212124937.GE31345@kuha.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/12 20:49, Heikki Krogerus wrote:
> On Thu, Dec 12, 2019 at 01:20:53PM +0100, Greg KH wrote:
>> On Thu, Dec 12, 2019 at 01:18:05PM +0200, Heikki Krogerus wrote:
>>> On Thu, Dec 12, 2019 at 05:40:40PM +0800, zhong jiang wrote:
>>>> On 2019/12/12 17:28, Greg KH wrote:
>>>>> On Thu, Dec 12, 2019 at 05:15:28PM +0800, zhong jiang wrote:
>>>>>> On 2019/12/12 17:01, Heikki Krogerus wrote:
>>>>>>> On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
>>>>>>>> Fixes the following compile error:
>>>>>>>>
>>>>>>>> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
>>>>>>>> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
>>>>>>>> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
>>>>>>>> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
>>>>>>>> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
>>>>>>>> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
>>>>>>>> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
>>>>>>>> make: *** [vmlinux] Error 1
>>>>>>> There are stubs for those functions so that really should not be
>>>>>>> happening. I can not reproduce that.
>>>>>> It can be reproduced in next branch. you can try it in the latest next branch.
>>>>> Can it be reproduced in 5.5-rc1?
>>>>>
>>>> commit 78adcacd4edbd6795e164bbda9a4b2b7e51666a7
>>>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
>>>> Date:   Thu Dec 12 15:48:07 2019 +1100
>>>>
>>>>     Add linux-next specific files for 20191212
>>>>
>>>> I  reproduce it  based on this commit.  The related config is attached.
>>> OK, now I get what's going on. EXTCON is build as a module, but
>>> FUSB302 is not. This should be explained in the commit message.
>>>
>>> That does not mean we have to force everybody to enable EXTCON in
>>> order to use this driver. Try something like this:
>>>
>>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
>>> index 72481bbb2af3..06e026f6325c 100644
>>> --- a/drivers/usb/typec/tcpm/Kconfig
>>> +++ b/drivers/usb/typec/tcpm/Kconfig
>>> @@ -31,6 +31,7 @@ endif # TYPEC_TCPCI
>>>
>>>  config TYPEC_FUSB302
>>>         tristate "Fairchild FUSB302 Type-C chip driver"
>>> +       depends on EXTCON=n || EXTCON=y || (EXTCON=m && m)
>> Ugh.  We need a better "pattern" for stuff like this, it's getting more
>> and more frequent.
>>
>> And no, I don't have a better idea :(
> I think this works:
>
>         depends on EXTCON || !EXTCON
It seems to be better and works when I test the above patch.

Thanks,
zhong jiang
> thanks,
>


