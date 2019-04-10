Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9F2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDJI3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:29:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:52479 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfDJI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:29:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 01:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="160344024"
Received: from mylly.fi.intel.com (HELO [10.237.72.159]) ([10.237.72.159])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2019 01:29:31 -0700
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
 <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
 <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
 <2a8b7e65d1334a5491b8bc9e9a96a685@asem.it>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <400467d8-19d6-1796-5fa9-cb5b37d61792@linux.intel.com>
Date:   Wed, 10 Apr 2019 11:29:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2a8b7e65d1334a5491b8bc9e9a96a685@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:13 AM, Flavio Suligoi wrote:
>> [    9.506895] pxa2xx-spi pxa2xx-spi.13: no DMA channels available,
>> using PIO
>> [    9.516770] pxa2xx-spi pxa2xx-spi.13: registered master spi2
>> [    9.518527] pxa2xx-spi pxa2xx-spi.13: PXA2xx SPI master controller
>> (PIO mode)
> 
> I have added this message because, using an x86 machine, the message:
> 
> "pxa2xx-spi pxa2xx-spi.13: registered master spi2"
> 
> doesn't appear in the kernel messages!
> 
Yeah, it needs CONFIG_SPI_DEBUG.

>> Actually this info message doesn't necessarily tell will the driver end
>> up using DMA for transfers. See pxa2xx_spi_can_dma() and
>> pxa2xx_spi_transfer_one().
>>
>> How about replacing "no DMA channels available, using PIO" and have
>> instead single info message telling is the DMA available or does the
>> driver use PIO only?
> 
> Ok, it's a good idea, to avoid to many similar messages.
> So I can simply remove the:
> 
> "no DMA channels available, using PIO"
> 
> and leave only the new:
> 
> " pxa2xx-spi pxa2xx-spi.13: PXA2xx SPI master controller (PIO mode)"
> 
Yes, something like that.

Now I remember, please also take into account driver is dual role since 
commit ec93cb6f827b ("spi: pxa2xx: Add slave mode support").

-- 
Jarkko
