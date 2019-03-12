Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF302147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCLJDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:03:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58334 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCLJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:03:03 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8EE67280794;
        Tue, 12 Mar 2019 09:03:01 +0000 (GMT)
Date:   Tue, 12 Mar 2019 10:02:57 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 4/9] mtd: rawnand: denali: switch over to ->exec_op()
 from legacy hooks
Message-ID: <20190312100257.4fa142d1@collabora.com>
In-Reply-To: <1552380290-19951-5-git-send-email-yamada.masahiro@socionext.com>
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
        <1552380290-19951-5-git-send-email-yamada.masahiro@socionext.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 17:44:45 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:


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

I agree with Miquel, this statement tends to obfuscate the code, and
it's not like an extra if will make a huge difference in term of LOC.
	

> +		return 0;
> +	case NAND_OP_DATA_OUT_INSTR:
> +		(!instr->ctx.data.force_8bit && width16 ?
> +		 denali_exec_out16 :
> +		 denali_exec_out8)(denali, DENALI_MAP11_DATA,
> +				   instr->ctx.data.buf.out,
> +				   instr->ctx.data.len);

Ditto.

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
