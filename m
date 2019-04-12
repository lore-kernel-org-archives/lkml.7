Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD70206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDLN0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:26:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLN0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:26:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2DC81A45623B1C5A690B;
        Fri, 12 Apr 2019 21:26:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 21:26:42 +0800
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
 <20190405142112.26592-1-yuehaibing@huawei.com>
 <20190405145009.GD9224@smile.fi.intel.com> <2719325.nu6fPkO1U5@kreacher>
 <CAHp75VccF9-ax8nJ9qOfAFMvLR19K6NqwyePEf-86r4ifMnJKA@mail.gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <241a0251-3d2d-b304-c103-a6d240e89ce6@huawei.com>
Date:   Fri, 12 Apr 2019 21:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VccF9-ax8nJ9qOfAFMvLR19K6NqwyePEf-86r4ifMnJKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/12 21:13, Andy Shevchenko wrote:
> On Fri, Apr 12, 2019 at 3:55 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, April 5, 2019 4:50:09 PM CEST Andy Shevchenko wrote:
>>> On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
>>>> From: YueHaibing <yuehaibing@huawei.com>
>>>>
>>>> When building CONFIG_ACPI is not set
>>>> gcc warn this:
>>>>
>>>> drivers/gpio/gpio-merrifield.c: In function
>>>> mrfld_gpio_get_pinctrl_dev_name: drivers/gpio/gpio-merrifield.c:388:19:
>>>> error: dereferencing pointer to incomplete type struct acpi_device>
>>>>    put_device(&adev->dev);
>>>>
>>>>                    ^
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use
>>>> acpi_dev_get_first_match_dev()") Signed-off-by: YueHaibing
>>>> <yuehaibing@huawei.com>
>>>
>>> Thank you for an update, I have a comment below, but before sending v3, let
>>> Rafael to have a chance to look at it.
>>>
>>>>  #ifdef CONFIG_ACPI
>>>>  extern int acpi_platform_notify(struct device *dev, enum kobject_action
>>>>  action);>
>>>> +
>>>> +static inline void put_acpi_device(struct acpi_device *adev)
>>>> +{
>>>> +   put_device(&adev->dev);
>>>> +}
>>>
>>> This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
>>> And talking to Mika we agreed that naming would be better as acpi_dev_put().
>>
>> Agreed on both accounts.
> 
> Thanks!
> YueHaibing, please, send v3 with suggested changes.

Ok.

> 

