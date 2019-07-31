Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD80C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD262208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rilh8BWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfGaQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:35:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35838 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfGaQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:35:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6VGZKlT008471;
        Wed, 31 Jul 2019 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564590920;
        bh=/frXQ4KOaIB5wlfnm3bIFpuw4RJxR6iAeoBpUdEjJNk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rilh8BWbZ/+l5TBDpm11NM07/fO1kW/j9UZbET7VD4xAYd2fm73ZTz/gGdsfy6oeO
         yd2Ps56ie9I7ICEtrMu702nYrxUVhBBDGK5XBKxAc4tUpcIGG2ZCDC/jGNbvPoUC7Q
         mSccOg1j90bPH/QHJiqOP83ij2QHbIzGExCTiYkA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6VGZKqP093095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Jul 2019 11:35:20 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 31
 Jul 2019 11:35:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 31 Jul 2019 11:35:19 -0500
Received: from [10.250.133.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6VGZFVL083599;
        Wed, 31 Jul 2019 11:35:16 -0500
Subject: Re: [PATCH] scsi: ufs: Additional clock initialization in Cadence UFS
To:     Anil Varughese <aniljoy@cadence.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <pedrom.sousa@synopsys.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <rafalc@cadence.com>, <mparab@cadence.com>, <jank@cadence.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190731083614.25926-1-aniljoy@cadence.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <77210067-ee65-4c12-9c7e-2b78260acdef@ti.com>
Date:   Wed, 31 Jul 2019 22:05:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731083614.25926-1-aniljoy@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-Jul-19 2:06 PM, Anil Varughese wrote:
> Configure CDNS_UFS_REG_HCLKDIV in .hce_enable_notify()
> because if UFSHCD resets the controller ip because of
> phy or device related errors then CDNS_UFS_REG_HCLKDIV
> is reset to default value and .setup_clock() is not
> called later in the sequence whereas hce_enable_notify
> will be called everytime controller is reenabled.
>
So, now that CDNS_UFS_REG_HCLKDIV is configured in .hce_enable_notify(),
is it still required to have the same code in .setup_clock() as well?
Isn't setting up CDNS_UFS_REG_HCLKDIV in .hce_enable_notify() alone not
sufficient?

Regards
Vignesh

> Signed-off-by: Anil Varughese <aniljoy@cadence.com>
> ---
>  drivers/scsi/ufs/cdns-pltfrm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
> index 86dbb723f..15ee54d28 100644
> --- a/drivers/scsi/ufs/cdns-pltfrm.c
> +++ b/drivers/scsi/ufs/cdns-pltfrm.c
> @@ -78,6 +78,22 @@ static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
>  	return cdns_ufs_set_hclkdiv(hba);
>  }
>  
> +/**
> + * Called before and after HCE enable bit is set.
> + * @hba: host controller instance
> + * @status: notify stage (pre, post change)
> + *
> + * Return zero for success and non-zero for failure
> + */
> +static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
> +				      enum ufs_notify_change_status status)
> +{
> +	if (status != PRE_CHANGE)
> +		return 0;
> +
> +	return cdns_ufs_set_hclkdiv(hba);
> +}
> +
>  /**
>   * cdns_ufs_init - performs additional ufs initialization
>   * @hba: host controller instance
> @@ -115,12 +131,14 @@ static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
>  static const struct ufs_hba_variant_ops cdns_ufs_pltfm_hba_vops = {
>  	.name = "cdns-ufs-pltfm",
>  	.setup_clocks = cdns_ufs_setup_clocks,
> +	.hce_enable_notify = cdns_ufs_hce_enable_notify,
>  };
>  
>  static const struct ufs_hba_variant_ops cdns_ufs_m31_16nm_pltfm_hba_vops = {
>  	.name = "cdns-ufs-pltfm",
>  	.init = cdns_ufs_init,
>  	.setup_clocks = cdns_ufs_setup_clocks,
> +	.hce_enable_notify = cdns_ufs_hce_enable_notify,
>  	.phy_initialization = cdns_ufs_m31_16nm_phy_initialization,
>  };
>  
> 
