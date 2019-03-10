Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F97C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE97207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCJSB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:01:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCJSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:01:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E575514692AB7;
        Sun, 10 Mar 2019 11:01:27 -0700 (PDT)
Date:   Sun, 10 Mar 2019 11:01:27 -0700 (PDT)
Message-Id: <20190310.110127.1284658132202643848.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8390: fix potential NULL pointer dereferences
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190310081455.6097-1-kjlu@umn.edu>
References: <20190310081455.6097-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 11:01:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Sun, 10 Mar 2019 03:14:53 -0500

> In case ioremap fails, the fix returns to avoid NULL pointer
> dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/8390/pcnet_cs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
> index 61e43802b9a5..d82ecedf7366 100644
> --- a/drivers/net/ethernet/8390/pcnet_cs.c
> +++ b/drivers/net/ethernet/8390/pcnet_cs.c
> @@ -289,6 +289,9 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
>  
>      virt = ioremap(link->resource[2]->start,
>  	    resource_size(link->resource[2]));
> +		if (unlikely(!virt))
> +			return NULL;

Please retain the existing indentation, otherwise your changes are
impossible to read.
