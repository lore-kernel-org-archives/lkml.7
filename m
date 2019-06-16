Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095CBC31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71ED2183F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560697973;
	bh=XYxeE6m6iVjdndgF4Gpsy/J7kmBHdL5js7nG2GNIyZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QLYkXeHefKpQ/zxFvOg8elFjVozagNsvanFsCS3xG6s//cGgRTZ3/xw5XKC8s0Q0o
	 60KSuhZov20//1ErQL2nGpTfK6Pr0UpbSkskDI2deR1O1ljDMT225S7aOD16Jln7By
	 kRu2JkZLslXAQkx8cn0FcCCOXQ//H3xKUOw8yfkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfFPPMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfFPPMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:12:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5532084B;
        Sun, 16 Jun 2019 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560697971;
        bh=XYxeE6m6iVjdndgF4Gpsy/J7kmBHdL5js7nG2GNIyZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aerEuJ3rVFrEPfO49k463mid3L5f8cFSHgrCjjsakURRDaaAI0y1DwgI+mFwbsyPf
         WfF8K4nRyeLJz6Ra1+OSmTm/wXzqeuFozHaVudTxyy2eoUTrLn3TlTl/i9VyYbwUtT
         pfFctaleQ0BF0vMjakzUyq/Zyz/Tli9jMAsgbEP0=
Date:   Sun, 16 Jun 2019 16:12:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: stm32: add analog switches
 supply control
Message-ID: <20190616161245.38168d94@archlinux>
In-Reply-To: <1560324276-681-2-git-send-email-fabrice.gasnier@st.com>
References: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
        <1560324276-681-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 09:24:34 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
> switches which have reduced performances when their supply is below 2.7V
> (vdda by default).
> 
> Add documentation for optional vdda-supply & vdd-supply that can be used
> to supply analog circuitry (controlled by syscfg bits).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 8346bcb..3af48b9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -46,6 +46,12 @@ Required properties:
>  Optional properties:
>  - A pinctrl state named "default" for each ADC channel may be defined to set
>    inX ADC pins in mode of operation for analog input on external pin.
> +- vdda-supply: Phandle to the vdda input voltage. It can be used to supply ADC
> +  analog inputs switches on stm32h7 and stm32mp1.

input switches

> +- vdd-supply: Phandle to the vdd input voltage. It can be used to supply ADC
> +  analog inputs switches on stm32mp1.
> +- st,syscfg: Phandle to system configuration controller. It can be used to
> +  control the analog circuitry on stm32h7 and stm32mp1.
>  
>  Contents of a stm32 adc child node:
>  -----------------------------------

