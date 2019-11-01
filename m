Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F6ACA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23915208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RzYkjOhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfKAIXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:23:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60778 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbfKAIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:23:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA18NUb6014331;
        Fri, 1 Nov 2019 03:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572596610;
        bh=9mT8EACeZWCGyrUJOHbpL28LGZaahlCj2GAuPGYtZfg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RzYkjOhSN33pe+hDy6de5+dBOaQlkTgNEiP8f+714LFv6Th4+r5fmcB5xBBh8qXy/
         O220bn4FknARVvrIe0W00wQyhnqsl6GoUqzL0AWgi2M/ebPfzryzyt1lKDCsq4LXjk
         lUYLP2MZ91EUBXQPHUzwGns0sYjAQrZQ5W5RRvkM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA18NUZF097534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Nov 2019 03:23:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 1 Nov
 2019 03:23:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 1 Nov 2019 03:23:16 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA18NRsG088943;
        Fri, 1 Nov 2019 03:23:28 -0500
Subject: Re: [PATCH] firmware: ti_sci: rm: Add support for tx_tdtype parameter
 for tx channel
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
References: <20191025084715.25098-1-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <b2231065-ae16-8870-03ac-a435f190ee9f@ti.com>
Date:   Fri, 1 Nov 2019 10:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025084715.25098-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2019 11:47, Peter Ujfalusi wrote:
> The system controller's resource manager have support for configuring the
> TDTYPE of TCHAN_CFG register on j721e.
> With this parameter the teardown completion can be controlled:
> TDTYPE == 0: Return without waiting for peer to complete the teardown
> TDTYPE == 1: Wait for peer to complete the teardown
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
> Hi,
> 
> I know it is kind of getting late for 5.5, but can you consider this small
> addition so I can add the support for it in the initial DMA driver?
> 
> Thanks and regards,
> Peter
> 
>   drivers/firmware/ti_sci.c              | 1 +
>   drivers/firmware/ti_sci.h              | 7 +++++++
>   include/linux/soc/ti/ti_sci_protocol.h | 2 ++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 4126be9e3216..f13e4a96f3b7 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2412,6 +2412,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>   	req->fdepth = params->fdepth;
>   	req->tx_sched_priority = params->tx_sched_priority;
>   	req->tx_burst_size = params->tx_burst_size;
> +	req->tx_tdtype = params->tx_tdtype;
>   
>   	ret = ti_sci_do_xfer(info, xfer);
>   	if (ret) {
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index f0d068c03944..255327171dae 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -910,6 +910,7 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
>    *   12 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_credit_count
>    *   13 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::fdepth
>    *   14 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_burst_size
> + *   15 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_tdtype
>    *
>    * @nav_id: SoC device ID of Navigator Subsystem where tx channel is located
>    *
> @@ -973,6 +974,11 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
>    *
>    * @tx_burst_size: UDMAP transmit channel burst size configuration to be
>    * programmed into the tx_burst_size field of the TCHAN_TCFG register.
> + *
> + * @tx_tdtype: UDMAP transmit channel teardown type configuration to be
> + * programmed into the tdtype field of the TCHAN_TCFG register:
> + * 0 - Return immediately
> + * 1 - Wait for completion message from remote peer
>    */
>   struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
>   	struct ti_sci_msg_hdr hdr;
> @@ -994,6 +1000,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
>   	u16 fdepth;
>   	u8 tx_sched_priority;
>   	u8 tx_burst_size;
> +	u8 tx_tdtype;
>   } __packed;
>   
>   /**
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 9531ec823298..f3aed0b91564 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -342,6 +342,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID        BIT(11)
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_CREDIT_COUNT_VALID      BIT(12)
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FDEPTH_VALID            BIT(13)
> +#define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID            BIT(15)
>   	u16 nav_id;
>   	u16 index;
>   	u8 tx_pause_on_err;
> @@ -359,6 +360,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
>   	u16 fdepth;
>   	u8 tx_sched_priority;
>   	u8 tx_burst_size;
> +	u8 tx_tdtype;
>   };
>   
>   /**
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
