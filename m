Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C412920857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCBOTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:19:33 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:53002 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfCBOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:19:33 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x22EJGcc045326;
        Sat, 2 Mar 2019 23:19:16 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 02 Mar 2019 23:19:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x22EJFQt045323
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 2 Mar 2019 23:19:15 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <20190217173407.29189-2-katsuhiro@katsuster.net>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
Date:   Sat, 2 Mar 2019 23:19:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190217173407.29189-2-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 2019/02/18 2:34, Katsuhiro Suzuki wrote:
> This patch adds HDMI sound (I2S0) node for rock64.
> 
> After apply this patch, UART2 will fail to allocate DMA resources
> but UART driver can work fine without DMA.
> 
> This error is related to the DMAC of rk3328 (pl330 or compatible).
> DMAC connected to 16 DMA sources. Each sources have ID number that is
> called 'Req number' in rk3328 TRM. Currently total 7 sources has been
> activated as follows:
> 
> | Req number | Source | Required  |
> |            |        | channels  |
> |------------+--------+-----------|
> | 14, 15     | I2S1   | 2ch       |
> |  6,  7     | UART2  | 2ch       |
> |     10     | SPDIF  | 1ch       |
> |  8,  9     | SPI0   | 2ch       |
> |------------+--------+-----------|
> |            | Total  | 7ch       |
> 
> HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
> I2S0 can work concurrently with other sources, but rk3328 DMAC can
> use max 8 channels at same time. If I2S0 is simply activated by this
> patch, required DMAC channels will be 9. So last one (UART2) cannot
> allocate the DMA resources.
> 
> Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
> problem.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 21 ++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 2157a528276b..bfc0930d245c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -68,7 +68,8 @@
>   	sound {
>   		compatible = "audio-graph-card";
>   		label = "rockchip,rk3328";
> -		dais = <&i2s1_p0
> +		dais = <&i2s0_p0
> +			&i2s1_p0
>   			&spdif_p0>;
>   	};
>   
> @@ -141,6 +142,12 @@
>   
>   &hdmi {
>   	status = "okay";
> +
> +	port@0 {
> +		hdmi_p0_0: endpoint {
> +			remote-endpoint = <&i2s0_p0_0>;
> +		};
> +	};
>   };
>   
>   &hdmiphy {
> @@ -256,6 +263,18 @@
>   	};
>   };
>   
> +&i2s0 {
> +	status = "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&hdmi_p0_0>;
> +		};
> +	};
> +};
> +
>   &i2s1 {
>   	status = "okay";
>   
> 

