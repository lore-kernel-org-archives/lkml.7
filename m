Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8A92173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfDQJkV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:40:21 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42185 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:40:20 -0400
X-Originating-IP: 90.88.160.238
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 07E3BC0016;
        Wed, 17 Apr 2019 09:40:11 +0000 (UTC)
Date:   Wed, 17 Apr 2019 11:40:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific
 partition info
Message-ID: <20190417114010.774693cf@xps13>
In-Reply-To: <20190324223344.24590-1-jmkrzyszt@gmail.com>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com>
        <20190324223344.24590-1-jmkrzyszt@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Sun, 24 Mar 2019
23:33:44 +0100:

> After recent modifications, only a hardcoded partition info makes
> the driver device specific.  Other than that, the driver uses GPIO
> exclusively and can be used on any hardware.
> 
> Drop the partition info and use MTD partition parser with default list
> of parser names instead.  For the OF parser to work correctly, pass
> device of_node to mtd.
> 
> Amstrad Delta users should append the following partition info to their
> kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> 
> mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).
> 
> For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
> automatically from that board Kconfig if this NAND driver is also
> selected.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---

FYI I am okay with the change but I am waiting for acks before applying
it.

Thanks,
Miquèl
