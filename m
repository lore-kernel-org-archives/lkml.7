Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77D1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EFA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfDOJs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:48:27 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:57193 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:48:26 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3F9m79p078824;
        Mon, 15 Apr 2019 18:48:07 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 15 Apr 2019 18:48:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3F9m6gc078817
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 15 Apr 2019 18:48:07 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: fix IO domain voltage setting of
 APIO5
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20190327120317.15256-1-katsuhiro@katsuster.net>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <5170ca5c-ac5a-d88f-6c3d-3794a5afdb30@katsuster.net>
Date:   Mon, 15 Apr 2019 18:48:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327120317.15256-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2019/03/27 21:03, Katsuhiro Suzuki wrote:
> This patch fixes IO domain voltage setting that is related to
> audio_gpio3d4a_ms (bit 1) of GRF_IO_VSEL.
> 
> This is because RockPro64 schematics P.16 says that regulator
> supplies 3.0V power to APIO5_VDD. So audio_gpio3d4a_ms bit should
> be clear (means 3.0V). Power domain map is saying different thing
> (supplies 1.8V) but I believe P.16 is actual connectings.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 791fb0ee9722..20ec7d1c25d7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -508,7 +508,7 @@
>   	status = "okay";
>   
>   	bt656-supply = <&vcc1v8_dvp>;
> -	audio-supply = <&vcca1v8_codec>;
> +	audio-supply = <&vcc_3v0>;
>   	sdmmc-supply = <&vcc_sdio>;
>   	gpio1830-supply = <&vcc_3v0>;
>   };
> 

