Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AC0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733EB2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDZRxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:53:02 -0400
Received: from thoth.sbs.de ([192.35.17.2]:50181 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfDZRxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:53:02 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x3QHqon5024124
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 19:52:50 +0200
Received: from [167.87.22.130] ([167.87.22.130])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3QHqmdw009495;
        Fri, 26 Apr 2019 19:52:49 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360>
 <534a4812-e6d3-9b16-5142-ab214da3d661@siemens.com>
 <20190426174645.GB31161@Mani-XPS-13-9360>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0e9b6e72-d7d8-6dea-4efa-4eb7c1a8e0c9@siemens.com>
Date:   Fri, 26 Apr 2019 19:52:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190426174645.GB31161@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.19 19:46, Manivannan Sadhasivam wrote:
> On Fri, Apr 26, 2019 at 07:39:56PM +0200, Jan Kiszka wrote:
>> On 26.04.19 19:33, Manivannan Sadhasivam wrote:
>>> On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
>>>> On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
>>>>>> On 26.04.19 15:36, Jan Kiszka wrote:
>>>>>>
>>>>>>> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
>>>>>> switch> the engine.
>>>>>> Which value exactly does that collection of crude wrappers and broken
>>>>>> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
>>>>>> provide ?
>>>>>
>>>>> Leaving that blunt hack aside:
>>>>>
>>>>> import mraa
>>>>>
>>>>> pin = mraa.Gpio(13)
>>>>> pin.dir(mraa.DIR_OUT)
>>>>> pin.write(1)
>>>>>
>>>>> And the same goes for nodejs, java and c++.
>>>>>
>>>>> Moreover, this allows you to abstract away where "Pin 13" actually came from on
>>>>> that board if the kernel changes (BSP -> upstream...) or the extension board or
>>>>> ...
>>>>
>>>> The problem here is opaque number. This has to be chip + *relative* pin number/
>>>> See this:
>>>> https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
>>>>
>>>
>>> But for platform like 96Boards we don't need controller specific lookup, these
>>> are all handled by the platform code [1] so that the users can use the standard
>>> pinout number to access GPIOs. For instance, pin 23 on the Low Speed expansion
>>> header is the GPIO for all 96Boards platform, so the user can access that pin
>>> using 23 itself in the application and it will run across all supported
>>> 96Boards.
>>
>> Can you ensure stable numbering when probing order changes, e.g. due to
>> adding an extension board?
>>
> 
> Good point! For tackling this, I'm planning to introduce an API for accessing
> the GPIO by its line name. It will be tricky to implement but once done, it
> will serve.

Whatever is stable and handy. As cited in the other thread, I played with the 
device path as well, see [1][2]. Feel free to pick what what is useful, I will 
likely not have time to work on that soon again.

Jan

[1] https://github.com/siemens/mraa/commit/034d787eea1a5b201ea77a6549ffc0bdbc3b776d
[2] https://github.com/siemens/mraa/commit/6fd8a3c27764718c1e62a4938a6dc88819c3f65f

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
