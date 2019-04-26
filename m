Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488DA2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDZQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:04:06 -0400
Received: from goliath.siemens.de ([192.35.17.28]:45382 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfDZQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:04:06 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x3QG3p2i011123
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 18:03:51 +0200
Received: from [167.87.22.130] ([167.87.22.130])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3QG3lJi026127;
        Fri, 26 Apr 2019 18:03:47 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
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
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
Date:   Fri, 26 Apr 2019 18:03:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <bc856e19-470d-7655-5680-a031831ab513@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> On 26.04.19 15:36, Jan Kiszka wrote:
> 
>> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> switch> the engine.
> Which value exactly does that collection of crude wrappers and broken
> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> provide ?

Leaving that blunt hack aside:

import mraa

pin = mraa.Gpio(13)
pin.dir(mraa.DIR_OUT)
pin.write(1)

And the same goes for nodejs, java and c++.

Moreover, this allows you to abstract away where "Pin 13" actually came from on 
that board if the kernel changes (BSP -> upstream...) or the extension board or 
... We will exploit that when moving to a completely different base hardware 
with the next revision or our IOT2000.

> 
> mraa belongs to the category of software, I would never put onto any
> production system. (yes, I already had a client who asked me to repair
> his mraa-based software. finally, I've replaced mraa w/ a few LoC ...)

You also have to keep the class of "cool, I've just created my first Node.RED 
node!" IoT newbies in mind. These higher abstraction help to keep them away from 
the wrong lower APIs - or enable them to do something at all ("Cool, I've just 
connected my first two nodes!"). By far not all of them have consultants at hand.

And while we only ship our IOT2000 image with mraa and all the fun as reference 
image, it's way more for quite a few users. Even if you do not want to look 
behind the curtains of certain software components (that we primarily inherited 
and then started to clean up), they are working, or we would have heard.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
