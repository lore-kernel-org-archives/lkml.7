Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDF2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfCKUhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:37:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:37:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 27EF814C68359;
        Mon, 11 Mar 2019 13:37:11 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:37:10 -0700 (PDT)
Message-Id: <20190311.133710.1969649183468126991.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fujitsu: fix a potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311061503.18181-1-kjlu@umn.edu>
References: <20190311061503.18181-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 13:37:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 01:15:01 -0500

> In case ioremap fails, the fix returns -ENOMEM to avoid the
> NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> index a69cd19a55ae..5061ddf699a7 100644
> --- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> +++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> @@ -547,6 +547,9 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
>  	return -1;
>  
>      base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
> +    if (!base)
> +	    return -ENOMEM;
> +

You must release the pcmcia window if you exit the function here.
