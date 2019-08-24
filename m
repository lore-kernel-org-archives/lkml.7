Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8B220870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfHXKsR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 06:48:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40769 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfHXKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:48:17 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3D5FC1BF203;
        Sat, 24 Aug 2019 10:48:09 +0000 (UTC)
Date:   Sat, 24 Aug 2019 12:48:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mtd: hyperbus: fix dependency and build error
Message-ID: <20190824124807.393f125d@xps13>
In-Reply-To: <9b1b4ab1-681f-0ef9-7b5c-b6545f7464d2@infradead.org>
References: <9b1b4ab1-681f-0ef9-7b5c-b6545f7464d2@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

Randy Dunlap <rdunlap@infradead.org> wrote on Tue, 13 Aug 2019 16:03:13
-0700:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> lib/devres.c, which implements devm_ioremap_resource(), is only built
> when CONFIG_HAS_IOMEM is set/enabled, so MTD_HYPERBUS should depend
> on HAS_IOMEM.  Fixes a build error and a Kconfig warning (as seen on
> UML builds):
> 
> WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS
>   Depends on [n]: MTD [=m] && HAS_IOMEM [=n]
>   Selected by [m]:
>   - MTD_HYPERBUS [=m] && MTD [=m]
> 
> ERROR: "devm_ioremap_resource" [drivers/mtd/hyperbus/hyperbus-core.ko] undefined!
> 
> Fixes: dcc7d3446a0f ("mtd: Add support for HyperBus memory devices")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-mtd@lists.infradead.org
> ---

This patch looks like a good candidate for fixes, shall I send a fixes
PR next week with it? (Acked-by wished)

Miquèl
