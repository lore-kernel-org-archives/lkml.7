Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7652E2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfJJHQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:16:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732945AbfJJHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:14:47 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2F573290694;
        Thu, 10 Oct 2019 08:14:45 +0100 (BST)
Date:   Thu, 10 Oct 2019 09:14:42 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <vigneshr@ti.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <geert+renesas@glider.be>,
        <jonas@norrbonn.se>, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, richard@nod.at, linux-kernel@vger.kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org, joel@jms.id.au,
        miquel.raynal@bootlin.com, matthias.bgg@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 06/22] mtd: spi-nor: Rework read_fsr()
Message-ID: <20191010091433.2977865a@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20190924074533.6618-7-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
        <20190924074533.6618-7-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 07:46:12 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> static int read_fsr(struct spi_nor *nor)
> becomes
> static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
> 
> The new function returns 0 on success and -errno otherwise.
> We let the callers pass the pointer to the buffer where the
> value of the Flag Status Register will be written. This way
> we avoid the casts between int and u8, which can be confusing.
> 
> Prepend spi_nor_ to the function name, all functions should begin
> with that.
> 
> S/pr_err/dev_err and drop duplicated dev_err in callers, in case the
> function returns error.

Same comments as for patch 5.
