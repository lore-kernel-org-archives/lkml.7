Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192AC207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iris.mystia.org header.i=@iris.mystia.org header.b="Gnd+Y6+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCIPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:16:52 -0500
Received: from lyra.margatroid.com ([118.27.33.189]:57844 "EHLO
        lyra.margatroid.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCIPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:16:51 -0500
From:   Tomohiro Mayama <parly-gh@iris.mystia.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris.mystia.org;
        s=lyra-20180701; t=1552144603;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=TMlsqd59wyGOj5P0i+MecLazjmJwEuO3mA75sXbSqKI=;
        b=Gnd+Y6+eJY4+pKVqf0tkw4e+vkK2+jWgj7HcwfUO9AFcTzUU4IS74qbg4OtCWPyK8zROzM
        7JEKBsIuPl6kPA2mvcTLrSrfHBMXu6UK2DHkWYiS8ERmCcuPg2OqFC/egHkvXdNJke5KYG
        zDB7ElsFlNMb750hqaXYuuCD7rfZBqZv+HuH35eN2Tstb9DpryEXgxc9ZqiStJaM+YMSBo
        4OAufudpQeuVFwlfC1hBtRQpU0mmFszw0QZ+aUMeMjLfWy6iJp993y2U68LhEqEd7QAhMx
        e+yOmPcIq91NbqwCNi+32dYMi7Zh9myK29bvb6zNnLGe2jDNuaRUMgqRQPxoLA==
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on
 rk3328-rock64
To:     katsuhiro@katsuster.net, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
 <164d616b-f445-2aa6-e57a-e6db446eb121@katsuster.net>
Message-ID: <4a72a4b1-003e-800c-743f-86f8333ed0c2@iris.mystia.org>
Date:   Sun, 10 Mar 2019 00:16:48 +0900
MIME-Version: 1.0
In-Reply-To: <164d616b-f445-2aa6-e57a-e6db446eb121@katsuster.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/09 11:52, Katsuhiro Suzuki wrote:
> Hello Mayama-san,
> 
> On 2019/03/08 1:18, Tomohiro Mayama wrote:
>> This patch makes USB ports functioning again.
>>
>> Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 21107d0f4378..7f365e448867 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -45,8 +45,7 @@
>>         vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
>>           compatible = "regulator-fixed";
>> -        enable-active-high;
>> -        gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +        gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
>>           pinctrl-names = "default";
>>           pinctrl-0 = <&usb20_host_drv>;
>>           regulator-name = "vcc_host1_5v";
>>
> 
> After this patch applied, USB and S/PDIF both work well.
> 
> Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> 
> $ lsusb
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 046d:c526 Logitech, Inc. Nano Receiver
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> 
> Best Regards,
> Katsuhiro Suzuki
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Thank you for testing my patch, Suzuki-san!

Regards,
Tomohiro Mayama
