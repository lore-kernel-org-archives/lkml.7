Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214D72133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfFNJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:29:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35582 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfFNJ3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:29:39 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8DF5FA1091;
        Fri, 14 Jun 2019 11:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id yKkjF9F1R2O0; Fri, 14 Jun 2019 11:29:31 +0200 (CEST)
Subject: Re: [PATCH 1/3 v6] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Yegor Yefremov <yegorslists@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <20190613154542.32438-1-sr@denx.de>
 <20190613170802.GE9224@smile.fi.intel.com>
 <CAGm1_ksNqh0ZVO+aHsdcS6XQHt3hfqWE3a=3waKWEp8Oc8HWcQ@mail.gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <0bf6629c-cedf-e1dd-b42b-989c6711d390@denx.de>
Date:   Fri, 14 Jun 2019 11:29:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAGm1_ksNqh0ZVO+aHsdcS6XQHt3hfqWE3a=3waKWEp8Oc8HWcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.19 11:04, Yegor Yefremov wrote:
> On Thu, Jun 13, 2019 at 7:08 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Thu, Jun 13, 2019 at 05:45:40PM +0200, Stefan Roese wrote:
>>> This patch adds a check for the GPIOs property existence, before the
>>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
>>> support is added (2nd patch in this patch series) on x86 platforms using
>>> ACPI.
>>>
>>> Here Mika's comments from 2016-08-09:
>>>
>>> "
>>> I noticed that with v4.8-rc1 serial console of some of our Broxton
>>> systems does not work properly anymore. I'm able to see output but input
>>> does not work.
>>>
>>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
>>> ("tty/serial/8250: use mctrl_gpio helpers").
>>>
>>> The reason why it fails is that in ACPI we do not have names for GPIOs
>>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
>>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
>>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
>>> UART device in Broxton has following (simplified) ACPI description:
>>>
>>>      Device (URT4)
>>>      {
>>>          ...
>>>          Name (_CRS, ResourceTemplate () {
>>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>              {
>>>                  0x003A
>>>              }
>>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>              {
>>>                  0x003D
>>>              }
>>>          })
>>>
>>> In this case it finds the first GPIO (0x003A which happens to be RX pin
>>> for that UART), turns it into GPIO which then breaks input for the UART
>>> device. This also breaks systems with bluetooth connected to UART (those
>>> typically have some GPIOs in their _CRS).
>>>
>>> Any ideas how to fix this?
>>>
>>> We cannot just drop the _CRS index lookup fallback because that would
>>> break many existing machines out there so maybe we can limit this to
>>> only DT enabled machines. Or alternatively probe if the property first
>>> exists before trying to acquire the GPIOs (using
>>> device_property_present()).
>>> "
>>>
>>> This patch implements the fix suggested by Mika in his statement above.
>>>
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I cannot compile the driver without adding #include <linux/property.h>
> to drivers/tty/serial/serial_mctrl_gpio.c.
> 
> My platform is AM335X (OMAP3). I've tried the patches both against the
> main repo and also tty-next.
>
> Other than that everything is working.

Thanks for reporting. I'll wait a bit for other review comments and
tests (thanks Andy) and will then send v7 with this header included
(and compile tested on OMAP3) later next week.

BTW: Could you please add a Tested-by-tag with the next version?

Thanks,
Stefan
