Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D5218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfC2XYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:24:19 -0400
Received: from foss.arm.com ([217.140.101.70]:38908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbfC2XYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:24:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87A8BA78;
        Fri, 29 Mar 2019 16:24:18 -0700 (PDT)
Received: from [192.168.1.124] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B13B3F59C;
        Fri, 29 Mar 2019 16:24:16 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
To:     Heiko Stuebner <heiko@sntech.de>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
 <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com>
 <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
 <14265087.Gbs4YZABJo@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <69d5d0fd-00c3-36ae-596e-1b9f9452a07a@arm.com>
Date:   Fri, 29 Mar 2019 23:24:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <14265087.Gbs4YZABJo@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-27 12:00 pm, Heiko Stuebner wrote:
> Hi,
> 
> Am Dienstag, 26. März 2019, 14:49:16 CET schrieb Katsuhiro Suzuki:
>> Hello Robin,
>>
>> Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
>> please revert my patch if you need.
> 
> I've dropped the patch from my queue now.
> 
>> BTW, there are DMA properties in RK3328 device-tree like as this patch.
>> RK3328 UART DMA could not work correctly too...??
> 
> I remember Rockcihip dma-controllers having issues with burst-sizes
> and flushing (there is a no-flushp option in pl330), so it's
> possible that all share the same error up to rk3399 and rk3328
> 
> But so far no-one has shouted regarding the rk3328.

Let me be the first, then, I guess :)

I found an easy way to observe the problem on my 3399, and I've just 
fired up my 3328 box with a 5.0 distro kernel to find that it behaves 
the same. Basically just dump a large pile of text into 'less' on the 
serial console, and scroll through line-by-line - certain lines get 
dropped except for a few characters at the end.

I'll see if I can narrow it down a bit, starting with trying 
broken-flushp...

Robin.
