Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45025C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD0720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfCDJa5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:30:57 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34865 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfCDJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:30:57 -0500
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BFAF940008;
        Mon,  4 Mar 2019 09:30:53 +0000 (UTC)
Date:   Mon, 4 Mar 2019 10:30:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 04/10] mtd: rawnand: denali: switch over to
 ->exec_op() from legacy hooks
Message-ID: <20190304103052.0eba71a6@xps13>
In-Reply-To: <1549955582-30346-5-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
        <1549955582-30346-5-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
2019 16:12:56 +0900:

> Implement ->exec_op(), and remove the deprecated hooks.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks for working on this, I like it very much!

> 
> Changes in v2: None
> 
>  drivers/mtd/nand/raw/denali.c | 234 +++++++++++++++++++++++-------------------
>  1 file changed, 126 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index a2fe2ff..bd7df25 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c

[...]

> +
> +static int denali_exec_instr(struct nand_chip *chip,
> +			     const struct nand_op_instr *instr)
> +{
> +	struct denali_nand_info *denali = to_denali(chip);
> +	bool width16 = chip->options & NAND_BUSWIDTH_16;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		denali_exec_out8(denali, DENALI_MAP11_CMD,
> +				 &instr->ctx.cmd.opcode, 1);
> +		return 0;
> +	case NAND_OP_ADDR_INSTR:
> +		denali_exec_out8(denali, DENALI_MAP11_ADDR,
> +				 instr->ctx.addr.addrs,
> +				 instr->ctx.addr.naddrs);
> +		return 0;
> +	case NAND_OP_DATA_IN_INSTR:
> +		(!instr->ctx.data.force_8bit && width16 ?
> +		 denali_exec_in16 :
> +		 denali_exec_in8)(denali, DENALI_MAP11_DATA,
> +				  instr->ctx.data.buf.in,
> +				  instr->ctx.data.len);

I think this is abusing the ternary operator, can you please find
another way for writing this? Otherwise it is not easily readable... If
it is really too complicated within 80 chars, then never mind.

> +		return 0;
> +	case NAND_OP_DATA_OUT_INSTR:
> +		(!instr->ctx.data.force_8bit && width16 ?
> +		 denali_exec_out16 :
> +		 denali_exec_out8)(denali, DENALI_MAP11_DATA,
> +				   instr->ctx.data.buf.out,
> +				   instr->ctx.data.len);
> +		return 0;
> +	case NAND_OP_WAITRDY_INSTR:
> +		return denali_exec_waitrdy(denali);
> +	default:
> +		WARN_ONCE(1, "unsupported NAND instruction type: %d\n",
> +			  instr->type);
> +
> +		return -EINVAL;
> +	}
> +}
> +


Thanks,
Miquèl
