Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC6FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557146070;
	bh=Q5fMKkiVbMug91PNamL4tmMt8uapZ0T4Sv2f/qxiycY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xSHgRB8GfkW/UCJg+FUCD7PfdO38i+NelrU+34Fc6cZOek6fUtZFvSmpfsAJCWM40
	 y9PZ/Ud/dAYdMEV48A6ecNOaMBsyNb7LrXCsNHrcgUgZV4pFWQhSzWIAJaguPSNoCz
	 Y2yVlqhu1O/4Jj3+pCXPzxgMSgvP1PLx1Hxr4gGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfEFMe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFMe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:34:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B21D206A3;
        Mon,  6 May 2019 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557146068;
        bh=Q5fMKkiVbMug91PNamL4tmMt8uapZ0T4Sv2f/qxiycY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKdDlF1jgWRs4Kfa2YhXCcLOjwm3zsi+ltisEgtFAsulfDfKDocSqj8Wwl1zroQcG
         sLhn41HptU6mriC06C7kYOL/MOczjcYdETIiWeumf4l8QWPNgKZ4LTdb4d14jTPyuB
         eQPblBCjlfOPPaOZ6IFD6ahsOJM2alEKKCP1fIDI=
Date:   Mon, 6 May 2019 14:34:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
Message-ID: <20190506123425.GA26360@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
 <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190504075502.GA11133@kroah.com>
 <BL0PR02MB56814D6EACC16938A0575D16CB300@BL0PR02MB5681.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB56814D6EACC16938A0575D16CB300@BL0PR02MB5681.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 12:23:56PM +0000, Dragan Cvetic wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Saturday 4 May 2019 08:55
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > 
> > On Fri, May 03, 2019 at 04:41:21PM +0000, Dragan Cvetic wrote:
> > > Hi Greg,
> > >
> > > Please find my inline comments below,
> > >
> > > Regards
> > > Dragan
> > >
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Thursday 2 May 2019 18:20
> > > > To: Dragan Cvetic <draganc@xilinx.com>
> > > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > > >
> > > > On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> > > > > +#define DRIVER_NAME "xilinx_sdfec"
> > > > > +#define DRIVER_VERSION "0.3"
> > > >
> > > > Version means nothing with the driver in the kernel tree, please remove
> > > > it.
> > >
> > > Will be removed. Thank you.
> > >
> > > >
> > > > > +#define DRIVER_MAX_DEV BIT(MINORBITS)
> > > >
> > > > Why this number?  Why limit yourself to any number?
> > > >
> > >
> > > There can be max 8 devices for this driver. I'll change to 8.
> > >
> > > > > +
> > > > > +static struct class *xsdfec_class;
> > > >
> > > > Do you really need your own class?
> > >
> > > When writing a character device driver, my goal is to create and register an instance
> > > of that structure associated with a struct file_operations, exposing a set of operations
> > > to the user-space. One of the steps to make this goal is Create a class for a devices,
> > > visible in /sys/class/.
> > 
> > Why do you need a class?  Again, why not just use the misc_device api,
> > that seems much more relevant here and will make the code a lot simpler.
> > 
> 
> The driver can have 8 devices in SoC plus more in Programming Logic.
> It looked logical to group them under the same MAJOR, although they
> are independent of each other.  Is this argument strong enough to use
> class?

Not really :)

8 devices is pretty small.  What tool will be trying to talk to all of
these devices and how was it going to find out what devices were in the
system?

thanks,

greg k-h
