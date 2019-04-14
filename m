Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDDCC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B45206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDNIgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 04:36:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfDNIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 04:36:13 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B2304263959;
        Sun, 14 Apr 2019 09:36:11 +0100 (BST)
Date:   Sun, 14 Apr 2019 10:36:08 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, bbrezillon@kernel.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, computersforpeace@gmail.com,
        dwmw2@infradead.org
Subject: Re: [PATCH 2/2] mtd: nandsim: switch to exec_op interface
Message-ID: <20190414103608.257bd8b9@collabora.com>
In-Reply-To: <20190413084052.15416-2-richard@nod.at>
References: <20190413084052.15416-1-richard@nod.at>
        <20190413084052.15416-2-richard@nod.at>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 10:40:52 +0200
Richard Weinberger <richard@nod.at> wrote:

> Stop using the legacy interface.

Thanks for converting the nandsim driver.

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/nand/raw/nandsim.c | 78 ++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 3d80e2d23b6e..33c369f9a607 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -299,6 +299,7 @@ union ns_mem {
>   */
>  struct nandsim {
>  	struct nand_chip chip;
> +	struct nand_controller base;
>  	struct mtd_partition partitions[CONFIG_NANDSIM_MAX_PARTS];
>  	unsigned int nbparts;
>  
> @@ -645,9 +646,6 @@ static int __init init_nandsim(struct mtd_info *mtd)
>  		return -EIO;
>  	}
>  
> -	/* Force mtd to not do delays */
> -	chip->legacy.chip_delay = 0;
> -
>  	/* Initialize the NAND flash parameters */
>  	ns->busw = chip->options & NAND_BUSWIDTH_16 ? 16 : 8;
>  	ns->geom.totsz    = mtd->size;
> @@ -2077,24 +2075,6 @@ static void ns_nand_write_byte(struct nand_chip *chip, u_char byte)
>  	return;
>  }
>  
> -static void ns_hwcontrol(struct nand_chip *chip, int cmd, unsigned int bitmask)
> -{
> -	struct nandsim *ns = nand_get_controller_data(chip);
> -
> -	ns->lines.cle = bitmask & NAND_CLE ? 1 : 0;
> -	ns->lines.ale = bitmask & NAND_ALE ? 1 : 0;
> -	ns->lines.ce = bitmask & NAND_NCE ? 1 : 0;
> -
> -	if (cmd != NAND_CMD_NONE)
> -		ns_nand_write_byte(chip, cmd);
> -}
> -
> -static int ns_device_ready(struct nand_chip *chip)
> -{
> -	NS_DBG("device_ready\n");
> -	return 1;
> -}
> -
>  static void ns_nand_write_buf(struct nand_chip *chip, const u_char *buf,
>  			      int len)
>  {
> @@ -2146,7 +2126,7 @@ static void ns_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
>  		int i;
>  
>  		for (i = 0; i < len; i++)
> -			buf[i] = chip->legacy.read_byte(chip);
> +			buf[i] = ns_nand_read_byte(chip);
>  
>  		return;
>  	}
> @@ -2169,6 +2149,46 @@ static void ns_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
>  	return;
>  }
>  
> +static int ns_exec_op(struct nand_chip *chip, const struct nand_operation *op,
> +		      bool check_only)
> +{
> +	int i;
> +	unsigned int op_id;
> +	const struct nand_op_instr *instr = NULL;
> +	struct nandsim *ns = nand_get_controller_data(chip);
> +
> +	ns->lines.ce = chip->cur_cs == -1 ? 0 : 1;

You can assume ns->lines.ce is always 1, since there's no point
executing a NAND operation if the CS pin is not asserted. BTW, in case
you ever consider supporting multi-CS chips, the CS line to select is
passed through op->cs (you should not use nand->cur_cs).

The rest of the patch looks good. Once this tiny detail is addressed you
can add

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> +
> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
> +		instr = &op->instrs[op_id];
> +		ns->lines.cle = 0;
> +		ns->lines.ale = 0;
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			ns->lines.cle = 1;
> +			ns_nand_write_byte(chip, instr->ctx.cmd.opcode);
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			ns->lines.ale = 1;
> +			for (i = 0; i < instr->ctx.addr.naddrs; i++)
> +				ns_nand_write_byte(chip, instr->ctx.addr.addrs[i]);
> +			break;
> +		case NAND_OP_DATA_IN_INSTR:
> +			ns_nand_read_buf(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
> +			break;
> +		case NAND_OP_DATA_OUT_INSTR:
> +			ns_nand_write_buf(chip, instr->ctx.data.buf.out, instr->ctx.data.len);
> +			break;
> +		case NAND_OP_WAITRDY_INSTR:
> +			/* we are always ready */
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int ns_attach_chip(struct nand_chip *chip)
>  {
>  	unsigned int eccsteps, eccbytes;
> @@ -2209,6 +2229,7 @@ static int ns_attach_chip(struct nand_chip *chip)
>  
>  static const struct nand_controller_ops ns_controller_ops = {
>  	.attach_chip = ns_attach_chip,
> +	.exec_op = ns_exec_op,
>  };
>  
>  /*
> @@ -2234,14 +2255,6 @@ static int __init ns_init_module(void)
>  	nsmtd       = nand_to_mtd(chip);
>  	nand_set_controller_data(chip, (void *)ns);
>  
> -	/*
> -	 * Register simulator's callbacks.
> -	 */
> -	chip->legacy.cmd_ctrl	 = ns_hwcontrol;
> -	chip->legacy.read_byte  = ns_nand_read_byte;
> -	chip->legacy.dev_ready  = ns_device_ready;
> -	chip->legacy.write_buf  = ns_nand_write_buf;
> -	chip->legacy.read_buf   = ns_nand_read_buf;
>  	chip->ecc.mode   = NAND_ECC_SOFT;
>  	chip->ecc.algo   = NAND_ECC_HAMMING;
>  	/* The NAND_SKIP_BBTSCAN option is necessary for 'overridesize' */
> @@ -2292,7 +2305,10 @@ static int __init ns_init_module(void)
>  	if ((retval = parse_gravepages()) != 0)
>  		goto error;
>  
> -	chip->legacy.dummy_controller.ops = &ns_controller_ops;
> +	nand_controller_init(&ns->base);
> +	ns->base.ops = &ns_controller_ops;
> +	chip->controller = &ns->base;
> +
>  	retval = nand_scan(chip, 1);
>  	if (retval) {
>  		NS_ERR("Could not scan NAND Simulator device\n");

