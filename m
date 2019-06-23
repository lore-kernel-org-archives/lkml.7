Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C69C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDEE20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFWNb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:31:58 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:55019 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfFWNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:31:58 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5NDVU9l019165;
        Sun, 23 Jun 2019 22:31:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sun, 23 Jun 2019 22:31:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5NDVTux019135
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 23 Jun 2019 22:31:29 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ARM: dts: rockchip: add ethernet phy node for tinker
 board
To:     Andrew Lunn <andrew@lunn.ch>, Jose Abreu <joabreu@synopsys.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20190621180017.29646-1-katsuhiro@katsuster.net>
 <1871177.hjLhdHVgcu@phil>
 <ccf5ad2c-bd56-2d77-4728-d7906045e302@katsuster.net>
 <20190622175508.GE8497@lunn.ch>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <8a006d47-a546-163f-0c3f-f35b0056ba3a@katsuster.net>
Date:   Sun, 23 Jun 2019 22:31:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190622175508.GE8497@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko, Andrew,

Thank you for comments. I found the commit that has regression:
   74371272f97f net: stmmac: Convert to phylink and remove phylib logic

So I'll report it to netdev and stmmac guys.

Best Regards,
---
Katsuhiro Suzuki


On 2019/06/23 2:55, Andrew Lunn wrote:
> On Sat, Jun 22, 2019 at 11:50:10PM +0900, Katsuhiro Suzuki wrote:
>> Hello,
> 
> Hi Katsuhiro
> 
> Please also report this to netdev, and the stmmac maintainers.
> 
> ./scripts/get_maintainer.pl -f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> Giuseppe Cavallaro <peppe.cavallaro@st.com> (supporter:STMMAC ETHERNET DRIVER)
> Alexandre Torgue <alexandre.torgue@st.com> (supporter:STMMAC ETHERNET DRIVER)
> Jose Abreu <joabreu@synopsys.com> (supporter:STMMAC ETHERNET DRIVER)
> "David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS)
> Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 ARCHITECTURE)
> netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER)
> linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
> linux-kernel@vger.kernel.org (open list)
> 
>> I have not bisect commit of root cause yet... Is it better to bisect
>> and find problem instead of sending this patch?
> 
> My guess is that it is one of these three which broken it:
> 
> 74371272f97f net: stmmac: Convert to phylink and remove phylib logic
> eeef2f6b9f6e net: stmmac: Start adding phylink support
> 9ad372fc5aaf net: stmmac: Prepare to convert to phylink
> 
> 	     Andrew
> 

