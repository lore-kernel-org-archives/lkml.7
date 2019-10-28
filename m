Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C06CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31321744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403818AbfJ1Qlg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:41:36 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40973 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733000AbfJ1Qlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:41:36 -0400
X-Originating-IP: 91.217.168.176
Received: from xps13 (unknown [91.217.168.176])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EC341FF80E;
        Mon, 28 Oct 2019 16:41:31 +0000 (UTC)
Date:   Mon, 28 Oct 2019 17:41:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] mtd: spinand: fix detection of GD5FxGQ4xA flash
Message-ID: <20191028174131.65c3d580@xps13>
In-Reply-To: <20191016013845.23508-1-gch981213@gmail.com>
References: <20191016013845.23508-1-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chuanhong Guo <gch981213@gmail.com> wrote on Wed, 16 Oct 2019 09:38:24
+0800:

> GD5FxGQ4xA didn't follow the SPI spec to keep MISO low while slave is
> reading, and instead MISO is kept high. As a result, the first byte
> of id becomes 0xFF.
> Since the first byte isn't supposed to be checked at all, this patch
> just removed that check.
> 
> While at it, redo the comment above to better explain what's happening.
> 
> Fixes: cfd93d7c908e ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> CC: Jeff Kletsky <git-commits@allycomm.com>
> ---
> RFC:
> I doubt whether this patch is a proper fix for the underlying problem:
> The actual problem is that we have two different implementation of read id
> command: One replies immediately after master sending 0x9f and the other
> need to send 0x9f and an offset byte (found in winbond and early GD flashes.)
> Current code only works if SPI master is properly implemented (i.e. keep MOSI
> low while reading.)

I am not entirely against the fix, but this is a SPI host controller
issue, right? Can you try to fix the controller driver instead?

Thanks,
Miquèl
