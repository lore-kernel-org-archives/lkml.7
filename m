Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E726CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66E9208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SZxKxlZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfHHNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:55:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59816 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:55:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x78DtFrf054761;
        Thu, 8 Aug 2019 08:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565272515;
        bh=qGqqTiZ9NV5raXNiacx95UlmfwU1eU9rrbjXz7JfN2Y=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=SZxKxlZTI4/NqKLBK3/fbikDwDTNgySVsc/x89niLP/ZJVcWhv2UrbdNW6ay6Wr89
         Fr5CQDLKbglUoPrSgNl/W2MKXIK+DYObJ3D4iDvQ62oT2Ioo2NSmiX1UA+e+Bml7mI
         5uhTOhiXlD96FWOfkTa1McFakE5nw1OBm3YZECO4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x78DtFWp060185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Aug 2019 08:55:15 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 8 Aug
 2019 08:55:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 8 Aug 2019 08:55:14 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x78DtCbm009329;
        Thu, 8 Aug 2019 08:55:13 -0500
Subject: Re: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
References: <20190808074042.15403-1-nishkadg.linux@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
Date:   Thu, 8 Aug 2019 16:55:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808074042.15403-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishka,

On 08/08/2019 10:40, Nishka Dasgupta wrote:
> In function sysc_check_children, there is an if-statement checking
> whether the value returned by function sysc_check_one_child is non-zero.
> However, sysc_check_one_child always returns 0, and hence this check is
> not needed. Hence remove this if-block.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/bus/ti-sysc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index e6deabd8305d..bc8082ae7cb5 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -637,8 +637,6 @@ static int sysc_check_children(struct sysc *ddata)
>  
>  	for_each_child_of_node(ddata->dev->of_node, child) {
>  		error = sysc_check_one_child(ddata, child);
> -		if (error)
> -			return error;

We cannot assume that sysc_check_one_child() will never return error in the future.
If it can never return an error then why does it have an int return type?

>  	}
>  
>  	return 0;
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
