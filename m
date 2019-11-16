Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239A8206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573907940;
	bh=HBkvlpFZIO65jcpBhQKXq2tVhuOky695hw0cijzuhes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dhjwumpquw8eH+452nVCNBr7eLEqMFoWFTWCCyv1a2gCJfvFZ2y0n8v39Xh80NavP
	 OhtVBG4+zmsnZa7ON0a7j7USVyL5w96a7zOar2EwcJtJAIMQ+iVFp6eVibW0dizGsa
	 TrA0D+9jRr3gh6mcAWyVXjxhUVbrDVXfnngKeLkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKPMiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfKPMiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:38:55 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05B6206D3;
        Sat, 16 Nov 2019 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573907934;
        bh=HBkvlpFZIO65jcpBhQKXq2tVhuOky695hw0cijzuhes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEZEAIXGtb20yNhvRlpWj5+HQNlUPUEsmiFAmvRDv0dOoU6+DkD2gRDDvx9o1WEIf
         QZPuCEZ7csgGCPzhiALnl2vfMDCrhiDmgk7BRKVkZiMncNk2eH7cUvHM0tsOn9zJm3
         SbUYJQAMlZCg7jZdejx3g2Ws4UVbVkz6YNDpQsPE=
Date:   Sat, 16 Nov 2019 13:38:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: bus: add more client attributes to sysfs
Message-ID: <20191116123851.GA450532@kroah.com>
References: <20191116142136.17535-1-tomas.winkler@intel.com>
 <20191116115824.GB425445@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DD16447@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DD16447@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 12:08:52PM +0000, Winkler, Tomas wrote:
> > 
> > On Sat, Nov 16, 2019 at 04:21:36PM +0200, Tomas Winkler wrote:
> > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > >
> > > Export more client attributes via sysfs that are usually obtained upon
> > > connection. In some cases, for example a monitoring application may
> > > wish to know the attributes without actually performing the connection.
> > > Added attributes:
> > > max number of connections, fixed address, max message length.
> > >
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-mei | 21 +++++++++++++++
> > >  drivers/misc/mei/bus.c                  | 33 +++++++++++++++++++++++
> > >  drivers/misc/mei/client.h               | 36 +++++++++++++++++++++++++
> > >  3 files changed, 90 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-mei
> > > b/Documentation/ABI/testing/sysfs-bus-mei
> > > index 3f8701e8fa24..3d37e2796d5a 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-mei
> > > +++ b/Documentation/ABI/testing/sysfs-bus-mei
> > > @@ -26,3 +26,24 @@ KernelVersion:	4.3
> > >  Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > >  Description:	Stores mei client protocol version
> > >  		Format: %d
> > > +
> > > +What:		/sys/bus/mei/devices/.../max_conn
> > > +Date:		Nov 2019
> > > +KernelVersion:	5.5
> > > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > > +Description:	Stores mei client maximum number of connections
> > > +		Format: %d
> > > +
> > > +What:		/sys/bus/mei/devices/.../fixed
> > > +Date:		Nov 2019
> > > +KernelVersion:	5.5
> > > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > > +Description:	Stores mei client fixed address, if any
> > > +		Format: %d
> > > +
> > > +What:		/sys/bus/mei/devices/.../max_len
> > > +Date:		Nov 2019
> > > +KernelVersion:	5.5
> > > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > > +Description:	Stores mei client maximum message length
> > > +		Format: %d
> > > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> > > 53bb394ccba6..a0a495c95e3c 100644
> > > --- a/drivers/misc/mei/bus.c
> > > +++ b/drivers/misc/mei/bus.c
> > > @@ -791,11 +791,44 @@ static ssize_t modalias_show(struct device *dev,
> > > struct device_attribute *a,  }  static DEVICE_ATTR_RO(modalias);
> > >
> > > +static ssize_t max_conn_show(struct device *dev, struct device_attribute
> > *a,
> > > +			     char *buf)
> > > +{
> > > +	struct mei_cl_device *cldev = to_mei_cl_device(dev);
> > > +	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
> > > +
> > > +	return scnprintf(buf, PAGE_SIZE, "%d", maxconn);
> > 
> > Nit, you can just do sprintf() for sysfs file attributes as you "know"
> > the buffer is big enough and your variable will fit.
> > 
> > Not a bit deal, but something to do in the future.
> 
> 
> Right, missed that, I can fix it in a follow up patch or resend this one.

follow-up is fine, I've already queued this one up.

thanks,

greg k-h
