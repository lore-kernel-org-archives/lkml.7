Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B220840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551459608;
	bh=L5vtetHrEy9oal9REsCsxQSvlO9Q456lbnteWlGnOIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bpnPH0BTmG51E5dAkIJnGNntnOMbN9v8yYUjM9r7S+hUXDpw/EzYqwe6qYnb/9XUf
	 StHUSeHRJUwVZVNeJxXtU+s6r8G7iBkDyUNVeZLZTaLSFhfP3oJ3M/aluD/k73px8L
	 TenLBkEsBUkAbvY+o7aVxUOJ2NdkPL6CJZoORvLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbfCARAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389182AbfCARAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:00:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E2020857;
        Fri,  1 Mar 2019 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551459605;
        bh=L5vtetHrEy9oal9REsCsxQSvlO9Q456lbnteWlGnOIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUyX9ZkfolsvavE0N7lY29W2RxFT9Hr72sJ/v4ojB5iRXvjP3h1xbagIBJEyBlC6e
         IphJVjq3Fz80Y0q/RgeWLeHp7UGPGXDgQLHY+1qqLFuZG5G0xEu5rZh7b3bsd4j6md
         F3jKzp2hgo8NqFUe2KvxNCIjCtGK2bVDLe5h0Fco=
Date:   Fri, 1 Mar 2019 18:00:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [RFC net-next 1/8] subdev: Introducing subdev bus
Message-ID: <20190301170002.GB24452@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-2-git-send-email-parav@mellanox.com>
 <20190301071727.GA8975@kroah.com>
 <AM4PR0501MB22601B097AF53AAFD59CB8B6D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB22601B097AF53AAFD59CB8B6D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:35:46PM +0000, Parav Pandit wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, March 1, 2019 1:17 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > <jiri@mellanox.com>
> > Subject: Re: [RFC net-next 1/8] subdev: Introducing subdev bus
> > 
> > On Thu, Feb 28, 2019 at 11:37:45PM -0600, Parav Pandit wrote:
> > > Introduce a new subdev bus which holds sub devices created from a
> > > primary device. These devices are named as 'subdev'.
> > > A subdev is identified similarly to pci device using 16-bit vendor id
> > > and device id.
> > > Unlike PCI devices, scope of subdev is limited to Linux kernel.
> > 
> > But these are limited to only PCI devices, right?
> > 
> For Mellanox use case yes, its limited to PCI devices.
> 
> > This sounds a lot like that ARM proposal a week or so ago that asked for
> > something like this, are you working with them to make sure your proposal
> > works for them as well?  (sorry, can't find where that was announced, it was
> > online somewhere...)
> > 
> We were not aware of it, mostly because we are either on net side of mailing lists (netdev, rdma, virt etc).
> ARM proposal likely on linux-kernel, I guess.
> I will lookup that proposal and surely see if both of us can use common infrastructure.
> 
> > > A central entry that assigns unique subdev vendor and device id is:
> > > include/linux/subdev_ids.h enums. Enum are chosen over define macro so
> > > that two vendors do not end up with vendor id in kernel development
> > > process.
> > 
> > Why not just make it dynamic with on static ids?
> > 
> Can you please elaborate?
> Do you mean we should use something similar to pci_add_dynid() with enhancement to catch duplicate id addition?

I have no idea what I wrote here, sorry :)

I was trying to say something like "using an enumerated type going to
rely on a central authority for your "dynamic" bus, why is that needed
at all"?

> > > subdev bus holds subdevices of multiple devices. A typical created
> > > subdev for a PCI device in sysfs tree appears under their parent's
> > > device as using core's default device naming scheme:
> > >
> > > subdev<instance_id>.
> > > i.e.
> > > subdev0
> > > subdev1
> > >
> > > $ ls -l /sys/bus/pci/devices/0000:05:00.0 [..]
> > > drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev0
> > > drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev1
> > >
> > > Device model view:
> > > ------------------
> > >                +------+    +------+       +------+
> > >                |subdev|    |subdev|       |subdev|
> > >           -----|  1   |----|  2   |-------|  3   |----------
> > >           |    +--|---+    +-|----+       +--|---+         |
> > >           --------|----------|---subdev bus--|--------------
> > >                   |          |               |
> > >                +--+----+-----+           +---+---+
> > >                |pcidev |                 |pcidev |
> > >           -----|   A   |-----------------|   B   |----------
> > >           |    +-------+                 +-------+         |
> > >           -------------------pci bus------------------------
> > 
> > To be clear, "subdev bus" is just a logical grouping, there is no physical
> > backing "bus" here at all, right?
> > 
> Yep. that's correct.
> 
> > What is going to "bind" to subdev devices?  PCI drivers?  Or new types of
> > drivers?
> > 
> Devices are placed on subdev bus using devlink interface. And drivers which registers using subdev_register_driver(), their probe() method will be called.

But it's just a virtual mapping, what "good" does this provide anyone?
You are still sharing the same backing device here, what does this
logical split buy you?

> So yes, those are PCI vendor driver.
> I tried to capture this in cover-letter.
> At present users didn't ask to map this subdev to VM, but there is very high chance that once we have this without PCI SR-IOV, they would like to extend to VMs too.
> So in that case devlink will have option to say, add 'passthrough' device, and in that case instead of vendor's pci driver, some high level vfio type driver will bind to it.
> That is just the anticipation, but we haven't really worked out this fully.
> But this model allows to do so.

I think mfd is what you want to do here, instead of creating your own
bus type.

> > > +int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
> > > +		   enum subdev_vendor_id vid, enum subdev_device_id did) {
> > > +	u32 id = 0;
> > > +	int ret;
> > > +
> > > +	if (!parent_dev)
> > > +		return -EINVAL;
> > 
> > No root devices?
> > 
> I didn't get the comment. Intent of this check is subdev must have parent. Parent type doesn't matter.

You do not allow a subdev to sit at the "root" of the device tree.
That's fine, it was just a comment, it's your choice.

thanks,

greg k-h
