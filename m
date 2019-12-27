Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC9C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F7B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0JTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:19:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfL0JTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:19:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 03D5B283C07
Subject: Re: [PATCH v22 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ulrich Hecht <uli@fpond.eu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20191223143538.20327-1-enric.balletbo@collabora.com>
 <20191223143538.20327-2-enric.balletbo@collabora.com>
 <9fc5e30b8bc7e160ddc54a2056ca6e57eaebbab4.camel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9eee88d1-21d4-5571-038f-60bc7fa05d3f@collabora.com>
Date:   Fri, 27 Dec 2019 10:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9fc5e30b8bc7e160ddc54a2056ca6e57eaebbab4.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On 26/12/19 15:27, Ezequiel Garcia wrote:
> Hi Enric, Rob,
> 
> On Mon, 2019-12-23 at 15:35 +0100, Enric Balletbo i Serra wrote:
>> From: Jitao Shi <jitao.shi@mediatek.com>
>>
>> Add documentation for DT properties supported by
>> ps8640 DSI-eDP converter.
>>
>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [..]
>> +
>> +  ports:
>> +    type: object
>> +    description:
>> +      A node containing DSI input & output port nodes with endpoint
>> +      definitions as documented in
>> +      Documentation/devicetree/bindings/media/video-interfaces.txt
>> +      Documentation/devicetree/bindings/graph.txt
>> +    properties:
>> +      port@0:
>> +        type: object
>> +        description: |
>> +          Video port for DSI input
>> +
>> +      port@1:
>> +        type: object
>> +        description: |
>> +          Video port for eDP output (panel or connector).
>> +
>> +    required:
>> +      - port@0
>> +
> 
> Is it correct to require port@0 ? This could be called port@1
> or port@2, and IIUC it should bind the same.
> 

My understanding is that at least the Video port for DSI input is required,
which makes sense, otherwise you have the chip connected nowhere. port@1 is
optional because it could be connected to a eDP panel or can just be a connector.

About your second question, I am not sure I understand you. You mean that have a
DT like this should work?

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@1 {
                    reg = <0>;
                    ps8640_in: endpoint {
                        remote-endpoint = <&dsi0_out>;
                    };
                };

                port@2 {
                    reg = <1>;
                    ps8640_out: endpoint {
                        remote-endpoint = <&panel_in>;
                   };
                };
            };


Probably yes, because the driver what really looks is the register value, but
that's odd and probably a bad practice. Also if I am not wrong the convention is
name the nodes with port@<reg property> (like we do in i2c devices for example)

port@0 is the label that has the register value to 0.
port@1 is the label that has the register value to 1.
...

Thanks,
 Enric

> Thanks,
> Ezequiel 
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - powerdown-gpios
>> +  - reset-gpios
>> +  - vdd12-supply
>> +  - vdd33-supply
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    i2c0 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ps8640: edp-bridge@18 {
>> +            compatible = "parade,ps8640";
>> +            reg = <0x18>;
>> +            powerdown-gpios = <&pio 116 GPIO_ACTIVE_LOW>;
>> +            reset-gpios = <&pio 115 GPIO_ACTIVE_LOW>;
>> +            vdd12-supply = <&ps8640_fixed_1v2>;
>> +            vdd33-supply = <&mt6397_vgp2_reg>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    ps8640_in: endpoint {
>> +                        remote-endpoint = <&dsi0_out>;
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    ps8640_out: endpoint {
>> +                        remote-endpoint = <&panel_in>;
>> +                   };
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> -- 
>> 2.20.1
>>
>>
> 
> 
> 
