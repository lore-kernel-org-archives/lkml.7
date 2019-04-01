Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F2FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9DE20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554119167;
	bh=R1DiDEmWN34Eu6wGHStCK95swdQT6eCvuFfPOAqtQXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ylhjc0/ztWC25MTUDRtrD21gU9TKnqQumUltXGBm9etngnUGh5fnyBtyFPeifOHM8
	 C7CSBRgdgdG5t4UuWuI9jRvjrhIvJuyOCpj2cfEQ8CuTdzfEDG76Oj5fBh4deBayXY
	 YvnltyBgAN7Y5vAVJtOppFFL4XlqOv1wlD+j2dd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDALqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDALqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:46:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF42A20880;
        Mon,  1 Apr 2019 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554119164;
        bh=R1DiDEmWN34Eu6wGHStCK95swdQT6eCvuFfPOAqtQXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTiXbUyrq0MLpZ0eTxZnshLsiW393LFThvvqHnOeEwBcHjE7pEKOq8LtOoeLa7jVf
         2YjfvJto1+mX37ALbDZ2OIYkbLVPaNWcG+xH2jeYlQBbj7+Ulxn/ovFbP8cAa2sr1f
         j5cUt7Yk8Obfg+pDV0sgt2l3I858QHm5GJJjmQC8=
Date:   Mon, 1 Apr 2019 13:46:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4.9 25/30] USB: core: only clean up what we allocated
Message-ID: <20190401114600.GE8156@kroah.com>
References: <20190326042607.558087893@linuxfoundation.org>
 <20190326042608.413616958@linuxfoundation.org>
 <20190330171838.GA2150@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330171838.GA2150@archlinux-ryzen>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:18:38AM -0700, Nathan Chancellor wrote:
> On Tue, Mar 26, 2019 at 03:30:04PM +0900, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Andrey Konovalov <andreyknvl@google.com>
> > 
> > commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3 upstream.
> > 
> > When cleaning up the configurations, make sure we only free the number
> > of configurations and interfaces that we could have allocated.
> > 
> > Reported-by: Andrey Konovalov <andreyknvl@google.com>
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  drivers/usb/core/config.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > --- a/drivers/usb/core/config.c
> > +++ b/drivers/usb/core/config.c
> > @@ -763,18 +763,21 @@ void usb_destroy_configuration(struct us
> >  		return;
> >  
> >  	if (dev->rawdescriptors) {
> > -		for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
> > +		for (i = 0; i < dev->descriptor.bNumConfigurations &&
> > +				i < USB_MAXCONFIG; i++)
> >  			kfree(dev->rawdescriptors[i]);
> >  
> >  		kfree(dev->rawdescriptors);
> >  		dev->rawdescriptors = NULL;
> >  	}
> >  
> > -	for (c = 0; c < dev->descriptor.bNumConfigurations; c++) {
> > +	for (c = 0; c < dev->descriptor.bNumConfigurations &&
> > +			c < USB_MAXCONFIG; c++) {
> >  		struct usb_host_config *cf = &dev->config[c];
> >  
> >  		kfree(cf->string);
> > -		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
> > +		for (i = 0; i < cf->desc.bNumInterfaces &&
> > +				i < USB_MAXINTERFACES; i++) {
> >  			if (cf->intf_cache[i])
> >  				kref_put(&cf->intf_cache[i]->ref,
> >  					  usb_release_interface_cache);
> > 
> > 
> 
> You reverted this upstream in commit cf4df407e0d7 ("Revert "USB: core:
> only clean up what we allocated"") in favor of commit 48a4ff1c7bb5
> ("USB: core: prevent malicious bNumInterfaces overflow"), which has been
> in this tree since 4.9.71.
> 
> Sorry for not catching this earlier,

Not a problem, thanks for letting me know, I've now queued up the fix
everywhere.

thanks,

greg k-h
