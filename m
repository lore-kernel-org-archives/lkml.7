Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B38CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27120856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408478AbfJXGE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:04:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404173AbfJXGE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:04:58 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C115128F789;
        Thu, 24 Oct 2019 07:04:56 +0100 (BST)
Date:   Thu, 24 Oct 2019 08:04:52 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <geert+renesas@glider.be>, <andrew@aj.id.au>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <marek.vasut@gmail.com>, <jonas@norrbonn.se>,
        <linux-mtd@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Message-ID: <20191024080452.522b6447@collabora.com>
In-Reply-To: <34fbb0d7-ee8f-a6d7-4a3e-d64f2f8555ff@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
        <20190924074533.6618-9-tudor.ambarus@microchip.com>
        <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
        <34fbb0d7-ee8f-a6d7-4a3e-d64f2f8555ff@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 23:39:31 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 10/10/2019 10:21 AM, Boris Brezillon wrote:
> > External E-Mail
> > 
> > 
> > On Tue, 24 Sep 2019 07:46:18 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> static int write_enable(struct spi_nor *nor)
> >> static int write_disable(struct spi_nor *nor)
> >> become
> >> static int spi_nor_write_enable(struct spi_nor *nor)
> >> static int spi_nor_write_disable(struct spi_nor *nor)
> >>
> >> Check for errors after each call to them. Move them up in the
> >> file as the first SPI NOR Register Operations, to avoid further
> >> forward declarations.  
> > 
> > Same here, split that in 3 patches please.  

In order to keep the number of patch in this series small, I'd
recommend doing all spi_nor_ prefixing in a patch, all function
moves in another one and all error checking in a third patch, instead of
splitting it per-function.
