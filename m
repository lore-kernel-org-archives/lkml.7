Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38269C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FB72173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfHYLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:31:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfHYLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:31:48 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B55F526BC15;
        Sun, 25 Aug 2019 12:31:46 +0100 (BST)
Date:   Sun, 25 Aug 2019 13:31:43 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] mtd: spi-nor: Use nor->params
Message-ID: <20190825133143.7ef9600a@collabora.com>
In-Reply-To: <20190823155325.13459-3-tudor.ambarus@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
        <20190823155325.13459-3-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:53:37 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The Flash parameters and settings are now stored in 'struct spi_nor'.
> Use this instead of the stack allocated params.
> 
> Few functions stop passing pointer to params, as they can get it from
> 'struct spi_nor'. spi_nor_parse_sfdp() and children will keep passing
> pointer to params because of the roll-back mechanism: in case the
> parsing of SFDP fails, the legacy flash parameter and settings will be
> restored.
> 
> Zeroizing params is no longer needed because all SPI NOR users kzalloc

  ^ Zeroing

With this fixed, you can add

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 'struct spi_nor'.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

