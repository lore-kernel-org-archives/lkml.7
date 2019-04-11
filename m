Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD84C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E32173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:17:45 -0400
Received: from foss.arm.com ([217.140.101.70]:48126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDKTRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:17:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15EEF374;
        Thu, 11 Apr 2019 12:17:44 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A2D43F59C;
        Thu, 11 Apr 2019 12:17:42 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
From:   Robin Murphy <robin.murphy@arm.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
 <14265087.Gbs4YZABJo@phil> <69d5d0fd-00c3-36ae-596e-1b9f9452a07a@arm.com>
 <2463729.IUJ8mRE5Ts@phil> <8d164cfe-c345-aa45-aaf3-11983f9142e5@arm.com>
Message-ID: <2e5a1468-9a65-9cc5-f96c-272faeb92ec9@arm.com>
Date:   Thu, 11 Apr 2019 20:17:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d164cfe-c345-aa45-aaf3-11983f9142e5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-11 2:48 pm, Robin Murphy wrote:
> On 11/04/2019 13:46, Heiko Stuebner wrote:
>> Hi Robin,
>>
>> Am Samstag, 30. März 2019, 00:24:16 CEST schrieb Robin Murphy:
>>> On 2019-03-27 12:00 pm, Heiko Stuebner wrote:
>>>> Hi,
>>>>
>>>> Am Dienstag, 26. März 2019, 14:49:16 CET schrieb Katsuhiro Suzuki:
>>>>> Hello Robin,
>>>>>
>>>>> Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
>>>>> please revert my patch if you need.
>>>>
>>>> I've dropped the patch from my queue now.
>>>>
>>>>> BTW, there are DMA properties in RK3328 device-tree like as this 
>>>>> patch.
>>>>> RK3328 UART DMA could not work correctly too...??
>>>>
>>>> I remember Rockcihip dma-controllers having issues with burst-sizes
>>>> and flushing (there is a no-flushp option in pl330), so it's
>>>> possible that all share the same error up to rk3399 and rk3328
>>>>
>>>> But so far no-one has shouted regarding the rk3328.
>>>
>>> Let me be the first, then, I guess :)
>>>
>>> I found an easy way to observe the problem on my 3399, and I've just
>>> fired up my 3328 box with a 5.0 distro kernel to find that it behaves
>>> the same. Basically just dump a large pile of text into 'less' on the
>>> serial console, and scroll through line-by-line - certain lines get
>>> dropped except for a few characters at the end.
>>>
>>> I'll see if I can narrow it down a bit, starting with trying
>>> broken-flushp...
>>
>> did you manage to find time for that test you wanted to do?
> 
> Sadly not - I got somewhat distracted by the ethernet thing, and since 
> then I've had too much else going on to follow up on any of my 'for fun' 
> projects :(

Urgh, and it turns out what I thought were dropped characters seems to 
just be my console handling line wrapping weirdly, so now I have no idea 
if RK3328 actually has an issue, and coming up with a reliable 
reproducer for RK3399 is going to take some thought...

Robin.
