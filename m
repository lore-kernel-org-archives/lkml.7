Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCRO3C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:29:02 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:56286 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCRO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:29:02 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 65C3115060; Mon, 18 Mar 2019 14:29:00 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Bin Liu <b-liu@ti.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: sunxi: propagate devicetree node to glue pdev
References: <20190228112031.8122-1-mans@mansr.com>
Date:   Mon, 18 Mar 2019 14:29:00 +0000
In-Reply-To: <20190228112031.8122-1-mans@mansr.com> (Mans Rullgard's message
        of "Thu, 28 Feb 2019 11:20:31 +0000")
Message-ID: <yw1xwokw1ck3.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

> In order for devicetree nodes to be correctly associated with attached
> devices, the controller node needs to be propagated to the glue device.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> This depends on 2c1ea6abde88 ("platform: set of_node in
> platform_device_register_full()") which is currently winding its way
> through the staging trees.

That patch is now in next.

> ---
>  drivers/usb/musb/sunxi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index 832a41f9ee7d..a72665fbf111 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -781,6 +781,8 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>  	pinfo.name	 = "musb-hdrc";
>  	pinfo.id	= PLATFORM_DEVID_AUTO;
>  	pinfo.parent	= &pdev->dev;
> +	pinfo.fwnode	= of_fwnode_handle(pdev->dev.of_node);
> +	pinfo.of_node_reused = true;
>  	pinfo.res	= pdev->resource;
>  	pinfo.num_res	= pdev->num_resources;
>  	pinfo.data	= &pdata;
> -- 
> 2.20.1
>

-- 
Måns Rullgård
