Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509A2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCICw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:52:26 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:58654 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCICw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:52:26 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x292q9oe055929;
        Sat, 9 Mar 2019 11:52:10 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sat, 09 Mar 2019 11:52:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x292q9SR055926
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 9 Mar 2019 11:52:09 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on
 rk3328-rock64
To:     Tomohiro Mayama <parly-gh@iris.mystia.org>, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <164d616b-f445-2aa6-e57a-e6db446eb121@katsuster.net>
Date:   Sat, 9 Mar 2019 11:52:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mayama-san,

On 2019/03/08 1:18, Tomohiro Mayama wrote:
> This patch makes USB ports functioning again.
> 
> Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 21107d0f4378..7f365e448867 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -45,8 +45,7 @@
>   
>   	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
>   		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&usb20_host_drv>;
>   		regulator-name = "vcc_host1_5v";
> 

After this patch applied, USB and S/PDIF both work well.

Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>


$ lsusb
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 046d:c526 Logitech, Inc. Nano Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


Best Regards,
Katsuhiro Suzuki
