Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E193C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEB32133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfJGINn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:13:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:13:42 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6C49628AF35;
        Mon,  7 Oct 2019 09:13:40 +0100 (BST)
Date:   Mon, 7 Oct 2019 10:13:37 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Message-ID: <20191007101337.647300e2@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-7-sshivamurthy@micron.com>
        <20190807120408.031b8d1b@xps13>
        <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 09:03:38 +0000
"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:

> >   
> > >  static int micron_spinand_detect(struct spinand_device *spinand)
> > >  {
> > > +	const struct spi_mem_op *op;
> > >  	u8 *id = spinand->id.data;
> > > -	int ret;
> > >
> > >  	/*
> > >  	 * Micron SPI NAND read ID need a dummy byte,
> > > @@ -114,16 +102,55 @@ static int micron_spinand_detect(struct  
> > spinand_device *spinand)  
> > >  	if (id[1] != SPINAND_MFR_MICRON)
> > >  		return 0;
> > >
> > > -	ret = spinand_match_and_init(spinand, micron_spinand_table,
> > > -				     ARRAY_SIZE(micron_spinand_table),  
> > id[2]);
> > 
> > I am not sure this is the right solution. I would keep this call and
> > overwrite what you need to overwrite with the fixup hook.
> >   

I'm definitely not comfortable with this whole "rely on ONFi
param-page" thing. Vendors have proven to get it wrong from time to
time, so before we do that, I'd like to make sure all currently
supported Micron NANDs (looks like we only support MT29F2G01ABAGD, so
that shouldn't be hard) expose the right thing there. For instance, are
we sure the ECC layout is always the same, and if not, do we have a
reliable way to extract that?

> 
> Then, I will have dummy structure like below.
> 
> static const struct spinand_info micron_spinand_table[] = {                      
>         SPINAND_INFO(NULL, 0,                                                                    
>                      NAND_MEMORG(0, 0, 0, 0, 0, 0, 0, 0, 0),           
>                      NAND_ECCREQ(0, 0),                                                                       
>                      SPINAND_INFO_OP_VARIANTS(&read_cache_variants,              
>                                               &write_cache_variants,             
>                                               &update_cache_variants),           
>                      0,                                                                                         
>                      SPINAND_ECCINFO(&micron_ooblayout_ops,                      
>                                      micron_ecc_get_status)),                    
> };   

> 
> Let me know if you are thinking for different approach.

Exposing dummy entries is useless. If you're entirely sure all Micron
SPI NANDs have a valid ONFi param page, then no need to use the
ID-based detection. But as I said above, I feel param-page-based
detection is going to be as messy as SFDP-based detection is for SPI
NORs. Vendors tend to make mistakes which we have to fix to make
things work. ID-based detection is much more reliable in this regard,
as long as we don't have ID collisions :P.
Plus, it looks like only a few manufacturers decided to use ONFi param
pages to expose SPI NAND info (AFAICT, only Micron and Macronix do
that), which is not surprising since the ONFi param page has been
created to describe parallel NANDs not SPI NANDs (if you look closely
enough, you'll notice that some fields are meaningless for SPI NANDs).
