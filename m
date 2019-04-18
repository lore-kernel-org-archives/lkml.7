Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C56C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A62720693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfDRQM5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:12:57 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40367 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:12:56 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5110560007;
        Thu, 18 Apr 2019 16:12:51 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:12:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 0/9] mtd: rawnand: denali: exec_op(), controller/chip
 separation, and cleanups
Message-ID: <20190418181250.14d7da9c@xps13>
In-Reply-To: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue,  2 Apr
2019 13:03:00 +0900:

> I took time for the Denali driver to catch up with the latest framework.
> 
>  - switch over to exec_op() and remove legacy hooks
> 
>  - separate controller/chips
> 
>  - various cleanups
> 
> Major changes in v5:
> 
>   - Passing both nand_chip and denali is redundant.
>     Pass only nand_chip to local helpers.
> 
> Major changes in v4:
>   - Add denali_exec_out() and denali_exec_in()
>     in order to make denali_exec_instr() readable
> 
>   - Make .read_page_raw() and .write_page_raw() even simpler
>     by giving up the performance
> 
> Major changes in v3:
>   - Drop "mtd: rawnand: denali: use more precise timeout for NAND_OP_WAITRDT_INSTR"
>     entirely according to the review comments in v2
> 
>   - Add comments to helpers in 2/9
> 
> 
> 
> Masahiro Yamada (9):
>   mtd: rawnand: denali: use more nand_chip pointers for internal
>     functions
>   mtd: rawnand: denali: refactor raw page accessors
>   mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
>   mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
>   mtd: rawnand: denali: use bool type instead of int where appropriate
>   mtd: rawnand: denali_pci: rename goto labels
>   mtd: rawnand: denali: decouple controller and NAND chips
>   mtd: rawnand: denali: remove DENALI_NR_BANKS macro
>   mtd: rawnand: denali: clean up coding style
> 
>  .../devicetree/bindings/mtd/denali-nand.txt        |   40 +-
>  drivers/mtd/nand/raw/denali.c                      | 1146 ++++++++++----------
>  drivers/mtd/nand/raw/denali.h                      |  117 +-
>  drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
>  drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
>  5 files changed, 823 insertions(+), 616 deletions(-)
> 


Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks,
Miquèl



Thanks,
Miquèl
