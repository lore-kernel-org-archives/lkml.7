Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDACA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E722064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TWfVdh9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbfJWHhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:37:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35576 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:37:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N7avpg066092;
        Wed, 23 Oct 2019 02:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571816217;
        bh=hSzvgH/fYhxQrqXTcRNYKzrQ6ol4lEhc/mEfX/Z7o7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TWfVdh9B08FIKIucWm0aHQ86YNFmzrbr7KWaQoG2JPvKF62WsJmOttLQya8Qm5SY4
         8MV2erJdQ97AIlZxCbMPqi3RdwT1hE9pSEvMoJDi/yyVSugb90Wj7PBCWrCvqQ2IlN
         jHY/dYeeA1OmYdoBx0vCsuP5tMUqUTY5kOD5FbQo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N7avHi029396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 02:36:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 02:36:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 02:36:55 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N7apZU124421;
        Wed, 23 Oct 2019 02:36:53 -0500
Subject: Re: [PATCH 1/3] phy: cadence: Sierra: add phy_reset hook
To:     Roger Quadros <rogerq@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191022132249.869-1-rogerq@ti.com>
 <20191022132249.869-2-rogerq@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3d261add-8fa8-13b8-a42b-8662fcbe4b23@ti.com>
Date:   Wed, 23 Oct 2019 13:06:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022132249.869-2-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

On 22/10/19 6:52 PM, Roger Quadros wrote:
> This is required if type C driver needs to hold
> global reset on J7ES to perform LN10 swap.

Can you replace "This" with something more specific.

Thanks
Kishon
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index affede8c4368..e6d27bdec22a 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -339,10 +339,20 @@ static int cdns_sierra_phy_off(struct phy *gphy)
>  	return reset_control_assert(ins->lnk_rst);
>  }
>  
> +static int cdns_sierra_phy_reset(struct phy *gphy)
> +{
> +	struct cdns_sierra_phy *sp = dev_get_drvdata(gphy->dev.parent);
> +
> +	reset_control_assert(sp->phy_rst);
> +	reset_control_deassert(sp->phy_rst);
> +	return 0;
> +};
> +
>  static const struct phy_ops ops = {
>  	.init		= cdns_sierra_phy_init,
>  	.power_on	= cdns_sierra_phy_on,
>  	.power_off	= cdns_sierra_phy_off,
> +	.reset		= cdns_sierra_phy_reset,
>  	.owner		= THIS_MODULE,
>  };
>  
> 
