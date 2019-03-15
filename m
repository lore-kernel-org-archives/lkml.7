Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A158EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E37A218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552669268;
	bh=frDmzjvXGHn3RcnAn0HTwqUjFhyYsM34nSwaSa9S03Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XlBl0VSISvuhIKUkCmCFi6N3hD/ZrcSkdyEPsAC+yKX73gYDCEf7Mpnmjl+uQz11p
	 5fZZSrnOfsKFKa7edujeQdBvh+g4rmO+MQ3qE4487VNphePZi634vzO/UiHyi4BVcE
	 SkOGEMlrRpDmjAeqER7aIURSvOp4jPGPvbhN9Xvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfCORBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfCORBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:01:06 -0400
Received: from localhost (unknown [122.178.218.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4385218A1;
        Fri, 15 Mar 2019 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552669265;
        bh=frDmzjvXGHn3RcnAn0HTwqUjFhyYsM34nSwaSa9S03Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=en7sKf3MKTcdaGOjRKrvub8nM025WoVRjlYOye4dWxQWV5pU78zw+PHM3WnLGokEi
         FFvw2kg4oM+p6Y3eZecF0l6u0bFq7poh5tzs9iHxi0NfmECHCoIQv0+fzaiYRYh+iM
         4oU45+toTg9mst78rg9GBjxOs91xQPsGZYHU2uwI=
Date:   Fri, 15 Mar 2019 22:30:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: introduce debugfs interface
Message-ID: <20190315170059.GF5348@vkoul-mobl>
References: <20190314184953.8129-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314184953.8129-1-katsuhiro@katsuster.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-19, 03:49, Katsuhiro Suzuki wrote:
> This patch adds debugfs interface to show the relationship between
> DMA threads (hardware resource for transferring data) and DMA
> channel ID of DMA slave.
> 
> Typically, PL330 has many slaves than number of DMA threads.
> So sometimes PL330 cannot allocate DMA threads for all slaves even
> if an user specify DMA channel ID in devicetree. This interface will

a user :)

> be useful for checking that DMA threads are allocated or not.
> 
> Below is an output sample:
> 
> $ sudo cat /sys/kernel/debug/ff1f0000.dmac
> PL330 physical channels:
> THREAD:         CHANNEL:
> --------        -----
> 0               8
> 1               9
> 2               11
> 3               12
> 4               14
> 5               15
> 6               10
> 7               --
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  drivers/dma/pl330.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index eec79fdf27a5..aab71863757c 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -11,6 +11,7 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> @@ -2896,6 +2897,55 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
>  	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
>  	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int pl330_debugfs_show(struct seq_file *s, void *data)
> +{
> +	struct pl330_dmac *pl330 = s->private;
> +	int chans, pchs, ch, pr, found;
> +
> +	chans = pl330->pcfg.num_chan;
> +	pchs = pl330->num_peripherals;
> +
> +	seq_puts(s, "PL330 physical channels:\n");
> +	seq_puts(s, "THREAD:\t\tCHANNEL:\n");
> +	seq_puts(s, "--------\t-----\n");
> +	for (ch = 0; ch < chans; ch++) {
> +		struct pl330_thread *thrd = &pl330->channels[ch];
> +
> +		found = -1;

found can be uninitialized if we skip this for, which should not be an
issue as chans> 0!

> +		for (pr = 0; pr < pchs; pr++) {
> +			struct dma_pl330_chan *pch = &pl330->peripherals[pr];
> +
> +			if (!pch->thread || thrd->id != pch->thread->id)
> +				continue;
> +
> +			found = pr;
> +		}
> +
> +		seq_printf(s, "%d\t\t", thrd->id);
> +		if (found == -1)
> +			seq_puts(s, "--\n");
> +		else
> +			seq_printf(s, "%d\n", found);
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(pl330_debugfs);
> +
> +static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
> +{
> +	debugfs_create_file(dev_name(pl330->ddma.dev),
> +			    S_IFREG | S_IRUGO, NULL, pl330,

are we not supposed to use octal permissions?

> +			    &pl330_debugfs_fops);
> +}
> +#else
> +static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
> +{
> +}
> +#endif
> +
>  /*
>   * Runtime PM callbacks are provided by amba/bus.c driver.
>   *
> @@ -3082,6 +3132,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  		dev_err(&adev->dev, "unable to set the seg size\n");
>  
>  
> +	init_pl330_debugfs(pl330);
>  	dev_info(&adev->dev,
>  		"Loaded driver for PL330 DMAC-%x\n", adev->periphid);
>  	dev_info(&adev->dev,
> -- 
> 2.20.1

-- 
~Vinod
