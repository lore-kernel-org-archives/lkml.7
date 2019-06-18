Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E820823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560843538;
	bh=ILs/Ia/OlaNfzDvq1zzYhCa2K9+YxMXJ/g1oQnP5Vbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0HP2HMN60iaaMb1tzhcKky2dpyE95x+xcM+4EriCEq55No+e2yh+JkMwJAZOFWG1b
	 AL8wJdmSdmoaLEDA+tMwZ7nNNzJxIw9latoFmOW/9PsVLJ8+WhM1eOobUhcwE3xoTI
	 Z4O6qOrssS7GuCKaFN1QCsUptPaImLxiXOfjTCwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfFRHi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRHi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:38:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E739420823;
        Tue, 18 Jun 2019 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560843535;
        bh=ILs/Ia/OlaNfzDvq1zzYhCa2K9+YxMXJ/g1oQnP5Vbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDIqq3LYU7oL3yputwRye5Z6k2lgvoIUxNUE/d9OwnImWPZgwLXa5WrqlmLtTMnI4
         WRE7E0qcasaUjnet9qhbmog1LfiTFtTHf79VrJ6xkOS570Sgbq4M0rTEeqUpEROdJr
         RtD6vSfsou2rUNpEGqrb1o9k1kKKKn7PPTpxLR9M=
Date:   Tue, 18 Jun 2019 09:38:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Charles <18oliveira.charles@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
Message-ID: <20190618073853.GA25598@kroah.com>
References: <20190613180824.6ajwjelzr5fmjnie@debie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613180824.6ajwjelzr5fmjnie@debie>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:08:24PM -0300, Charles wrote:
> Avoid following compiler warning on uninitialized variable
> 
> In file included from ./include/linux/rwsem.h:16:0,
>                  from ./include/linux/notifier.h:15,
>                  from ./include/linux/clk.h:17,
>                  from drivers/tty/serial/sh-sci.c:24:
> drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~

What version of gcc is doing this?  It should be smarter than that,
perhaps you should just upgrade.

thanks,

greg k-h
