Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF8C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034FD227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576677620;
	bh=VlqpBY7UEf7YesewWVwk4g+Isr+ZF825AiNgGGh2hCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZnNVa2kM0QXKkschtAzzGftxFJ1d59fSbnMiFx+/ogMks+TeZC0inoJBBWEoP1bx
	 O43R4dAkkuHa5lgPdsKLEXsfnjz3+bRwwIk8yNjAH6b6RLsfYm6GxG4nIrNFxBaTl6
	 PQf5Em6BgcETtXdfbCIVfFwmrDDrs9Hn6Mx0t6sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfLROAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLROAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:00:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5552176D;
        Wed, 18 Dec 2019 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576677618;
        bh=VlqpBY7UEf7YesewWVwk4g+Isr+ZF825AiNgGGh2hCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zJBawkD4TbBu/Zj7CAC9zKhpFk0V2bVhNNus+kYE6ViK994OP2ib9ofL0DIBg9AvR
         f0Vb7npEY9SroKsbSjSTcc676vwueOW7bhAxKL/AYOf3w8gARO5dB5vUNQT61naWop
         cNimxlkswqRSTS6Rmknbwx2sFwywM1XocRolFpaM=
Date:   Wed, 18 Dec 2019 15:00:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] Revert "serdev: simplify Makefile"
Message-ID: <20191218140016.GB209514@kroah.com>
References: <20191218131154.13702-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218131154.13702-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 02:11:54PM +0100, Johan Hovold wrote:
> This reverts commit 54edb425346a4d5e17f7e54e8c97c0d0eac26315.
> 
> The offending commit caused serdev core to always be built-in, something
> which breaks the build of dependent modules when serdev is being built
> as a module:
> 
> ERROR: "__serdev_device_driver_register" [drivers/gnss/gnss-ubx.ko] undefined!
> ...
> make[2]: *** [/home/johan/work/omicron/src/linux/scripts/Makefile.modpost:94: __modpost] Error 1
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serdev/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Heh, give me a chance to catch up here, I would have reverted it on my
own :)

I'll go queue this up now, thanks.

greg k-h
