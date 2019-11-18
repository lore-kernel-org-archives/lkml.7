Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBE3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AECB20722
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qz8ABwXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKRG02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:26:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfKRG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:26:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAI6QL19103464;
        Mon, 18 Nov 2019 00:26:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574058381;
        bh=RjpnW7IJoweCoHZjZTuJ8T6MhKMBuud1ijHfVeBaP98=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Qz8ABwXuGHPQlY4BsmWR08CBQs4xyuvQ9pWTVKE7JqCZmUGbK5gqK3c65qem3InX8
         uG1uc/kBzT13FE9/eGNGmU9VPjpG65RaLUnx7QIncXAqgnj/Bqb5+v4ZpqNkgklSaQ
         pffyqXwpauhTh4Ok5UB3iwsrXNzveCVW99hyJZZY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAI6QL80125054
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 00:26:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 00:26:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 00:26:20 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAI6QILj020162;
        Mon, 18 Nov 2019 00:26:19 -0600
Subject: Re: [PATCH] mmc: sdhci_am654: Add Support for Command Queuing Engine
 to J721E
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
References: <20191115114009.20090-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <28fa7d6a-1067-f898-a2e0-28468092a39c@ti.com>
Date:   Mon, 18 Nov 2019 11:57:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115114009.20090-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/11/19 5:10 PM, Faiz Abbas wrote:
> Add Support for CQHCI (Command Queuing Host Controller Interface)
> for each of the host controllers present in TI's J721E devices.
> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..25f12ef813ff 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
>  	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>  	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select CONFIG_MMC_CQHCI

Oops, this should just be select MMC_CQHCI. Sending v2.

Thanks,
Faiz
