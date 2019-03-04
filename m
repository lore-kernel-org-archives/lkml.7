Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D37C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfCDFSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:18:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:32649 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfCDFSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:18:15 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Mar 2019 14:18:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 2D363180BB6;
        Mon,  4 Mar 2019 14:18:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Mar 2019 14:18:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B518E1A15B7;
        Mon,  4 Mar 2019 14:18:12 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8FBBC1217B3;
        Mon,  4 Mar 2019 14:18:12 +0900 (JST)
Subject: Re: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V
 SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <e1da21a8-f369-a620-c149-521f10b7535e@socionext.com>
Date:   Mon, 4 Mar 2019 14:18:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/03/01 23:34, Arnd Bergmann wrote:
> On Wed, Feb 27, 2019 at 5:51 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>>
>> Here is the series of patches the initial support for SC2000(M10V) of
>> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
>> source code.
>>
>> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
>> computer vision. It also features advanced functionalities such as 360-degree,
>> real-time spherical stitching with multi cameras, image stabilization for
>> without mechanical gimbals, and rolling shutter correction. More detail is
>> below:
>> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>>
>> Specifications for developers are below:
>>   - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>>   - NEON support
>>   - DSP
>>   - GPU
>>   - MAX 3GB DDR3
>>   - Cortex-M0 for power control
>>   - NAND Flash Interface
>>   - SD UHS-I
>>   - SD UHS-II
>>   - SDIO
>>   - USB2.0 HOST / Device
>>   - USB3.0 HOST / Device
>>   - PCI express Gen2
>>   - Ethernet Engine
>>   - I2C
>>   - UART
>>   - SPI
>>   - PWM
>>
>> Support is quite minimal for now, since it only includes timer, clock,
>> pictrl and serial controller drivers, so we can only boot to userspace
>> through initramfs. Support for the other peripherals  will come eventually.
> 
> I've merged these all into the arm/newsoc branch now, with the
> exception of the patch that Greg has already taken.
> 
> I'll do a little more build testing before that branch will be sent,
> but I expect it will be fine.
> 
>       Arnd
> 

Thanks a lot!

