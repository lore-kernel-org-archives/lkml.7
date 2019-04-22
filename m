Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B5C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1A320881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555928092;
	bh=2NDX7a/oF3+wR3ClQPwRoNDywtT9vPrseyn0WaUMBNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IjjAkshnOuf/R7ikaiFAbUw67I+vM8gnzT2DyKPDHkkPrPYeOVmFrZDPjL74cEo6I
	 kTe1CZQkPBxx9C5m/WG37vNqHZXZ8WuCo71JmlFZ7koO/wJt6du26tZ3cfDoIWE1dM
	 8A914sHkGzXTVieNV1fu5K1VYSjcJ5q6pao92m+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfDVKOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:14:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D991E206A3;
        Mon, 22 Apr 2019 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555928090;
        bh=2NDX7a/oF3+wR3ClQPwRoNDywtT9vPrseyn0WaUMBNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCoieSXtx0F+k1B5dC08md6B13zWersEtpm2JUXIs3vidCrLdx/nCBcSS+xTShfsk
         vp2HX83fo+0WUSVPFt/S6WRzGs/vNBYC0HxIR9NYEDMkG7vUO0crWcs12ujWbWOz9i
         5leUsoKaQc9/63zLM/bZkEOEyhALZHyFBGQ0aw0E=
Date:   Mon, 22 Apr 2019 11:14:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <benjamin.gaignard@linaro.org>, <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH] iio: trigger: stm32-timer: fix build issue when
 disabled
Message-ID: <20190422111443.276572ff@archlinux>
In-Reply-To: <1555321642-482-1-git-send-email-fabrice.gasnier@st.com>
References: <1555321642-482-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 11:47:22 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> This fixes a build issue when CONFIG_IIO_STM32_TIMER_TRIGGER isn't set but
> used in stm32-dfsdm-adc driver (e.g. CONFIG_STM32_DFSDM_ADC is set):
> ERROR: "is_stm32_timer_trigger" [drivers/iio/adc/stm32-dfsdm-adc.ko]
> undefined!
> 
> There are two possible options to fix this issue:
> - select IIO_STM32_TIMER_TRIGGER along with CONFIG_STM32_DFSDM_ADC.
>   This is what's being done currently for CONFIG_STM32_ADC.
> - stub "is_stm32_timer_trigger" function
> 
> Choice is made to stub this function as suggested in [1]. This is also
> inspired by similar "is_stm32_lptim_trigger" function (see [2]) in
> include/linux/iio/timer/stm32-lptim-trigger.h
> 
> [1]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1977377.html
> [2] https://lkml.org/lkml/2017/9/10/124
> 
> Fixes: 11646e81d775 ("iio: adc: stm32-dfsdm: add support for buffer modes")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fix-suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hmm. That feels a bit more complex than I was anticipating but fair enough,
it seems to cover the combinations.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to have another poke at it.

Thanks,

Jonathan

> ---
>  include/linux/iio/timer/stm32-timer-trigger.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
> index d68add8..cbb7c7a 100644
> --- a/include/linux/iio/timer/stm32-timer-trigger.h
> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
> @@ -73,6 +73,15 @@
>  
>  #define TIM17_OC1	"tim17_oc1"
>  
> +#if IS_REACHABLE(CONFIG_IIO_STM32_TIMER_TRIGGER)
>  bool is_stm32_timer_trigger(struct iio_trigger *trig);
> -
> +#else
> +static inline bool is_stm32_timer_trigger(struct iio_trigger *trig)
> +{
> +#if IS_ENABLED(CONFIG_IIO_STM32_TIMER_TRIGGER)
> +	pr_warn_once("stm32-timer-trigger not linked in\n");
> +#endif
> +	return false;
> +}
> +#endif
>  #endif

