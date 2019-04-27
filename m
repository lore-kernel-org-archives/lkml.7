Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F1C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90167208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556361906;
	bh=flwco3je1Q/uKS+Nq99CsLoSDI9a68ilfeV6XvEgXDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=heo/Xj/tcwlhkWxoLhbVnLZZok4xM3k10u6uocFqxRt704NgUNbrpH2qNOZvyrl5L
	 ih76kBZy1y9PNAsKTfMfhCsBU2HzjsibVmeiCcm7F8vhg44nVrUKR71Mx3d6aujZUj
	 WFORDy391jUh3gSOaBQgnIW6FqJ0ziUZNeMAcTkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfD0KpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfD0KpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:45:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E46B2087C;
        Sat, 27 Apr 2019 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556361903;
        bh=flwco3je1Q/uKS+Nq99CsLoSDI9a68ilfeV6XvEgXDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ET+o2mRrk7w2HBVR1EVzWcjZyA8pi6hkypugsCtgm50yGKrmpeCCpZbWeXloZzieU
         RpG8ueOgAKOSY39GdswtldQ3NlpfZB4J4ezCYNe7iINVPoJE8ke73LCLvlEk/buc+A
         ecNL36YBKTPEUY+Fk2tFGgycvK4jMhsVogIlEUTc=
Date:   Sat, 27 Apr 2019 12:45:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427104500.GA26765@kroah.com>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
 <20190427071025.hdrm3e5abnl4yock@mobilestation>
 <20190427073200.GB30973@kroah.com>
 <20190427073940.6yzhklfus4qd6ver@mobilestation>
 <20190427075323.GA31478@kroah.com>
 <20190427093110.3rx42ucv2zqjjnrp@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427093110.3rx42ucv2zqjjnrp@mobilestation>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:31:11PM +0300, Serge Semin wrote:
> On Sat, Apr 27, 2019 at 09:53:23AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 27, 2019 at 10:39:41AM +0300, Serge Semin wrote:
> > > On Sat, Apr 27, 2019 at 09:32:00AM +0200, Greg Kroah-Hartman wrote:
> > > > On Sat, Apr 27, 2019 at 10:10:27AM +0300, Serge Semin wrote:
> > > > > On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > > > > > > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > > > > > > state. This is the mode the hub is supposed to be to let this driver
> > > > > > > work correctly. But a race condition might happen right after reset
> > > > > > > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > > > > > > function. In case if the reset pin is handled by a i2c GPIO expander,
> > > > > > > which is also placed at the same i2c-bus segment as the usb251x
> > > > > > > SMB-interface connected to, then the hub reset clearance might
> > > > > > > cause the CFG_SEL[0] being latched in unpredictable state. So
> > > > > > > sometimes the hub configuration mode might be 0x1 (as expected),
> > > > > > > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > > > > > > interface activated and consequently causes this driver failure.
> > > > > > > 
> > > > > > > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > > > > > > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > > > > > > it doesn't, we can safely block the segment for the time the reset is
> > > > > > > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > > > > > > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > > > > > > just return an error. If we locked the i2c-bus segment and tried to
> > > > > > > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > > > > > > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > > > > > > 
> > > > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > 
> > > > > > I signed off on this?  Where?  When?
> > > > > > 
> > > > > > never add a s-o-b line that you did not create, that implies a legal
> > > > > > agreement.
> > > > > > 
> > > > > 
> > > > > Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
> > > > > since you already added the first version of this into linux-next tree. But
> > > > > apparently copy-pasted and left as is...
> > > > 
> > > > If I have already applied a patch, I can't apply it again (or a
> > > > different version.)  You need to send a fix-up patch for the reported
> > > > issue, not a whole new one as I can not go back in time and rewrite
> > > > history.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Ok. Should I send it in reply to this patch or as a completely separate one?
> > 
> > A separate one.
> 
> Just did this.
> 
> Two more questions.
> 
> Is there any online service or ready-to-use configs-gen-script to build
> patchsets locally with various kernel configs before sending them for review?
> By using this I'd most likely prevent such unfortunate mistakes in future
> patches.

'make allmodconfig' works for me.  Also, the 0-day bot sometimes will
test patches sent to the mailing list before they are applied, but that
doesn't always work.

> I suppose the situation like this isn't unique, and there are other patches
> submitted with possible compilation problems. In this case seeing the linux-next
> will be eventually integrated into the linux-stable, then at the point of those
> patches the kernel source code will be build-broken corresponding config.
> In this case wouldn't it be better to have some rebasable branch with build
> robot service and fix the problematic patches in-place instead of
> apply an incrementing commits? This also would keep the source code cleaner
> at that particular commits.

As this passed the first round of 0-day testing in my rebasable branch,
I assumed it was good enough.  But later testing found that not to be
the case, which is pretty rare.  And I can't have public trees that are
rebasable as people work off of them, so we can just live with fixing
this up.

thanks,

greg k-h
