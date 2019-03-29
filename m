Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01342082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfC2KCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:02:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:40783 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfC2KCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:02:39 -0400
X-IronPort-AV: E=Sophos;i="5.60,284,1549954800"; 
   d="scan'208";a="28855835"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 29 Mar 2019 03:02:38 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Fri, 29 Mar 2019
 03:02:37 -0700
Date:   Fri, 29 Mar 2019 11:02:02 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH]  arm/mach-at91/pm : fix possible object reference leak
Message-ID: <20190329100202.rupu5xo2prxlcafa@M43218.corp.atmel.com>
Mail-Followup-To: Peng Hao <peng.hao2@zte.com.cn>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1550069746-85671-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1550069746-85671-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 13, 2019 at 10:55:46PM +0800, Peng Hao wrote:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device. When returning error we should
> call put_device.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mach-at91/pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 51e808a..70fadb7 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -621,6 +621,7 @@ static int __init at91_pm_backup_init(void)
>  
>  securam_fail:
>  	iounmap(pm_data.sfrbu);
> +	put_device(&pdev->dev);

Fixed in this way, in some cases (as there are goto securam_fail before calling
of_find_device_by_node), we may decrement a reference which has not been
incremented. Is it safe?

Regards

Ludovic

>  	pm_data.sfrbu = NULL;
>  	return ret;
>  }
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
