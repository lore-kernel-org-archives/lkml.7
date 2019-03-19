Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FB20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NStvJdfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCSH71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:59:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57944 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:59:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2J7xLpf006846;
        Tue, 19 Mar 2019 02:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552982361;
        bh=eUQ23bQSfVBY26o04Gc0aqlKevkr8rc9nOUmAUrXLQY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NStvJdfD2/rJj4Uv847A5K/OcTh37kXgqk3wyLNLA65LI5cQh3zYqUv3pBhavvQKw
         vw3qT/kjh/2nvwIfbYIIF0thdPonHCowZ1kKMVuhU0HsgjniDmSV3Rrq2MNU9mTu5R
         5GpvaGzqIf8OpeZ1gMbDsrU3Ye0SG7WQYQBe+cwk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2J7xL1u078588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 02:59:21 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 02:59:20 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 02:59:21 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2J7xIZe020095;
        Tue, 19 Mar 2019 02:59:19 -0500
Subject: Re: [PATCH v3 1/2] mmc: sdhci: Make sdhci_send_command() public
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-2-faiz_abbas@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
Date:   Tue, 19 Mar 2019 13:28:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319063533.12171-2-faiz_abbas@ti.com>
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
> Make sdhci_send_command() public so that it can be called from platform
> drivers.

This should be sdhci_finish_command here and also in subject
How about using "mmc: sdhci: Export sdhci_finish_command()"?

Thanks
Kishon
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8141ff9be03..76d36e13a011 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1445,7 +1445,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_finish_command(struct sdhci_host *host)
> +void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> @@ -1495,6 +1495,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  			sdhci_finish_mrq(host, cmd->mrq);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_command);
>  
>  static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 01002cba1359..49b133babf47 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -798,5 +798,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_finish_command(struct sdhci_host *host);
>  
>  #endif /* __SDHCI_HW_H */
> 
