Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1FC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8C82084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfILIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:24:18 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:20320 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfILIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:24:15 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 12 Sep
 2019 16:25:07 +0800
Subject: Re: [PATCH v3 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
References: <1568216290-84219-1-git-send-email-jianxin.pan@amlogic.com>
 <1568216290-84219-5-git-send-email-jianxin.pan@amlogic.com>
 <e0054a53-7516-0527-3df7-c85e168003ba@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <eefe907c-d1f3-1c56-51d4-01af342a9697@amlogic.com>
Date:   Thu, 12 Sep 2019 16:25:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e0054a53-7516-0527-3df7-c85e168003ba@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.226]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,


On 2019/9/11 23:54, Neil Armstrong wrote:
> On 11/09/2019 17:38, Jianxin Pan wrote:
>> Add basic support for the Amlogic A1 based Amlogic AD401 board:
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
>> Timer, UART. It's capable of booting up into the serial console.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile           |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts |  30 ++++++
>>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi      | 131 +++++++++++++++++++++++++
>>  3 files changed, 162 insertions(+)
[...]
>> +
>> +	sm: secure-monitor {
>> +		compatible = "amlogic,meson-gxbb-sm";
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +
>> +		apb: bus@0xfe000000 {
> 
> Should be bus@fe000000
>
Thanks for your review.
I resent a new version and fixed it.
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xfe000000 0x0 0x1000000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
[...]
>> +	xtal: xtal-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "xtal";
>> +		#clock-cells = <0>;
>> +	};
>> +};
>>
> 
> With that fixed:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Neil
> 
> .
> 

