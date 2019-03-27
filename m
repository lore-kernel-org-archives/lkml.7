Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FB920700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfC0JjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:39:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:28243 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfC0JjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:39:16 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Mar 2019 18:39:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id C6B086117D;
        Wed, 27 Mar 2019 18:39:14 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 27 Mar 2019 18:39:14 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 947A54036C;
        Wed, 27 Mar 2019 18:39:14 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8122E120487;
        Wed, 27 Mar 2019 18:39:14 +0900 (JST)
Subject: Re: [PATCH] serial: Add Milbeaut serial control
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <1553591536-3760-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0Sx5vxbserW27KMPYnpLabPkGJZ_2iuW9y082oHiO+aQ@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <875480bf-42d1-1c88-1dc7-4895e15cb87f@socionext.com>
Date:   Wed, 27 Mar 2019 18:39:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Sx5vxbserW27KMPYnpLabPkGJZ_2iuW9y082oHiO+aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thank you for your comments.

On 2019/03/26 18:57, Arnd Bergmann wrote:
> On Tue, Mar 26, 2019 at 10:13 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 72966bc..961519b 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1582,6 +1582,32 @@ config SERIAL_RDA_CONSOLE
>>            Say 'Y' here if you wish to use the RDA8810PL UART as the system
>>            console. Only earlycon is implemented currently.
>>
>> +config SERIAL_MILBEAUT_USIO
>> +       tristate "Milbeaut USIO/UART serial port support"
>> +       depends on ARCH_MILBEAUT
>> +       default y
>> +       select SERIAL_CORE
>> +       help
>> +         This selects the USIO/UART IP found in Socionext Milbeaut SoCs.
> 
> In general, it would be good to make it possible to build this on
> other architectures for better compile test coverage, e.g. like
> 
> config SERIAL_MILBEAUT_USIO
>       tristate "Milbeaut USIO/UART serial port support"
>       depends on ARCH_MILBEAUT || COMPILE_TEST
>       default ARCH_MILBEAUT
> 
All right.
I agree with the style.

> You might need additional dependencies like 'depends on OF'
> to make this work reliably.
> 
I got it.
I think the way is inserting "depends on OF" as a new line.

Thanks,
Sugaya Taichi


>          Arnd
> 

