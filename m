Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C6C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B6D208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfGAHSB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:18:01 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33449 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfGAHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:18:01 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2EFB8240002;
        Mon,  1 Jul 2019 07:17:57 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:17:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: onenand_base: Mark expected switch fall-through
Message-ID: <20190701091757.591051b5@xps13>
In-Reply-To: <20190604141737.GA1064@embeddedor>
References: <20190604141737.GA1064@embeddedor>
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

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Tue, 4 Jun 2019
09:17:37 -0500:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
> drivers/mtd/nand/onenand/onenand_base.c:3264:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_NOP_1;
> drivers/mtd/nand/onenand/onenand_base.c:3265:2: note: here
>   case ONENAND_DEVICE_DENSITY_4Gb:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index ba46d0cf60a1..bdb5f4733d28 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3262,6 +3262,7 @@ static void onenand_check_features(struct mtd_info *mtd)
>  	switch (density) {
>  	case ONENAND_DEVICE_DENSITY_8Gb:
>  		this->options |= ONENAND_HAS_NOP_1;
> +		/* fall through */
>  	case ONENAND_DEVICE_DENSITY_4Gb:
>  		if (ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;


Applied to nand/next, thanks.

Miquèl
