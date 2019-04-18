Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07873C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E9D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbfDRQZU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:25:20 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42457 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389016AbfDRQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:25:19 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 53E061C0007;
        Thu, 18 Apr 2019 16:25:13 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:25:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v6 0/7] mtd: rawnand: Support bad block markers in
 first, second or last page
Message-ID: <20190418182511.4991decd@xps13>
In-Reply-To: <20190417123631.22545-1-frieder.schrempf@kontron.de>
References: <20190417123631.22545-1-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Wed, 17 Apr
2019 12:36:33 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Currently supported bad block marker positions within the block are:
> * in first page only
> * in last page only
> * in first or second page
> 
> After some cleanup and preparation in patches 1 to 4 we make it
> possible to set NAND_BBM_FIRSTPAGE, NAND_BBM_SECONDPAGE and
> NAND_BBM_LASTPAGE independently of each other (patch 5).
> 
> Some ESMT NANDs are known to have been shipped by the manufacturer
> with bad block markers in the first or last page, instead of the
> first or second page.
> 
> Also the datasheets for Cypress/Spansion/AMD NANDs claim that the
> first, second *and* last page needs to be checked.
> 
> Therefore in patch 6 and 7 we set all three flags for
> AMD/Spansion/Cypress and ESMT chips.
> ---
> Changes in v6:
> ==============
> * None (v5 was missing some of the mentioned fixes)
> 
> Changes in v5:
> ==============
> * Rebase onto current nand/next
> * Fix nand_bbm_get_next_page() docs
> * Use inclusive values for start page in nand_bbm_get_next_page()
> * Return -EINVAL from nand_bbm_get_next_page() when no more pages are available
> * Improve code style in nand_block_bad()
> * Add parentheses in scan_block_fast() and nand_default_block_markbad()
> * Unsign badblockpos field in struct nand_chip and struct onenand_chip
> * Add R-b tags
> 
> Changes in v4:
> ==============
> * Move onenand changes to separate patch
> * Add missing badblockpos field to onenand_chip struct
> * Move cleanup of badblockpos field and flags to separate patch
> * Move assignemnt of badblockpos from onenand_bbt.c to onenand_base.c
> * Fix incorrect usage of bbt_options in nand_bbt.c
> * Add R-b tags
> 
> Changes in v3:
> ==============
> * Fix bit offsets for new flags in nand_chip->options
> * Move separation of flags for first and second page markers to a
>   separate patch
> * Fix cover letter
> * Fix S-o-b tag
> * Add R-b tags
> 
> Changes in v2:
> ==============
> * Rebase on 5.0-rc1
> * Add patch to move bad block marker position info to a common place and
>   rename/prepare existing flags
> * improve/rename function nand_bbm_get_next_page() to use new flags
> ---
> Frieder Schrempf (7):
>   mtd: rawnand: Always store info about bad block markers in chip struct
>   mtd: onenand: Store bad block marker position in chip struct
>   mtd: nand: Cleanup flags and fields for bad block marker position
>   mtd: nand: Make flags for bad block marker position more granular
>   mtd: rawnand: Support bad block markers in first, second or last page
>   mtd: rawnand: ESMT: Also use the last page for bad block markers
>   mtd: rawnand: AMD: Also use the last page for bad block markers
> 
>  drivers/mtd/nand/onenand/onenand_base.c |  5 +-
>  drivers/mtd/nand/onenand/onenand_bbt.c  |  3 --
>  drivers/mtd/nand/raw/internals.h        |  1 +
>  drivers/mtd/nand/raw/nand_amd.c         |  8 ++-
>  drivers/mtd/nand/raw/nand_base.c        | 65 +++++++++++++++++--------
>  drivers/mtd/nand/raw/nand_bbt.c         | 28 +++++------
>  drivers/mtd/nand/raw/nand_esmt.c        |  9 +++-
>  drivers/mtd/nand/raw/nand_hynix.c       |  4 +-
>  drivers/mtd/nand/raw/nand_macronix.c    |  2 +-
>  drivers/mtd/nand/raw/nand_micron.c      |  2 +-
>  drivers/mtd/nand/raw/nand_samsung.c     |  4 +-
>  drivers/mtd/nand/raw/nand_toshiba.c     |  2 +-
>  drivers/mtd/nand/raw/sh_flctl.c         |  4 +-
>  include/linux/mtd/bbm.h                 | 14 +-----
>  include/linux/mtd/onenand.h             |  3 ++
>  include/linux/mtd/rawnand.h             | 17 ++++++-
>  16 files changed, 106 insertions(+), 65 deletions(-)
> 

Series applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks,
Miquèl
