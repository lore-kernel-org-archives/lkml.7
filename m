Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CF82173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfC1Icd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:32:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC1Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:32:33 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B136927FAE5;
        Thu, 28 Mar 2019 08:32:31 +0000 (GMT)
Date:   Thu, 28 Mar 2019 09:32:28 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: maps: physmap: Store gpio_values correctly
Message-ID: <20190328093228.5ab79718@collabora.com>
In-Reply-To: <20190328040217.1895-2-chris.packham@alliedtelesis.co.nz>
References: <20190328040217.1895-1-chris.packham@alliedtelesis.co.nz>
        <20190328040217.1895-2-chris.packham@alliedtelesis.co.nz>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 17:02:15 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> When the gpio-addr-flash.c driver was merged with physmap-core.c the
> code to store the current gpio_values was lost. This meant that once a
> gpio was asserted it was never de-asserted. Fix this by storing the
> current offset in gpio_values like the old driver used to.
> 
> Fixes: commit ba32ce95cbd9 ("mtd: maps: Merge gpio-addr-flash.c into physmap-core.c")

You miss

Cc: <stable@vger.kernel.org>

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/maps/physmap-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
> index d9a3e4bebe5d..21b556afc305 100644
> --- a/drivers/mtd/maps/physmap-core.c
> +++ b/drivers/mtd/maps/physmap-core.c
> @@ -132,6 +132,8 @@ static void physmap_set_addr_gpios(struct physmap_flash_info *info,
>  
>  		gpiod_set_value(info->gpios->desc[i], !!(BIT(i) & ofs));
>  	}
> +
> +	info->gpio_values = ofs;
>  }
>  
>  #define win_mask(order)		(BIT(order) - 1)

