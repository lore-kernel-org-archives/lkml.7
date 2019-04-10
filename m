Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B0AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D4920818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfDJOKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:10:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54580 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfDJOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:10:53 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6E01828252A;
        Wed, 10 Apr 2019 15:10:51 +0100 (BST)
Date:   Wed, 10 Apr 2019 16:10:48 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul.burton@mips.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: Fix build error while
 CONFIG_MTD_NAND_ECC_SW_BCH is set to module
Message-ID: <20190410161048.1d6f4c55@collabora.com>
In-Reply-To: <20190410155856.655122c8@collabora.com>
References: <20190410130747.35692-1-yuehaibing@huawei.com>
        <20190410153920.68267a1a@collabora.com>
        <20190410155856.655122c8@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:58:56 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 10 Apr 2019 15:39:28 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Wed, 10 Apr 2019 21:07:47 +0800
> > Yue Haibing <yuehaibing@huawei.com> wrote:
> >   
> > > From: YueHaibing <yuehaibing@huawei.com>
> > > 
> > > Fix gcc build error while CONFIG_MTD_NAND_ECC_SW_BCH
> > > is set to module:
> > > 
> > > drivers/mtd/nand/raw/nand_base.o: In function `nand_cleanup':
> > > (.text+0xef6): undefined reference to `nand_bch_free'
> > > drivers/mtd/nand/raw/nand_base.o: In function `nand_scan_tail':
> > > nand_base.c:(.text+0xa101): undefined reference to `nand_bch_calculate_ecc'
> > > nand_base.c:(.text+0xa120): undefined reference to `nand_bch_correct_data'
> > > nand_base.c:(.text+0xa269): undefined reference to `nand_bch_init'
> > > 
> > > CONFIG_MTD_NAND_ECC_SW_BCH should not be set to M,
> > > because MTD_RAW_NAND need it while linked.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: 193bd4002644 ("mtd: nand: add software BCH ECC support"    
> > 
> > Nope, it's not this one that introduced the regression.
> > 
> > 
> >   
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/mtd/nand/raw/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> > > index 615d738..0500c42 100644
> > > --- a/drivers/mtd/nand/raw/Kconfig
> > > +++ b/drivers/mtd/nand/raw/Kconfig
> > > @@ -22,7 +22,7 @@ menuconfig MTD_RAW_NAND
> > >  if MTD_RAW_NAND
> > >  
> > >  config MTD_NAND_ECC_SW_BCH
> > > -	tristate "Support software BCH ECC"
> > > +	bool "Support software BCH ECC"
> > >  	select BCH
> > >  	default n
> > >  	help    
> > 
> > Should be fixed with the following diff squashed into:
> > 
> > 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
> >   
> > --->8---    
> > diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
> > index b8106651f807..06ce2b655c13 100644
> > --- a/include/linux/mtd/nand_bch.h
> > +++ b/include/linux/mtd/nand_bch.h
> > @@ -15,7 +15,7 @@ struct mtd_info;
> >  struct nand_chip;
> >  struct nand_bch_control;
> >  
> > -#if defined(CONFIG_MTD_NAND_ECC_BCH)
> > +#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
> >  
> >  static inline int mtd_nand_has_bch(void) { return 1; }
> >  
> > @@ -39,7 +39,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd);
> >   */
> >  void nand_bch_free(struct nand_bch_control *nbc);
> >  
> > -#else /* !CONFIG_MTD_NAND_ECC_BCH */
> > +#else /* !CONFIG_MTD_NAND_ECC_SW_BCH */
> >  
> >  static inline int mtd_nand_has_bch(void) { return 0; }
> >  
> > @@ -64,6 +64,6 @@ static inline struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
> >  
> >  static inline void nand_bch_free(struct nand_bch_control *nbc) {}
> >  
> > -#endif /* CONFIG_MTD_NAND_ECC_BCH */
> > +#endif /* CONFIG_MTD_NAND_ECC_SW_BCH */
> >  
> >  #endif /* __MTD_NAND_BCH_H__ */  
> 
> Sorry, I didn't look at the right branch, this part of the code was
> correct, but we still have a problem to express the RAW_NAND(y) ->
> SW_BCH(y) dependency.

This one should do the trick, though imply means MTD_NAND_ECC_SW_BCH will
now be selected by default.

--->8---
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 7fcdaf6c279d..f9258d666846 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
        tristate "M-Systems Disk-On-Chip G3"
        select BCH
-       select BCH_CONST_PARAMS if !CONFIG_MTD_NAND_ECC_SW_BCH
+       select BCH_CONST_PARAMS if !MTD_NAND_ECC_SW_BCH
        select BITREVERSE
        help
          This provides an MTD device driver for the M-Systems DiskOnChip
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 615d738be411..65c85fc53c41 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -9,18 +9,6 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
          Software ECC according to the Smart Media Specification.
          The original Linux implementation had byte 0 and 1 swapped.
 
-menuconfig MTD_RAW_NAND
-       tristate "Raw/Parallel NAND Device Support"
-       depends on MTD
-       select MTD_NAND_CORE
-       select MTD_NAND_ECC_SW_HAMMING
-       help
-         This enables support for accessing all type of raw/parallel
-         NAND flash devices. For further information see
-         <http://www.linux-mtd.infradead.org/doc/nand.html>.
-
-if MTD_RAW_NAND
-
 config MTD_NAND_ECC_SW_BCH
        tristate "Support software BCH ECC"
        select BCH
@@ -31,6 +19,19 @@ config MTD_NAND_ECC_SW_BCH
          ECC codes. They are used with NAND devices requiring more than 1 bit
          of error correction.
 
+menuconfig MTD_RAW_NAND
+       tristate "Raw/Parallel NAND Device Support"
+       depends on MTD
+       select MTD_NAND_CORE
+       select MTD_NAND_ECC_SW_HAMMING
+       imply MTD_NAND_ECC_SW_BCH
+       help
+         This enables support for accessing all type of raw/parallel
+         NAND flash devices. For further information see
+         <http://www.linux-mtd.infradead.org/doc/nand.html>.
+
+if MTD_RAW_NAND
+
 comment "Raw/parallel NAND flash controllers"
 
 config MTD_NAND_DENALI
