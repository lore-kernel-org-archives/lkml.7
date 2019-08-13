Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D618320679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ron2hE1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHMLNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:13:38 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44858 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHMLNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:13:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7DBDYfl053573;
        Tue, 13 Aug 2019 06:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565694814;
        bh=1GsITDseAPR0gCuvqJHeFa6pH0KOtdE1ogOqtvofk5s=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Ron2hE1FnMOph5izMsLtsPYNaKR25qDzirUg9zc0go3RBW7E1OjgkGyN1oylh0pFk
         oqObePvblTaw4EjGIFO2jFQPq+tbcI+yZ0ax8MNBOKW60rGaxDMLX1vTwxXZXgRUaT
         1vv1tAv8KtILms7ta/az/8D2wNX3Ku+d0NM+Ha4w=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7DBDYeZ010642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 06:13:34 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 06:13:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 06:13:34 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7DBDXhx104539;
        Tue, 13 Aug 2019 06:13:33 -0500
Subject: Re: [PATCH v3 2/2] bus: ti-sysc: sysc_check_children(): Change return
 type to void
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
 <20190813075553.2354-1-nishkadg.linux@gmail.com>
 <20190813075553.2354-2-nishkadg.linux@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <dd6f47c8-13bc-f20e-90ce-208bd10c3bc0@ti.com>
Date:   Tue, 13 Aug 2019 14:13:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813075553.2354-2-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/08/2019 10:55, Nishka Dasgupta wrote:
> Change return type of function sysc_check_children() from int to void as
> it always returns 0. Remove its return statement as well.
> At call site, remove the variable that was used to store the return
> value, as well as the check on the return value.
> 

You don't need to describe each and everything as it is obvious
from code. How about?
"Change return type of sysc_check_children() to "void"
as it never returns error"

Should both patches can be squashed into one patch?

> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> - This is a new patch; labelled v3 only because it is in the same series
>   as the previous patch.
> 
>  drivers/bus/ti-sysc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index 9c6d3e121d37..a2eae8f36ef8 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -628,14 +628,12 @@ static void sysc_check_one_child(struct sysc *ddata,
>  	sysc_parse_dts_quirks(ddata, np, true);
>  }
>  
> -static int sysc_check_children(struct sysc *ddata)
> +static void sysc_check_children(struct sysc *ddata)
>  {
>  	struct device_node *child;
>  
>  	for_each_child_of_node(ddata->dev->of_node, child)
>  		sysc_check_one_child(ddata, child);
> -
> -	return 0;
>  }
>  
>  /*
> @@ -788,9 +786,7 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
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
