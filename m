Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21884C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA8020857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yGnhFVFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDAPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:43:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49448 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfDAPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:43:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31FhXkd096405;
        Mon, 1 Apr 2019 10:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554133413;
        bh=rytgBPIQQhnYKnd1jlb2WOCdTasvmI3/5RejPyun8ds=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yGnhFVFp8V6VHc2tKU+o9E67HBJr6OuXHbmto2PNKo0HurEm6VDXtrXSpQSmQVHLQ
         fRQl1dIdHB/5dkhjvmiDqoZs5iT6yHoMGoGYrGIjMbBpQ27isH7AMaDT7+um3oj6p2
         R+FMy8X2T5ejn7TSdXY1+8EoiCF5vxfcHgZkd61Q=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31FhXmN069612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 10:43:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 10:43:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 10:43:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31FhXdB076337;
        Mon, 1 Apr 2019 10:43:33 -0500
Date:   Mon, 1 Apr 2019 10:43:33 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Silence error about blacklisting hubs if
 !CONFIG_USB
Message-ID: <20190401154333.GJ25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190319135146.25995-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190319135146.25995-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:51:46PM +0100, Paul Cercueil wrote:
> Some drivers, like jz4740-musb, don't depend on CONFIG_USB.

CONFIG_USB_OTG_BLACKLIST_HUB is about hub, so should it depend on
CONFIG_USB instead in drivers/usb/core/Kconfig?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/musb/musb_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b7d56272f9d1..9f5a4819a744 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1497,10 +1497,11 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
>  	} else {
>  		musb->is_multipoint = 0;
>  		type = "";
> -#ifndef	CONFIG_USB_OTG_BLACKLIST_HUB
> -		pr_err("%s: kernel must blacklist external hubs\n",
> -		       musb_driver_name);
> -#endif
> +		if (IS_ENABLED(CONFIG_USB) &&
> +		    !IS_ENABLED(CONFIG_USB_OTG_BLACKLIST_HUB)) {
> +			pr_err("%s: kernel must blacklist external hubs\n",
> +			       musb_driver_name);
> +		}
>  	}
>  
>  	/* log release info */

Regards,
-Bin.
