Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D39C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1831A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577102334;
	bh=QyuoZyIhNs4xmOxwsNxxEhCCg7Gu9hD6h7ZqKd7+bQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w9t9J0KXLv8ILE1ZsSIhucZte4Tmr/xXXEicYuvLgwMQ4t7NBMxo0ekvzi6aiGPxE
	 te5DbKIMOPA6TOBgGG4iHRpoWjSWf53VNuyPNZEh2u1qBXVwJWAcCrip9V6TQjBhQK
	 6zehSgymH1dz5RolvY/p9dLFsMJT1XR/IimFMhnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWL6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:58:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F3E20709;
        Mon, 23 Dec 2019 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577102332;
        bh=QyuoZyIhNs4xmOxwsNxxEhCCg7Gu9hD6h7ZqKd7+bQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OYvEt+yz5urzWr1WlgfkJ4G2hB4fZdPGZ/uPQp5TtdxwDerjLj47mX9ylrJ49Qo/j
         HRYwoqj30Xd68PMERLUotZFsxD7O+uwplwlj0IsjbuwF+SROc6LUpXwt/lcepFujDO
         1QkGz5jX+nZyK8+2dTCa7JcaJuQtyIYuZqLCWdEg=
Date:   Mon, 23 Dec 2019 11:58:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 02/10] dt-bindings: iio: adc: at91-sama5d2: add
 rtc-trigger optional property
Message-ID: <20191223115847.244c1406@archlinux>
In-Reply-To: <1576686157-11939-3-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-3-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 16:23:58 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add property to connect RTC-type trigger to the ADC block.
> The ADC is connected internally with a line to the RTC block.
> The RTC can provide a trigger signal to the ADC to start conversions.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
As discussed, might want to just be the rtc handle rather than a new
trigger one.

> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 4a3c1d4..1980f0e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -23,6 +23,9 @@ Optional properties:
>    See ../../dma/dma.txt for details.
>    - #io-channel-cells: in case consumer drivers are attached, this must be 1.
>    See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details.
> +  - atmel,rtc-trigger: The ADC IP block can be triggered by the RTC block
> +inside the SoC. This property is a phandle to a node that provides a
> +trigger device, if the ADC block supports it.

Do we want to be more specific on devices that do support it?
Maybe it's enough of a complex mess that we don't.

>  
>  Properties for consumer drivers:
>    - Consumer drivers can be connected to this producer device, as specified
> @@ -44,6 +47,7 @@ adc: adc@fc030000 {
>  	vddana-supply = <&vdd_3v3_lp_reg>;
>  	vref-supply = <&vdd_3v3_lp_reg>;
>  	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> +	atmel,rtc-trigger = <&rtc_adc_trigger>;
>  	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
>  	dma-names = "rx";
>  	#io-channel-cells = <1>;

