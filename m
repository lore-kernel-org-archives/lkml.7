Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C119C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AE92082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfDJQSu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:18:50 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59205 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfDJQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:18:50 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 06398100008;
        Wed, 10 Apr 2019 16:18:45 +0000 (UTC)
Date:   Wed, 10 Apr 2019 18:18:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul.burton@mips.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: Fix build error while
 CONFIG_MTD_NAND_ECC_SW_BCH is set to module
Message-ID: <20190410181843.489a4e33@xps13>
In-Reply-To: <41165c39-da0c-0f15-87f9-4fb588b77dcc@huawei.com>
References: <20190410130747.35692-1-yuehaibing@huawei.com>
        <20190410153920.68267a1a@collabora.com>
        <20190410155856.655122c8@collabora.com>
        <8b020124-4008-6081-c04c-eaefb7875878@huawei.com>
        <20190410162927.17ea678b@collabora.com>
        <41165c39-da0c-0f15-87f9-4fb588b77dcc@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

YueHaibing <yuehaibing@huawei.com> wrote on Wed, 10 Apr 2019 23:03:24
+0800:

> On 2019/4/10 22:29, Boris Brezillon wrote:
> > On Wed, 10 Apr 2019 22:22:16 +0800
> > YueHaibing <yuehaibing@huawei.com> wrote:
> >   
> >> On 2019/4/10 21:58, Boris Brezillon wrote:  
> >>> On Wed, 10 Apr 2019 15:39:28 +0200
> >>> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >>>     
> >>>> On Wed, 10 Apr 2019 21:07:47 +0800
> >>>> Yue Haibing <yuehaibing@huawei.com> wrote:
> >>>>    
> >>>>> From: YueHaibing <yuehaibing@huawei.com>
> >>>>>
> >>>>> Fix gcc build error while CONFIG_MTD_NAND_ECC_SW_BCH
> >>>>> is set to module:
> >>>>>
> >>>>> drivers/mtd/nand/raw/nand_base.o: In function `nand_cleanup':
> >>>>> (.text+0xef6): undefined reference to `nand_bch_free'
> >>>>> drivers/mtd/nand/raw/nand_base.o: In function `nand_scan_tail':
> >>>>> nand_base.c:(.text+0xa101): undefined reference to `nand_bch_calculate_ecc'
> >>>>> nand_base.c:(.text+0xa120): undefined reference to `nand_bch_correct_data'
> >>>>> nand_base.c:(.text+0xa269): undefined reference to `nand_bch_init'
> >>>>>
> >>>>> CONFIG_MTD_NAND_ECC_SW_BCH should not be set to M,
> >>>>> because MTD_RAW_NAND need it while linked.
> >>>>>
> >>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
> >>>>> Fixes: 193bd4002644 ("mtd: nand: add software BCH ECC support"      
> >>>>
> >>>> Nope, it's not this one that introduced the regression.
> >>>>
> >>>>
> >>>>    
> >>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>>> ---
> >>>>>  drivers/mtd/nand/raw/Kconfig | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> >>>>> index 615d738..0500c42 100644
> >>>>> --- a/drivers/mtd/nand/raw/Kconfig
> >>>>> +++ b/drivers/mtd/nand/raw/Kconfig
> >>>>> @@ -22,7 +22,7 @@ menuconfig MTD_RAW_NAND
> >>>>>  if MTD_RAW_NAND
> >>>>>  
> >>>>>  config MTD_NAND_ECC_SW_BCH
> >>>>> -	tristate "Support software BCH ECC"
> >>>>> +	bool "Support software BCH ECC"
> >>>>>  	select BCH
> >>>>>  	default n
> >>>>>  	help      
> >>>>
> >>>> Should be fixed with the following diff squashed into:
> >>>>
> >>>> 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
> >>>>    
> >>>> --->8---      
> >>>> diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
> >>>> index b8106651f807..06ce2b655c13 100644
> >>>> --- a/include/linux/mtd/nand_bch.h
> >>>> +++ b/include/linux/mtd/nand_bch.h
> >>>> @@ -15,7 +15,7 @@ struct mtd_info;
> >>>>  struct nand_chip;
> >>>>  struct nand_bch_control;
> >>>>  
> >>>> -#if defined(CONFIG_MTD_NAND_ECC_BCH)
> >>>> +#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
> >>>>  
> >>>>  static inline int mtd_nand_has_bch(void) { return 1; }
> >>>>  
> >>>> @@ -39,7 +39,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd);
> >>>>   */
> >>>>  void nand_bch_free(struct nand_bch_control *nbc);
> >>>>  
> >>>> -#else /* !CONFIG_MTD_NAND_ECC_BCH */
> >>>> +#else /* !CONFIG_MTD_NAND_ECC_SW_BCH */
> >>>>  
> >>>>  static inline int mtd_nand_has_bch(void) { return 0; }
> >>>>  
> >>>> @@ -64,6 +64,6 @@ static inline struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
> >>>>  
> >>>>  static inline void nand_bch_free(struct nand_bch_control *nbc) {}
> >>>>  
> >>>> -#endif /* CONFIG_MTD_NAND_ECC_BCH */
> >>>> +#endif /* CONFIG_MTD_NAND_ECC_SW_BCH */
> >>>>  
> >>>>  #endif /* __MTD_NAND_BCH_H__ */    
> >>>
> >>> Sorry, I didn't look at the right branch, this part of the code was
> >>> correct, but we still have a problem to express the RAW_NAND(y) ->
> >>> SW_BCH(y) dependency.    
> >>
> >> It seems this dependency is not always need,
> >>
> >> case MTD_RAW_NAND set to y works well while CONFIG_MTD_NAND_ECC_SW_BCH is not set.  
> > 
> > Yes, I know, but forcing nand_bch to a be a boolean is not the right
> > solution either, hence my suggestion to use 'imply'.  

Why exactly? SW BCH is going to be converted to the generic ECC engine
abstraction and IIRC you told me that it would not be problematic to
turn it into a boolean?


Thanks,
Miquèl
