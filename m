Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24F1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33D621903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752292;
	bh=5avZoldc/VBWuRfMH3d1vTyehdbIwFRq6i5kyyDhAaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TE5eNBYJNMAzBBvFmn9icYF2aZdQL7QpTwxEGIh3cSfExZRAjV4mvbyiDXXQUJ7AF
	 2L1fmLQ8UPFvzogrAY2AU6IxduTw4n75OHfkxNQD2fo5QBRGA4Sl4L82PxrVUMvsbL
	 RPUV79P+KQ+9nn3HeHD4MXeMMdNKzNUotCYE4zFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCPQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPQEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:04:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2146521900;
        Sat, 16 Mar 2019 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752289;
        bh=5avZoldc/VBWuRfMH3d1vTyehdbIwFRq6i5kyyDhAaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBYdRYXzQvVORXfaw0odMpB8+8jxy1ApWcPzecawPGZs6VMqFsqGHczdQCsIXQjyc
         91l9iCz8FXCCPB9ptB6MVLZUdxK5a2a1JPRBRGSGPvscJD6wdR09PLlJWdRvAxvo2f
         MfEYoTtSJO2hBsNmSsXB1GfhpbL9zA0nF1fOiu/4=
Date:   Sat, 16 Mar 2019 16:04:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: adis16480: Document
 external clock
Message-ID: <20190316160443.4252ae30@archlinux>
In-Reply-To: <1552297597-26640-1-git-send-email-stefan.popa@analog.com>
References: <1552297597-26640-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 11:46:37 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Add documentation for optional use of external clock. All devices
> supported by this driver can work with an external clock in sync mode.
> Another mode, called Pulse Per Second (PPS) is supported only by adis1649x
> devices. The mode is selected by using the "clock-names" property.
> 
> The pin which is used as external clock input is selected by using a
> custom optional property called "adi,ext-clk-pin". If this field is left
> empty, DIO2 is assigned as default external clock input pin.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
This seems standard enough, but if Rob or anyone else wants to comment
I won't be pushing this out as non-rebaseing for a few more days at least.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Mentioned that both "clocks" and "clock-names" fields should be left
> 	  empty for internal clock to be used.
> 
>  .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> index 39ab016..ed7783f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> @@ -34,6 +34,39 @@ Optional properties:
>  	signal.
>  - reset-gpios: must be the device tree identifier of the RESET pin. As the line
>  	is active low, it should be marked GPIO_ACTIVE_LOW.
> +- clocks: phandle to the external clock. Should be set according to
> +	"clock-names".
> +	If this field is left empty together with the "clock-names" field, then
> +	the internal clock is used.
> +- clock-names: The name of the external clock to be used. Valid values are:
> +	* sync: In sync mode, the internal clock is disabled and the frequency
> +		of the external clock signal establishes therate of data
> +		collection and processing. See Fig 14 and 15 in the datasheet.
> +		The clock-frequency must be:
> +		* 3000 to 4500 Hz for adis1649x devices.
> +		* 700 to 2400 Hz for adis1648x devices.
> +	* pps: In Pulse Per Second (PPS) Mode, the rate of data collection and
> +	       production is equal to the product of the external clock
> +	       frequency and the scale factor in the SYNC_SCALE register, see
> +	       Table 154 in the datasheet.
> +	       The clock-frequency must be:
> +	       * 1 to 128 Hz for adis1649x devices.
> +	       * This mode is not supported by adis1648x devices.
> +	If this field is left empty together with the "clocks" field, then the
> +	internal clock is used.
> +- adi,ext-clk-pin: The DIOx line to be used as an external clock input.
> +	Valid values are:
> +	* DIO1
> +	* DIO2
> +	* DIO3
> +	* DIO4
> +	Each DIOx pin supports only one function at a time (data ready line
> +	selection or external clock input). When a single pin has two
> +	two assignments, the enable bit for the lower priority function
> +	automatically resets to zero (disabling the lower priority function).
> +	Data ready has highest priority.
> +	If this field is left empty, DIO2 is assigned as default external clock
> +	input pin.
>  
>  Example:
>  
> @@ -46,4 +79,7 @@ Example:
>  		interrupts = <25 IRQF_TRIGGER_FALLING>;
>  		interrupt-parent = <&gpio>;
>  		interrupt-names = "DIO2";
> +		clocks = <&adis16495_sync>;
> +		clock-names = "sync";
> +		adi,ext-clk-pin = "DIO1";
>  	};

