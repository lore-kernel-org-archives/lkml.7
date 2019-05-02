Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589F820873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEBIZL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:25:11 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53479 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfEBIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:25:10 -0400
Received: from xps13 (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3B27810001D;
        Thu,  2 May 2019 08:25:05 +0000 (UTC)
Date:   Thu, 2 May 2019 10:25:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: brcmnand: When oops in progress use pio
 and interrupt polling
Message-ID: <20190502102504.32b45247@xps13>
In-Reply-To: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com>
References: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Wed,  1 May 2019 13:46:15
-0400:

> If mtd_oops is in progress switch to polling for nand command completion

s/nand/NAND/

> interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
> be completely written in the assinged nand partition.

What about:

"If mtd_oops is in progress, switch to polling during NAND command
completion instead of relying on DMA/interrupts so that the mtd_oops
buffer can be completely written in the assigned NAND partition."

> This is needed in
> cases where the panic does not happen on cpu0 and there is only one online
> CPU and the panic is not on cpu0.

"This is needed in case the panic does not happen on CPU0 and there is
only one online CPU."

I am not sure to understand the problem or how this can happen (and
be a problem). Have you met such issue already or is this purely
speculative?

> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 55 ++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 482c6f0..cfbe51a 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -823,6 +823,12 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
>  	return ctrl->flash_dma_base;
>  }
>  
> +static inline void disable_flash_dma_xfer(struct brcmnand_controller *ctrl)
> +{
> +	if (has_flash_dma(ctrl))
> +		ctrl->flash_dma_base = 0;
> +}
> +
>  static inline bool flash_dma_buf_ok(const void *buf)
>  {
>  	return buf && !is_vmalloc_addr(buf) &&
> @@ -1237,15 +1243,58 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
>  	/* intentionally left blank */
>  }
>  
> +static bool is_mtd_oops_in_progress(void)
> +{
> +	int i = 0;
> +
> +#ifdef CONFIG_MTD_OOPS
> +	if (oops_in_progress && smp_processor_id()) {
> +		int cpu = 0;
> +
> +		for_each_online_cpu(cpu)
> +			++i;
> +	}
> +#endif
> +	return i == 1 ? true : false;

I suppose return (i == 1); is enough

> +}
> +
> +static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
> +{
> +	struct brcmnand_host *host = nand_get_controller_data(chip);
> +	struct brcmnand_controller *ctrl = host->ctrl;
> +	bool err = false;
> +	int sts;
> +
> +	if (is_mtd_oops_in_progress()) {
> +		/* Switch to interrupt polling and PIO mode */
> +		disable_flash_dma_xfer(ctrl);
> +		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY |
> +					       NAND_STATUS_READY,
> +					       NAND_CTRL_RDY |
> +					       NAND_STATUS_READY, 0);
> +		err = (sts < 0) ? true : false;
> +	} else {
> +		unsigned long timeo = msecs_to_jiffies(
> +						NAND_POLL_STATUS_TIMEOUT_MS);
> +		/* wait for completion interrupt */
> +		sts = wait_for_completion_timeout(&ctrl->done, timeo);
> +		err = (sts <= 0) ? true : false;
> +	}
> +
> +	return err;
> +}
> +
>  static int brcmnand_waitfunc(struct nand_chip *chip)
>  {
>  	struct brcmnand_host *host = nand_get_controller_data(chip);
>  	struct brcmnand_controller *ctrl = host->ctrl;
> -	unsigned long timeo = msecs_to_jiffies(100);
> +	bool err = false;
>  
>  	dev_dbg(ctrl->dev, "wait on native cmd %d\n", ctrl->cmd_pending);
> -	if (ctrl->cmd_pending &&
> -			wait_for_completion_timeout(&ctrl->done, timeo) <= 0) {

What about the wait_for_completion_timeout() call in brcmnand_write()?

> +	if (ctrl->cmd_pending)
> +		err = brcmstb_nand_wait_for_completion(chip);
> +
> +	if (err) {
>  		u32 cmd = brcmnand_read_reg(ctrl, BRCMNAND_CMD_START)
>  					>> brcmnand_cmd_shift(ctrl);  
>  


Thanks,
Miquèl
