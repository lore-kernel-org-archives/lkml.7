Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E5C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF62120818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDKDm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:42:58 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:42066 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKDm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:42:57 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.41])
        by regular1.263xmail.com (Postfix) with ESMTP id 628369C2;
        Thu, 11 Apr 2019 11:42:52 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24419T140373282043648S1554954170386687_;
        Thu, 11 Apr 2019 11:42:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7c090b46a2986083d3b27dd2daba841f>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-3-dianders@chromium.org>
 <50b744cd-b8d9-79ca-ba2d-6765808aa5e5@rock-chips.com>
 <CAD=FV=Vyy4bNJV=t2yALP3dAnm0-QsR55F5B==uUoi-Tp6b7Vg@mail.gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <43b5ef8c-4617-bdc5-7109-35eac228b8f9@rock-chips.com>
Date:   Thu, 11 Apr 2019 11:42:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vyy4bNJV=t2yALP3dAnm0-QsR55F5B==uUoi-Tp6b7Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2019/4/10 下午11:25, Doug Anderson 写道:
> Hi,
>
> On Tue, Apr 9, 2019 at 11:42 PM elaine.zhang <zhangqing@rock-chips.com> wrote:
>> hi,
>>
>> 在 2019/4/10 上午4:47, Douglas Anderson 写道:
>>> Most rk3288-based boards are derived from the EVB and thus use a PWM
>>> regulator for the logic rail.  However, most rk3288-based boards don't
>>> specify the PWM regulator in their device tree.  We'll deal with that
>>> by making it critical.
>>>
>>> NOTE: it's important to make it critical and not just IGNORE_UNUSED
>>> because all PWMs in the system share the same clock.  We don't want
>>> another PWM user to turn the clock on and off and kill the logic rail.
>>>
>>> This change is in preparation for actually having the PWMs in the
>>> rk3288 device tree actually point to the proper PWM clock.  Up until
>>> now they've all pointed to the clock for the old IP block and they've
>>> all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
>>> clock rates for both clocks were the same.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>    drivers/clk/rockchip/clk-rk3288.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
>>> index 06287810474e..c3321eade23e 100644
>>> --- a/drivers/clk/rockchip/clk-rk3288.c
>>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>>> @@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>>>        GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
>>>        GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
>>>        GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
>>> -     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 11, GFLAGS),
>>> +     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 11, GFLAGS),
>>>
>>>        /* ddrctrl [DDR Controller PHY clock] gates */
>>>        GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 4, GFLAGS),
>>> @@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[] __initconst = {
>>>        "pclk_alive_niu",
>>>        "pclk_pd_pmu",
>>>        "pclk_pmu_niu",
>>> +     "pclk_rkpwm",
>> pwm have device node, can enable and disable it in the pwm drivers.
>>
>> pwm regulator use pwm node as:
>>
>> pwms = <&pwm2 0 25000 1>
>>
>> when set Logic voltage:
>>
>> pwm_regulator_set_voltage()
>>
>>       --> pwm_apply_state()
>>
>>           -->clk_enable()
>>
>>           -->pwm_enable()
>>
>>           -->pwm_config()
>>
>>           -->pinctrl_select()
>>
>>           --....
>>
>> For mark pclk_rkpwm as critical,do you have any questions, or provides
>> some log or more information.
> Right, if we actually specify the PWM used for the PWM regulator in
> the device tree then there is no need to mark it as a critical clock.
> In fact rk3288-veyron devices boot absolutely fine without marking
> this clock as critical.  Actually, it seems like the way the PWM
> framework works (IIRC it was designed this way specifically to support
> PWM regulators) is that even just specifying that pwm1 is "okay" is
> enough to keep the clock on even if the PWM regulator isn't specified.
>
> ...however...
>
> Take a look at, for instance, the rk3288-evb device tree file.
> Nowhere in there does it specify that the PWM used for the PWM
> regulator should be on.  Presumably that means that if we don't mark
> the clock as critical then rk3288-evb will fail to boot.  That's easy
> for me to fix since I have the rk3288-evb schematics, but what about
> other rk3288 boards?  We could make educated guesses about each of
> them and/or fix things are we hear about breakages.
>
> ...but...
>
> All the above would only be worth doing if we thought someone would
> get some benefit out of it.  I'd bet that pretty much all rk3288-based
> boards use a PWM regulator.  Thus, in reality, everyone will want the
> rkpwm clock on all the time anyway.  In that case going through all
> that extra work / potentially breaking other boards doesn't seem worth
> it.  Just mark the clock as critical.

I have no problem with changing it like this, but I think it is better 
to modify dts:

vdd_log: vdd-log {
         compatible = "pwm-regulator";
         rockchip,pwm_id = <2>; //for rk uboot
         rockchip,pwm_voltage = <900000>; // for rk uboot
         pwms = <&pwm2 0 25000 1>;
         regulator-name = "vdd_log";
         regulator-min-microvolt = <800000>;//hw logic min voltage
         regulator-max-microvolt = <1400000>;//hw logic max voltage
         regulator-always-on;
         regulator-boot-on;
     };

Maybe we did not push the modification of this part in rk3288-evb, I 
will push to deal with this.(rk3229-evb.dts and rk3399 has been already 
pushed)
>
>
>
>
> -Doug
>
>
>


