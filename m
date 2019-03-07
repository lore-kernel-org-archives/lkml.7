Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E12C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2720643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCGP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:26:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:18782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGP05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:26:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 07:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121835106"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 07:26:54 -0800
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
To:     xiao jin <jin.xiao@intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Cc:     bo <bo.he@intel.com>
References: <20190307072424.18820-1-jin.xiao@intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
Date:   Thu, 7 Mar 2019 17:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307072424.18820-1-jin.xiao@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is this also related to the regression with d5898e19c0d7 ("spi: pxa2xx: 
Use core message processing loop") you have found or another issue?

Comments below.

On 3/7/19 9:24 AM, xiao jin wrote:
> The spi-pxa2xx can't read and write data correctly on our board.
> The pxa_ssp_type is LPSS_BXT_SSP in our case.
> 
> With more debug we find that it's related to restart the SPP
> during pxa2xx_spi_transfer_one().
> 
> In the normal case the spi_transfer_one_message() calls spi-pxa2xx
> cs_assert before transferring one message. After completing the
> transfer it calls spi-pxa2xx cs_deassert. The spi-pxa2xx works
> well.
> 
> But in some other case pxa2xx_spi_unprepare_transfer() is called
> that clears SSCR0_SSE bit before the next transfer. In the next
> transfer the spi-pxa2xx driver will restart the SSP as the SSE
> bit is cleared. The cs_assert before the SSP restart can't ensure
> spi-pxa2xx work well.
> 
> The patch is to do cs again if spi-pxa2xx restar the SSP during
> pxa2xx_spi_transfer_one()
> 
Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer() 
is called always when there is no more messages pending and the spi core 
should have deasserted the CS already?

More below.

> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Signed-off-by: he, bo <bo.he@intel.com>
> ---
>   drivers/spi/spi-pxa2xx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 14f4ea59caff..1a2ea46858d9 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -928,6 +928,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>   	u32 cr1;
>   	int err;
>   	int dma_mapped;
> +	bool need_cs_change = false;
>   
>   	/* Check if we can DMA this transfer */
>   	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
> @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>   	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
>   	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
>   	    != (cr1 & change_mask)) {
> +		/* It needs to deassert the chip selection
> +		 * firstly before restart the SPP */
> +		need_cs_change = true;
> +		cs_deassert(spi);
> +

I think code comes here at the beginning of each transfer so will be hit 
multiple times before pxa2xx_spi_unprepare_transfer() if SPI message 
consists of multiple transfers.

This makes me wondering if the device driver setting up the "struct 
spi_transfer" is maybe missing the cs_change flag set for transfers 
before last one in case HW needs CS toggling between transfers? For 
instance what following drivers are doing with the cs_change flag:

drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()

-- 
Jarkko
