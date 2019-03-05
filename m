Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79118C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51024206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfCEA57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:57:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfCEA57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:57:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4620FA4B828D87ACBE96;
        Tue,  5 Mar 2019 08:57:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Mar 2019
 08:57:53 +0800
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
To:     Andrew Lunn <andrew@lunn.ch>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190304132617.GB26378@lunn.ch>
 <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
 <20190304145710.GA17097@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <df65d515-7a04-22d6-d99d-55f119a9116d@hisilicon.com>
Date:   Tue, 5 Mar 2019 08:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190304145710.GA17097@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2019/3/4 22:57, Andrew Lunn wrote:
> On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
>> Hi Andrew,
>>
>> On 2019/3/4 21:26, Andrew Lunn wrote:
>>> On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
>>>> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
>>>> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
>>>> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
>>>> Let's fix it.
>>>
>>> Hi Shaokun, Heiner
>>>
>>> Although this fixes the warning, i suspect there i something wrong
>>> with the original patch adding mv88e6390x_port_set_cmode(). It should
>>> also be used without CONFIG_NET_DSA_LEGACY.
>>
>> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
>> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)
> 
> No, i suspect mv88e6390x_ports_cmode_init() is being called from the
> wrong place, or needs to be called from a second location.
> 

Ok, I didn't check it carefully.

> [Goes and looks at the code]
> 
> Yes, it should also be called in mv88e6xxx_probe(). I would call it
> just after the call to mv88e6xxx_detect(), so that it is the same as
> in mv88e6xxx_drv_probe().
> 
> There are two ways DSA drivers can be probed. The legacy way, which is
> optional, and is slowly getting removed, and the current way. Heiner
> is new to DSA and probably missed that, and only handled the legacy
> probe method. I also missed checking when i reviewed to patch :-(
> 

Hmm, I am not familiar wit it, please feel free to fix it.

Thanks,
Shaokun

>    Andrew
> 
> 
> 
> 
> .
> 

