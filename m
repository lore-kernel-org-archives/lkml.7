Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF9FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35121479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EyiQUBfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfJ2M0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:26:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34220 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfJ2M0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:26:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TCQQMv063478;
        Tue, 29 Oct 2019 07:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572351987;
        bh=KcKoz19cXM5HLBkQayGtrDbv0pk6Rspdk0DQiHTWR5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EyiQUBfatKmd5vuIiIUsUJ/HcuDqnqr2e1CpE+Y41LAlefq5XG9EVQQjaZWYKZ2dn
         BxxHyBw6NYgPdK5bW8yGMbDiGcxOD365pkR7zU2A4arJB9xWJSyfSBVIJQQ47x3bXv
         F+ao2qL9PvhgAFSDkmfhCfSfCSk2/BnIIcdh3alI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TCQQNV017567;
        Tue, 29 Oct 2019 07:26:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 07:26:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 07:26:26 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TCQOn7020114;
        Tue, 29 Oct 2019 07:26:24 -0500
Subject: Re: [PATCH] usb: cdns3: gadget: reset EP_CLAIMED flag while unloading
To:     Sanket Parmar <sparmar@cadence.com>, <gregkh@linuxfoundation.org>,
        <felipe.balbi@linux.intel.com>
CC:     <pawell@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <peter.chen@nxp.com>, <nsekhar@ti.com>
References: <20191029122441.5816-1-sparmar@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d7f94cd4-774c-5281-4437-1a160d196bb2@ti.com>
Date:   Tue, 29 Oct 2019 14:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029122441.5816-1-sparmar@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2019 14:24, Sanket Parmar wrote:
> EP_CLAIMED flag is used to track the claimed endpoints. While unloading the
> module, Reset EP_CLAIMED flag for all enabled endpoints. So that it can be
> reused.
> 
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

> ---
> Hi Greg/Felipe,
> 
> This can be used for -rc as it is bug fix.
> 
> Regards,
> Sanket
> 
>   drivers/usb/cdns3/gadget.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 9050b380ab83..2fb78322ed3c 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2381,6 +2381,8 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>   		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>   		readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
>   					  !(val & EP_CMD_EPRST), 1, 100);
> +
> +		priv_ep->flags &= ~EP_CLAIMED;
>   	}
>   
>   	/* disable interrupt for device */
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
