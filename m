Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50116C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD6208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfDAPYJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:24:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56059 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:24:08 -0400
X-Originating-IP: 90.88.32.136
Received: from xps13 (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 02B1F40016;
        Mon,  1 Apr 2019 15:24:03 +0000 (UTC)
Date:   Mon, 1 Apr 2019 17:24:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 00/11] add support for sam9x60 nand controller
Message-ID: <20190401172352.7f18e49f@xps13>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

<Tudor.Ambarus@microchip.com> wrote on Wed, 13 Feb 2019 08:59:41 +0000:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 board defines the CCFG_EBICSA register under SFR,
> and not as a MATRIX register, as previous boards do.
> NAND Flash I/Os are connected to D16–D23, thus
> SFR_CCFG_EBICSA.NFD0_ON_D16 is set to 1.
> 
> Tested using mtd-utils.
> 
> - patches [1, 7] add support for the sam9x60 nand controller. I would
>   suggest to get them through linux-mtd tree, if all agree.
> - patch 8 can be taken by Alexandre
> - patch 9 - SPDX change, can be taken by Lee
> - patch 10 - SPDX change, can be taken by Alexandre
> - patch 11 - SPDX change, should go through linux-mtd
> 
> dt compatible string for "microchip,sam9x60-sfr" has already been
> submited at https://patchwork.kernel.org/patch/10799831/
> 
> Tudor Ambarus (11):
>   ARM: at91: add sam9x60 SFR definitions
>   memory: atmel-ebi: add generic name for ebi regmap
>   dt-bindings: memory: atmel-ebi: add sam9x60 compatible
>   memory: atmel-ebi: add sam9x60 EBI support
>   mtd: rawnand: atmel: add generic name for EBICSA regmap
>   dt-bindings: mtd: atmel-nand: add sam9x60 compatible
>   mtd: rawnand: atmel: add sam9x60 nand controller support
>   memory: atmel-ebi: move NUM_CS definition inside atmel-ebi
>   mfd: syscon: atmel: switch to SPDX license identifiers
>   memory: atmel-ebi: switch to SPDX license identifiers
>   mtd: rawnand: atmel: switch to SPDX license identifiers
> 
>  .../bindings/memory-controllers/atmel,ebi.txt      |   1 +
>  .../devicetree/bindings/mtd/atmel-nand.txt         |   1 +
>  drivers/memory/atmel-ebi.c                         |  48 ++++++---
>  drivers/mtd/nand/raw/atmel/nand-controller.c       | 117 ++++++++++++++++-----
>  drivers/mtd/nand/raw/atmel/pmecc.c                 |   5 +-
>  drivers/mtd/nand/raw/atmel/pmecc.h                 |   6 +-
>  include/linux/mfd/syscon/atmel-matrix.h            |   7 +-
>  include/linux/mfd/syscon/atmel-mc.h                |   6 +-
>  include/linux/mfd/syscon/atmel-smc.h               |   5 +-
>  include/linux/mfd/syscon/atmel-st.h                |   6 +-
>  include/soc/at91/atmel-sfr.h                       |  34 ++++--
>  11 files changed, 161 insertions(+), 75 deletions(-)
> 


Patches 1-7 & 11 applied to
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git on nand/next.


Thanks,
Miquèl
