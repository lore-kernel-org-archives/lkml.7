Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B292184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfC2IxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:53:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfC2IxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:53:12 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 25C6C27D87F;
        Fri, 29 Mar 2019 08:53:11 +0000 (GMT)
Date:   Fri, 29 Mar 2019 09:53:07 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: Re: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
Message-ID: <20190329095307.02d970fd@collabora.com>
In-Reply-To: <d21f7363-eeea-830e-b9b8-ef5bb9e1261b@ti.com>
References: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20190328205522.272e1da6@collabora.com>
        <d21f7363-eeea-830e-b9b8-ef5bb9e1261b@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 13:50:26 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> Hi Boris,
> 
> On 29/03/19 1:25 AM, Boris Brezillon wrote:
> > On Thu, 28 Mar 2019 16:46:24 +0530
> > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> >   
> >> Call spi_mem_default_supports_op() first, before calling controller
> >> specific ctlr->supports_op().
> >> With this, controller drivers can drop checking the buswidths again.  
> > 
> > No, this was done on purpose, in case the controller does not want the
> > default check to be applied (say it does not need bus-width props to
> > be defined and has another way to check if a device can be accessed in
> > dual, quad or octal mode).  
> 
> Sorry, I don't understand here.
> Based on capabilities declared in spi_device->mode, m25p80 driver will
> claim appropriate  SNOR_HWCAPS_*.  SPI NOR layer chooses opcodes based
> on that for which m25p80 layer populates buswidths.

Well, that test in m25p80 should go away and be replaced by a proper
spi_mem_supports_op() iteration on all modes reported as supported by
the *chip* (I think that's what I did in my series merging m25p80 code
into the spi-nor core). But that's not really related to the problem
we're discussing here.

> 
> So, I don't really expect any mismatch in spi_mem_default_supports_op()
> in the case you mentioned. Or did I miss something? Maybe something SPI
> NAND specific?

Nothing NAND specific, just something controller specific and how we
want to deal with buswidth detection. Most memory devices expose their
caps in some way (be it ID-based detection or using some kind of
caps/parameters table), so they know what they're capable of. SPI
controllers know what they're capable of, of course. The only part that
remains unknown for buswidth negotiation is how things are wired on the
board. I keep thinking that defining buswidth in the DT (using
spi-{tx,rx}-bus-width) should only be done if there are board-related
limiting factors (some IO pins not routed).
If you look at the code, SPI_{TX,RX}_{DUAL,QUAD,OCTAL} flags are only
set if the spi-{tx,rx}-bus-width props are defined.

The idea behind making spi_mem_default_supports_op() optional is to let
new drivers implement a new scheme where missing
spi-{tx,rx}-bus-width does not necessarily mean "use regular SPI mode".
