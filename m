Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79889C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547FD20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCDJqA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:46:00 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57781 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:45:59 -0500
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 87BD424000B;
        Mon,  4 Mar 2019 09:45:55 +0000 (UTC)
Date:   Mon, 4 Mar 2019 10:45:54 +0100
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
Subject: Re: [PATCH v4 1/9] dt-bindings: mtd: ingenic: Add compatible
 strings for JZ4740 and JZ4725B
Message-ID: <20190304104554.09be4cd4@xps13>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
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

Paul Cercueil <paul@crapouillou.net> wrote on Sat,  9 Feb 2019 16:22:57
-0300:

> Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
> from devicetree on the JZ4725B and JZ4740 SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: - Change 'ingenic,jz4725b-nand' compatible string to
>       'ingenic,jz4740-nand' to reflect driver change
>     - Add 'ingenic,jz4740-bch' compatible string
>     - Document 'ingenic,oob-layout' property
> 
> v3: - Removed 'ingenic,oob-layout' property
>     - Update compatible strings to what the driver supports
> 
> v4: No change
> 
>  Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> index 29ea5853ca91..a5b940f18bf6 100644
> --- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> @@ -6,7 +6,10 @@ memory-controllers/ingenic,jz4780-nemc.txt), and thus NAND device nodes must
>  be children of the NEMC node.
>  
>  Required NAND controller device properties:
> -- compatible: Should be set to "ingenic,jz4780-nand".
> +- compatible: Should be one of:
> +  * ingenic,jz4740-nand
> +  * ingenic,jz4725b-nand
> +  * ingenic,jz4780-nand

Wouldn't "-nand-controller" suffix be better? Of course in the driver
you should still check for jz4780-nand.

>  - reg: For each bank with a NAND chip attached, should specify a bank number,
>    an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
>  
> @@ -72,7 +75,10 @@ NAND devices. The following is a description of the device properties for a
>  BCH controller.
>  
>  Required BCH properties:
> -- compatible: Should be set to "ingenic,jz4780-bch".
> +- compatible: Should be one of:
> +  * ingenic,jz4740-ecc
> +  * ingenic,jz4725b-bch
> +  * ingenic,jz4780-bch
>  - reg: Should specify the BCH controller registers location and length.
>  - clocks: Clock for the BCH controller.
>  

Thanks,
Miquèl
