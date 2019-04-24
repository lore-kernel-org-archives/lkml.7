Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E872B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfDXJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:48:20 -0400
Received: from gecko.sbs.de ([194.138.37.40]:49025 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfDXJsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:48:19 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x3O9mBR1022138
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 11:48:11 +0200
Received: from [139.22.114.195] ([139.22.114.195])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3O9mAhw022291;
        Wed, 24 Apr 2019 11:48:10 +0200
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
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
Date:   Wed, 24 Apr 2019 11:48:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190424094506.GA2654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 11:45, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 11:36:58AM +0200, Jan Kiszka wrote:
>> OK, there is that table, but what is it supposed to tell me about the
>> event and where to hook into it better?
> ...
>> [02Eh 0046   2]                SCI Interrupt : 0009
> 
> This is the SCI interrupt GSI number. IIRC it maps 1:1 to Linux
> interrupt number so you should see it in /proc/interrupts. When a GPE
> event is triggered it should be handled in the ACPI core.
> 

Yes, clear, all this happens already. But I need to link the core with the sch 
gpio handler so that the gpio event is filtered out and the right virtual gpio 
interrupt is triggered. So, other than acpi_install_sci_handler, how should I 
establish that link?

Jan


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
