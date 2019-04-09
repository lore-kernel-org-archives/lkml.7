Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F773C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF32070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDINsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:48:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:21218 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfDINsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:48:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 06:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="149336406"
Received: from mylly.fi.intel.com (HELO [10.237.72.147]) ([10.237.72.147])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2019 06:48:10 -0700
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
Date:   Tue, 9 Apr 2019 16:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/8/19 6:22 PM, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of the transfer mode used (DMA or GPIO).
> 
> This info is useful to individuate the timing when
> the module starts.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>   drivers/spi/spi-pxa2xx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..d449501 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1826,6 +1826,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   		goto out_error_clock_enabled;
>   	}
>   
> +	dev_info(dev, "PXA2xx SPI master controller (%s mode)\n",
> +		 platform_info->enable_dma ? "DMA" : "PIO");
> +
>   	return status;
>   
Would this look better if moved before devm_spi_register_controller() call?

-- 
Jarkko
