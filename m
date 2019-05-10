Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D8C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FF2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vhUOfmR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEJFRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:17:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44590 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfEJFRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:17:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4A5H9Qt119282;
        Fri, 10 May 2019 00:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557465429;
        bh=XzeXpROI5a8Ib+B15hXUIuq68tFBHpy9RE1urDk4Fxg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vhUOfmR1SQLwC9e6IwOLQ+fb8Ct4UBCcW1lSNW/qtTDpGjzv1EJvWwRp0cXuRpCwS
         UY+nSBep7erXQvPjr9fcENZ5EVVgbOXw5dq5qgaWQo8dJpjstBBzngF2MTUVi5Pibv
         q9VTlYPxMSVE370+DDdw0Pynb9XdO326pyFv+71I=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4A5H9AW003501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 May 2019 00:17:09 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 10
 May 2019 00:17:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 10 May 2019 00:17:08 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4A5H6jM032326;
        Fri, 10 May 2019 00:17:06 -0500
Subject: Re: [PATCH] arm64: arch_k3: Fix kconfig dependency warning
To:     YueHaibing <yuehaibing@huawei.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <marc.zyngier@arm.com>, <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190510035255.27568-1-yuehaibing@huawei.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <f7c420ec-ee4e-c17e-7650-353002bb81b9@ti.com>
Date:   Fri, 10 May 2019 10:46:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190510035255.27568-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/19 9:22 AM, YueHaibing wrote:
> Fix Kbuild warning when SOC_TI is not set
> 
> WARNING: unmet direct dependencies detected for TI_SCI_INTA_IRQCHIP
>   Depends on [n]: TI_SCI_PROTOCOL [=y] && SOC_TI [=n]
>   Selected by [y]:
>   - ARCH_K3 [=y]
> 
> Fixes: 009669e74813 ("arm64: arch_k3: Enable interrupt controller drivers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for catching it.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 42eca65..9d1292f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -88,6 +88,7 @@ config ARCH_K3
>  	bool "Texas Instruments Inc. K3 multicore SoC architecture"
>  	select PM_GENERIC_DOMAINS if PM
>  	select MAILBOX
> +	select SOC_TI
>  	select TI_MESSAGE_MANAGER
>  	select TI_SCI_PROTOCOL
>  	select TI_SCI_INTR_IRQCHIP
> 
