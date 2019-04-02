Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B253C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439252070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfDBH1w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:27:52 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53549 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfDBH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:27:51 -0400
X-Originating-IP: 90.88.32.136
Received: from xps13 (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A59E3C0011;
        Tue,  2 Apr 2019 07:27:48 +0000 (UTC)
Date:   Tue, 2 Apr 2019 09:27:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nand tree
Message-ID: <20190402092747.758544a2@xps13>
In-Reply-To: <1554161512.10471.3@crapouillou.net>
References: <20190402101431.6708cb70@canb.auug.org.au>
        <1554161512.10471.3@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Tue, 02 Apr 2019 01:31:52
+0200:

> Hi Stephen,
> 
> Le mar. 2 avril 2019 à 1:14, Stephen Rothwell <sfr@canb.auug.org.au> a écrit :
> > Hi all,
> > 
> > After merging the nand tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:26:5: error: redefinition > of 'ingenic_ecc_calculate'
> >  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
> >      ^~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: note: previous > definition of 'ingenic_ecc_calculate' was here
> >  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
> >      ^~~~~~~~~~~~~~~~~~~~~
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:47:5: error: redefinition > of 'ingenic_ecc_correct'
> >  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
> >      ^~~~~~~~~~~~~~~~~~~
> > In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: note: previous > definition of 'ingenic_ecc_correct' was here
> >  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
> >      ^~~~~~~~~~~~~~~~~~~
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:93:21: error: redefinition > of 'of_ingenic_ecc_get'
> >  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *of_node)
> >                      ^~~~~~~~~~~~~~~~~~
> > In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: note: previous > definition of 'of_ingenic_ecc_get' was here
> >  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
> >                      ^~~~~~~~~~~~~~~~~~
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:119:6: error: redefinition > of 'ingenic_ecc_release'
> >  void ingenic_ecc_release(struct ingenic_ecc *ecc)
> >       ^~~~~~~~~~~~~~~~~~~
> > In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: note: previous > definition of 'ingenic_ecc_release' was here
> >  void ingenic_ecc_release(struct ingenic_ecc *ecc)
> >       ^~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   8278ad0d709a ("mtd: rawnand: ingenic: Separate top-level and SoC > specific code")
> > 
> > I have used the nand tree from next-20190401 for today.  
> 
> That makes no sense to me; from the offsets of the errors in the ingenic_ecc.h
> file, it seems that CONFIG_MTD_NAND_INGENIC_ECC is not set, and in this case
> ingenic_ecc.c should not be compiled at all.
> 
> -Paul
> 
> 

There must be a mistmatch somewhere in Kconfig, please reproduce with
allmodconfig on x86_64, I don't have time to check on this today.
Otherwise I'll have to drop the patchset :/


Thanks,
Miquèl
