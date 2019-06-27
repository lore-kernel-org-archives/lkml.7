Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1AAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfF0Q7L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:59:11 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58161 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0Q7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:59:11 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5789AFF813;
        Thu, 27 Jun 2019 16:59:04 +0000 (UTC)
Date:   Thu, 27 Jun 2019 18:59:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: increase DMA completion
 timeouts
Message-ID: <20190627185901.6247a77c@xps13>
In-Reply-To: <1561128480-14531-1-git-send-email-christophe.kerello@st.com>
References: <1561128480-14531-1-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 21 Jun
2019 16:48:00 +0200:

> When the system is overloaded, DMA data transfer completion occurs after
> 100ms. Increase the timeouts to let it the time to complete.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

The first SoB should be the author's. Either Amelie is the author and
you should use 'git commit --amend --author=..." or she is not and
should be dropped (unless she sends the patch which is yours, and in
this case her name should appear second).

> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 4aabea2..c7f7c6f 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -981,7 +981,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
>  
>  	/* Wait DMA data transfer completion */
>  	if (!wait_for_completion_timeout(&fmc2->dma_data_complete,
> -					 msecs_to_jiffies(100))) {
> +					 msecs_to_jiffies(500))) {
>  		dev_err(fmc2->dev, "data DMA timeout\n");
>  		dmaengine_terminate_all(dma_ch);
>  		ret = -ETIMEDOUT;
> @@ -990,7 +990,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
>  	/* Wait DMA ECC transfer completion */
>  	if (!write_data && !raw) {
>  		if (!wait_for_completion_timeout(&fmc2->dma_ecc_complete,
> -						 msecs_to_jiffies(100))) {
> +						 msecs_to_jiffies(500))) {

IIRC I already asked you this but could you please make a define and at
the same time make it 1000 ms, I don't see the point in being close
to the maximum latency. If this is reached, your transfer was
screwed already, there is no performance impact here.

Sorry for the late notice but I will close the nand/next branch
tomorrow, so I'll queue your v2 only if I receive it soon enough :)

Thanks,
Miquèl
