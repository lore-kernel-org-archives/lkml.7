Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C17C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEBE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfDWBPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:15:22 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:34816 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfDWBPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:15:21 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.78])
        by regular1.263xmail.com (Postfix) with ESMTP id 16F8325D;
        Tue, 23 Apr 2019 09:15:12 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29765T139902436968192S1555982110311816_;
        Tue, 23 Apr 2019 09:15:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1d0c61725f2fedc3f3fadbfa0afc204d>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2] clk: rockchip: undo several noc and special clocks as
 critical on rk3288
To:     Doug Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190412161747.107107-1-dianders@chromium.org>
 <CAD=FV=Xkdc_yPCjVUh96atdiB4fo4h3oNZYe45ef+eLeVUVM8g@mail.gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <a8bd1681-0d24-e8d5-9f81-77e8fcb61c63@rock-chips.com>
Date:   Tue, 23 Apr 2019 09:15:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xkdc_yPCjVUh96atdiB4fo4h3oNZYe45ef+eLeVUVM8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2019/4/22 下午11:23, Doug Anderson 写道:
> Elaine,
>
> On Fri, Apr 12, 2019 at 9:18 AM Douglas Anderson <dianders@chromium.org> wrote:
>> This is mostly a revert of commit 55bb6a633c33 ("clk: rockchip: mark
>> noc and some special clk as critical on rk3288") except that we're
>> keeping "pmu_hclk_otg0" as critical still.
>>
>> NOTE: turning these clocks off doesn't seem to do a whole lot in terms
>> of power savings (checking the power on the logic rail).  It appears
>> to save maybe 1-2mW.  ...but still it seems like we should turn the
>> clocks off if they aren't needed.
>>
>> About "pmu_hclk_otg0" (the one clock from the original commit we're
>> still keeping critical) from an email thread:
>>
>>> pmu ahb clock
>>>
>>> Function: Clock to pmu module when hibernation and/or ADP is
>>> enabled. Must be greater than or equal to 30 MHz.
>>>
>>> If the SOC design does not support hibernation/ADP function, only have
>>> hclk_otg, this clk can be switched according to the usage of otg.
>>> If the SOC design support hibernation/ADP, has two clocks, hclk_otg and
>>> pmu_hclk_otg0.
>>> Hclk_otg belongs to the closed part of otg logic, which can be switched
>>> according to the use of otg.
>>>
>>> pmu_hclk_otg0 belongs to the always on part.
>>>
>>> As for whether pmu_hclk_otg0 can be turned off when otg is not in use,
>>> we have not tested. IC suggest make pmu_hclk_otg0 always on.
>> For the rest of the clocks:
>>
>> atclk: No documentation about this clock other than that it goes to
>> the CPU.  CPU functions fine without it on.  Maybe needed for JTAG?
>>
>> jtag: Presumably this clock is only needed if you're debugging with
>> JTAG.  It doesn't seem like it makes sense to waste power for every
>> rk3288 user.  In any case to do JTAG you'd need private patches to
>> adjust the pinctrl the mux the JTAG out anyway.
>>
>> pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
>> clocks on only during kernel panics in order to access some coresight
>> registers.  Since nothing in the upstream kernel does this we should
>> be able to leave them off safely.  Maybe also needed for JTAG?
>>
>> hsicphy12m_xin12m: There is no indication of why this clock would need
>> to be turned on for boards that don't use HSIC.
>>
>> pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
>> these 4 clocks on only when doing DDR transitions and they are off
>> otherwise.  I see no reason why they'd need to be on in the upstream
>> kernel which doesn't support DDRFreq.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Now keep pmu_hclk_otg0 as critical.
>> - Updated description since this isn't a clean revert.
>> - PWM patches have landed, so just one patch in the series now.
>>
>>   drivers/clk/rockchip/clk-rk3288.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
> >From previous discussions I think you're all happy with this patch
> now, right?  Care to give it an official Reviewed-by tag?

Yes.

Reviewed-by: Elaine Zhang <zhangqing@rock-chips.com>

>
> -Doug
>
>
>


