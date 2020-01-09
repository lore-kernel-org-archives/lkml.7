Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684942067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgAIPs0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:48:26 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55875 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgAIPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:48:26 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E2B82C0013;
        Thu,  9 Jan 2020 15:48:22 +0000 (UTC)
Date:   Thu, 9 Jan 2020 16:48:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     richard@nod.at, frieder.schrempf@kontron.de, bbrezillon@kernel.org,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH 1/1] mtd: spinand: Add support for new Micron SPI NAND
 devices
Message-ID: <20200109164821.0e5f0796@xps13>
In-Reply-To: <20191209064223.10003-2-sshivamurthy@micron.com>
References: <20191209064223.10003-1-sshivamurthy@micron.com>
        <20191209064223.10003-2-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon,  9 Dec 2019 07:42:23 +0100:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add device table for new Micron SPI NAND devices. While at it, add
> support to the multi-die selection. Also, generalize the OOB layout
> structure and function names.

Sorry for the delay. I am fine with this patch mostly, but could we
split it please?

O/ Disable continuous read feature (one typo, see below). I think this
might be considered as a fix.

1/ Generalize the OOB layout structure and function names.
2/ Add support for all the parts.
3/ Add multi-die support (one comment below about that).

As a general rule of thumb, small patches, doing one logic change are
much easier and quick to review and accept.


> +static int micron_select_target(struct spinand_device *spinand,
> +				unsigned int target)
> +{
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(0xd0,
> +						      spinand->scratchbuf);
> +
> +	if (target == 1)
> +		*spinand->scratchbuf = 0x40;

Please define 0x40 and explain clearly with a comment that this is
multi-die selection.

> +
> +	return spi_mem_exec_op(spinand->spimem, &op);
> +}
> +

[...]

> +static int micron_spinand_init(struct spinand_device *spinand)
> +{
> +	/*
> +	 * M70A series device enables Continuos Read feature on Power-up,
> +	 * which is not supported here. Making this BIT disable will avoid
> +	 * any possible failure.

What about:

           M70A device series enable Continuous Read feature at
           power-up, which is not supported. Disable this bit to
	   avoid any possible failure.

> +	 */
> +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
> +}
> +
>  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
>  	.detect = micron_spinand_detect,
> +	.init = micron_spinand_init,
>  };
>  
>  const struct spinand_manufacturer micron_spinand_manufacturer = {

Thanks,
Miquèl
