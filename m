Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B67C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A38214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FPH7IiZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfJKLVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:21:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44691 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:21:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191011112145euoutp01280f287889129ed9c86c55cfaf19b25c~Mk9M7f0YL2770327703euoutp01a
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:21:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191011112145euoutp01280f287889129ed9c86c55cfaf19b25c~Mk9M7f0YL2770327703euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570792905;
        bh=NdCU0ajjFXD2Hz5/SwXrTzjkf2qPzS2QhIlUI/Oyv54=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FPH7IiZStzamMEooSHtbupQIBrKlWBg9FJBwkT6/mbQDUdIam7es1d7F/qcaTYiGo
         hl2o0g52gKvZt4ZhWi6vJliPU5yWFTcwKllqyIVtWEt5bAoMkRsx3+y8mLptxm/Ydu
         Q0T6UDjX4QNO36liOojS8hgUeY4q5K8jrYu4NVHI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191011112145eucas1p17b623641517eda969c6d566e09957a4e~Mk9MkKm782009820098eucas1p1X;
        Fri, 11 Oct 2019 11:21:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.D0.04374.8C560AD5; Fri, 11
        Oct 2019 12:21:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191011112144eucas1p2a3426613ecd0d2a12478082f915f0fb0~Mk9L4CJ3Q2109421094eucas1p2Z;
        Fri, 11 Oct 2019 11:21:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191011112144eusmtrp25718cf3076396e9c481c89dfed552b1f~Mk9L3S6dy3086930869eusmtrp2Y;
        Fri, 11 Oct 2019 11:21:44 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-5a-5da065c895a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.12.04117.8C560AD5; Fri, 11
        Oct 2019 12:21:44 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191011112143eusmtip18fe88c0ace2e0e511df2c0e108ff1d17~Mk9LPdeHV2339823398eusmtip1z;
        Fri, 11 Oct 2019 11:21:43 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
To:     Xin Ji <xji@analogixsemi.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3c6067de-9f3c-b93c-f263-fa5dd09c3270@samsung.com>
Date:   Fri, 11 Oct 2019 13:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <75bb8a47d2c3c1f979c6d62158c21988b846e79b.1570760115.git.xji@analogixsemi.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SazBUYRj27Xd291i2OZbad9SodpgpU6uGH8dkjBrNnOpP/WimMtLihLDM
        Lko1+JFLRKQLS0hESqEQ5bZmQu63GZdCoRlkjFzCuGT3aPLved/3ed7nfb75SCyZ5JuTPsog
        VqVU+MkEIqLs83Lb4UY2y/VI8xcHOr6tiUdPrT8h6I2yJEx/alkR0j0LMwL6VU8+Qff+mcB0
        069egr6blCOkuyvTBbQ2wYX+WZjLpzO+LWEnMfO0qhIzM32RQiYtopNghqrrCaZqMYtg0mJS
        +UxjYhePKV8c4TPDcQ08ZnZ8gGBq45MJZq7E4qzxJZGDJ+vnE8KqbByviLxrVtJ4gRuWNyK+
        jhIRaM08FhmSQNlB7JtoYSwSkRIqH0HC80keV8wjmHqUxtexJNQcgvX14FhE6hX95WEcJw9B
        3ccixBXTCJ5PlWKdwJS6DFW1o/qBGfUYQfHoon4tpmowaGef6dcKqIOw9q5foMNiyhEyxrKF
        OkxQVlC5lMPX2e2kLkDzgoKjmEBT6hihw4aUC0wkf9LTMbUXyqfTMYelMDCWqfcCKpWE0rIm
        ggvqDCmvyxGHTWGy4b2Qw3tgo0In0OFwGM6/gzlxDILSogrMDY5BfUOn/iC8efTbShuufRzy
        ojIx9yw7oG/ahLthBzwoe7LVFkNMlIRj74fh1tKthVLI7VgQJCKZZlsyzbY0mm1pNP99sxBR
        gKRssNrfi1XbKtnrcrXCXx2s9JJ7BPiXoM0f2LzesPABVa+6axFFIpmxOGVvpquErwhRh/pr
        EZBYZibO1qS7SsSeitCbrCrATRXsx6q1aDdJyKTiWwYjLhLKSxHE+rJsIKv6N+WRhuYRSHpq
        qHBeY9SeLZQH0AdOG0Z22p2xdhzQeniJBm/HPYwqunrt0MvoltbE1eXD3zHVbuRmmTJTLxi/
        57SLQcU1yyLnwMiOi+4ZlyxK7Jod2G7cMmdl3xriZpu3wp7e13W+QP77nEFdmG/ii5n74fKK
        wRO9LcpieiXM/uSP0HaDYiMZofZWHLXGKrXiLzql75Z9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xu7onUhfEGlw/I2TRe+4kk8Xrf9NZ
        LP5vm8hssefML3aLK1/fs1msvrKCxeLq95fMFiffXGWx6Jy4hN3i8q45bBaH+qItnq1dymox
        7+4PZgdej7l7dzF7vL/Ryu4xu+Eii8e9fYdZPPZ+W8DiMbtjJqvHiQmXmDy2f3vA6nG/+ziT
        x8ent1g8DvROZvH4vEkugCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2P/r9lMBf9VKhruPGZpYPwr1cXIwSEhYCJxc3tdFyMXh5DAUkaJY2db
        2LsYOYHi4hK7579lhrCFJf5c62KDKHrNKNEyZQoTSEJYIE5i74HHjCAJEYFpjBIbpr5mBnGY
        BQ4ySzyc8AesXUjgDqPE7of1IDabgKbE38032UBsXgE7iXlPFoGtYxFQldj1YwkriC0qECHx
        fPsNRogaQYmTM5+wgNicAtESLyfvAatnFlCX+DPvEjOELS+x/e0cKFtc4taT+UwTGIVmIWmf
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM+23Hfm7Zwdj1LvgQowAH
        oxIP7wz5+bFCrIllxZW5hxglOJiVRHgXzZoTK8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5
        wJSUVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0X/5/U+2fmE+
        /bt0p3S5abjaZD1zrLR5fjT1dk9zX/bCqn96Kg2vMjPyff6fKXBuC//Y8PDpNcXiWn7JM5vk
        7l3136YT0rTmcP5yM77F7yeu2OukmvJ97WrNmj/nGeat/u8SU/fufKVsxJ+j/Xtu6nyRmck0
        RfSsipeP6Y+AfWofYg69f8kyRYmlOCPRUIu5qDgRAOQt6XcRAwAA
X-CMS-MailID: 20191011112144eucas1p2a3426613ecd0d2a12478082f915f0fb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191011022154epcas3p1a719423a23f8bf193b6136e853e66b04
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191011022154epcas3p1a719423a23f8bf193b6136e853e66b04
References: <cover.1570760115.git.xji@analogixsemi.com>
        <CGME20191011022154epcas3p1a719423a23f8bf193b6136e853e66b04@epcas3p1.samsung.com>
        <75bb8a47d2c3c1f979c6d62158c21988b846e79b.1570760115.git.xji@analogixsemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2019 04:21, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.
>
> You can add support to your board with binding.
>
> Example:
> 	anx7625_bridge: encoder@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		status = "okay";
> 		panel-flags = <1>;
> 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
>
> 		port@0 {
> 		  reg = <0>;
> 		  anx_1_in: endpoint {
> 		    remote-endpoint = <&mipi_dsi>;
> 		  };
> 		};
>
> 		port@3 {
> 		  reg = <3>;
> 		  anx_1_out: endpoint {
> 		    remote-endpoint = <&panel_in>;
> 		  };
> 		};
> 	};
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/anx7625.yaml           | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> new file mode 100644
> index 0000000..fc84683
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analogix Semiconductor, Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
> +
> +maintainers:
> +  - Xin Ji <xji@analogixsemi.com>
> +
> +description: |
> +  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> +  designed for portable devices.
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    items:
> +      - const: analogix,anx7625
> +
> +  reg:
> +    maxItems: 1
> +
> +  panel-flags:
> +    description: indicate the panel is internal or external
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: used for power on chip control, POWER_EN pin D2.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: used for reset chip control, RESET_N pin B7.
> +    maxItems: 1
> +
> +  port@0:
> +    type: object
> +    description:
> +      A port node pointing to MIPI DSI host port node.
> +
> +  port@1:
> +    type: object
> +    description:
> +      A port node pointing to MIPI DPI host port node.
> +
> +  port@2:
> +    type: object
> +    description:
> +      A port node pointing to external connector port node.
> +
> +  port@3:
> +    type: object
> +    description:
> +      A port node pointing to eDP port node.


Decrypting available product brief[1], there are following physical lines:

Input:

- MIPI DSI/DPI - video data, are DSI and DPI lines shared?

- I2S - audio data,

- I2C - control line,

- ALERT/INTP - interrupt,

- USB 3.1 SSRc/Tx - for USB forwarding,

Output:

- SS1, SS2,

- SBU/AUX,

- CC1/2.


Having this information I try to understand ports defined by you:

- port@2 you have defined as pointing to external port, but here the
port should be rather subnode of ANX7625 - the chip has CC lines, see
beginning of [2].

- port@3 describes SS1, SS2 and SBU/AUX lines together, am I right? In
USB-C binding SBU and SS lines are represented by different ports,
different approach, but maybe better in this case.


Maybe it would be good to add 2nd example with USB-C port.


[1]:
https://www.analogix.com/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf

[2]: Documentation/devicetree/bindings/connector/usb-connector.txt


Regards

Andrzej


> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - port@0
> +  - port@3
> +
> +example:
> +  - |
> +    anx7625_bridge: encoder@58 {
> +        compatible = "analogix,anx7625";
> +        reg = <0x58>;
> +        status = "okay";
> +        panel-flags = <1>;
> +        enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> +        reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          anx_1_in: endpoint {
> +            remote-endpoint = <&mipi_dsi>;
> +          };
> +        };
> +
> +        port@3 {
> +          reg = <3>;
> +          anx_1_out: endpoint {
> +            remote-endpoint = <&panel_in>;
> +          };
> +        };
> +    };


