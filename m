Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7576C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9C82087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556350325;
	bh=dh5f3T4cJp3SsaYCcSL9UdFWlx3AnkR8jybNow6zaJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T/yqYhliezmJReUc8xrD37bIsC+txDfdv6xi9OjqxsXSTXtzmuugy2qkp32NlauNe
	 rVcShJYrMrFPP2mrl4148jNVPUix9t1cQO6R3L3yZGvOnLWUjHtGPMnraWTZDINE6U
	 bJf8pQz57tMQGLN+dUgniDkWrNaC+C3MQFNk78Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfD0HcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0HcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:32:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0075206BB;
        Sat, 27 Apr 2019 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556350323;
        bh=dh5f3T4cJp3SsaYCcSL9UdFWlx3AnkR8jybNow6zaJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wdy5R0BELeIPD6005t7eU9cvAIAW0veU1r7IIuKdKcufUc8o6y0zuxiCXtq7S2C0W
         lzrOsMMfMPR6+N+IeuDIZXlHm03HgLK+eqgilU+TA1CnPR0kPMg3Eu+iYlDhrOd7Rc
         mepHt+UsbCymYCjF1D3FQf9mlMUKsKcL7BRR8U3g=
Date:   Sat, 27 Apr 2019 09:32:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427073200.GB30973@kroah.com>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
 <20190427071025.hdrm3e5abnl4yock@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427071025.hdrm3e5abnl4yock@mobilestation>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:10:27AM +0300, Serge Semin wrote:
> On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > > state. This is the mode the hub is supposed to be to let this driver
> > > work correctly. But a race condition might happen right after reset
> > > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > > function. In case if the reset pin is handled by a i2c GPIO expander,
> > > which is also placed at the same i2c-bus segment as the usb251x
> > > SMB-interface connected to, then the hub reset clearance might
> > > cause the CFG_SEL[0] being latched in unpredictable state. So
> > > sometimes the hub configuration mode might be 0x1 (as expected),
> > > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > > interface activated and consequently causes this driver failure.
> > > 
> > > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > > it doesn't, we can safely block the segment for the time the reset is
> > > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > > just return an error. If we locked the i2c-bus segment and tried to
> > > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > > 
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I signed off on this?  Where?  When?
> > 
> > never add a s-o-b line that you did not create, that implies a legal
> > agreement.
> > 
> 
> Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
> since you already added the first version of this into linux-next tree. But
> apparently copy-pasted and left as is...

If I have already applied a patch, I can't apply it again (or a
different version.)  You need to send a fix-up patch for the reported
issue, not a whole new one as I can not go back in time and rewrite
history.

thanks,

greg k-h
