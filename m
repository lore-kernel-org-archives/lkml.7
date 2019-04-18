Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DBC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAFD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555570765;
	bh=/4cQHoHYh1aVJTgjgqbEKlG8yJoPuKgZaGsmxVzlTYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Un9SJI3qIAQH0J/9DOK5D7bDfiQap4fZAd+7j/8UHSE64bWF9rbeog2KFbGQera4H
	 H80FqVr/r6PK+C7lGOGJT71AgQt+WN36ipRkQFsHUD7oP2Yn3ZjNS3A/M8b6RTOJLT
	 /7t4gBBoSiO43tI30Iy0I6if4wyF7T/2hGHQAINE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbfDRG7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388044AbfDRG7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:59:23 -0400
Received: from localhost (ip-213-127-62-114.ip.prioritytelecom.net [213.127.62.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10F4217D7;
        Thu, 18 Apr 2019 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555570763;
        bh=/4cQHoHYh1aVJTgjgqbEKlG8yJoPuKgZaGsmxVzlTYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ygg6f/961WIc6z4+0vsTjhQaEf9JmjAAXVxiy1O7+sVcatjGa6dYsJHs3alA5007D
         gzNHPceZFKEEuQseEku8kzAaRb+PehNnAP/eDWoAzVpCJDnMZpCq1rMavB9bY/Jvva
         zLmgrY9+wvJA4d14AxamwEsHMm03MufmX/1fdLFE=
Date:   Thu, 18 Apr 2019 08:59:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/02] tty: rocket: deprecate the rp_ioctl
Message-ID: <20190418065915.GA14565@kroah.com>
References: <20190418043558.10577-1-huangfq.daxian@gmail.com>
 <20190418043558.10577-2-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418043558.10577-2-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:35:58PM +0800, Fuqian Huang wrote:
> This patch depends on patch 01.

THat's implied as it is patch 02/02, so no need to put it in the
changelog text :)

> 
> The rp_ioctl is deprecated.
> Add dev_warn_ratelimited to warn the use of rp_ioctl.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/tty/rocket.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index b6543e28bd8b..1e1bcb54b680 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1284,18 +1284,28 @@ static int rp_ioctl(struct tty_struct *tty,
>  
>  	switch (cmd) {
>  	case RCKP_GET_CONFIG:
> +		dev_warn_ratelimited(tty->dev,
> +					"RCKP_GET_CONFIG option is deprecated\n");

Nit, you can wrap this a bit nicer to make checkpatch.pl happy:

		dev_warn_ratelimited(tty->dev,
				     "RCKP_GET_CONFIG option is deprecated\n");

I'll fix it up when I apply it, thanks!

greg k-h
