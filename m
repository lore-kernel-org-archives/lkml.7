Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724C20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfDJSH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:07:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:63132 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDJSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:07:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="134641283"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 11:07:27 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 944F35807A6;
        Wed, 10 Apr 2019 11:07:27 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 4/4] platform/x86: intel_punit_ipc: Revert "Fix
 resource ioremap warning"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>, junxiao.chang@intel.com,
        linux-kernel@vger.kernel.org
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
 <20190409112515.84725-4-andriy.shevchenko@linux.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <7a117f9f-9838-0f98-2807-df89f24b6a6f@linux.intel.com>
Date:   Wed, 10 Apr 2019 11:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409112515.84725-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/9/19 4:25 AM, Andy Shevchenko wrote:
> Since we have a proper fix for intel_pmc_ipc driver for resource management,
> get rid of unneeded commit in the intel_punit_ipc driver.
>
> This reverts commit 6cc8cbbc8868033f279b63e98b26b75eaa0006ab.
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/intel_punit_ipc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
> index 79671927f4ef..ab7ae1950867 100644
> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -252,28 +252,28 @@ static int intel_punit_get_bars(struct platform_device *pdev)
>   	 * - GTDRIVER_IPC BASE_IFACE
>   	 */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	if (res && resource_size(res) > 1) {
> +	if (res) {
>   		addr = devm_ioremap_resource(&pdev->dev, res);
>   		if (!IS_ERR(addr))
>   			punit_ipcdev->base[ISPDRIVER_IPC][BASE_DATA] = addr;
>   	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> -	if (res && resource_size(res) > 1) {
> +	if (res) {
>   		addr = devm_ioremap_resource(&pdev->dev, res);
>   		if (!IS_ERR(addr))
>   			punit_ipcdev->base[ISPDRIVER_IPC][BASE_IFACE] = addr;
>   	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -	if (res && resource_size(res) > 1) {
> +	if (res) {
>   		addr = devm_ioremap_resource(&pdev->dev, res);
>   		if (!IS_ERR(addr))
>   			punit_ipcdev->base[GTDRIVER_IPC][BASE_DATA] = addr;
>   	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 5);
> -	if (res && resource_size(res) > 1) {
> +	if (res) {
>   		addr = devm_ioremap_resource(&pdev->dev, res);
>   		if (!IS_ERR(addr))
>   			punit_ipcdev->base[GTDRIVER_IPC][BASE_IFACE] = addr;

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

