Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242352147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552406099;
	bh=1kVzXKkfU77EDNklJTh0/LYoDyd/B04M7cCtfdczUSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKAAjZuYcpVfywD5+Jea78S9bA+vI3UtFU01+0RbDxAWyVEMssBdSHFGnZIdSQva0
	 erAkyUycL5PzvDE1OgCOYzc8KW4Z5CjLGLctwQDPg0/tKl7cJPGbNciM2jZg/axD8n
	 jQbpwKbt17e+pqapuI97YddbmpfXWQ/oGX1YPLWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfCLPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:54:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34407 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfCLPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:54:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id g16so2512993oib.1;
        Tue, 12 Mar 2019 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5EPZsq1erXLZINt3QcHNiSzdfem0AIvWPobRUxebRM=;
        b=E1kOVpHUNFaxRo8+JTRPfNfB02RslMVZZR6I0Mc5QynUJJnjEG3KkE9QpNOeN8ANyg
         KayR6f0M9TdI9zkiyGSUQO9cqYr9rYlz36QztnewW+SmWa4KFWMntz762pfk6YoPvWue
         N6+wpw8HgQI7c1EETnS2FWf9dpjUn/O69/kEbo5BcY+ftc2sOMLmlpnh/PlRzGUQV395
         6N6Tcmh2sZ5JP0ul2/E27Bjln+MpiiaEWOYa9aKyk3mQMB/iVtYcSedgaCD2Z4konc47
         TCf36Aci9+SJPBJvo07C0jUudX2McOFwVc3nmCzH92aGFxPu/3GgcemZrKH9cCIFuGIb
         3gBg==
X-Gm-Message-State: APjAAAUvApaIU7SeBM8Y+Mm9cDZXARkV4/Yf5lK8Lzh16PtYLPBMWgqf
        sgCaBqzAmknI1gatWwbyUTPLe9E=
X-Google-Smtp-Source: APXvYqz4kooUq+GLJ8VsB+JeTl3YaL9UbNi3ag4CZKTvHOau6AK8QSOKSe7LaUAFTqOWdekUShYJuA==
X-Received: by 2002:aca:3d44:: with SMTP id k65mr2024279oia.143.1552406095048;
        Tue, 12 Mar 2019 08:54:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m125sm3524007oib.49.2019.03.12.08.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:54:54 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:54:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     pisa@cmp.felk.cvut.cz
Cc:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, wg@grandegger.com, davem@davemloft.net,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com,
        ondrej.ille@gmail.com
Subject: Re: [PATCH v2 2/2] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Message-ID: <20190312155453.GA24561@bogus>
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
 <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:26:29PM +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> new file mode 100644
> index 000000000000..fea9c08b79ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> @@ -0,0 +1,108 @@
> +Memory mapped CTU CAN FD open-source IP core
> +
> +The core sources and documentation on project page
> +
> +  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> +  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
> +
> +Integration in Xilinx Zynq SoC based system together with
> +OpenCores SJA1000 compatible controllers
> +
> +  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> +
> +Martin Jerabek's dimploma thesis with integration and testing
> +framework description
> +
> + https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
> +
> +Required properties:
> +
> +- compatible : should be one of "ctu,ctucanfd", "ctu,canfd-2".
> +      The "canfd-2" has been reserved for older revision of the IP core.
> +      The revision can be read from the IP core register as well.
> +
> +- reg = <(baseaddr) (size)> : specify mapping into physical address
> +      space of the processor system.
> +
> +- interrupts : property with a value describing the interrupt source
> +      required for the CTU CAN FD. For Zynq SoC system format is
> +      <(is_spi) (number) (type)> where is_spi defines if it is SPI
> +      (shared peripheral) interrupt, the second number is translated
> +      to the vector by addition of 32 on Zynq-7000 systems and type
> +      is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.
> +
> +- interrupt-parent = <&interrupt-controller-phandle> :
> +      is required for Zynq SoC to find map interrupt
> +      to the correct controller

Remove as this is implied and could be in a parent node.

> +
> +- clocks: phandle of reference clock (100 MHz is appropriate
> +      for FPGA implementation on Zynq-7000 system).
> +
> +Optional properties:
> +
> +- clock-names: not used in actual design but if more clocks are used
> +      by cores then "can_clk" would be clock source name for the clocks
> +      used to define CAN time-quanta.
> +
> +Example when integrated to Zynq-7000 system DTS:
> +
> +        / {
> +            /* ... */
> +            amba: amba {
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                compatible = "simple-bus";
> +
> +                ctu_can_fd_0: ctu_can_fd@43c30000 {

can@...

> +                    compatible = "ctu,ctucanfd";
> +                    interrupt-parent = <&intc>;
> +                    interrupts = <0 30 4>;
> +                    clocks = <&clkc 15>;
> +                    reg = <0x43c30000 0x10000>;
> +                };
> +            };
> +        };
> +
> +
> +Example when used as DTS overlay on Zynq-7000 system:
> +
> +
> +// Device Tree Example: Full Reconfiguration without Bridges

Drop this example. Overlays are outside the scope of bindings.

> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +    fragment@0 {
> +        target-path = "/fpga-full";
> +
> +        __overlay__ {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            firmware-name = "system.bit.bin";
> +        };
> +    };
> +
> +    fragment@1 {
> +        target-path = "/amba";
> +        __overlay__ {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            ctu_can_fd_0: ctu_can_fd@43c30000 {
> +                compatible = "ctu,ctucanfd";
> +                interrupt-parent = <&intc>;
> +                interrupts = <0 30 4>;
> +                clocks = <&clkc 15>;
> +                reg = <0x43c30000 0x10000>;
> +            };
> +            ctu_can_fd_1: ctu_can_fd@43c70000 {
> +                compatible = "ctu,ctucanfd";
> +                interrupt-parent = <&intc>;
> +                interrupts = <0 31 4>;
> +                clocks = <&clkc 15>;
> +                reg = <0x43c70000 0x10000>;
> +            };
> +        };
> +    };
> +};
> -- 
> 2.11.0
> 
