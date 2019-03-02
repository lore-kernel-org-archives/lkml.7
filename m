Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F86C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB1820838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCBT05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:26:57 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:32567 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfCBT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:26:57 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x22JQcQB058181;
        Sun, 3 Mar 2019 04:26:38 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Sun, 03 Mar 2019 04:26:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x22JQcRF058174
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 3 Mar 2019 04:26:38 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To:     Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <20190217173407.29189-2-katsuhiro@katsuster.net>
 <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
 <AM3PR03MB0966F2308C6003C192A68F4DAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <fb36eddb-ef3b-df4a-5e1a-6f8866726ae9@katsuster.net>
Date:   Sun, 3 Mar 2019 04:26:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <AM3PR03MB0966F2308C6003C192A68F4DAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonas,

Thanks for your comments.

On 2019/03/03 2:20, Jonas Karlman wrote:
> On 2019-03-02 15:19, Katsuhiro Suzuki wrote:
>> Ping...
>>
>> On 2019/02/18 2:34, Katsuhiro Suzuki wrote:
>>> This patch adds HDMI sound (I2S0) node for rock64.
>>>
>>> After apply this patch, UART2 will fail to allocate DMA resources
>>> but UART driver can work fine without DMA.
>>>
>>> This error is related to the DMAC of rk3328 (pl330 or compatible).
>>> DMAC connected to 16 DMA sources. Each sources have ID number that is
>>> called 'Req number' in rk3328 TRM. Currently total 7 sources has been
>>> activated as follows:
>>>
>>> | Req number | Source | Required  |
>>> |            |        | channels  |
>>> |------------+--------+-----------|
>>> | 14, 15     | I2S1   | 2ch       |
>>> |  6,  7     | UART2  | 2ch       |
>>> |     10     | SPDIF  | 1ch       |
>>> |  8,  9     | SPI0   | 2ch       |
>>> |------------+--------+-----------|
>>> |            | Total  | 7ch       |
>>>
>>> HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
>>> I2S0 can work concurrently with other sources, but rk3328 DMAC can
>>> use max 8 channels at same time. If I2S0 is simply activated by this
>>> patch, required DMAC channels will be 9. So last one (UART2) cannot
>>> allocate the DMA resources.
>>>
>>> Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
>>> problem.
>>>
>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>> ---
>>>    .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 21 ++++++++++++++++++-
>>>    1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>> index 2157a528276b..bfc0930d245c 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>> @@ -68,7 +68,8 @@
>>>    	sound {
>>>    		compatible = "audio-graph-card";
>>>    		label = "rockchip,rk3328";
>>> -		dais = <&i2s1_p0
>>> +		dais = <&i2s0_p0
>>> +			&i2s1_p0
>>>    			&spdif_p0>;
> 
> I am working on multi-channel hdmi audio support for dw-hdmi at [1] and are wondering if having multiple dais on one graph card
> instead of a separate hdmi sound card will affect the ability to define a proper alsa config for multi channel hdmi sound.
> 
> [1] https://github.com/Kwiboo/linux-rockchip/compare/8874c206d613dc575f5cb6e385e7a866020138d0...92b20eaa6b6dd2cf3418a428f905d10bbc62724f
> 

It seems a part of multi channel (5.1 ch) has already been supported
by rockchip-i2s and dw-hdmi. So I applied this patch and tried below
command.
   speaker-test -D hw:0,0 -f 48000 -c 6
It does not return errors.

Would you tell me more details you worried about if something wrong?


FYI: Rock64 PCM devices are as follows after applied this patch.
~~~~~
$ cat /proc/asound/pcm
00-00: ff000000.i2s-i2s-hifi i2s-hifi-0 :  : playback 1
00-01: ff010000.i2s-rk3328-hifi ff410000.codec-1 :  : playback 1 : capture 1
00-02: ff030000.spdif-dit-hifi dit-hifi-2 :  : playback 1
~~~~~

Best Regards,
Katsuhiro Suzuki


> Regards,
> Jonas
> 
>>>    	};
>>>    
>>> @@ -141,6 +142,12 @@
>>>    
>>>    &hdmi {
>>>    	status = "okay";
>>> +
>>> +	port@0 {
>>> +		hdmi_p0_0: endpoint {
>>> +			remote-endpoint = <&i2s0_p0_0>;
>>> +		};
>>> +	};
>>>    };
>>>    
>>>    &hdmiphy {
>>> @@ -256,6 +263,18 @@
>>>    	};
>>>    };
>>>    
>>> +&i2s0 {
>>> +	status = "okay";
>>> +
>>> +	i2s0_p0: port {
>>> +		i2s0_p0_0: endpoint {
>>> +			dai-format = "i2s";
>>> +			mclk-fs = <256>;
>>> +			remote-endpoint = <&hdmi_p0_0>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>>    &i2s1 {
>>>    	status = "okay";
>>>    
>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> https://nam03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=02%7C01%7C%7Cfcb0d6c43ded4d5e7d4c08d69f1a226d%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C636871331922090426&amp;sdata=ABb%2Fo%2FMAGvFBH%2B37uQr6rzn%2B%2FXBAXyiGfv2%2BMO0RQoQ%3D&amp;reserved=0
> 
> 
> 

