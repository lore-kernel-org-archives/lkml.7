Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE102087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfCHPHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:07:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfCHPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:07:44 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E1785792FD8121307E2;
        Fri,  8 Mar 2019 23:07:41 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 8 Mar 2019
 23:07:39 +0800
Date:   Fri, 8 Mar 2019 15:07:28 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Stefan Popa <stefan.popa@analog.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: adis16480: Document external
 clock
Message-ID: <20190308150728.00002ec1@huawei.com>
In-Reply-To: <1551972559-15148-1-git-send-email-stefan.popa@analog.com>
References: <1551972559-15148-1-git-send-email-stefan.popa@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 17:29:19 +0200
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
Trivial comments inline...

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> index 39ab016..9e2fcd4 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> @@ -34,6 +34,37 @@ Optional properties:
>  	signal.
>  - reset-gpios: must be the device tree identifier of the RESET pin. As the line
>  	is active low, it should be marked GPIO_ACTIVE_LOW.
> +- clocks: phandle to the external clock. Should be set according to
> +	"clock-names".
> +	If this field is left empty, the internal clock is used.
> +- clock-names: The name of the external clock to be used. Valid values are:
> +	* sync: In sync mode, the internal clock is disabled and the frequency
> +		of the external clock signal establishes therate of data
the rate
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
> +	If this field is left empty, the internal clock is used.

Should we say that both clocks and clock-names should be empty if that is
the intent?

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
> @@ -46,4 +77,7 @@ Example:
>  		interrupts = <25 IRQF_TRIGGER_FALLING>;
>  		interrupt-parent = <&gpio>;
>  		interrupt-names = "DIO2";
> +		clocks = <&adis16495_sync>;
> +		clock-names = "sync";
> +		adi,ext-clk-pin = "DIO1";
>  	};


