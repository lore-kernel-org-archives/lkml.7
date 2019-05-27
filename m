Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA418C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FBF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE0HGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:06:10 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:8350 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0HGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:06:09 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5FD0B4F2A0;
        Mon, 27 May 2019 09:06:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id LeklOLh5Mc4z; Mon, 27 May 2019 09:05:56 +0200 (CEST)
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <20190524094825.16151-1-sr@denx.de>
 <20190524102002.GT2781@lahna.fi.intel.com>
 <CAHp75VcMVrYv1MXmmqE9fDXShS=Y8pPdWZ4f1neo=ne88TLZDg@mail.gmail.com>
 <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
 <20190524134657.GV9224@smile.fi.intel.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <1fcbe336-d372-e705-e041-894f637b8657@denx.de>
Date:   Mon, 27 May 2019 09:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190524134657.GV9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.19 15:46, Andy Shevchenko wrote:
> On Fri, May 24, 2019 at 01:29:34PM +0200, Stefan Roese wrote:
>> On 24.05.19 13:11, Andy Shevchenko wrote:
>>> On Fri, May 24, 2019 at 1:21 PM Mika Westerberg
>>> <mika.westerberg@linux.intel.com> wrote:
>>>>
>>>> On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
>>>>> This patch adds a check for the GPIOs property existence, before the
>>>>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
>>>>> support is added (2nd patch in this patch series) on x86 platforms using
>>>>> ACPI.
>>>>>
>>>>> Here Mika's comments from 2016-08-09:
>>>>>
>>>>> "
>>>>> I noticed that with v4.8-rc1 serial console of some of our Broxton
>>>>> systems does not work properly anymore. I'm able to see output but input
>>>>> does not work.
>>>>>
>>>>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
>>>>> ("tty/serial/8250: use mctrl_gpio helpers").
>>>>>
>>>>> The reason why it fails is that in ACPI we do not have names for GPIOs
>>>>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
>>>>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
>>>>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
>>>>> UART device in Broxton has following (simplified) ACPI description:
>>>>>
>>>>>       Device (URT4)
>>>>>       {
>>>>>           ...
>>>>>           Name (_CRS, ResourceTemplate () {
>>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>>               {
>>>>>                   0x003A
>>>>>               }
>>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>>               {
>>>>>                   0x003D
>>>>>               }
>>>>>           })
>>>>>
>>>>> In this case it finds the first GPIO (0x003A which happens to be RX pin
>>>>> for that UART), turns it into GPIO which then breaks input for the UART
>>>>> device. This also breaks systems with bluetooth connected to UART (those
>>>>> typically have some GPIOs in their _CRS).
>>>>>
>>>>> Any ideas how to fix this?
>>>>>
>>>>> We cannot just drop the _CRS index lookup fallback because that would
>>>>> break many existing machines out there so maybe we can limit this to
>>>>> only DT enabled machines. Or alternatively probe if the property first
>>>>> exists before trying to acquire the GPIOs (using
>>>>> device_property_present()).
>>>>> "
>>>>>
>>>>> This patch implements the fix suggested by Mika in his statement above.
>>>>>
>>>
>>> We have a board where ASL provides _DSD for CTS and RxD pins.
>>> I'm afraid this won't work on it.
>>
>> With "won't work" you mean, that the GPIO can't be used for modem
>> control in this case in the current implementation (with this
>> patchset)? Or do you mean, that the breakage (input does not work
>> on Broxton systems) will not be solved by this patch?
> 
> It will solve RxD case, due to mctrl doesn't count RxD as a "control" line.
> 
> Though we have CTS pin defined for the same purpose, which means the hardware
> flow control won't work on a subset of Broxton boards.
> 
>> If its the former, then I think that solving this issue is something
>> for a new patch, to support modem-control on such platforms as well
>> (if needed).
> 
>> Please note that this patch is not trying to get modem-control working
>> on such ACPI based systems.
> 
> I understand that. At the same time it should not break existing systems.
> 
>> Its targeted for device-tree enabled
>> platforms, using the 8250 serial driver, here specifically a MIPS
>> MT7688 based board. And just wants to fix the latter issue mentioned
>> above so that the 8250 modem-control support can be accepted in
>> mainline.
> 
> As I said already we have to distinguish *the purpose* of these GPIOs.
> (like CTS).
> 
> Can we apply this if and only if the device has no ACPI companion device?
> 
> In this case DT will work as you expect and ACPI won't be broken.

So your suggestion is to add a has_acpi_companion() check before
mctrl_gpio_init() is called in serial8250_register_8250_port() and
then only use the gpio related mctrl, if the GPIO's are really used?

I can certainly change patch 2/2 to do this. It would be great though,
if you (or someone else) could test this on such a ACPI based platform,
as I don't have access to such a board.

Thanks,
Stefan
