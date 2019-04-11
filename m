Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9395C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E66E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDKOyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:54:21 -0400
Received: from muru.com ([72.249.23.125]:45304 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfDKOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:54:21 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0CDF7810D;
        Thu, 11 Apr 2019 14:54:34 +0000 (UTC)
Date:   Thu, 11 Apr 2019 07:54:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v6 04/12] firmware: ti_sci: Add RM mapping table for am654
Message-ID: <20190411145416.GP2839@atomide.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410041358.16809-5-lokeshvutla@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Lokesh Vutla <lokeshvutla@ti.com> [190410 04:15]:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> index b56a02c10ae6..6f0cd31c1520 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> @@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
>  
>  Required properties:
>  -------------------
> -- compatible: should be "ti,k2g-sci"
> +- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
> +		should be "ti,am654-sci" for for TI AM654 SoC
>  - mbox-names:
>  	"rx" - Mailbox corresponding to receive path
>  	"tx" - Mailbox corresponding to transmit path
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index d303f5a14da9..88e461498def 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2297,10 +2297,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>  	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
>  	.max_msgs = 20,
>  	.max_msg_size = 64,
> +	.rm_type_map = NULL,
> +};
> +
> +static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
> +	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
> +	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
> +	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
> +	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
> +	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
> +	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
> +	{.dev_id = 0, .type = 0x000}, /* end of table */
> +};
> +
> +/* Description for AM654 */
> +static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
> +	.default_host_id = 12,
> +	/* Conservative duration */
> +	.max_rx_timeout_ms = 10000,
> +	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
> +	.max_msgs = 20,
> +	.max_msg_size = 60,
> +	.rm_type_map = ti_sci_am654_rm_type_map,
>  };
>  
>  static const struct of_device_id ti_sci_of_match[] = {
>  	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
> +	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, ti_sci_of_match);

Great, this approach with mapping table in the driver based on
the compatible looks good to me and avoids stuffing the IDs
into device tree:

Acked-by: Tony Lindgren <tony@atomide.com>
