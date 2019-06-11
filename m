Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886622089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="leILpbnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406311AbfFKRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:31:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405786AbfFKRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:31:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BHVIg2080041;
        Tue, 11 Jun 2019 12:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560274278;
        bh=1RmvW+AZ9FteTp3r96qSO0PelKVyqe7ED4AJeEZJgPM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=leILpbnQMLwVrBDDDmI4QvLvPFV/ZSJVE1jkZFENg6NcTx20XqpF38FNIjqyXEYN+
         5lJvMtgyyw+s7pWxUn0E9lVdyQ4DL2TqZeN9ilWPFhp8tla3DxuZunYtxOoBNGOh/+
         Tf7N3GzyDgbLO9U2J/8iVfANsSiEi20J/iuzZaT0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BHVIU1078820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 12:31:18 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 12:31:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 12:31:17 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BHVG9t054946;
        Tue, 11 Jun 2019 12:31:16 -0500
Subject: Re: [PATCH v2] firmware: ti_sci: Always request response from
 firmware
To:     "Andrew F. Davis" <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190528155510.373-1-afd@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <034a2922-1ee2-53b8-04ed-a05a66fda066@ti.com>
Date:   Tue, 11 Jun 2019 20:31:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528155510.373-1-afd@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2019 18:55, Andrew F. Davis wrote:
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
> Tested-by: Alejandro Hernandez <ajhernandez@ti.com>
> ---
> 
> Changes from v1:
>   - Rebased on v5.2-rc2

Thanks, queuing up for 5.3.

-Tero

> 
>   drivers/firmware/ti_sci.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index ef93406ace1b..36ce11a67235 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -466,9 +466,9 @@ static int ti_sci_cmd_get_revision(struct ti_sci_info *info)
>   	struct ti_sci_xfer *xfer;
>   	int ret;
>   
> -	/* No need to setup flags since it is expected to respond */
>   	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_VERSION,
> -				   0x0, sizeof(struct ti_sci_msg_hdr),
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(struct ti_sci_msg_hdr),
>   				   sizeof(*rev_info));
>   	if (IS_ERR(xfer)) {
>   		ret = PTR_ERR(xfer);
> @@ -596,9 +596,9 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
>   	info = handle_to_ti_sci_info(handle);
>   	dev = info->dev;
>   
> -	/* Response is expected, so need of any flags */
>   	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_GET_DEVICE_STATE,
> -				   0, sizeof(*req), sizeof(*resp));
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
>   	if (IS_ERR(xfer)) {
>   		ret = PTR_ERR(xfer);
>   		dev_err(dev, "Message alloc failed(%d)\n", ret);
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
