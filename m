Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37948C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051D120848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfCZAO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:14:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCZAO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:14:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9E6E149AE563;
        Mon, 25 Mar 2019 17:14:28 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:14:28 -0700 (PDT)
Message-Id: <20190325.171428.816775455885557497.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, ulf.hansson@linaro.org, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com,
        linus.walleij@linaro.org,
        laurent.pinchart+renesas@ideasonboard.com, j.neuschaefer@gmx.net,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: liquidio: fix NULL pointer dereferences
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190323032420.21162-1-kjlu@umn.edu>
References: <20190311.121710.968693621648443243.davem@davemloft.net>
        <20190323032420.21162-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Mar 2019 17:14:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 22 Mar 2019 22:24:19 -0500

> In case octeon_alloc_soft_command fails, the fix reports the
> error and goes to cleanup to avoid NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: goto setup_nic_dev_free for cleanup
> ---
>  drivers/mmc/host/mmc_spi.c                         |  2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 32fea585262b..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  
>  	status = spi_sync_locked(spi, &host->m);
>  	if (status < 0) {
> -		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
> +		dev_dbg(&spi->dev, "read error %d\n", status);
>  		return status;
>  	}

This is:

1) Unrelated to your bug fix.

2) It is often the case that people print values in hex and decimal
   intentionally for debugging.  I've done this myself countless
   times.
