Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC6020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iPXPkUY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfD2Olv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:41:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2Olu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:41:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3TEfgDS005819;
        Mon, 29 Apr 2019 09:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556548902;
        bh=12cspNAIBmeFC9boxgWSm3Qi/ryg0xgp/h3FhKZhj1M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iPXPkUY5paXv1lRHkyy7RtN72NTaGb2WFeVD0vgT0V8NmMwZc1CBwcc2MzSi0y5Lz
         wqx1jVG7jfLXScQYyA9fnQjJMljzos7vypJHjjBP7fuGvecAGKHoPDsqUcI2ItgRwT
         Z0V3crTqbz9yzAwyrPKoYuVmM5yq7g/TfpvsDERE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3TEfgdh090310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Apr 2019 09:41:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 29
 Apr 2019 09:41:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 29 Apr 2019 09:41:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3TEffom082202;
        Mon, 29 Apr 2019 09:41:41 -0500
Date:   Mon, 29 Apr 2019 09:40:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: Always request response from firmware
Message-ID: <20190429144049.5dmudk63b3xftmr2@kahuna>
References: <20190429131533.25122-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190429131533.25122-1-afd@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:15-20190429, Andrew F. Davis wrote:
> TI-SCI firmware will only respond to messages when the
> TI_SCI_FLAG_REQ_ACK_ON_PROCESSED flag is set. Most messages already do
> this, set this for the ones that do not.
> 
> This will be enforced in future firmware that better match the TI-SCI
> specifications, this patch will not break users of existing firmware.
> 
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>

yep, the patch allows backward and forward compatibility with TISCI
compliant firmware.

Thanks for doing the patch.

> Tested-by: Alejandro Hernandez <ajhernandez@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 3fbbb61012c4..3f202c63b9a6 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -448,9 +448,9 @@ static int ti_sci_cmd_get_revision(struct ti_sci_info *info)
>  	struct ti_sci_xfer *xfer;
>  	int ret;
>  
> -	/* No need to setup flags since it is expected to respond */
>  	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_VERSION,
> -				   0x0, sizeof(struct ti_sci_msg_hdr),
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(struct ti_sci_msg_hdr),
>  				   sizeof(*rev_info));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> @@ -578,9 +578,9 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
>  	info = handle_to_ti_sci_info(handle);
>  	dev = info->dev;
>  
> -	/* Response is expected, so need of any flags */
>  	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_GET_DEVICE_STATE,
> -				   0, sizeof(*req), sizeof(*resp));
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
>  		dev_err(dev, "Message alloc failed(%d)\n", ret);
> -- 
> 2.21.0
> 

-- 
Regards,
Nishanth Menon
