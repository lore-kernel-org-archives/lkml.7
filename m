Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03E527F5E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFCNFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:05:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33496 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFCNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:05:42 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BDC3D285189;
        Mon,  3 Jun 2019 14:05:39 +0100 (BST)
Date:   Mon, 3 Jun 2019 15:05:37 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/12] mtd: rawnand: introduce struct onfi_helper
Message-ID: <20190603150537.3ca5ca8a@collabora.com>
In-Reply-To: <MN2PR08MB5951E35FED92DD502F57B590B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951E35FED92DD502F57B590B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

On Mon, 3 Jun 2019 12:43:28 +0000
"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:

> Create onfi_helper object. This is base to turn ONFI code to generic.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  include/linux/mtd/nand.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 3cdf06cae8b6..645dde4c5797 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -11,6 +11,7 @@
>  #define __LINUX_MTD_NAND_H
>  
>  #include <linux/mtd/mtd.h>
> +#include <linux/mtd/onfi.h>
>  
>  /**
>   * struct nand_memory_organization - Memory organization structure
> @@ -157,6 +158,24 @@ struct nand_ops {
>  	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
>  };
>  
> +/**
> + * struct onfi_helper - ONFI helper functions that should be implemented by
> + * specialized layers (raw NAND, SPI NAND, etc.)
> + * @page: Page number for ONFI parameter table
> + * @check_revision: Check ONFI revision number
> + * @parameter_page_read: Function to read parameter pages
> + * @init_intf_data: Initialize interface specific data or fixups
> + */
> +struct onfi_helper {
> +	u8 page;
> +	int (*check_revision)(struct nand_device *base,
> +			      struct nand_onfi_params *p, int *onfi_version);
> +	int (*parameter_page_read)(struct nand_device *base, u8 page,
> +				   void *buf, unsigned int len);
> +	int (*init_intf_data)(struct nand_device *base,
> +			      struct nand_onfi_params *p);
> +};
> +
>  /**
>   * struct nand_device - NAND device
>   * @mtd: MTD instance attached to the NAND device
> @@ -165,6 +184,7 @@ struct nand_ops {
>   * @rowconv: position to row address converter
>   * @bbt: bad block table info
>   * @ops: NAND operations attached to the NAND device
> + * @helper: Helper functions to detect and initialize ONFI NAND
>   *
>   * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNAND)
>   * should declare their own NAND object embedding a nand_device struct (that's
> @@ -183,6 +203,7 @@ struct nand_device {
>  	struct nand_row_converter rowconv;
>  	struct nand_bbt bbt;
>  	const struct nand_ops *ops;
> +	struct onfi_helper helper;

Sorry, but I don't think that's the right solution. When I said we
should have ONFI code shared I was thinking about the code that parses
the ONFI struct/data to extract nand_memory_organization bits or other
generic info, not something that would abstract how to retrieve the
ONFI param page. Clearly, the generic NAND layer is not supposed to
handle such protocol/low-level details.

Regards,

Boris
