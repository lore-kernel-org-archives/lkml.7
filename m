Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18E420850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfDJKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:11:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:38468 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfDJKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:11:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 03:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="160367842"
Received: from mylly.fi.intel.com (HELO [10.237.72.159]) ([10.237.72.159])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2019 03:11:48 -0700
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
 <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
Date:   Wed, 10 Apr 2019 13:11:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 12:47 PM, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of:
> 
> - mode (slave device or master controller)
> - transfer mode (DMA or GPIO)
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
> 
> v1:	- first version
> v2:	- remove warning message "no DMA channels available, using PIO"
> 	- add "slave device"/"master controller" indication message
> 
>   drivers/spi/spi-pxa2xx.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..b9e04e2 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1696,7 +1696,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   	if (platform_info->enable_dma) {
>   		status = pxa2xx_spi_dma_setup(drv_data);
>   		if (status) {
> -			dev_warn(dev, "no DMA channels available, using PIO\n");
>   			platform_info->enable_dma = false;
>   		} else {
>   			controller->can_dma = pxa2xx_spi_can_dma;
> @@ -1818,6 +1817,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   
> +	dev_info(dev, "PXA2xx SPI %s (%s mode)\n",
> +		platform_info->is_slave ? "slave device" : "master controller",
> +		platform_info->enable_dma ? "DMA" : "PIO");
> +

"slave device" is ambiguous. Please use "controller" with both, i.e. 
"PXA2xx SPI %s controller (%s mode)\n", ... ? "slave" : "master", ...

With that changed you may add:

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
