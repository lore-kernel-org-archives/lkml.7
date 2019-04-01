Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88717C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0EA208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDAPXQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:23:16 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39699 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:23:15 -0400
X-Originating-IP: 90.88.32.136
Received: from xps13 (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DEED2C0003;
        Mon,  1 Apr 2019 15:23:10 +0000 (UTC)
Date:   Mon, 1 Apr 2019 17:23:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] mtd: rawnand: Mark expected switch fall-throughs
Message-ID: <20190401172309.4c6929a8@xps13>
In-Reply-To: <20190208174930.GA12962@embeddedor>
References: <20190208174930.GA12962@embeddedor>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Fri, 8 Feb 2019
11:49:30 -0600:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mtd/nand/raw/diskonchip.c: In function ‘doc_probe’:
> ./include/linux/printk.h:303:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/diskonchip.c:1479:4: note: in expansion of macro ‘pr_err’
>     pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
>     ^~~~~~
> drivers/mtd/nand/raw/diskonchip.c:1480:3: note: here
>    default:
>    ^~~~~~~
> drivers/mtd/nand/raw/nandsim.c: In function ‘ns_init_module’:
> drivers/mtd/nand/raw/nandsim.c:2254:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     chip->bbt_options |= NAND_BBT_NO_OOB;
> drivers/mtd/nand/raw/nandsim.c:2255:2: note: here
>   case 1:
>   ^~~~
> drivers/mtd/nand/raw/nuc900_nand.c: In function ‘nuc900_nand_command_lp’:
> ./arch/x86/include/asm/io.h:91:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  #define __raw_writel __writel
> drivers/mtd/nand/raw/nuc900_nand.c:52:2: note: in expansion of macro ‘__raw_writel’
>   __raw_writel((val), (dev)->reg + REG_SMCMD)
>   ^~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:196:3: note: in expansion of macro ‘write_cmd_reg’
>    write_cmd_reg(nand, NAND_CMD_READSTART);
>    ^~~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:197:2: note: here
>   default:
>   ^~~~~~~
> drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_restore’:
> drivers/mtd/nand/raw/omap_elm.c:512:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       regs->elm_syndrome_fragment_4[i]);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:514:3: note: here
>    case BCH8_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c:517:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       regs->elm_syndrome_fragment_2[i]);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:519:3: note: here
>    case BCH4_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_save’:
> drivers/mtd/nand/raw/omap_elm.c:466:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>       ELM_SYNDROME_FRAGMENT_4 + offset);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:468:3: note: here
>    case BCH8_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c:471:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>       ELM_SYNDROME_FRAGMENT_2 + offset);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:473:3: note: here
>    case BCH4_ECC:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
on nand/next.

Thanks,
Miquèl
