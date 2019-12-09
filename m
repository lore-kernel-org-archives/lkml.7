Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EAC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1127D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLIKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:35:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLIKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:35:12 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6DB5728EDB5;
        Mon,  9 Dec 2019 10:35:09 +0000 (GMT)
Date:   Mon, 9 Dec 2019 11:35:06 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
Message-ID: <20191209113506.41341ed4@collabora.com>
In-Reply-To: <20191127105522.31445-5-miquel.raynal@bootlin.com>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
        <20191127105522.31445-5-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 11:55:22 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Introduce a generic way to define concatenated MTD devices. This may
> be very useful in the case of ie. stacked SPI-NOR. Partitions to
> concatenate are described in an additional property of the partitions
> subnode:
> 
>         flash0 {
>                 partitions {
>                         compatible = "fixed-partitions";
>                         part-concat = <&flash0_part1>, <&flash1_part0>;
> 
> 			part0@0 {
> 				label = "part0_0";
> 				reg = <0x0 0x800000>;
> 			};
> 
> 			flash0_part1: part1@800000 {
> 				label = "part0_1";
> 				reg = <0x800000 0x800000>;

So, flash0_part1 and flash0_part2 will be created even though the user
probably doesn't need them?

> 			};
>                 };
>         };
> 
>         flash1 {
>                 partitions {
>                         compatible = "fixed-partitions";
> 
> 			flash0_part1: part1@0 {
> 				label = "part1_0";
> 				reg = <0x0 0x800000>;
> 			};
> 
> 			part0@800000 {
> 				label = "part1_1";
> 				reg = <0x800000 0x800000>;
> 			};
>                 };
>         };

IMHO this representation is far from intuitive. At first glance it's not
obvious which partitions are linked together and what's the name of the
resulting concatenated part. I definitely prefer the solution where we
have a virtual device describing the concatenation. I also understand
that this goes against the #1 DT rule: "DT only decribes HW blocks, not
how they should be used/configured", but maybe we can find a compromise
here, like moving this description to the /chosen node?

chosen {
	flash-arrays {
		/*
		 * my-flash-array is the MTD name if label is
		 * not present.
		 */
		my-flash-array {
			/*
			 * We could have
			 * compatible = "flash-array";
			 * but we can also do without it.
			 */
			label = "foo";
			flashes = <&flash1 &flash2 ...>;
			partitions {
				/* usual partition description. */
				...
			};
		};
	};
};

Rob, what do you think?

> 
> This is useful for boards where memory range has been extended with
> the use of multiple flash chips as memory banks of a single MTD
> device, with partitions spanning chip borders.
> 
> Suggested-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/Kconfig           |   8 ++
>  drivers/mtd/Makefile          |   1 +
>  drivers/mtd/mtd_virt_concat.c | 240 ++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 drivers/mtd/mtd_virt_concat.c
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 79a8ff542883..3e1e55e7158f 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -276,6 +276,14 @@ config MTD_PARTITIONED_MASTER
>  	  the parent of the partition device be the master device, rather than
>  	  what lies behind the master.
>  
> +config MTD_VIRT_CONCAT
> +	tristate "Virtual concatenated MTD devices"
> +	help
> +	  This driver allows creation of a virtual MTD device, which
> +	  concatenates multiple physical MTD devices into a single one.
> +	  This is useful to create partitions bigger than the underlying
> +	  physical chips by allowing cross-chip boundaries.
> +
>  source "drivers/mtd/chips/Kconfig"
>  
>  source "drivers/mtd/maps/Kconfig"
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 58fc327a5276..c7ee13368a66 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_SSFDC)		+= ssfdc.o
>  obj-$(CONFIG_SM_FTL)		+= sm_ftl.o
>  obj-$(CONFIG_MTD_OOPS)		+= mtdoops.o
>  obj-$(CONFIG_MTD_SWAP)		+= mtdswap.o
> +obj-$(CONFIG_MTD_VIRT_CONCAT)	+= mtd_virt_concat.o

Can we move that code to mtdconcat? After, it's just an extension to
the mtdconcat logic that extract the description from a DT instead of
expecting drivers to create the concatenation on their own.


> +
> +static int __init mtd_virt_concat_init(void)
> +{
> +	struct mtd_virt_concat_node *item;
> +	struct device_node *parts = NULL;
> +	int ret = 0, count;
> +
> +	/* List all the concatenations found in DT */
> +	do {
> +		parts = of_find_node_with_property(parts, CONCAT_PROP);
> +		if (!of_device_is_available(parts))
> +			continue;
> +
> +		count = of_count_phandle_with_args(parts, CONCAT_PROP, NULL);
> +		if (count < MIN_DEV_PER_CONCAT)
> +			continue;
> +
> +		ret = mtd_virt_concat_create_item(parts, count);
> +		if (ret) {
> +			of_node_put(parts);
> +			goto destroy_items;
> +		}
> +	} while (parts);
> +
> +	/* TODO: also parse the cmdline */
> +
> +	/* Create the concatenations */
> +	list_for_each_entry(item, &concat_list, head) {
> +		ret = mtd_virt_concat_create_join(item);
> +		if (ret)
> +			goto destroy_joins;
> +	}
> +
> +	return 0;
> +
> +destroy_joins:
> +	mtd_virt_concat_destroy_joins();
> +destroy_items:
> +	mtd_virt_concat_destroy_items();
> +
> +	return ret;
> +}
> +late_initcall(mtd_virt_concat_init);

Right now the solution assumes all drivers are statically linked. I'm
pretty sure we can support other cases if we use MTD notifiers to be
informed of MTD device is addition/removal.

> +
> +static void __exit mtd_virt_concat_exit(void)
> +{
> +	mtd_virt_concat_destroy_joins();
> +	mtd_virt_concat_destroy_items();
> +}
> +module_exit(mtd_virt_concat_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Bernhard Frauendienst <kernel@nospam.obeliks.de>");
> +MODULE_DESCRIPTION("Virtual concat MTD device driver");

