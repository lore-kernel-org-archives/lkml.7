Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78661C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596D1206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKKTcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:32:04 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:56388 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbfKKTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:32:04 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iUFPr-00017a-Bc; Mon, 11 Nov 2019 20:31:59 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (pD9E89174.dip0.t-ipconnect.de [217.232.145.116])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xABJVvBQ021691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 11 Nov 2019 20:31:58 +0100
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on
 rk3399-roc-pc
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
 <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
Date:   Mon, 11 Nov 2019 20:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1573500722;d304cc47;
X-HE-SMSGID: 1iUFPr-00017a-Bc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Am 11.11.19 um 18:27 schrieb Ulf Hansson:
> On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wrote:
>>
>> Add SDR104 capability and regulators to SD card node.
>> While at it, fix a typo in lcd pinctrl and remove two
>> undocumented bindings from pmic.
>>
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++----
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index 33df95e384b4..e86a6db54499 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -135,6 +135,20 @@
>>                 vin-supply = <&vcc_1v8>;
>>         };
>>
>> +       vcc3v0_sd: vcc3v0-sd {
>> +               compatible = "regulator-fixed";
>> +               enable-active-high;
>> +               gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&vcc3v0_sd_en>;
>> +               regulator-name = "vcc3v0_sd";
>> +               regulator-always-on;
> 
> This looks odd. A GPIO regulator being always on?

This is a standard micro SD card socket that can also be used for
booting the board. I wanted to be cautious and start
working with it and several SD cards and explore the capabilities.

On this board nearly all regulators are still continously
switched on. I plan to remove the always-on properties step
by step from the regulators when the board runs stable with it's
components all enbled. 

> 
>> +               regulator-boot-on;
>> +               regulator-min-microvolt = <3000000>;
>> +               regulator-max-microvolt = <3000000>;
>> +               vin-supply = <&vcc3v3_sys>;
>> +       };
> 
> Assumes this powers an SDIO embedded card. Often those have a specific
> power sequence, just wanted to make sure the above are really
> sufficient? No delays or external clock needed?

It's not embedded, just a standard µSD plug. It is already enabled
by mainline U-Boot and ejecting and inserting the card works fine.

--
Gruß,
Markus
> 
> [...]
> 
> Kind regards
> Uffe
> 
