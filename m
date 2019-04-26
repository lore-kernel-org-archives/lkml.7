Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32586C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9B3208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDZPoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:44:24 -0400
Received: from gecko.sbs.de ([194.138.37.40]:39988 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfDZPoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:44:24 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x3QFiCJG019432
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 17:44:12 +0200
Received: from [167.87.22.130] ([167.87.22.130])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3QFiBTm030321;
        Fri, 26 Apr 2019 17:44:11 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <CACRpkdY=m1QJVqvERiAY+7taUgjPXn=9U2Eajx7d7NPo-iNhiA@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <63b179c9-242d-ae90-9c33-49ed256bde28@siemens.com>
Date:   Fri, 26 Apr 2019 17:44:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CACRpkdY=m1QJVqvERiAY+7taUgjPXn=9U2Eajx7d7NPo-iNhiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.19 16:41, Linus Walleij wrote:
> On Fri, Apr 26, 2019 at 3:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Wed, Apr 24, 2019 at 12:39:35PM +0200, Jan Kiszka wrote:
>>> On 24.04.19 12:33, Mika Westerberg wrote:
>>>> On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
>>
>>>>> And even if that were possible, we would be back to the square of existing
>>>>> devices without those definitions. If this were a recent chipset, I would
>>>>> say, "go, fix future firmware versions". But this one is legacy.
>>>>
>>>> Is it fixing some real issue with these legacy platforms? I mean without
>>>> the patch some GPE event is not handled properly? It was not clear to me
>>>> from the commit message.
>>>>
>>>
>>> Without that patch, you are forced to poll for event changes in your
>>> application, timer-driven. There are application that cannot process these
>>> GPIOs because they lack such logic (mraa with node-red-node-intel-gpio is a
>>> public example).
>>
>> Just a side note: MRAA is a hack itself. It abuses almost all interfaces Linux
>> kernel provides.
> 
> I think it's pretty clean for GPIOs these days. My colleague Manivannan
> was part of cleaning it up a while back and since then it is doing
> what userspace should be doing if userspace absolutely cannot
> abstain from using GPIOs directly (i.e. uses the character device).
> https://github.com/intel-iot-devkit/mraa/blob/master/src/gpio/gpio_chardev.c
> 
> I don't know about other resources than GPIOs though.

That's valuable progress!

OTOH, there still seem to be the broken pattern to address pins via hard-coded 
GPIO numbers. This broke our neck, e.g., when trying to replace the hacky BSP 
kernel with upstream. I started to create better infrastructure but never fished 
that.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
