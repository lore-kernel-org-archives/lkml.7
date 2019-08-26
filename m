Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F017C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C80621848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfHZMt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:49:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHZMt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:49:26 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6BD6A28A1B7;
        Mon, 26 Aug 2019 13:49:24 +0100 (BST)
Date:   Mon, 26 Aug 2019 14:49:21 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v3 20/20] mtd: spi-nor: Rework the disabling
 of block write protection
Message-ID: <20190826144921.70ee27c5@collabora.com>
In-Reply-To: <20190826120821.16351-21-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
        <20190826120821.16351-21-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 12:09:09 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> spi_nor_unlock() unlocks blocks of memory or the entire flash memory
> array, if requested. clear_sr_bp() unlocks the entire flash memory
> array at boot time. This calls for some unification, clear_sr_bp() is
> just an optimization for the case when the unlock request covers the
> entire flash size.
> 
> Merge the clear_sr_bp() and stm_lock/unlock logic and introduce
> spi_nor_unlock_all(), which makes an unlock request that covers the
> entire flash size.
> 
> Get rid of the MFR handling and implement specific manufacturer
> default_init() fixup hooks.
> 
> Move write_sr_cr() to avoid to add a forward declaration. Prefix
> new function with 'spi_nor_'.
> 
> Note that this changes a bit the logic for the SNOR_MFR_ATMEL and
> SNOR_MFR_INTEL cases. Before this patch, the Atmel and Intel chips
> did not set the locking ops, but unlocked the entire flash at boot
> time, while now they are setting the locking ops to stm_locking_ops.
> This should work, since the the disable of the block protection at the
> boot time used the same Status Register bits to unlock the flash, as
> in the stm_locking_ops case.
> 
> In future, we should probably add new hooks to
> 'struct spi_nor_flash_parameter' to describe how to interact with the
> Status and Configuration Registers in the form of:
> 	nor->params.ops->read_sr
> 	nor->params.ops->write_sr
> 	nor->params.ops->read_cr
> 	nor->params.ops->write_sr
> We can retrieve this info starting with JESD216 revB, by checking the
> 15th DWORD of Basic Flash Parameter Table, or with later revisions of
> the standard, by parsing the "Status, Control and Configuration Register
> Map for SPI Memory Devices".
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Though I'd recommend waiting a bit before applying that one. As
discussed privately, we might have problems when ->quad_enable is set
to spansion_read_cr_quad_enable or spansion_no_read_cr_quad_enable.
