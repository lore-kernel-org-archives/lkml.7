Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862EA2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558603128;
	bh=D47SZ3rC8YqjRXXCEp2iX9lqbuyVUuPxKEACATWopWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0WIwiTCEYU8jW+6Ms79SSIxySzo2xie/LeJku4Ooq5gIDp2LgW5sQz7YAIMoH3fV2
	 9TG35ETTh2CrOmyxrydYxN8e1vZ7hxjVPXB9Vrx6eA4VmoDrPd+2fUu2Y/nwzNy0rG
	 2R+Z6RlpReNBJIb2LZPDqWuCwIY5DTsUuOevcXW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfEWJSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:18:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37141 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfEWJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:18:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so4764620ljj.4;
        Thu, 23 May 2019 02:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/XfMkjLnKh0ukfRfxFsRQAaMtLbiVTjQKw202INVT4=;
        b=IVJJ6bxgmdh6qU7JCN3n2Meg8MV1W8i7HFzs/HA7OeWEGErxrC1MuWmB8X4kXPqemB
         6DLq15ygoQoXuclkd73tP6HR85gBpCJrwardU1/0pCsghD6lopIDFiSorsp7JyBJGHQJ
         7ioaiJHsqArAmR679CjJW/0nHKxBwMw6PcnhlwLc0bbq7Uo6783WoYuxltUzWY8847hy
         Cqkfs/Wi4tOohhoiM7UtKkYSRIdqtyh/MF6zyAco9+pAvRaXEv2QnPyUKBgHVGwpBQGO
         lZuijL2M7EItIYsf/QIf/tkxQqJRA86TyzB/aTiItOJ8r3e1Tdb4scxQ3u+7NIMGGhOC
         CO9A==
X-Gm-Message-State: APjAAAU3kCVusQdg+lKFKyBKeqJ81Wl74P61CJ77dIzdwnihLAwIiyvm
        Z+KxIJxUjDAmsQ22exwO5rg=
X-Google-Smtp-Source: APXvYqxtmrCtPuJEYr0BX7Fxm1NZUhEMFGmN328zSC8nrYFE0qDgchpdo63d4IzquHSuJ+yJ4Dj33Q==
X-Received: by 2002:a2e:9983:: with SMTP id w3mr19031046lji.58.1558603124731;
        Thu, 23 May 2019 02:18:44 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q9sm5909529lfn.88.2019.05.23.02.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 02:18:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTjrz-0002Gs-JK; Thu, 23 May 2019 11:18:39 +0200
Date:   Thu, 23 May 2019 11:18:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Message-ID: <20190523091839.GC568@localhost>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost>
 <20190521101059.GB13612@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521101059.GB13612@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:10:59PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
> > On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
> > > If ulite_probe is not called or failed to registed
> > > uart_register_driver, unload the module will call
> > > uart_unregister_driver, which will tigger NULL
> > > pointer dereference like this:
> > > 
> > > BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> > > Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
> > 
> > > This patch fix this by moving uart_unregister_driver
> > > to ulite_remove.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/tty/serial/uartlite.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> > > index b8b912b..2e49fb6 100644
> > > --- a/drivers/tty/serial/uartlite.c
> > > +++ b/drivers/tty/serial/uartlite.c
> > > @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
> > >  	pm_runtime_disable(&pdev->dev);
> > >  	pm_runtime_set_suspended(&pdev->dev);
> > >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > +	uart_unregister_driver(&ulite_uart_driver);
> > 
> > This broken. Consider what happens if you have tho ports registered and
> > you unbind the first.
> > 
> > Someone else sent a fix for this here
> > 
> > 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
> > 
> > That fix also has some issues, but is still better given the current
> > state this driver is in.
> 
> I'm not taking any of these patches until people agree on what needs to
> be done here :)

Good. :)

> Why is this driver so "special" it is having these types of problems?
> Why can't it do what all other drivers do in this case?

Apparently some vendor-tree hacks has made it into mainline. They're
trying to register one tty/uart driver per physical port which sounds
like a terrible idea. And even the implementation is broken as these bug
reports indicate.

A series was apparently first posted for xilinks_uartps.c, but that one
has not yet been merged AFAICT. A similar series was later posted for
uartlite.c, but only the first half or so got in:

	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com

Actually, it looks like the problems started already with:

	https://lkml.kernel.org/r/1533545534-24458-1-git-send-email-shubhrajyoti.datta@gmail.com

So the first broken commit is

	415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")

I think the offending patches should be reverted, but unfortunately they
may no longer revert cleanly since there were some new features (e.g.
runtime pm) thrown in the mix.

Johan
