Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AEF206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y+l5C+N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFFIO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:14:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45830 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFFIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:14:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x568EmdQ109788;
        Thu, 6 Jun 2019 03:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559808888;
        bh=9CGWmFPZFkM4haIpdXdnS/PW2KTAvEhGOsht3nl69aM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y+l5C+N4UN7JgoiVx59rl13K3WiR027/sCRxaNhTaB7T9zYa7z/2W5NI0ZsOWYoIc
         7gUcCAVrbcfm9+6fAvSUt2QMEFFt3Oa6wTRyGMtDSBG3DGYBsNSh/XsvkFTj/2l6I/
         l1boUF1Q/ytOH3TdHNrPIR+ZSqSgIrW3oby9FFKk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x568EmfC109386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 03:14:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 03:14:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 03:14:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x568Ejh5008241;
        Thu, 6 Jun 2019 03:14:46 -0500
Subject: Re: [PATCH -next] phy: ti: am654-serdes: Make serdes_am654_xlate()
 static
To:     Yue Haibing <yuehaibing@huawei.com>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <hulkci@huawei.com>
References: <20190418133633.3908-1-yuehaibing@huawei.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <659d9904-fa9a-a03b-b609-0ac053520c9a@ti.com>
Date:   Thu, 6 Jun 2019 11:14:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418133633.3908-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/04/2019 16:36, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/phy/ti/phy-am654-serdes.c:250:12: warning:
>  symbol 'serdes_am654_xlate' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  drivers/phy/ti/phy-am654-serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> index d376920..f8edd08 100644
> --- a/drivers/phy/ti/phy-am654-serdes.c
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -247,8 +247,8 @@ static void serdes_am654_release(struct phy *x)
>  	mux_control_deselect(phy->control);
>  }
>  
> -struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
> -				 *args)
> +static struct phy *serdes_am654_xlate(struct device *dev,
> +				      struct of_phandle_args *args)
>  {
>  	struct serdes_am654 *am654_phy;
>  	struct phy *phy;
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
