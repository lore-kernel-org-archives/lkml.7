Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D19C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468D5217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558433464;
	bh=3XiZCXDyFIOqJ0brClUDF41oj7AQYFEXL3hF5p3J1MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0OshatT8TPFhkM3zzsWsOwC+JJWHi5lAWpX27zy65QwXyHE7hNwNgvexvJWMnuST7
	 uGOGKiu+pXmPHKEBNj/bhS+Y13SHVblAjmh66e8J1kqt30MdpANU+92X+NSsu+V/bI
	 bHdlh8qFzzNEhEmoL4tX+aIHpIhKnwNEPB8DepVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEUKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfEUKLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:11:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C090921773;
        Tue, 21 May 2019 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558433462;
        bh=3XiZCXDyFIOqJ0brClUDF41oj7AQYFEXL3hF5p3J1MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhimzAOKn9lJyHCTZ4zl9j4WYMekkcTm2pztQ+UbAP+G1OEuI9BgoTxSDpTinqfHj
         BZ4ybeKhWbQgw9tm/vF9WsgH8tOCdMNQpBbpctd003WtghHsFCI4wAhX4SKaZs0OL1
         7r3hkCYVMpa5t3oGP/je5LAzl8ds1zduHNw15r9Y=
Date:   Tue, 21 May 2019 12:10:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, jacmet@sunsite.dk,
        jslaby@suse.com, shubhrajyoti.datta@xilinx.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Message-ID: <20190521101059.GB13612@kroah.com>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075502.GE28564@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
> On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
> > If ulite_probe is not called or failed to registed
> > uart_register_driver, unload the module will call
> > uart_unregister_driver, which will tigger NULL
> > pointer dereference like this:
> > 
> > BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> > Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
> 
> > This patch fix this by moving uart_unregister_driver
> > to ulite_remove.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/tty/serial/uartlite.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> > index b8b912b..2e49fb6 100644
> > --- a/drivers/tty/serial/uartlite.c
> > +++ b/drivers/tty/serial/uartlite.c
> > @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +	uart_unregister_driver(&ulite_uart_driver);
> 
> This broken. Consider what happens if you have tho ports registered and
> you unbind the first.
> 
> Someone else sent a fix for this here
> 
> 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
> 
> That fix also has some issues, but is still better given the current
> state this driver is in.

I'm not taking any of these patches until people agree on what needs to
be done here :)

Why is this driver so "special" it is having these types of problems?
Why can't it do what all other drivers do in this case?

thanks,

greg k-h
