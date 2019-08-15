Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19781C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D571821721
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GVp9DHj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfHONCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:02:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35186 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfHONCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:02:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7FD2Uw6103370;
        Thu, 15 Aug 2019 08:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565874150;
        bh=UwmPB+RzcmPBKn40d07imRZP5WOSdf5E1uzaUFQzvb0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=GVp9DHj1naRKitGnBRg8jflX//MmBKnd3wskBinhnzHwkSBjF/IxWdXs7b2n+Y68D
         6UGEIcSI5o5Bela1Lor6c/ptdwQuILpAIQjqoL4+E+cka7rVyYanwIHaALNQ6NSba6
         F0LN/3q7jczHshan56INxTr6vl/pf6UpLfIgi+uY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7FD2U8N048525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Aug 2019 08:02:30 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 15
 Aug 2019 08:02:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 15 Aug 2019 08:02:30 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7FD2SEq026308;
        Thu, 15 Aug 2019 08:02:29 -0500
Subject: Re: [PATCH v4] bus: ti-sysc: Change return types of functions
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>
References: <20190813114256.GR52127@atomide.com>
 <20190815054647.32750-1-nishkadg.linux@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <cb5483e4-ddec-497c-6355-56d557ad6ca1@ti.com>
Date:   Thu, 15 Aug 2019 16:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815054647.32750-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2019 08:46, Nishka Dasgupta wrote:
> Change return type of functions sysc_check_one_child() and
> sysc_check_children() from int to void as neither ever returns an error.
> Modify call sites of both functions accordingly.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
> Changes in v4:
> - Merge into a single patch the two patches for sysc_check_one_child()
>   and sysc_check_children().
> Changes in v3:
> - Add patch for sysc_check_children().
> - Remove return statement in sysc_check_one_child().
> - Remove braces at call site.
> Changes in v2:
> - Remove error variable entirely.
> - Change return type of sysc_check_one_child().
> 
>  drivers/bus/ti-sysc.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index e6deabd8305d..a2eae8f36ef8 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -615,8 +615,8 @@ static void sysc_check_quirk_stdout(struct sysc *ddata,
>   * node but children have "ti,hwmods". These belong to the interconnect
>   * target node and are managed by this driver.
>   */
> -static int sysc_check_one_child(struct sysc *ddata,
> -				struct device_node *np)
> +static void sysc_check_one_child(struct sysc *ddata,
> +				 struct device_node *np)
>  {
>  	const char *name;
>  
> @@ -626,22 +626,14 @@ static int sysc_check_one_child(struct sysc *ddata,
>  
>  	sysc_check_quirk_stdout(ddata, np);
>  	sysc_parse_dts_quirks(ddata, np, true);
> -
> -	return 0;
>  }
>  
> -static int sysc_check_children(struct sysc *ddata)
> +static void sysc_check_children(struct sysc *ddata)
>  {
>  	struct device_node *child;
> -	int error;
> -
> -	for_each_child_of_node(ddata->dev->of_node, child) {
> -		error = sysc_check_one_child(ddata, child);
> -		if (error)
> -			return error;
> -	}
>  
> -	return 0;
> +	for_each_child_of_node(ddata->dev->of_node, child)
> +		sysc_check_one_child(ddata, child);
>  }
>  
>  /*
> @@ -794,9 +786,7 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
>  	if (error)
>  		return error;
>  
> -	error = sysc_check_children(ddata);
> -	if (error)
> -		return error;
> +	sysc_check_children(ddata);
>  
>  	error = sysc_parse_registers(ddata);
>  	if (error)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
