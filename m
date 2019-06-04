Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CAEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A28424C96
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559634241;
	bh=NvdK8lMAfKjdnCZQ+IRP9uhnMLT1EkXpd9a+0DvNXVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TB5LjxbD5xFPyTvnQ1VO7jWofb+gNuZXJY+hIAwDp99bJe99XM9ZQsW/0SSuwVN6x
	 Tpq5UU7DoCJrGxn8hoRPvPaBpQrSA0mWgw9VD1hleDt/Y9Ob69OEwzXMrTZwi6bewQ
	 2JDzruxY/c3dWzcgVcdIQUQN5qzJUrhOUuf7z/6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFDHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:44:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5B62084A;
        Tue,  4 Jun 2019 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559634239;
        bh=NvdK8lMAfKjdnCZQ+IRP9uhnMLT1EkXpd9a+0DvNXVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilHBo0li2/H0Kt4eUR7rvbE2ItvJq6XVMr0hj2fcdhKxbd9A4knoPCxKmxiU7/8yZ
         qBPPdOPXjBiB2DJyRWosePzhDWF3BMt6q4lDE/8yhbu3BG2/bfhDMNHzi9iRTEiw7K
         W7e4jp+Evs3KzbBGsYFgpRaDbYCvL5lexueEDorc=
Date:   Tue, 4 Jun 2019 09:43:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 02/57] drivers: ipmi: Drop device reference
Message-ID: <20190604074356.GA29192@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
 <20190603190921.GC6487@kroah.com>
 <20190603195927.GN2742@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603195927.GN2742@minyard.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:59:27PM -0500, Corey Minyard wrote:
> On Mon, Jun 03, 2019 at 09:09:21PM +0200, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 04:49:28PM +0100, Suzuki K Poulose wrote:
> > > Drop the reference to a device found via bus_find_device()
> > > 
> > > Cc: Corey Minyard <minyard@acm.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >  drivers/char/ipmi/ipmi_si_platform.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> > > index f2a91c4..ff82353 100644
> > > --- a/drivers/char/ipmi/ipmi_si_platform.c
> > > +++ b/drivers/char/ipmi/ipmi_si_platform.c
> > > @@ -442,6 +442,7 @@ void ipmi_remove_platform_device_by_name(char *name)
> > >  				      pdev_match_name))) {
> > >  		struct platform_device *pdev = to_platform_device(dev);
> > >  
> > > +		put_device(dev);
> > >  		platform_device_unregister(pdev);
> > 
> > So you drop the reference, and then actually use the pointer?
> 
> I did think about this, and in this case you can, I think.
> platform_device_unregister() does a put_device() at the end of it's
> processing, right?

Yes, but that is the reference of the counter that was originally
initialized, not the reference that was just grabbed here.  It's really
all the same :)

> But it is better style to do it the other way, so I can change it.

Please do, thanks.

greg k-h
