Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA22087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfC0MKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:10:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfC0MKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6247E374;
        Wed, 27 Mar 2019 05:10:08 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F8B3F557;
        Wed, 27 Mar 2019 05:10:07 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
 <8309531.dRdlsDmmhi@phil> <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com>
 <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <07287fad-c3e6-bcf2-a247-fe4f5031900e@arm.com>
Date:   Wed, 27 Mar 2019 12:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 13:49, Katsuhiro Suzuki wrote:
> Hello Robin,
> 
> Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
> please revert my patch if you need.

I found a little time to fire up the board again this morning, so I gave 
this another try to double-check - in fact this time I only saw it fail 
3 times in 15 reboots. So something's certainly not quite right, but 
it's not quite as terrible as the first try implied.

My suspicion at this point is that the DMA implementation might be 
losing characters occasionally, and obviously the bluetooth firmware 
transfer is going to be a lot more sensitive to that than a text console is.

> BTW, there are DMA properties in RK3328 device-tree like as this patch.
> RK3328 UART DMA could not work correctly too...??

Quite possibly, although my 3328 box doesn't have any UARTS connected or 
exposed other than the standard debug console, so I can't easily 
investigate there. I do have a 3288 box with similar serial bluetooth to 
my 3399 which might be worth digging out for comparison with an 
up-to-date kernel.

Robin.

> 
> Best Regards,
> Katsuhiro Suzuki
> 
> 
> On 2019/03/26 20:48, Robin Murphy wrote:
>> On 25/03/2019 12:34, Heiko Stuebner wrote:
>>> Am Donnerstag, 21. März 2019, 17:22:44 CET schrieb Katsuhiro Suzuki:
>>>> Add UART dma channels as specified by the rk3399 TRM.
>>>>
>>>> Refer:
>>>> RK3399 TRM V1.4: Chapter 12 DMA Controller
>>>>
>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>
>>> applied for 5.2
>>
>> As a heads-up, I did manage to try my board with this patch applied 
>> over the weekend, and it makes probing the bluetooth adapter fail with 
>> communication errors, so I'm not sure the 8250 and pl330 drivers are 
>> really cooperating well enough :(
>>
>> Robin.
>>
> 
