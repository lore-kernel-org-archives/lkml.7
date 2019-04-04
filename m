Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF59206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfDDJud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:50:33 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:20685 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfDDJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:50:31 -0400
X-IronPort-AV: E=Sophos;i="5.60,308,1549954800"; 
   d="scan'208";a="26741851"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 02:50:30 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Thu, 4 Apr 2019
 02:50:29 -0700
Date:   Thu, 4 Apr 2019 11:49:48 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mojha@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] arm/mach-at91/pm : fix possible object reference leak
Message-ID: <20190404094948.fumw3w53ogtd4bud@M43218.corp.atmel.com>
Mail-Followup-To: Peng Hao <peng.hao2@zte.com.cn>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mojha@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1554214358-113444-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1554214358-113444-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:12:38PM +0800, Peng Hao wrote:
> 
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device. When returning error we should
> call put_device.
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Thanks applied to at91-fixes with:

Fixes: 24a0f5c539f9 ("ARM: at91: pm: Add sama5d2 backup mode")
Cc: <stable@vger.kernel.org> # v4.14+

> ---
>  arch/arm/mach-at91/pm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 51e808a..38511a5 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -591,13 +591,13 @@ static int __init at91_pm_backup_init(void)
>  
>  	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
>  	if (!np)
> -		goto securam_fail;
> +		goto securam_fail_no_ref_dev;
>  
>  	pdev = of_find_device_by_node(np);
>  	of_node_put(np);
>  	if (!pdev) {
>  		pr_warn("%s: failed to find securam device!\n", __func__);
> -		goto securam_fail;
> +		goto securam_fail_no_ref_dev;
>  	}
>  
>  	sram_pool = gen_pool_get(&pdev->dev, NULL);
> @@ -620,6 +620,8 @@ static int __init at91_pm_backup_init(void)
>  	return 0;
>  
>  securam_fail:
> +	put_device(&pdev->dev);
> +securam_fail_no_ref_dev:
>  	iounmap(pm_data.sfrbu);
>  	pm_data.sfrbu = NULL;
>  	return ret;
> -- 
> 1.8.3.1
> 
> 
