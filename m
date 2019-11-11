Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1039C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635B6222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573486841;
	bh=2iS64xZOYjvYvoLUUfe8qlTRll7p5DjvBX1t3/+GG/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YKe6iGsyfBJx4sA6RU46QTWTUWj5603hbWSAdhbE5JiDEDJFROOMeNPfd53qdBtjH
	 7GtQYxVgKSBNr9ZoVpf9Racpk1kiSEJqe6/s6GIBxNInZiHX7vbebKEgcS1duAPHh6
	 t+zugOkh2Zt4/UfnrQnz8aEGjJREyuqwkQjz02R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKKPkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:40:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0953E222BD;
        Mon, 11 Nov 2019 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573486839;
        bh=2iS64xZOYjvYvoLUUfe8qlTRll7p5DjvBX1t3/+GG/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mwq5EAHecQ97ip678b/pa0+doG30SMQbMzhZcL4fA9B4Gno/cnf5Xc2gj2oPjp7jS
         4YRxMqyutLmGGMZN4oOoBAR6lBSu4tdiHevigMtIyOX++pc2Paj4S9BdN14/XEWqlC
         v1/yTPNwgdYr898kjIE8z2XkEbQQHyyLU5vUbzZg=
Date:   Mon, 11 Nov 2019 16:40:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] staging: fbtft: Remove set but not used variable 'ret'
Message-ID: <20191111154037.GA816982@kroah.com>
References: <20191110105707.136956-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110105707.136956-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 06:57:07PM +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/fbtft/fb_ili9320.c: In function read_devicecode:
> drivers/staging/fbtft/fb_ili9320.c:25:6: warning: variable ret set but not used [-Wunused-but-set-variable]
> 
> ret is never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
> index f2e72d14431d..f0ebc40857b3 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -22,11 +22,10 @@
>  
>  static unsigned int read_devicecode(struct fbtft_par *par)
>  {
> -	int ret;
>  	u8 rxbuf[8] = {0, };
>  
>  	write_reg(par, 0x0000);
> -	ret = par->fbtftops.read(par, rxbuf, 4);
> +	par->fbtftops.read(par, rxbuf, 4);
>  	return (rxbuf[2] << 8) | rxbuf[3];
>  }
>  

If the read call can fail, shouldn't you be passing back the error
value instead?

thanks,

greg k-h

> -- 
> 2.23.0
> 
