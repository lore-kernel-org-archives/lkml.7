Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14670C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA899227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576153257;
	bh=eBkPCbN+a5nBEtF0cvytYNK/LsEi3MzHof3FZUsKDq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YPNl44LbVlVrVE4ImsMwMnZte7mOVqIFjeqEMXQplaX+iQbRxWqoW55zayezWNGhK
	 2iYUa4LeywTpTLeIL+HnG7yk2AB9SnSZL8N9s3jCzajRKOxAd4M2GtqqAP8OphAEve
	 1202MN9kUavgmASeVbcrSjl3Bsz47aMkP+MCAZaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLLMU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfLLMU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:20:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A05321655;
        Thu, 12 Dec 2019 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576153256;
        bh=eBkPCbN+a5nBEtF0cvytYNK/LsEi3MzHof3FZUsKDq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6G22sVpPYyowX4nr61saY9ArdC/97JNp7ksn9Inqz71+3YIditDdxZqLa0QpfZR9
         rzGqMlL32D/2HDztW/hS0jApXo8v0HxbkdoQX6P8oveMJBAkKZtbg2/QWQGIqDeNgn
         aJPjfPc8puaHGXg2+SzlDdDRhiOx6hXti6EV1xf4=
Date:   Thu, 12 Dec 2019 13:20:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, linux@roeck-us.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
Message-ID: <20191212122053.GA1541203@kroah.com>
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
 <20191212090132.GC31345@kuha.fi.intel.com>
 <5DF20530.2040509@huawei.com>
 <20191212092805.GA1375559@kroah.com>
 <5DF20B18.4020601@huawei.com>
 <20191212111805.GD31345@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212111805.GD31345@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:18:05PM +0200, Heikki Krogerus wrote:
> On Thu, Dec 12, 2019 at 05:40:40PM +0800, zhong jiang wrote:
> > On 2019/12/12 17:28, Greg KH wrote:
> > > On Thu, Dec 12, 2019 at 05:15:28PM +0800, zhong jiang wrote:
> > >> On 2019/12/12 17:01, Heikki Krogerus wrote:
> > >>> On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
> > >>>> Fixes the following compile error:
> > >>>>
> > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> > >>>> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> > >>>> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> > >>>> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> > >>>> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> > >>>> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> > >>>> make: *** [vmlinux] Error 1
> > >>> There are stubs for those functions so that really should not be
> > >>> happening. I can not reproduce that.
> > >> It can be reproduced in next branch. you can try it in the latest next branch.
> > > Can it be reproduced in 5.5-rc1?
> > >
> > commit 78adcacd4edbd6795e164bbda9a4b2b7e51666a7
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Thu Dec 12 15:48:07 2019 +1100
> > 
> >     Add linux-next specific files for 20191212
> > 
> > I  reproduce it  based on this commit.  The related config is attached.
> 
> OK, now I get what's going on. EXTCON is build as a module, but
> FUSB302 is not. This should be explained in the commit message.
> 
> That does not mean we have to force everybody to enable EXTCON in
> order to use this driver. Try something like this:
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 72481bbb2af3..06e026f6325c 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -31,6 +31,7 @@ endif # TYPEC_TCPCI
> 
>  config TYPEC_FUSB302
>         tristate "Fairchild FUSB302 Type-C chip driver"
> +       depends on EXTCON=n || EXTCON=y || (EXTCON=m && m)

Ugh.  We need a better "pattern" for stuff like this, it's getting more
and more frequent.

And no, I don't have a better idea :(

thanks,

greg k-h
