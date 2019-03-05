Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A09C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344AD20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551814057;
	bh=BZfIMvDRmWU9VvcL+NNAQV7DJZm0MqPa8dItDSB7GXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IHjTM2msA7z7s5NH4vfYk6/9D3d66lJwysaGsHO849t+ewUc9dJLhACGPxKkrrsxz
	 HCAKmzAwQE/qPDWyVlEcTlmOenyLy8E0ioIWzQY08oKRCwJcZi6JETfFVO3JlsvWRo
	 WaljM4UHYVGhTCHQoyVP5Q3EpWuXFPIzAMk0Y4/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCET1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfCET1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:27:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B967220652;
        Tue,  5 Mar 2019 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551814052;
        bh=BZfIMvDRmWU9VvcL+NNAQV7DJZm0MqPa8dItDSB7GXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZXf0SyxmYIEQsN6YqXgy2anhaJhnoyjIW/wYIxgX15Ia9KFpBkLjXmWsLHs5c4Ma
         gEg+mG+uK1WZNEpT8/6qYB7DOeOSJgYpuBc70nP7lKLByk2NM9vag77L/ytO99XMgq
         5jhAU+BqaI/qFsBLWNP1i4DMVxMAZSdJ+TA3wsbQ=
Date:   Tue, 5 Mar 2019 20:27:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Message-ID: <20190305192729.GA17047@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <20190301072158.GC8975@kroah.com>
 <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
 <20190305071331.GA2060@kroah.com>
 <VI1PR0501MB2271AA91B5D29CA69778268BD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB2271AA91B5D29CA69778268BD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:57:58PM +0000, Parav Pandit wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, March 5, 2019 1:14 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > <jiri@mellanox.com>; Jakub Kicinski <jakub.kicinski@netronome.com>
> > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to
> > subdev devices
> > 
> > On Fri, Mar 01, 2019 at 05:21:13PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Friday, March 1, 2019 1:22 AM
> > > > To: Parav Pandit <parav@mellanox.com>
> > > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > > > <jiri@mellanox.com>
> > > > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind
> > > > to subdev devices
> > > >
> > > > On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> > > > > Add a subdev driver to probe the subdev devices and create fake
> > > > > netdevice for it.
> > > >
> > > > So I'm guessing here is the "meat" of the whole goal here?
> > > >
> > > > You just want multiple netdevices per PCI device?  Why can't you do
> > > > that today in your PCI driver?
> > > >
> > > Yes, but it just not multiple netdevices.
> > > Let me please elaborate in detail.
> > >
> > > There is a swichdev mode of a PCI function for netdevices.
> > > In this mode a given netdev has additional control netdev (called
> > representor netdevice = rep-ndev).
> > > This rep-ndev is attached to OVS for adding rules, offloads etc using
> > standard tc, netfilter infra.
> > > Currently this rep-ndev controls switch side of the settings, but not the
> > host side of netdev.
> > > So there is discussion to create another netdev or devlink port..
> > >
> > > Additionally this subdev has optional rdma device too.
> > >
> > > And when we are in switchdev mode, this rdma dev has similar rdma rep
> > device for control.
> > >
> > > In some cases we actually don't create netdev when it is in InfiniBand
> > mode.
> > > Here there is PCI device->rdma_device.
> > >
> > > In other case, a given sub device for rdma is dual port device, having
> > netdevice for each that can use existing netdev->dev_port.
> > >
> > > Creating 4 devices of two different classes using one iproute2/ip or
> > iproute2/rdma command is horrible thing to do.
> > 
> > Why is that?
> > 
> When user creates the device, user tool needs to return a device handle that got created.
> Creating multiple devices doesn't make sense. I haven't seen any tool doing such crazy thing.

And what do you mean by "device handle"?  All you get here is a sysfs
device tree.

> > > In case if this sub device has to be a passthrough device, ip link command
> > will fail badly that day, because we are creating some sub device which is not
> > even a netdevice.
> > 
> > But it is a network device, right?
> > 
> When there is passthrough subdevice, there won't be netdevice created.
> We don't want to create passthrough subdevice using iproute2/ip tool which primarily works on netdevices.

I don't know enough networking to claim anything here, so I'll ignore
this :)

> > > So iproute2/devlink which works on bus+device, mainly PCI today, seems
> > right abstraction point to create sub devices.
> > > This also extends to map ports of the device, health, registers debug, etc
> > rich infrastructure that is already built.
> > >
> > > Additionally, we don't want mlx driver and other drivers to go through its
> > child devices (split logic in netdev and rdma) for power management.
> > 
> > And how is power management going to work with your new devices?  All
> > you have here is a tiny shim around a driver bus, 
> So subdevices power management is done before their parent's.
> Vendor driver doesn't need to iterate its child devices to suspend/resume it.

True, so we can just autosuspend these "children" device and the "vendor
driver" is not going to care?  You are going to care as you are talking
to the same PCI device.  This goes to the other question about "how are
you sharing PCI device resources?"

> > I do not see any new
> > functionality, and as others have said, no way to actually share, or split up,
> > the PCI resources.
> > 
> devlink tool create command will be able to accept more parameters during device creation time to share and split PCI resources.
> This is just the start of the development and RFC is to agree on direction.
> devlink tool has parameters options that can be queried/set and existing infra will be used for granular device config.

Pointers to this beast?

> > > Kernel core code does that well today, that we like to leverage through
> > subdev bus or mfd pm callbacks.
> > >
> > > So it is lot more than just creating netdevices.
> > 
> > But that's all you are showing here :)
> > 
> Starting use case is netdev and rdma, but we don't want to create new
> tools few months/a year later for passthrough mode or for different
> link layers etc.

And I don't want to see duplicated driver model code happen either,
which is why I point out the MFD layer :)

> > > > What problem are you trying to solve that others also are having
> > > > that requires all of this?
> > > >
> > > > Adding a new bus type and subsystem is fine, but usually we want
> > > > more than just one user of it, as this does not really show how it
> > > > is exercised very well.
> > > This subdev and devlink infrastructure solves this problem of creating
> > smaller sub devices out of one PCI device.
> > > Someone has to start.. :-)
> > 
> > That is what a mfd should allow you to do.
> > 
> I did cursory look at mfd.
> It lacks removing specific devices, but that is small. It can be
> enhanced to remove specific mfd device.

That should be easy enough, work with the MFD developers.  I think
something like that should work today as you can use USB devices with
MFD, right?

> > 
> > No, do not abuse a platform device. 
> Yes. that is my point mfd devices are platform devices.
> mfd creates platform devices. and to match to it, platfrom_register_driver() have to be called to bind to it.
> I do not know currently if we have the flexibility to say that instead of binding X driver, bind Y driver for platform devices.

try it :)

> > You should be able to just use a normal
> > PCI device for this just fine, and if not, we should be able to make the
> > needed changes to mfd for that.
> > 
> Ok. so parent pci device and mfd devices.
> mfd seems to fit this use case.
> Do you think 'Platform devices' section is stale in [1] for autonomy, host bridge, soc platform etc points?

Nope, they are still horrible things and I hate them :)

Maybe we should just make MFD create "virtual" devices (bare ones, no
need for platform stuff), and that would solve the issue of the platform
device bloat being drug around everywhere.

> Should we update the documentation to indicate that it can be used for
> non-autonomous, user created devices and it can be used for creating
> devices on top of PCI parent device etc?

Nope, leave it alone please.

thanks,

greg k-h
