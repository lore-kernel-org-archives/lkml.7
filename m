Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB94DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D7420643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbfDRQOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:14:42 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:45952 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:14:42 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id B3AE97B05FF;
        Thu, 18 Apr 2019 13:14:36 -0300 (-03)
Subject: Re: [PATCH v4 5/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Add
 Bluetooth device node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1555600282-9405-1-git-send-email-pgreco@centosproject.org>
 <1555600282-9405-6-git-send-email-pgreco@centosproject.org>
 <20190418155613.shiv7geoqyzfy4kf@flea>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <bc5d7e91-74c5-103a-db72-6cb1f3ef53b9@centosproject.org>
Date:   Thu, 18 Apr 2019 13:14:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418155613.shiv7geoqyzfy4kf@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: B3AE97B05FF.A445C
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-1.386, requerido 6, ALL_TRUSTED -1.00, BAYES_00 -1.90,
        URIBL_RHS_DOB 1.51)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 18/4/19 a las 12:56, Maxime Ripard escribió:
> On Thu, Apr 18, 2019 at 12:11:20PM -0300, Pablo Greco wrote:
>> Since the bananapi-m2-ultra and the bananapi-m2-berry have the same
>> WiFi/Bluetooth, add the required nodes to the bananapi-m2-berry.
>>
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>> ---
>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 26 +++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> index 78f4a1a..3d0bb7e 100644
>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> @@ -96,6 +96,8 @@
>>   	wifi_pwrseq: wifi_pwrseq {
>>   		compatible = "mmc-pwrseq-simple";
>>   		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
>> +		clocks = <&ccu CLK_OUTA>;
>> +		clock-names = "ext_clock";
>>   	};
>>   };
>>
>> @@ -171,6 +173,11 @@
>>   	status = "okay";
>>   };
>>
>> +&pio {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&clk_out_a_pin>;
>> +};
>> +
> I'm not sure you answered my question about why that is needed?
Because it is the same case as 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts?id=1e5f1db4ccd8348a21da55bff82f4263000879ef
I can repeat that info in this commit log
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
Pablo.
