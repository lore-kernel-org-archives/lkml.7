Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B46C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861B22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfGYMhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:37:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbfGYMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:37:49 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C053828AC0F;
        Thu, 25 Jul 2019 13:37:47 +0100 (BST)
Date:   Thu, 25 Jul 2019 14:37:45 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Message-ID: <20190725143745.634efcd6@collabora.com>
In-Reply-To: <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
References: <20190720080023.5279-1-vigneshr@ti.com>
        <20190720080023.5279-2-vigneshr@ti.com>
        <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 11:19:06 +0000
<Tudor.Ambarus@microchip.com> wrote:

> > + */
> > +static int spi_nor_exec_op(struct spi_nor *nor, struct spi_mem_op *op,
> > +			   u64 *addr, void *buf, size_t len)
> > +{
> > +	int ret;
> > +	bool usebouncebuf = false;  
> 
> I don't think we need a bounce buffer for regs. What is the maximum size that we
> read/write regs, SPI_NOR_MAX_CMD_SIZE(8)?
> 
> In spi-nor.c the maximum length that we pass to nor->read_reg()/write_reg() is
> SPI_NOR_MAX_ID_LEN(6).
> 
> I can provide a patch to always use nor->cmd_buf when reading/writing regs so
> you respin the series on top of it, if you feel the same.
> 
> With nor->cmd_buf this function will be reduced to the following:
> 
> static int spi_nor_spimem_xfer_reg(struct spi_nor *nor, struct spi_mem_op *op)
> {
> 	if (!op || (op->data.nbytes && !nor->cmd_buf))
> 		return -EINVAL;
> 
> 	return spi_mem_exec_op(nor->spimem, op);
> }

Well, I don't think that's a good idea. ->cmd_buf is an array in the
middle of the spi_nor struct, which means it won't be aligned on a
cache line and you'll have to be extra careful not to touch the spi_nor
fields when calling spi_mem_exec_op(). Might work, but I wouldn't take
the risk if I were you.

Another option would be to allocate ->cmd_buf with kmalloc() instead of
having it defined as a static array.

> 
> spi_nor_exec_op() always received a NULL addr, let's get rid of it. We won't
> need buf anymore and you can retrieve the length from op->data.nbytes. Now that
> we trimmed the arguments, I think I would get rid of the
> spi_nor_data/nodata_op() wrappers and use spi_nor_spimem_xfer_reg() directly.

I think I added the addr param for a good reason (probably to support
Octo mode cmds that take an address parameter). This being said, I
agree with you, we should just pass everything through the op parameter
(including the address if we ever need to add one).


> > +
> > +/**
> > + * spi_nor_spimem_xfer_data() - helper function to read/write data to
> > + *                              flash's memory region
> > + * @nor:        pointer to 'struct spi_nor'
> > + * @op:         pointer to 'struct spi_mem_op' template for transfer
> > + * @proto:      protocol to be used for transfer
> > + *
> > + * Return: number of bytes transferred on success, -errno otherwise
> > + */
> > +static ssize_t spi_nor_spimem_xfer_data(struct spi_nor *nor,
> > +					struct spi_mem_op *op,
> > +					enum spi_nor_protocol proto)
> > +{
> > +	bool usebouncebuf = false;  
> 
> declare bool at the end to avoid stack padding.

But it breaks the reverse-xmas-tree formatting :-).

> 
> > +	void *rdbuf = NULL;
> > +	const void *buf;  
> 
> you can get rid of rdbuf and buf if you pass buf as argument.

Hm, passing the buffer to send data from/receive data into is already
part of the spi_mem_op definition process (which is done in the caller
of this func) so why bother passing an extra arg to the function.
Note that you had the exact opposite argument for the
spi_nor_spimem_xfer_reg() prototype you suggested above (which I
agree with BTW) :P.

> 
> > +	int ret;
> > +
> > +	/* get transfer protocols. */
> > +	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
> > +	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> > +	op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
> > +
> > +	if (op->data.dir == SPI_MEM_DATA_IN)
> > +		buf = op->data.buf.in;
> > +	else
> > +		buf = op->data.buf.out;
> > +
> > +	if (object_is_on_stack(buf) || !virt_addr_valid(buf))
> > +		usebouncebuf = true;
> > +
> > +	if (usebouncebuf) {
> > +		if (op->data.nbytes > nor->bouncebuf_size)
> > +			op->data.nbytes = nor->bouncebuf_size;
> > +
> > +		if (op->data.dir == SPI_MEM_DATA_IN) {
> > +			rdbuf = op->data.buf.in;
> > +			op->data.buf.in = nor->bouncebuf;
> > +		} else {
> > +			op->data.buf.out = nor->bouncebuf;
> > +			memcpy(nor->bouncebuf, buf,
> > +			       op->data.nbytes);
> > +		}
> > +	}
> > +
> > +	ret = spi_mem_adjust_op_size(nor->spimem, op);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = spi_mem_exec_op(nor->spimem, op);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (usebouncebuf && op->data.dir == SPI_MEM_DATA_IN)
> > +		memcpy(rdbuf, nor->bouncebuf, op->data.nbytes);
> > +
> > +	return op->data.nbytes;
> > +}
> > +
> > +/**
> > + * spi_nor_spimem_read_data() - read data from flash's memory region via
> > + *                              spi-mem
> > + * @nor:        pointer to 'struct spi_nor'
> > + * @ofs:        offset to read from
> > + * @len:        number of bytes to read
> > + * @buf:        pointer to dst buffer
> > + *
> > + * Return: number of bytes read successfully, -errno otherwise
> > + */
> > +static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,  
> 
> s/ofs/from? both flash and buf may have offsets, "from" better indicates that
> the offset is associated with the flash.

The semantic is well documented in the doc just above the function, but
I have the feeling that you're in 'nitpick' mode, so I'll just let you
pick the one you prefer :).

> 
> > +					size_t len, u8 *buf)
> > +{
> > +	struct spi_mem_op op =
> > +		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
> > +			   SPI_MEM_OP_ADDR(nor->addr_width, ofs, 1),
> > +			   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
> > +			   SPI_MEM_OP_DATA_IN(len, buf, 1));
> > +
> > +	op.dummy.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
> > +
> > +	/* convert the dummy cycles to the number of bytes */
> > +	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > +
> > +	return spi_nor_spimem_xfer_data(nor, &op, nor->read_proto);  
> 
> stop passing nor->read_proto and do all buswidth initialization here. This way
> we'll keep the inits all gathered together, and will have the xfer() that will
> do just the transfer (with bouncebuffer if needed). Function that does a single
> thing.

Indeed, doesn't make sense to pass this info since it could be passed
through the op->data field.
