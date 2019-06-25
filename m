Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C10C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8DC2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="GQXVa9j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfFYORF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:17:05 -0400
Received: from mail.intenta.de ([178.249.25.132]:28391 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=0LXqnefS6ua7gqL9kD/KCf39EJ+ezxI8Okybp4/Vr+o=;
        b=GQXVa9j2NkuaRh3mroxMOkZV8AXHK22v8Lj314GNO/ChsPvS33P9Pzv/VrBU21g7Fnbt1V7HewaCrDHncVS+RMe0NaDPdrQapJEbyKttQypFLMjvVIRZ7R1owYz3tl43s+Zg+Nar+Jj4/Ayf2mT5qCeq2UKePxsiVj+pVNZEJnaR/n3ZrnQfo1nZ6jFNHzN81yuwcyOnD4kKqH/YCZvItcMoQ3k/+Rpv2iLFyyX+hLwRvQazeho7fxZx2reN+/6eIox4h7ZdYaYgWISGZY2Vflx6oUG0djzC4ZS+hmqj9NGqpeVfs84F9/64ghcbTLexjualZ/WKTfu1b1gFnhrmUA==;
X-CTCH-RefID: str=0001.0A0C020D.5D122B8D.0069,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Tue, 25 Jun 2019 16:11:25 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Message-ID: <20190625141125.a4umdey6ejxjxap4@laureti-dev>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:46:29AM +0200, Naga Sureshkumar Relli wrote:
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
>  		chip->ecc.size = 512;
>  		chip->ecc.strength = chip->base.eccreq.strength;
>  		chip->ecc.algo = NAND_ECC_BCH;
> -		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> -		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
> +		if (!chip->ecc.read_page)
> +			chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> +
> +		if (!chip->ecc.write_page)
> +			chip->ecc.write_page = micron_nand_write_page_on_die_ecc;

When used with pl353_nand.c, this change prioritizes the
pl353_nand_read_page_raw/pl353_nand_write_page_raw implementations over
micron_nand_read_page_on_die_ecc/micron_nand_write_page_on_die_ecc. The
pl353 implementations don't check the status register of the flash for
NAND_ECC_STATUS_WRITE_RECOMMENDED nor do they update ecc_stats.failed in
any way. Unless I am mistaken, this implies that bitflips cannot be
detected at all anymore.

However, this is the change that makes a MT29F2G08ABAEAWP practically
work with jffs2 on the Zynq platform.

In this context, I countered a document from Micron[1] indicating that
their on-die chips are incompatible with jffs2 as is, because the on-die
oob layout is incompatible with jffs2. I suppose that using the raw
variants puts jffs2 in full control of the oob area, but is this really
the correct solution?

Helmut

[1] https://www.micron.com/~/media/Documents/Products/Technical%20Note/NAND%20Flash/tn2975_enable_on-die-ECC_NAND_JFFS2.pdf
