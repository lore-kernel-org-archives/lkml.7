Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA6F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfHZMiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:38:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfHZMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:38:23 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CCF6328A178;
        Mon, 26 Aug 2019 13:38:21 +0100 (BST)
Date:   Mon, 26 Aug 2019 14:38:18 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 04/20] mtd: spi-nor: Move erase_map to 'struct
 spi_nor_flash_parameter'
Message-ID: <20190826143818.0eee77b2@collabora.com>
In-Reply-To: <20190826120821.16351-5-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
        <20190826120821.16351-5-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 12:08:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> All flash parameters and settings should reside inside
> 'struct spi_nor_flash_parameter'. Move the SMPT parsed erase map
> from 'struct spi_nor' to 'struct spi_nor_flash_parameter'.
> 
> Please note that there is a roll-back mechanism for the flash
> parameter and settings, for cases when SFDP parser fails. The SFDP
> parser receives a Stack allocated copy of nor->params, called
> sfdp_params, and uses it to retrieve the serial flash discoverable
> parameters. JESD216 SFDP is a standard and has a higher priority
> than the default initialized flash parameters, so will overwrite the
> sfdp_params data when needed. All SFDP code uses the local copy of
> nor->params, that will overwrite it in the end, if the parser succeds.
> 
> Saving and restoring the nor->params.erase_map is no longer needed,
> since the SFDP code does not touch it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: Collect R-b

Looks like you actually forgot to collect them :P.
