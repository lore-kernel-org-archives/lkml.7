Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A7C204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJg/Yu5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfCSIIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:08:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53254 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:08:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2J88Sue021496;
        Tue, 19 Mar 2019 03:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552982908;
        bh=ivxDbPG106JtQ/jx8liGkqiz3Yr36HsPSz4usx2ALFE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJg/Yu5yqmeDRrGpDsmg03ByUC0MrB5GOBuqmLRMd9lizCp5M2f6vOjtVwXXm/TpE
         yFhvRAcHnI4abnqD0WCFa9xlhCQ1zQ9pyzMl2+H6eyGXh1ETPWAZMvUgeO+RfXjeeU
         TJs8+ug0U3wBDA+b1Ll8Z0EhMAgUFil9utN7PZ+0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2J88SGR090335
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 03:08:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 03:08:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 03:08:28 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2J88PO4012619;
        Tue, 19 Mar 2019 03:08:26 -0500
Subject: Re: [PATCH v3 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-3-faiz_abbas@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8261c01f-fd8e-0930-fee5-793b02071542@ti.com>
Date:   Tue, 19 Mar 2019 13:37:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319063533.12171-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faiz,

On 19/03/19 12:05 PM, Faiz Abbas wrote:
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
> 
> Fix this by adding a platform specific callback for sdhci_irq. Mark the
> mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index b1a66ca3821a..765873dff7ca 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,41 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
> +
> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
> +
> +		/*
> +		 * Since we are not resetting data lines during tuning
> +		 * operation, data error or data complete interrupts
> +		 * might still arrive. Mark this request as a failure
> +		 * but still wait for the data interrupt
> +		 */
> +		if (intmask & SDHCI_INT_TIMEOUT)

CMD_ERR_MASK doesn't have SDHCI_INT_TIMEOUT. So this will never be true.

Thanks
Kishon
