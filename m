Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A5C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B42E2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfFSQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:18:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:18:37 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 840CE28A302;
        Wed, 19 Jun 2019 17:18:35 +0100 (BST)
Date:   Wed, 19 Jun 2019 18:18:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Peter Pan" <peterpandong@micron.com>
Subject: Re: [PATCH] mtd: spinand: fix error read return value
Message-ID: <20190619181832.6f467279@collabora.com>
In-Reply-To: <99279437-54a6-c81d-aad2-231009f18cfc@kontron.de>
References: <1560950005-8868-1-git-send-email-liaoweixiong@allwinnertech.com>
        <20190619154611.3bfc007b@collabora.com>
        <99279437-54a6-c81d-aad2-231009f18cfc@kontron.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 14:02:14 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> On 19.06.19 15:46, Boris Brezillon wrote:
> > Hi liaoweixiong,
> > 
> > On Wed, 19 Jun 2019 21:13:24 +0800
> > liaoweixiong <liaoweixiong@allwinnertech.com> wrote:
> >   
> >> In function spinand_mtd_read, if the last page to read occurs bitflip,
> >> this function will return error value because veriable ret not equal to 0.  
> > 
> > Actually, that's exactly what the MTD core expects (see [1]), so you're
> > the one introducing a regression here.  
> 
> To me it looks like the patch description is somewhat incorrect, but the 
> fix itself looks okay, unless I'm getting it wrong.
> 
> In case of the last page containing bitflips (ret > 0), 
> spinand_mtd_read() will return that number of bitflips for the last 
> page. But to me it looks like it should instead return max_bitflips like 
> it does when the last page read returns with 0.

Oh, you're right. liaoweixiong, can you adjust the commit message
accordingly?

> 
> >>
> >> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> >> ---
> >>   drivers/mtd/nand/spi/core.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> >> index 556bfdb..6b9388d 100644
> >> --- a/drivers/mtd/nand/spi/core.c
> >> +++ b/drivers/mtd/nand/spi/core.c
> >> @@ -511,12 +511,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
> >>   		if (ret == -EBADMSG) {
> >>   			ecc_failed = true;
> >>   			mtd->ecc_stats.failed++;
> >> -			ret = 0;
> >>   		} else {
> >>   			mtd->ecc_stats.corrected += ret;
> >>   			max_bitflips = max_t(unsigned int, max_bitflips, ret);
> >>   		}
> >>   
> >> +		ret = 0;
> >>   		ops->retlen += iter.req.datalen;
> >>   		ops->oobretlen += iter.req.ooblen;
> >>   	}  
> > 
> > [1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdcore.c#L1209
> > 
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> >  

