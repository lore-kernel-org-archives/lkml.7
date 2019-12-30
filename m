Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C762C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28DA20718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="VDha4HNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfL3Up7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:45:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:19990 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfL3Up7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:45:59 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47mqFw56cFz7N;
        Mon, 30 Dec 2019 21:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577738757; bh=s8g4G6MZBSj/JWYHiBIoQB/A8P4MtqlOvvb/SvdlSCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDha4HNHARaXWKwkXfwXhdcJhvvlxLkCKi4YkvuMri5gDvcBQOfLwG6NM9mp2XQhE
         g0I4h4JM3kJlDcoOI0jX3vOedeQzgzGN9x4zbd/ERKZ4ViZYvGXCqUR5kmCdD9J01l
         4OqseEfhCnRpJkWYaJ0IP6MGB9phe9Jo2hDy7ezUZjEVEx1DLby3lk71A/6KOzRbw2
         ZNtsNx8cZg/8tcy3fExnRHePQMY/vPU8xwOQm4bWllLFFP1nhAh8nEm6rnPczwMGbG
         9L2ij2VfuX5hCwived2I6oiMASBbE1ZFaFaYcnsTnzVqVUa5EQQfwEloAp+RABrTon
         hW+YBvA70zupw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Dec 2019 21:45:55 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
Message-ID: <20191230204555.GB24135@qmqm.qmqm.pl>
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228204640.25163-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
> It's unsafe to check the channel's "busy" state without taking a lock,
> it is also unsafe to assume that tasklet isn't in-fly.

'in-flight'. Also, the patch seems to have two independent bug-fixes
in it. Second one doesn't look right, at least not without an explanation.

First:

> -	if (tdc->busy)
> -		tegra_dma_terminate_all(dc);
> +	tegra_dma_terminate_all(dc);

Second:

> +	tasklet_kill(&tdc->tasklet);
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
> @@ -1543,7 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
>  
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);
> @@ -1563,7 +1562,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
>  		tdc = &tdma->channels[i];
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);

Best Regards,
Micha³ Miros³aw
