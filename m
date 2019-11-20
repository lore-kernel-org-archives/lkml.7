Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B8BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7A20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574264699;
	bh=J2YwIMKoAFnw6lYEcrpJ1BtEA5teUNpu9YL+k4Fd20U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WMFKdtzt3mKO4oUnslGIrAy74jrtl1tE4LHtJgCc60hBxPgst62LSTJQ7rUByrbRj
	 +u1gt2tl2wwGeWDhn+9Kju7ZLB0c8yZYXfRZ4geixGJgZBoX5yrWitRGDCpz0lrXeI
	 cBnGVnwNDE8xWkSHz3a3eZOW2OvriZrlxcQTvS0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfKTPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbfKTPox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:44:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DF420674;
        Wed, 20 Nov 2019 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574264692;
        bh=J2YwIMKoAFnw6lYEcrpJ1BtEA5teUNpu9YL+k4Fd20U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCB47beV2T+jgwFv5LH9O5QszgjSWllWH5eZDd69dFoIjFOlufTAMld5xebUakOA7
         XvsFMB3aSyuEyovavFCkSFxJO9mGh/3UdZGsO7inU5+q8sf+x6L4Vjx37Pu1vH1yGp
         UJkYAfC3+pLGunv3OA+aQ1+3H+3FbftCDzWcMjPI=
Date:   Wed, 20 Nov 2019 16:44:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: add retry to tty_init_dev() to workaround a
 race condition
Message-ID: <20191120154450.GB3004157@kroah.com>
References: <20191120151709.14148-1-sudipm.mukherjee@gmail.com>
 <20191120151709.14148-2-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120151709.14148-2-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 03:17:09PM +0000, Sudip Mukherjee wrote:
> There seems to be a race condition in tty drivers and I could see on
> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> do 'tty->port->itty = tty' even though tty->port is NULL.
> 'tty->port' will be set by the driver and if the driver has not yet done
> it before we open the tty device we can get to this situation. By adding
> some extra debug prints, I noticed that tty_port_link_device() is
> initialising 'driver->ports[index]' just few microseconds after I
> get the warning.
> So, add one retry so that tty_init_dev() will return -EAGAIN on its first
> try if 'tty->port' is not set yet, and then tty_open() will try to open
> it again.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/tty/pty.c                   |  2 +-
>  drivers/tty/serdev/serdev-ttyport.c |  2 +-
>  drivers/tty/tty_io.c                | 20 ++++++++++++++------
>  include/linux/tty.h                 |  3 ++-
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 00099a8439d2..22e8c40d9f9c 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -842,7 +842,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
>  
>  
>  	mutex_lock(&tty_mutex);
> -	tty = tty_init_dev(ptm_driver, index);
> +	tty = tty_init_dev(ptm_driver, index, 0);

Horrible naming scheme for this new "flag".

Look at that call here, can you instantly tell what this call is doing
with "0"?  I sure can not :(

If you really want to do this, you make a different function,
tty_init_dev_retry() and then have that pass in a retry flag in the tty
core, so that any users always know what they are doing here.

But, this really feels like a race in the code somewhere:

> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1295,6 +1295,7 @@ static int tty_reopen(struct tty_struct *tty)
>   *	tty_init_dev		-	initialise a tty device
>   *	@driver: tty driver we are opening a device on
>   *	@idx: device index
> + *	@retry: retry count if driver has not set tty->port yet

Why would tty->port not be set up already?  The caller has control over
this, what is not happening correctly to cause this?

thanks,

greg k-h
