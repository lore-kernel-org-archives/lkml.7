Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C33EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2060B2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfEBK1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:27:45 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:43070 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:27:45 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 9C6E57B05A2;
        Thu,  2 May 2019 07:27:40 -0300 (-03)
Subject: Re: [linux-sunxi] Re: [PATCH v5 7/7] ARM: dts: sun8i: v40:
 bananapi-m2-berry: Add Bluetooth device node
To:     wens@kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-8-git-send-email-pgreco@centosproject.org>
 <20190502074103.vtuxmsl55u3ygyvl@flea>
 <CAGb2v65eaRLRkJ2hvoOc1Cr=ncSeqy7Tq2pzt4rk4uiWQeag2w@mail.gmail.com>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <c96ecf5a-398c-d34e-72b8-332f0efbade0@centosproject.org>
Date:   Thu, 2 May 2019 07:27:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v65eaRLRkJ2hvoOc1Cr=ncSeqy7Tq2pzt4rk4uiWQeag2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 9C6E57B05A2.A5DC6
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 2/5/19 a las 05:20, Chen-Yu Tsai escribió:
> On Thu, May 2, 2019 at 3:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> On Tue, Apr 23, 2019 at 02:26:04PM -0300, Pablo Greco wrote:
>>> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
>>> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
>>>
>>> The Bluetooth side is connected to UART3 in a 4 wire configuration. Same
>>> as the WiFi side, due to being the same chip and package, DLDO1 and
>>> DLDO2 regulator outputs from the PMIC provide overall power via VBAT and
>>> I/O power via VDDIO. The CLK_OUT_A clock output from the SoC provides
>>> the LPO low power clock at 32.768 kHz.
>>>
>>> This patch enables Bluetooth on this board, and also adds the missing
>>> LPO clock on the WiFi side. There is also a PCM connection for
>>> Bluetooth, but this is not covered here.
>>>
>>> The LPO clock is fed from CLK_OUT_A, which needs to be muxed on pin
>>> PI12. This can be represented in multiple ways. This patch puts the
>>> pinctrl property in the pin controller node. This is due to limitations
>>> in Linux, where pinmux settings, even the same one, can not be shared
>>> by multiple devices. Thus we cannot put it in both the WiFi and
>>> Bluetooth device nodes. Putting it the CCU node is another option, but
>>> Linux's CCU driver does not handle pinctrl. Also the pin controller is
>>> guaranteed to be initialized after the CCU, when clocks are available.
>>> And any other devices that use muxed pins are guaranteed to be
>>> initialized after the pin controller. Thus having the CLK_OUT_A pinmux
>>> reference be in the pin controller node is a good choice without having
>>> to deal with implementation issues.
>>>
>>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>>> ---
>>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>>> index c87f2c0..15c22b0 100644
>>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>>> @@ -96,6 +96,8 @@
>>>        wifi_pwrseq: wifi_pwrseq {
>>>                compatible = "mmc-pwrseq-simple";
>>>                reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
>>> +             clocks = <&ccu CLK_OUTA>;
>>> +             clock-names = "ext_clock";
>> So if you don't have that patch (that enables bluetooth) the wifi
>> doesn't work (even though the previous patch is supposed to enable it)
> Maybe we should just squash the two (WiFi and Bluetooth) together?
> After all, they are in the same package, and depend on some of the
> same things, such as clocks and regulators.
>
> ChenYu
That seems better, I was trying to keep the same logic the patches 
applied to the ultra.
>>>        };
>>>   };
>>>
>>> @@ -173,6 +175,7 @@
>>>
>>>   &pio {
>>>        pinctrl-names = "default";
>>> +     pinctrl-0 = <&clk_out_a_pin>;
>> This one should bein the previous one as well
>>
>> Maxime
>>
>> --
>> Maxime Ripard, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
Pablo.
