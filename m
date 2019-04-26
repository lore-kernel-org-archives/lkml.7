Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A111C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4836920693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556307193;
	bh=5LanEKP4jJAqZfRYzUExjF60ASb/atZI1nU1C1g7dXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aWqH0RGbZN038ZNrTdEfFSXfHZDBgfxX8HGVinFclr/mdG8muDKriRjtd8nRy5Gj1
	 ejsC674Yf6A48WaRsO9ylebWrPkiTB9Jq/HA0HG4/TkgTT5iGfy0MXF/sV1P4BTx7S
	 M2MB9SeAryUTtb0/o6ULBLRW1wfuEJk563N95Tfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfDZTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:33:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42651 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:33:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so3601898otl.9;
        Fri, 26 Apr 2019 12:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+81lEXfAzzNKtobiEn29UNfrD9F8Ckf7nQJDg+0i0c8=;
        b=k7f0je8UCAFM9+YYMvDydNYQkgU1Eu9Yi7YRhd76zO55aqyUpIshENuoL84haxdSag
         YDn3Xkk2QtvEV2L475lQWZl6D5mw5shcB2ZFQcP7l5d1cyrWDFvlz1d/rJRIknHuk+tQ
         ZGQftQtWd13Mc6aegHZJBv89egGnLrVbzoKPII/XcNI7QgwQGOfQhvZ8laWmIj89f/xl
         K/SbVuDVi7Ciz35wVxeR80oBujRDiX/l5ywyKffj20YMxDtutqiuDwuDXNstS3zL13Q4
         s2bTvmtSxwriURlx3KI3TeWQCwV3QJwIu5rKqrLMzwiRxBr+LSO+KmDqadkaSX7xCJPt
         irSQ==
X-Gm-Message-State: APjAAAXvGBNnkBuC0ANPy3vxwmcFo5168c2/gcdLFUznSLSL4CXfvs8R
        wFpoS3RSBw8g1ehaS7OfYg==
X-Google-Smtp-Source: APXvYqz0PbDlJmvV0/mZ7rXSbPLpUqMhVyDui+oL8zcYwDQti4YY8Ai7YR5DnrwTgzIj4Sg0TTSyxw==
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr4444587otr.208.1556307190945;
        Fri, 26 Apr 2019 12:33:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w3sm648387oic.39.2019.04.26.12.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:33:10 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:33:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, michal.simek@xilinx.com,
        Jisheng.Zhang@synaptics.com, olof@lixom.net, dinguyen@kernel.org,
        amit.kucheria@linaro.org, stefan.popa@analog.com, dmurphy@ti.com,
        marcus.folkesson@gmail.com, tmaimon77@gmail.com,
        ricardo@ribalda.com, xc-racer2@live.ca, contact@artur-rojek.eu,
        geert@linux-m68k.org, smohanad@codeaurora.org,
        charles-antoine.couret@essensium.com, stefan@agner.ch,
        max.krummenacher@toradex.com, lee.jones@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <20190426193309.GA9084@bogus>
References: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
 <1555943870-15353-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555943870-15353-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:07:48PM +0530, Manish Narani wrote:
> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 183 +++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> new file mode 100644
> index 0000000..cacb6d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> @@ -0,0 +1,183 @@
> +Xilinx AMS controller
> +`````````````````````
> +The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
> +that can be used to sample external voltages and monitor on-die operating
> +conditions, such as temperature and supply voltage levels.
> +The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
> +PS (Processing System) SYSMON.
> +All designs should have AMS registers, but PS and PL are optional. The
> +AMS controller can work with only PS, only PL and both PS and PL
> +configurations. Please specify registers according to your design. Devicetree
> +should always have AMS module property. Providing PS & PL module is optional.
> +
> +Required properties:
> +	- compatible: Should be "xlnx,zynqmp-ams"
> +	- reg: Should specify AMS register space
> +	- interrupts: Interrupt number for the AMS control interface
> +	- interrupt-names: Interrupt name, must be "ams-irq"
> +	- clocks: Should contain a clock specifier for the device
> +	- ranges: keep the property empty to map child address space
> +	          (for PS and/or PL) nodes 1:1 onto the parent address
> +	          space

empty is not what you've done in the example. Non-empty is preferred.

> +
> +	AMS sub-nodes:
> +		- ams-ps : Used as PS-SYSMON node
> +		- ams-pl : Used as PL-SYSMON node
> +
> +
> +
> +AMS PS-SYSMON
> +`````````````
> +PS (Processing System) SYSMON is memory mapped to PS. This block has built-in
> +alarm generation logic that is used to interrupt the processor based on
> +condition set.
> +
> +Required properties:
> +	- compatible: Should be "xlnx,zynqmp-ams-ps"
> +	- reg: Register space for PS-SYSMON
> +
> +
> +
> +AMS PL-SYSMON
> +`````````````
> +PL-SYSMON is capable of monitoring off chip voltage and temperature. PL-SYSMON
> +block has DRP, JTAG and I2C interface to enable monitoring from external master.
> +Out of this interface currently only DRP is supported. This block has alarm
> +generation logic that is used to interrupt the processor based on condition set.
> +
> +Required properties:
> +	- compatible: Should be "xlnx,zynqmp-ams-pl"
> +	- reg: Register space for PL-SYSMON
> +
> +PL-SYSMON optional sub-nodes:
> +	- xlnx,ext-channels: List of external channels that are connected to the
> +	                     AMS PL module.

Why not just get rid of this and move 'channel' nodes up a level?

> +
> +	  The child nodes of PL-SYSMON represent the external channels which are
> +	  connected to this Module. If the property is not present
> +	  no external channels will be assumed to be connected.
> +
> +	  Each child node represents one channel and has the following
> +	  properties:
> +
> +	Required properties:
> +		* reg: Pair of pins the channel is connected to. This value is
> +		       same as Channel Number for particular channel.
> +
> +		    'reg' value		Channel Name
> +		    -----------		------------
> +			30		VP/VN
> +			31		VUSER0
> +			32		VUSER1
> +			33		VUSER3
> +			34		VUSER4
> +			35		VAUXP[0]/VAUXN[0]
> +			36		VAUXP[1]/VAUXN[1]
> +			...
> +			50		VAUXP[15]/VAUXN[15]
> +
> +		Each channel number should only be used at most once. For
> +		more details on channels, refer to the table given at the end.
> +
> +	Optional properties:
> +		* xlnx,bipolar: If set the channel is used in bipolar
> +		  mode.

I think we have a standard property for this now.

> +
> +
> +Example:
> +	xilinx_ams: ams@ffa50000 {
> +		compatible = "xlnx,zynqmp-ams";
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 56 4>;
> +		interrupt-names = "ams-irq";
> +		reg = <0x0 0xffa50000 0x0 0x800>;
> +		reg-names = "ams-base";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#io-channel-cells = <1>;
> +		ranges = <0 0 0xffa50800 0x800>;
> +
> +		ams_ps: ams-ps@0,0 {

unit address should be '0'

> +			compatible = "xlnx,zynqmp-ams-ps";
> +			reg = <0 0x400>;
> +		};
> +
> +		ams_pl: ams-pl@1,0 {

unit address should be '400'

> +			compatible = "xlnx,zynqmp-ams-pl";
> +			reg = <0x400 0x400>;
> +			xlnx,ext-channels {

Needs #address-cells and #size-cells. dtc should complain here.

> +				channel@30 {
> +					reg = <30>;
> +					xlnx,bipolar;
> +				};
> +				channel@31 {
> +					reg = <31>;
> +				};
> +				channel@38 {
> +					reg = <38>;
> +					xlnx,bipolar;
> +				};
> +			};
> +		};
> +	};
> +
> +
> +AMS Channel Details
> +```````````````````
> +Sysmon Block	|Channel|			Details					|Measurement
> +		|Number	|							 	|Type
> +---------------------------------------------------------------------------------------------------------
> +AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
> +		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
> +		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
> +		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
> +		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
> +		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
> +		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
> +---------------------------------------------------------------------------------------------------------
> +PS Sysmon	|7	|LPD temperature measurement.					|Temperature
> +		|8	|FPD temperature measurement (REMOTE).				|Temperature
> +		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
> +		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
> +		|11	|PS Aux voltage reference (supply3).				|Voltage
> +		|12	|DDR I/O VCC voltage measurement.				|Voltage
> +		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
> +		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
> +		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
> +		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
> +		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
> +		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
> +		|19	|VCC_PSADC voltage measurement.					|Voltage
> +---------------------------------------------------------------------------------------------------------
> +PL Sysmon	|20	|PL temperature measurement.					|Temperature
> +		|21	|PL Internal voltage measurement, VCCINT.			|Voltage
> +		|22	|PL Auxiliary voltage measurement, VCCAUX.			|Voltage
> +		|23	|ADC Reference P+ voltage measurement.				|Voltage
> +		|24	|ADC Reference N- voltage measurement.				|Voltage
> +		|25	|PL Block RAM voltage measurement, VCCBRAM.			|Voltage
> +		|26	|LPD Internal voltage measurement, VCC_PSINTLP (supply4).	|Voltage
> +		|27	|FPD Internal voltage measurement, VCC_PSINTFP (supply5).	|Voltage
> +		|28	|PS Auxiliary voltage measurement (supply6).			|Voltage
> +		|29	|PL VCCADC voltage measurement (vccams).			|Voltage
> +		|30	|Differential analog input signal voltage measurment.		|Voltage
> +		|31	|VUser0 voltage measurement (supply7).				|Voltage
> +		|32	|VUser1 voltage measurement (supply8).				|Voltage
> +		|33	|VUser2 voltage measurement (supply9).				|Voltage
> +		|34	|VUser3 voltage measurement (supply10).				|Voltage
> +		|35	|Auxiliary ch 0 voltage measurement (VAux0).			|Voltage
> +		|36	|Auxiliary ch 1 voltage measurement (VAux1).			|Voltage
> +		|37	|Auxiliary ch 2 voltage measurement (VAux2).			|Voltage
> +		|38	|Auxiliary ch 3 voltage measurement (VAux3).			|Voltage
> +		|39	|Auxiliary ch 4 voltage measurement (VAux4).			|Voltage
> +		|40	|Auxiliary ch 5 voltage measurement (VAux5).			|Voltage
> +		|41	|Auxiliary ch 6 voltage measurement (VAux6).			|Voltage
> +		|42	|Auxiliary ch 7 voltage measurement (VAux7).			|Voltage
> +		|43	|Auxiliary ch 8 voltage measurement (VAux8).			|Voltage
> +		|44	|Auxiliary ch 9 voltage measurement (VAux9).			|Voltage
> +		|45	|Auxiliary ch 10 voltage measurement (VAux10).			|Voltage
> +		|46	|Auxiliary ch 11 voltage measurement (VAux11).			|Voltage
> +		|47	|Auxiliary ch 12 voltage measurement (VAux12).			|Voltage
> +		|48	|Auxiliary ch 13 voltage measurement (VAux13).			|Voltage
> +		|49	|Auxiliary ch 14 voltage measurement (VAux14).			|Voltage
> +		|50	|Auxiliary ch 15 voltage measurement (VAux15).			|Voltage
> +---------------------------------------------------------------------------------------------------------
> -- 
> 2.1.1
> 
