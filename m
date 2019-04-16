Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD66920870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415366;
	bh=yLMMGcu4UdncNpIdfnwlQHu5NCCaALwZZdX1OFQWh0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bvV38kC6VE6qEcrZWj9XrllwLbXEGOJ6NWjbJkjXH4kxZjBLqNNq9v31THRjIl6lv
	 Z901F5qwtc/zrmF392lY2X8oY4xk+mV3LvqTGMszYEN5jB7tHD/Eh5UksCSa9aQq2t
	 N3jc98uD0xLsTzNSox+9gixo0OmILNihn71aIxw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfDPLtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDPLtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:49:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAC520870;
        Tue, 16 Apr 2019 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415364;
        bh=yLMMGcu4UdncNpIdfnwlQHu5NCCaALwZZdX1OFQWh0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCROY+bWz7TJLstXKm9CNIM+33hLLq9F+ccXqCNbNFxk8d4BWXWCHosxuqm8zwREs
         ahaxDztVUHGLilUSlvuz6Xmx0/ocA8vB6fNF58MyAxCHyrFen4xUACNrFIIal49RDT
         GPfMBz+3f8gyyxnEkbhKJTGnOQqJ57bD6rvE6ZDM=
Date:   Tue, 16 Apr 2019 13:43:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: olpc_dcon: Use WARN_ON() instead of BUG_ON()
Message-ID: <20190416114301.GA4059@kroah.com>
References: <20190405192836.4866-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405192836.4866-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:28:36PM -0500, Madhumitha Prabakaran wrote:
> Use WARN_ON() instead of BUG_ON(), as the WARN_ON() produces a backtrace
> without crashing the kernel.
> 
> Issue found by checkpatch.pl.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
> index 6b714f740ac3..900baab70691 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -138,7 +138,7 @@ static int dcon_bus_stabilize(struct dcon_priv *dcon, int is_powered_down)
>  	}
>  	if (x < 0) {
>  		pr_err("unable to stabilize dcon's smbus, reasserting power and praying.\n");
> -		BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
> +		WARN_ON(olpc_board_at_least(olpc_board(0xc2)));

If this change was as simple as this, we would have done it already :(

You have to properly handle this error that used to crash the system, by
properly correctly for it and continuing on.  You can't just log it and
keep on going, right?

thanks,

greg k-h
