Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84780C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5477B215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575287620;
	bh=X7/G7ECl+47WffpLyzXfw7hwitgqh9/qBbZpzYgVjIU=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=uPyZJ2Y8UzMkT+0kiKYw8/68dMhRhRR8innzZWwVO19MOiHSz7vi1cFxH2by5ETvM
	 kgsrcEyF7D7weIIIXmyxIC7Q+2scknm353bzacYVrwdo/q2rQeHnTVUhbgbO/CySMm
	 7PRSoxLG8L1QqPpnIPUDcfuVAmcvcRz20z2LLcMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLBLxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:53:39 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:42324 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfLBLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:53:39 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ibkGm-00088T-Js; Mon, 02 Dec 2019 12:53:36 +0100
To:     Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 02 Dec 2019 11:53:35 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <aaa0f679-9fde-f877-e125-7e609c555e38@huawei.com>
References: <20191130073849.38378-1-guoheyi@huawei.com>
 <20191201180434.1dba3116@why>
 <aaa0f679-9fde-f877-e125-7e609c555e38@huawei.com>
Message-ID: <31461466470212e05a279f9750a90463@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-02 11:07, Guoheyi wrote:
> 在 2019/12/2 2:04, Marc Zyngier 写道:
>> On Sat, 30 Nov 2019 15:38:49 +0800
>> Heyi Guo <guoheyi@huawei.com> wrote:
>>
>>> There is no special reason to set virtual LPI pending table as
>>> non-shareable. If we choose to hard code the shareability without
>>> probing, inner-shareable will be a better choice, for all the other
>>> ITS/GICR tables prefer to be inner-shareable.
>> One of the issues is that we have strictly no idea what the caches 
>> are
>> Inner Shareable with (I've been asking for such clarification for 
>> years
>> without getting anywhere). You can have as many disconnected inner
>> shareable domains as you want!
>
> Hisilicon HIP07 and HIP08 are compliant with ARM SBSA and have only
> one inner shareable domain in the whole system.

I'm glad these systems are well designed, but that's not what SBSA 
mandates.

All it requires is that the all PEs are part of the same IS domain, and
that PCIe is part of the same IS domain as the PEs. Nothing more, and
certainly nothing about the GIC. Or anything else.

> What will happen if a system has multiple inner shareable domains?
> Will Linux still work on such system? Can we declare that Linux only
> supports one single inner shareable domain?

Linux works just fine as long as all the PEs are in the same IS domain.
There is no architectural requirement for anything else to be in that
domain.

>> I suspect that in the grand scheme of things, the redistributors
>> ought to be in the same inner shareable domain, and that with a bit 
>> of
>> luck, the CPUs are there as well. Still, that's a massive guess.
>>
>>> What's more, on Hisilicon hip08 it will trigger some kind of bus
>>> warning when mixing use of different shareabilities.
>> Do you have more information about what the bus is complaining 
>> about?
>> Is that because the CPUs have these pages mapped as inner shareable?
>
> Actually HIP08 L3 Cache will complain on any non-shareable cache
> entry, for the data coherence cannot be guarenteed for such
> configuration. This also implies VPENDING table will be allocated and
> snooped in L3 cache.

It really looks odd that L3 would even contain non-shareable entries.

Anyway, I don't think that's a biggy. Given that GICv4 is almost
exclusively implemented on these two SoCs (unless someone revives
QC system), I think we can take this change after some testing.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
