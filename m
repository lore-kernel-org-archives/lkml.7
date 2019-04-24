Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9AA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfDXIZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:25:52 -0400
Received: from thoth.sbs.de ([192.35.17.2]:51342 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfDXIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:25:52 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x3O8PghL032179
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 10:25:42 +0200
Received: from [167.87.52.237] ([167.87.52.237])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3O8PfvW007319;
        Wed, 24 Apr 2019 10:25:41 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
 <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
Date:   Wed, 24 Apr 2019 10:25:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190424081802.GV2654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 10:18, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 10:12:42AM +0200, Jan Kiszka wrote:
>> On 24.04.19 09:58, Mika Westerberg wrote:
>>> +Rafael and linux-acpi.
>>>
>>> On Thu, Apr 18, 2019 at 11:23:49AM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Validated on the Quark platform, this adds interrupt support on rising
>>>> and/or falling edges.
>>>
>>> The irqchip parts look good to me but but the ACPI SCI handling seems
>>> weird. This is typically handled by ACPI core based on the values read
>>> from FADT ACPI table. What does it contain on this Quark platform?
>>
>> There is no FADT on the original Quark firmware, nor did we add one. As we
>> are talking about existing devices, possibly not only Quarks, I was going
>> down the ACPI-independent way to hook into the interrupt. But I'm open to
>> learn about better alternatives.
> 
> Hmm, if it does not have FADT table why would you need SCI then? Is this
> implementing some real use case?
> 

Maybe I'm looking at the wrong place: Where would I find it? There is definitely 
no separate entry under /sys/firmware/acpi/tables - but that's also true for my 
workstation.

In any case: The hardware defines that the GPIO events are sent via SCIs. That 
fact is probably not expressed in ACPI language.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
