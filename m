Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1732AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2118206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472897;
	bh=GCojsMxQn10tgSiueLPPGM61PEMejhrPHTmNDbqeo3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qbYStSB8Pw9CdnEVzqZaAf281C0xArWSLVazAWHrebOzdJf/Wp/8usp/G6c0uyx38
	 tgG+tVLXxiAqsKLnRv50gnB8Fxju5hzZWUVxoSwDEfMbQ1hWcJWD8GrsrG7cE7MuSo
	 IGyTnQzwFq9nTLhHJyyPixJbKm96q6msIXpYYKvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfJGS2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfJGS2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:28:15 -0400
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD1F206BB;
        Mon,  7 Oct 2019 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570472894;
        bh=GCojsMxQn10tgSiueLPPGM61PEMejhrPHTmNDbqeo3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo5MCDgqgvG2usng8PEml0Sdlc4SAjEU6X+c6XUEdu/ey+U0elRbqGSAT17xNnuP5
         ETyGhtnlNbZsZpOFM1qEz/kwTthmMcd3CQhSvPoEQF1tGi+vqyovP+/7WTe8X2YmQS
         kLuHZ3p7vjpn/U05sk+oNd7m6LTt4F+wtQklbpug=
Date:   Mon, 7 Oct 2019 12:28:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tyler Ramer <tyaramer@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191007182812.GB13149@C02WT3WMHTD6>
References: <20191007154448.GA3818@C02WT3WMHTD6>
 <20191007175011.6753-1-tyaramer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175011.6753-1-tyaramer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 01:50:11PM -0400, Tyler Ramer wrote:
> Shutdown the controller when nvme_remove_dead_controller is
> reached.
> 
> If nvme_remove_dead_controller() is called, the controller won't
> be comming back online, so we should shut it down rather than just
> disabling.
> 
> Remove nvme_kill_queues() as nvme_dev_remove() will take care of
> unquiescing queues.


We do still need to kill the queues, though. The shutdown == true just flushes
all pending requests. Killing queues does that too, but it also sets the
request_queue to dying, which will terminate syncing any dirty pages.
 
> ---
> 
> Changes since v1:
>     * Clean up commit message
>     * Remove nvme_kill_queues()
> ---
>  drivers/nvme/host/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c0808f9eb8ab..68d5fb880d80 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2509,8 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>  {
>  	nvme_get_ctrl(&dev->ctrl);
> -	nvme_dev_disable(dev, false);
> -	nvme_kill_queues(&dev->ctrl);
> +	nvme_dev_disable(dev, true);
>  	if (!queue_work(nvme_wq, &dev->remove_work))
>  		nvme_put_ctrl(&dev->ctrl);
>  }
> -- 
> 2.23.0
> 
