Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A3D20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xfVML/Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbfHFOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:07:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55572 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:07:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x76E7hXW127613;
        Tue, 6 Aug 2019 09:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565100463;
        bh=9YtLjEZEadsz4KozTsMZV1AwvV6y2GZFO/F76/NxOT0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xfVML/Paw5tmeELiNpO0KHNOaVe9i8KBpyIcgVeISCQbqllotcfyRcgymsa2szCxW
         K9ath2sKcY4lG12mB/LmK/zGF+FWWJzZSchVBNTvktqfbewyEZuJ7z8rwTsB4ag1Ya
         x774B5HBpIuIBy0TVdOokSb7Eo95sgERErOuKAOw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x76E7hvw077090
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Aug 2019 09:07:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 09:07:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 6 Aug 2019 09:07:43 -0500
Received: from [137.167.41.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x76E7frI020451;
        Tue, 6 Aug 2019 09:07:41 -0500
Subject: Re: [PATCH] phy: ti: am654-serdes: fix an use-after-free in
 serdes_am654_clk_register()
To:     Wen Yang <wen.yang99@zte.com.cn>, <linux-kernel@vger.kernel.org>
CC:     <xue.zhihong@zte.com.cn>, <wang.yi59@zte.com.cn>,
        <cheng.shengyu@zte.com.cn>, Kishon Vijay Abraham I <kishon@ti.com>
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
 <1562566745-7447-4-git-send-email-wen.yang99@zte.com.cn>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <2eec3583-4f89-189c-4a08-57b5acc2272b@ti.com>
Date:   Tue, 6 Aug 2019 17:07:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562566745-7447-4-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2019 09:19, Wen Yang wrote:
> The regmap_node variable is still being used in the syscon_node_to_regmap()
> call after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: 71e2f5c5c224 ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Roger Quadros <rogerq@ti.com>

> ---
>  drivers/phy/ti/phy-am654-serdes.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> index f8edd08..f14f1f0 100644
> --- a/drivers/phy/ti/phy-am654-serdes.c
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -405,6 +405,7 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
>  	const __be32 *addr;
>  	unsigned int reg;
>  	struct clk *clk;
> +	int ret = 0;
>  
>  	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>  	if (!mux)
> @@ -413,34 +414,40 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
>  	init = &mux->clk_data;
>  
>  	regmap_node = of_parse_phandle(node, "ti,serdes-clk", 0);
> -	of_node_put(regmap_node);
>  	if (!regmap_node) {
>  		dev_err(dev, "Fail to get serdes-clk node\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_put_node;
>  	}
>  
>  	regmap = syscon_node_to_regmap(regmap_node->parent);
>  	if (IS_ERR(regmap)) {
>  		dev_err(dev, "Fail to get Syscon regmap\n");
> -		return PTR_ERR(regmap);
> +		ret = PTR_ERR(regmap);
> +		goto out_put_node;
>  	}
>  
>  	num_parents = of_clk_get_parent_count(node);
>  	if (num_parents < 2) {
>  		dev_err(dev, "SERDES clock must have parents\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_put_node;
>  	}
>  
>  	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents),
>  				    GFP_KERNEL);
> -	if (!parent_names)
> -		return -ENOMEM;
> +	if (!parent_names) {
> +		ret = -ENOMEM;
> +		goto out_put_node;
> +	}
>  
>  	of_clk_parent_fill(node, parent_names, num_parents);
>  
>  	addr = of_get_address(regmap_node, 0, NULL, NULL);
> -	if (!addr)
> -		return -EINVAL;
> +	if (!addr) {
> +		ret = -EINVAL;
> +		goto out_put_node;
> +	}
>  
>  	reg = be32_to_cpu(*addr);
>  
> @@ -456,12 +463,16 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
>  	mux->hw.init = init;
>  
>  	clk = devm_clk_register(dev, &mux->hw);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto out_put_node;
> +	}
>  
>  	am654_phy->clks[clock_num] = clk;
>  
> -	return 0;
> +out_put_node:
> +	of_node_put(regmap_node);
> +	return ret;
>  }
>  
>  static const struct of_device_id serdes_am654_id_table[] = {
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
