Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE63C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73580205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAHIPd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:15:33 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57481 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAHIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:15:33 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CB699240010;
        Wed,  8 Jan 2020 08:15:29 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:15:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: sm_ftl: fix NULL pointer warning
Message-ID: <20200108091528.2c89d97f@xps13>
In-Reply-To: <20200107212509.4004137-1-arnd@arndb.de>
References: <20200107212509.4004137-1-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Tue,  7 Jan 2020 22:24:52 +0100:

> With gcc -O3, we get a new warning:
> 
> In file included from arch/arm64/include/asm/processor.h:28,
>                  from drivers/mtd/sm_ftl.c:8:
> In function 'memset',
>     inlined from 'sm_read_sector.constprop' at drivers/mtd/sm_ftl.c:250:3:
> include/linux/string.h:411:9: error: argument 1 null where non-null expected [-Werror=nonnull]
>   return __builtin_memset(p, c, size);
> 
> From all I can tell, this cannot happen (the function is called
> either with a NULL buffer or with a -1 block number but not both),
> but adding a check makes it more robust and avoids the warning.
> 
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/sm_ftl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
> index 4744bf94ad9a..b9f272408c4d 100644
> --- a/drivers/mtd/sm_ftl.c
> +++ b/drivers/mtd/sm_ftl.c
> @@ -247,7 +247,8 @@ static int sm_read_sector(struct sm_ftl *ftl,
>  
>  	/* FTL can contain -1 entries that are by default filled with bits */
>  	if (block == -1) {
> -		memset(buffer, 0xFF, SM_SECTOR_SIZE);
> +		if (buffer)
> +			memset(buffer, 0xFF, SM_SECTOR_SIZE);
>  		return 0;
>  	}
>  

What about a simpler form:

        if (buffer && block == -1) { ...

Instead of an additional indentation level? 

Thanks,
Miquèl
