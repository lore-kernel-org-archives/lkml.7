Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182222073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDKL4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:56:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:58491 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfDKL4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:56:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 04:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="134858982"
Received: from unknown (HELO [10.237.72.155]) ([10.237.72.155])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2019 04:56:02 -0700
Subject: Re: [PATCH 1/2] spi: pxa2xx: fix SCR (divisor) calculation
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <34b8442a-15ac-dea2-a088-fde8b1966e1e@linux.intel.com>
Date:   Thu, 11 Apr 2019 14:55:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 3:51 PM, Flavio Suligoi wrote:
> Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> that the SSP transmission rate can be greater than the device rate.
> 
> When the division between the SSP clock and the device rate generates
> a reminder, we have to increment by one the divisor.
> In this way the resulting SSP clock will never be greater than the
> device SPI max frequency.
> 
> For example, with:
> 
>   - ssp_clk  = 50 MHz
>   - dev freq = 15 MHz
> 
> without this patch the SSP clock will be greater than 15 MHz:
> 
>   - 25 MHz for PXA25x_SSP and CE4100_SSP
>   - 16,56 MHz for the others
> 
> Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
> so the max rate of the SPI device clock is respected.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>   drivers/spi/spi-pxa2xx.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..c9560a1 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -884,10 +884,15 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
>   
>   	rate = min_t(int, ssp_clk, rate);
>   
> +	/*
> +	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> +	 * that the SSP transmission rate can be greater than the device rate
> +	 */
>   	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
> -		return (ssp_clk / (2 * rate) - 1) & 0xff;
> +		return (ssp_clk / (2 * rate) - 1 +
> +			(ssp_clk % (2 * rate) ? 1 : 0)) & 0xff;
>   	else
> -		return (ssp_clk / rate - 1) & 0xfff;
> +		return (ssp_clk / rate - 1 + (ssp_clk % rate ? 1 : 0)) & 0xfff;
>   }
>   
I think DIV_ROUND_UP() - 1 would also fix this?

I realized we have also another issue here with the low rates. 
Calculated divider will underflow due masking with 0xff or 0xfff when 
the rate is low enough.

Would you want to fix that by setting the ctlr->min_speed_hz so that spi 
core can validate the rate? I'm asking since it goes well together with 
your fix. Maybe one patch setting the min_speed_hz and getting masking 
off from here and then another fixing the rate calculation.

-- 
Jarkko
