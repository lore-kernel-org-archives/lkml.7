Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19453C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1D82084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJGJ0h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:26:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40245 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:26:37 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DD96CE0010;
        Mon,  7 Oct 2019 09:26:33 +0000 (UTC)
Date:   Mon, 7 Oct 2019 11:24:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, marcel.ziswiler@toradex.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, linux-mtd@lists.infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH RFC 2/3] mtd: rawnand: Add support Macronix Block
 Protection function
Message-ID: <20191007112442.783e4fbe@xps13>
In-Reply-To: <20191007104511.5aa7b8f2@xps13>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
        <1568793387-25199-2-git-send-email-masonccyang@mxic.com.tw>
        <20191007104511.5aa7b8f2@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 7 Oct 2019
10:45:11 +0200:

> Hi Mason,
> 
> Mason Yang <masonccyang@mxic.com.tw> wrote on Wed, 18 Sep 2019 15:56:25
> +0800:
> 
> > Macronix AC series support using SET/GET_FEATURES to change
> > Block Protection and Unprotection.
> > 
> > MTD default _lock/_unlock function replacement by manufacturer
> > postponed initialization.  
> 
> Why would we do that?
> 
> Anyway your solution looks overkill, if we ever decide to
> implement these hooks for raw nand, it is better just to not
> overwrite them in nand_scan_tail() if they have been filled
> previously (ie. by the manufacturer code).

Actually you should add two NAND hooks that do the interface with the
MTD hooks. In the NAND hooks, check that the request is to lock all the
device, otherwise return -ENOTSUPP.

Then fill-in these two hooks from the manufacturer code, without the
postponed init.

> 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/raw/nand_macronix.c | 80 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 75 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> > index 58511ae..991c636 100644
> > --- a/drivers/mtd/nand/raw/nand_macronix.c
> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > @@ -11,6 +11,10 @@
> >  #define MACRONIX_READ_RETRY_BIT BIT(0)
> >  #define MACRONIX_NUM_READ_RETRY_MODES 6
> >  
> > +#define ONFI_FEATURE_ADDR_MXIC_PROTECTION 0xA0
> > +#define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
> > +#define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
> > +
> >  struct nand_onfi_vendor_macronix {
> >  	u8 reserved;
> >  	u8 reliability_func;
> > @@ -57,10 +61,7 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
> >   * the timings unlike what is declared in the parameter page. Unflag
> >   * this feature to avoid unnecessary downturns.
> >   */
> > -static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
> > -{
> > -	unsigned int i;
> > -	static const char * const broken_get_timings[] = {
> > +static const char * const broken_get_timings[] = {
> >  		"MX30LF1G18AC",
> >  		"MX30LF1G28AC",
> >  		"MX30LF2G18AC",
> > @@ -75,7 +76,11 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
> >  		"MX30UF4G18AC",
> >  		"MX30UF4G16AC",
> >  		"MX30UF4G28AC",
> > -	};
> > +};
> > +
> > +static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
> > +{
> > +	unsigned int i;
> >  
> >  	if (!chip->parameters.supports_set_get_features)
> >  		return;
> > @@ -105,6 +110,71 @@ static int macronix_nand_init(struct nand_chip *chip)
> >  	return 0;
> >  }
> >  
> > +static int mxic_nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> > +	int ret;
> > +
> > +	feature[0] = MXIC_BLOCK_PROTECTION_ALL_LOCK;
> > +	nand_select_target(chip, 0);
> > +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
> > +				feature);
> > +	nand_deselect_target(chip);
> > +	if (ret)
> > +		pr_err("%s all blocks failed\n", __func__);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mxic_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> > +	int ret;
> > +
> > +	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
> > +	nand_select_target(chip, 0);
> > +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
> > +				feature);
> > +	nand_deselect_target(chip);
> > +	if (ret)
> > +		pr_err("%s all blocks failed\n", __func__);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Macronix AC series support using SET/GET_FEATURES to change
> > + * Block Protection and Unprotection.
> > + *
> > + * MTD call-back function replacement by manufacturer postponed
> > + * initialization.
> > + */
> > +static void macronix_nand_post_init(struct nand_chip *chip)
> > +{
> > +	unsigned int i, blockprotected = 0;
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(broken_get_timings); i++) {
> > +		if (!strcmp(broken_get_timings[i], chip->parameters.model)) {
> > +			blockprotected = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (blockprotected && chip->parameters.supports_set_get_features) {
> > +		bitmap_set(chip->parameters.set_feature_list,
> > +			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
> > +		bitmap_set(chip->parameters.get_feature_list,
> > +			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
> > +
> > +		mtd->_lock = mxic_nand_lock;
> > +		mtd->_unlock = mxic_nand_unlock;
> > +	}
> > +}
> > +
> >  const struct nand_manufacturer_ops macronix_nand_manuf_ops = {
> >  	.init = macronix_nand_init,
> > +	.post_init = macronix_nand_post_init,
> >  };  
> 
> 
> Thanks,
> Miquèl

Thanks,
Miquèl
