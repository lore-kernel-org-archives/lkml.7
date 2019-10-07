Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F49C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE14D20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nK2ICAb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJGIkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:40:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53748 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:40:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x978eJEp039869;
        Mon, 7 Oct 2019 03:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570437619;
        bh=iRVKW68mcO3r9tC2SUOrwePSzioiFn8z6va76+E22Cc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nK2ICAb4uGYUn7+BmSD7i/RZtBGDiegDzR3ikhSGZhOMeKkzHFWupRVWznhJRDP62
         Ie/xIRgbihkco9/TYEbeBz4/H+1cHrl/kOcm9xQ7gLfMh409LOAuuWReCLjvywHkTj
         IbzDg5aDYvXvtnEVP4fcFLapctZL/PcZO/ZLIZf8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x978eJYl046528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 03:40:19 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 03:40:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 03:40:16 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x978eGEj024937;
        Mon, 7 Oct 2019 03:40:16 -0500
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <640b6cd2-5d10-2dbd-c74d-009747790633@ti.com>
Date:   Mon, 7 Oct 2019 11:40:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570430355-26118-1-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2019 09:39, Pawel Laszczak wrote:
> Patch fixes issue with Halt Endnpoint Test observed during using g_zero
> driver as DUT. Bug occurred only on some testing board.
> 
> Endpoint can defer transition to Halted state if endpoint has pending
> requests.
> Patch add additional condition that allows to return correct endpoint
> status during Get Endpoint Status request even if the halting endpoint
> is in progress.
> 
> Reported-by: Rahul Kumar <kurahul@cadence.com>
> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

Tested-by: Roger Quadros <rogerq@ti.com>


cheers,
-roger

> ---
>   drivers/usb/cdns3/ep0.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index 44f652e8b5a2..10ae03430f34 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
>   static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>   				    struct usb_ctrlrequest *ctrl)
>   {
> +	struct cdns3_endpoint *priv_ep;
>   	__le16 *response_pkt;
>   	u16 usb_status = 0;
>   	u32 recip;
> +	u8 index;
>   
>   	recip = ctrl->bRequestType & USB_RECIP_MASK;
>   
> @@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>   	case USB_RECIP_INTERFACE:
>   		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>   	case USB_RECIP_ENDPOINT:
> -		/* check if endpoint is stalled */
> +		index = cdns3_ep_addr_to_index(ctrl->wIndex);
> +		priv_ep = priv_dev->eps[index];
> +
> +		/* check if endpoint is stalled or stall is pending */
>   		cdns3_select_ep(priv_dev, ctrl->wIndex);
> -		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
> +		    (priv_ep->flags & EP_STALL_PENDING))
>   			usb_status =  BIT(USB_ENDPOINT_HALT);
>   		break;
>   	default:
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
