Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5517C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6DC206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCDKfY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:35:24 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39489 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCDKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:35:24 -0500
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E74CC1BF204;
        Mon,  4 Mar 2019 10:35:19 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:35:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] mtd: rawnand: ingenic: Add support for the
 JZ4725B
Message-ID: <20190304113519.2e102b25@xps13>
In-Reply-To: <20190209192305.4434-8-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-8-paul@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Sat,  9 Feb 2019 16:23:04
-0300:

> The boot ROM of the JZ4725B SoC expects a specific OOB layout on the
> NAND, so we use it unconditionally in the ingenic-nand driver.
> 
> Also add the jz4725b-bch driver to support the JZ4725B-specific BCH
> hardware.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: Instead of forcing the OOB layout, leave it to the board code or
>     devicetree to decide if the jz4725b-specific layout should be used
>     or not.
> 
> v3: - Revert the change in v2, as the previous behaviour was correct.
>     - Also add support for the hardware BCH of the JZ4725B in this
>       patch.
> 
> v4: - Add MODULE_* macros
>     - Add tweaks suggested by upstream feedback
> 
>  drivers/mtd/nand/raw/ingenic/Kconfig        |  10 +
>  drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
>  drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 ++++-
>  drivers/mtd/nand/raw/ingenic/jz4725b_bch.c  | 292 ++++++++++++++++++++++++++++
>  4 files changed, 350 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
> 

[...]

> +static int jz4725b_calculate(struct ingenic_ecc *bch,
> +			     struct ingenic_ecc_params *params,
> +			     const u8 *buf, u8 *ecc_code)
> +{
> +	int ret;
> +
> +	mutex_lock(&bch->lock);
> +	ret = jz4725b_bch_init(bch, params, true);

I really don't like this bch_init name. A BCH initialization is what is
supposed to be done only once (probably at boot time), can you find a
better name or a better organization of the correct/calculate path?

> +	if (ret) {
> +		dev_err(bch->dev, "Unable to init BCH with given parameters\n");
> +		goto out_disable;
> +	}
> +
> +	jz4725b_bch_write_data(bch, buf, params->size);
> +
> +	ret = jz4725b_bch_wait_complete(bch, BCH_BHINT_ENCF, NULL);
> +	if (ret) {
> +		dev_err(bch->dev, "timed out while calculating ECC\n");
> +		goto out_disable;
> +	}
> +
> +	jz4725b_bch_read_parity(bch, ecc_code, params->bytes);
> +
> +out_disable:
> +	jz4725b_bch_disable(bch);
> +	mutex_unlock(&bch->lock);
> +
> +	return ret;
> +}
> +

[...]

Thanks,
Miquèl
