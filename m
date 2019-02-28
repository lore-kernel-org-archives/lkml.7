Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E460A218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551342940;
	bh=fO3nInzBdbn7z0qyyE4t/ur1U8Xt2SJRP2XuX10mjNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oPLndAHwDusi8Nhl3/I+MyW5NtC40gUiCwI3VT1+HHRaQAhLCkWDTLc9dlf5Hf9Z/
	 e7SIGBzaLDoGR5okY+V9I6GFKfSof9VXGW+uIuTUiwTnE7cClQbwxbK1WCZwwhDODw
	 N3iH7OaWnlyk5G4okAmUa2c8LvEPHCs6LoDGodkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfB1Ifi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbfB1Ifh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:35:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896F8218AE;
        Thu, 28 Feb 2019 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551342937;
        bh=fO3nInzBdbn7z0qyyE4t/ur1U8Xt2SJRP2XuX10mjNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGaCKN7tScPlAkaEhtAyyS7sWFZYUpmRpGuCpX3I9aqESf7zsg9Xa7P/uxId5e+ly
         K8VY2LFCmIvlnOkrEJMovSnDYijm5sCIRteCewPNxhC6fAGbktC24TpoVy1lQEMwFC
         vKoOMGe/fz80BbtHvrtKD461fZ8BTwaQ5jWmCZ8g=
Date:   Thu, 28 Feb 2019 09:35:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190228083534.GA16271@kroah.com>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost>
 <20190227095424.GA11387@kroah.com>
 <20190227105951.GM4747@localhost>
 <20190227120645.GA15587@kroah.com>
 <20190227133226.GQ4747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227133226.GQ4747@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 02:32:26PM +0100, Johan Hovold wrote:
> On Wed, Feb 27, 2019 at 01:06:45PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 27, 2019 at 11:59:51AM +0100, Johan Hovold wrote:
> 
> > Yeah, that is a good point, normally we use packed to keep padding from
> > the middle of the structure from happening.
> > 
> > I just don't like that 4 bytes sitting there doing nothing :)
> 
> You could perhaps put them directly in struct device if the
> dev_links_info struct is just used a separator there and this really
> bothers you. :)

True :)

> > But, in thinking about this, there is no real reason that I can see that
> > this structure even is in struct device.  It should be able to be in the
> > private "internal" structure.
> > 
> > The patch below moves it out of struct device entirely.  Overall there
> > is no memory savings, but it could give us the chance to only create
> > this structure if we really need it later on, as very few things use
> > links at this point in time.
> > 
> > Rafael, there is one logic change below, the link structure is not
> > initialized until device_add() happens, instead of device_initialize().
> > Will that affect anything that you can think of?  Does anyone do
> > anything with links before device_add() is called?
> 
> I think device_add() may be too late.
> 
> 	The earliest point in time when device links can be added is
> 	after :c:func:`device_add()` has been called for the supplier
> 	and :c:func:`device_initialize()` has been called for the
> 	consumer.

That is true today due to the way the code is set up, but it would be
good to figure out if anyone actually does call it this early.

thanks,

greg k-h
