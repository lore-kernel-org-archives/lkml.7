Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09135C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CF42082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDLMgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:36:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:10796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLMgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 05:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="135223683"
Received: from mylly.fi.intel.com (HELO [10.237.72.155]) ([10.237.72.155])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2019 05:36:00 -0700
Subject: Re: [PATCH v2] spi: pxa2xx: fix SCR (divisor) calculation
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <729d9db2-de3e-e64c-862d-db8a25775b02@linux.intel.com>
Date:   Fri, 12 Apr 2019 15:35:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 10:32 AM, Flavio Suligoi wrote:
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
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> 
> v2: - simplify the code using "DIV_ROUND_UP"
> v1: - first version
> 
>   drivers/spi/spi-pxa2xx.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..a35fdcb 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -884,10 +884,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
>   
>   	rate = min_t(int, ssp_clk, rate);
>   
> +	/*
> +	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> +	 * that the SSP transmission rate can be greater than the device rate
> +	 */
>   	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
> -		return (ssp_clk / (2 * rate) - 1) & 0xff;
> +		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
>   	else
> -		return (ssp_clk / rate - 1) & 0xfff;
> +		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
>   }
>   
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
