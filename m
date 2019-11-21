Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9ABC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D7F20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574354506;
	bh=IrWFGRzmzJof+idBR3hRRL80JDK5bEELlrtOoefbtI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCim1kxxTH/FMkNtThaun0bDVxOcN+w2vKmUJJmzXf0xk5XcQmETBDVxpj33ITuKU
	 32U6qaNkQSxY0yb2qR173VZDAKzcSKT3jJ9JnJGjae+rCUqjpJ7QR7QmWICmi5v5gT
	 2xxdgiQPKQAN5pZLBTWZX7zlWGzvxvEUt0uFF4eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUQlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:41:44 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B04720672;
        Thu, 21 Nov 2019 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574354503;
        bh=IrWFGRzmzJof+idBR3hRRL80JDK5bEELlrtOoefbtI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWeKF1wuB8uwMK0EqpJQ3pOHyPA3Exyd5bnLUvSsLKoMQ10eDW9d2elW7ZFtJ+ryV
         MUp/SwpL64/rlW5F7Ni0/HDVhsVpnSjZTSMuFaRtYtVsZwUQs8V2RnFDTvTxBmWnQj
         GAZmturMvROOEGE/0MRhJyZiS6XK0Yp2ihp0/sDA=
Date:   Thu, 21 Nov 2019 17:41:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a
 race condition
Message-ID: <20191121164138.GD651886@kroah.com>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> There seems to be a race condition in tty drivers and I could see on
> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> do 'tty->port->itty = tty' even though tty->port is NULL.
> 'tty->port' will be set by the driver and if the driver has not yet done
> it before we open the tty device we can get to this situation. By adding
> some extra debug prints, I noticed that:
> 
> 6.650130: uart_add_one_port
> 6.663849: register_console
> 6.664846: tty_open
> 6.674391: tty_init_dev
> 6.675456: tty_port_link_device
> 
> uart_add_one_port() registers the console, as soon as it registers, the
> userspace tries to use it and that leads to tty_open() but
> uart_add_one_port() has not yet done tty_port_link_device() and so
> tty->port is not yet configured when control reaches tty_init_dev().

Shouldn't we do tty_port_link_device() before uart_add_one_port() to
remove that race?  Once you register the console, yes, tty_open() can
happen, so the driver had better be ready to go at that point in time.

This feels like it should be fixed by the caller, not in the tty core.
Any reason that can not happen?

thanks,

greg k-h
