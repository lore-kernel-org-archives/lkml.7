Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD82C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561912087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y60GKzjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbfHBMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:47:46 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48186 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfHBMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:47:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x72Clhkb013670;
        Fri, 2 Aug 2019 07:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564750063;
        bh=SuUzlKhtHBayh83JtSydpVMlTi0S6ttWT130+rq4NmU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y60GKzjN1O2YhyQ2s/FO6azlAmsjHt8oxXRMeo4WZZE3kLFbUNyqMCaC0E9Jjup6T
         UOYO89Kb/pGzR9iKUTRqTAeg1GXj5FkYuQYQ7uGyd4xUtp/VZ8b9nmvtOh5wQuGh8a
         EPF9vofOSyyaCwMoo9Ra1O888tKOfwGPTgYb3FdU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x72ClhGr036771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Aug 2019 07:47:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 2 Aug
 2019 07:47:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 2 Aug 2019 07:47:42 -0500
Received: from [172.24.145.64] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x72CleaQ096146;
        Fri, 2 Aug 2019 07:47:41 -0500
Subject: Re: [PATCH 8/9] phy: ti: am654-serdes: Don't reference clk_init_data
 after registration
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-9-sboyd@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <85f4dd66-0e99-7ecf-5b18-ad1715520ceb@ti.com>
Date:   Fri, 2 Aug 2019 18:15:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731193517.237136-9-sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/19 1:05 AM, Stephen Boyd wrote:
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Please ack so I can take this through clk tree

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>  drivers/phy/ti/phy-am654-serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> index f8edd0840fa2..398a8c9b675a 100644
> --- a/drivers/phy/ti/phy-am654-serdes.c
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -335,6 +335,7 @@ static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  {
>  	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
>  	struct regmap *regmap = mux->regmap;
> +	const char *name = clk_hw_get_name(hw);
>  	unsigned int reg = mux->reg;
>  	int clk_id = mux->clk_id;
>  	int parents[SERDES_NUM_CLOCKS];
> @@ -374,8 +375,7 @@ static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  		 * This can never happen, unless we missed
>  		 * a valid combination in serdes_am654_mux_table.
>  		 */
> -		WARN(1, "Failed to find the parent of %s clock\n",
> -		     hw->init->name);
> +		WARN(1, "Failed to find the parent of %s clock\n", name);
>  		return -EINVAL;
>  	}
>  
> 
