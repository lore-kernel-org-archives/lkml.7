Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3205C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC122084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfDJSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:07:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:33316 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDJSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:07:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="314782771"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 11:07:07 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 877B05807A6;
        Wed, 10 Apr 2019 11:07:07 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 3/4] platform/x86: intel_pmc_ipc: Don't map non-used
 optional resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>, junxiao.chang@intel.com,
        linux-kernel@vger.kernel.org
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
 <20190409112515.84725-3-andriy.shevchenko@linux.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <2e160dfa-9c01-28e1-65e3-029cb29c9c62@linux.intel.com>
Date:   Wed, 10 Apr 2019 11:05:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409112515.84725-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/9/19 4:25 AM, Andy Shevchenko wrote:
> The intel_pmc_ipc driver has a placeholder for all possible resources
> that may have been provided by ACPI. Since there are few optional ones,
> the driver still uses them and binds to wrong ranges in resource tree:
>
>    # grep intel_punit_ipc /proc/iomem
>    00000000-00000000 : intel_punit_ipc
>      00000000-00000000 : intel_punit_ipc
>        00000000-00000000 : intel_punit_ipc
>          00000000-00000000 : intel_punit_ipc
>
> This leads to issues with resource management during inserting and
> removing modules, such as intel_pmc_ipc itself, which can't be inserted
> anymore after first removal.
>
> Count the actual resources provided and supply only them to the child device.
>
> This is a real fix of the commit 8cc7fb4a6523
>
>    ("intel_pmc_ipc: update acpi resource structure for Punit")
>
> that also fixes a symptoms described in the commit 6cc8cbbc8868
>
>    ("platform/x86: intel_punit_ipc: Fix resource ioremap warning")
>
> that is going to be reverted afterwards.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Qipeng Zha <qipeng.zha@intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/platform/x86/intel_pmc_ipc.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 9007aa717586..55037ff258f8 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -131,6 +131,7 @@ static struct intel_pmc_ipc_dev {
>   
>   	/* punit */
>   	struct platform_device *punit_dev;
> +	unsigned int punit_res_count;
>   
>   	/* Telemetry */
>   	resource_size_t telem_pmc_ssram_base;
> @@ -682,7 +683,7 @@ static int ipc_create_punit_device(void)
>   		.name = PUNIT_DEVICE_NAME,
>   		.id = -1,
>   		.res = punit_res_array,
> -		.num_res = ARRAY_SIZE(punit_res_array),
> +		.num_res = ipcdev.punit_res_count,
>   		};
>   
>   	pdev = platform_device_register_full(&pdevinfo);
> @@ -789,7 +790,7 @@ static int ipc_create_pmc_devices(void)
>   
>   static int ipc_plat_get_res(struct platform_device *pdev)
>   {
> -	struct resource *res, *punit_res;
> +	struct resource *res, *punit_res = punit_res_array;
>   	void __iomem *addr;
>   	int size;
>   
> @@ -804,7 +805,8 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>   	ipcdev.acpi_io_size = size;
>   	dev_info(&pdev->dev, "io res: %pR\n", res);
>   
> -	punit_res = punit_res_array;
> +	ipcdev.punit_res_count = 0;
> +
>   	/* This is index 0 to cover BIOS data register */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM,
>   				    PLAT_RESOURCE_BIOS_DATA_INDEX);
> @@ -812,7 +814,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
>   		return -ENXIO;
>   	}
> -	*punit_res = *res;
> +	punit_res[ipcdev.punit_res_count++] = *res;
>   	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
>   
>   	/* This is index 1 to cover BIOS interface register */
> @@ -822,42 +824,38 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
>   		return -ENXIO;
>   	}
> -	*++punit_res = *res;
> +	punit_res[ipcdev.punit_res_count++] = *res;
>   	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
>   
>   	/* This is index 2 to cover ISP data register, optional */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM,
>   				    PLAT_RESOURCE_ISP_DATA_INDEX);
> -	++punit_res;
>   	if (res) {
> -		*punit_res = *res;
> +		punit_res[ipcdev.punit_res_count++] = *res;
>   		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
>   	}
>   
>   	/* This is index 3 to cover ISP interface register, optional */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM,
>   				    PLAT_RESOURCE_ISP_IFACE_INDEX);
> -	++punit_res;
>   	if (res) {
> -		*punit_res = *res;
> +		punit_res[ipcdev.punit_res_count++] = *res;
>   		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
>   	}
>   
>   	/* This is index 4 to cover GTD data register, optional */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM,
>   				    PLAT_RESOURCE_GTD_DATA_INDEX);
> -	++punit_res;
>   	if (res) {
> -		*punit_res = *res;
> +		punit_res[ipcdev.punit_res_count++] = *res;
>   		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
>   	}
>   
>   	/* This is index 5 to cover GTD interface register, optional */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM,
>   				    PLAT_RESOURCE_GTD_IFACE_INDEX);
> -	++punit_res;
>   	if (res) {
> -		*punit_res = *res;
> +		punit_res[ipcdev.punit_res_count++] = *res;
>   		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
>   	}
>   

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

