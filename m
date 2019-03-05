Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA939C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CC420848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551770016;
	bh=m3ssJpgzGPjMnDiklK+y5K6rH8PckJSfgnFKhs4vBD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I983MHmBlMHrwOuQAo6JDNIMIaHtTIYddDMS5QJL50YqVCsdKF+fYsdZHda/mgaQ9
	 yHaWlAwT4jA3I1b08dWrzEpvx7JDV71KftOW2a3H+jrbrVxDJCkCDRwX3SQ4WYlvxJ
	 RFbv3AXrZ9aKWjObG5iS3/1cbopt1AivqI3B88h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCEHNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfCEHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:13:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F58620675;
        Tue,  5 Mar 2019 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551770013;
        bh=m3ssJpgzGPjMnDiklK+y5K6rH8PckJSfgnFKhs4vBD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvDXnRR6eafRWprSXUBmWbi9ZAWZkunVI12V2YfFo+tib4me8bAGOXfAgocpCLfh5
         J1e/frf1MZ5BX7okgo1TY2st8rCZGOFg8K+IufcHMsxF6FQhaJs7xyJNg9Jg2YVaN8
         B31hqjqthsb0pXKhtKXjv/VaveZgOmCpLzXjr2mc=
Date:   Tue, 5 Mar 2019 08:13:31 +0100
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
Message-ID: <20190305071331.GA2060@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <20190301072158.GC8975@kroah.com>
 <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 05:21:13PM +0000, Parav Pandit wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, March 1, 2019 1:22 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > <jiri@mellanox.com>
> > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to
> > subdev devices
> > 
> > On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> > > Add a subdev driver to probe the subdev devices and create fake
> > > netdevice for it.
> > 
> > So I'm guessing here is the "meat" of the whole goal here?
> > 
> > You just want multiple netdevices per PCI device?  Why can't you do that
> > today in your PCI driver?
> > 
> Yes, but it just not multiple netdevices.
> Let me please elaborate in detail.
> 
> There is a swichdev mode of a PCI function for netdevices.
> In this mode a given netdev has additional control netdev (called representor netdevice = rep-ndev).
> This rep-ndev is attached to OVS for adding rules, offloads etc using standard tc, netfilter infra.
> Currently this rep-ndev controls switch side of the settings, but not the host side of netdev.
> So there is discussion to create another netdev or devlink port..
> 
> Additionally this subdev has optional rdma device too.
> 
> And when we are in switchdev mode, this rdma dev has similar rdma rep device for control.
> 
> In some cases we actually don't create netdev when it is in InfiniBand mode.
> Here there is PCI device->rdma_device.
> 
> In other case, a given sub device for rdma is dual port device, having netdevice for each that can use existing netdev->dev_port.
> 
> Creating 4 devices of two different classes using one iproute2/ip or iproute2/rdma command is horrible thing to do.

Why is that?

> In case if this sub device has to be a passthrough device, ip link command will fail badly that day, because we are creating some sub device which is not even a netdevice.

But it is a network device, right?

> So iproute2/devlink which works on bus+device, mainly PCI today, seems right abstraction point to create sub devices.
> This also extends to map ports of the device, health, registers debug, etc rich infrastructure that is already built.
> 
> Additionally, we don't want mlx driver and other drivers to go through its child devices (split logic in netdev and rdma) for power management.

And how is power management going to work with your new devices?  All
you have here is a tiny shim around a driver bus, I do not see any new
functionality, and as others have said, no way to actually share, or
split up, the PCI resources.

> Kernel core code does that well today, that we like to leverage through subdev bus or mfd pm callbacks.
> 
> So it is lot more than just creating netdevices.

But that's all you are showing here :)

> > What problem are you trying to solve that others also are having that
> > requires all of this?
> > 
> > Adding a new bus type and subsystem is fine, but usually we want more
> > than just one user of it, as this does not really show how it is exercised very
> > well.
> This subdev and devlink infrastructure solves this problem of creating smaller sub devices out of one PCI device.
> Someone has to start.. :-)

That is what a mfd should allow you to do.

> To my knowledge, currently Netronome, Broadcom and Mellanox are actively using this devlink and switchdev infra today.

Where are they "using it"?  This patchset does not show that.

> > Ideally 3 users would be there as that is when it proves itself that it is
> > flexible enough.
> > 
> 
> We were looking at drivers/visorbus if we can repurpose it, but GUID device naming scheme is just not user friendly.

You can always change the naming scheme if needed.  But why isn't a GUID
ok?  It's very easy to reserve properly, and you do not need a central
naming "authority".

> > Would just using the mfd subsystem work better for you?  That provides
> > core support for "multi-function" drivers/devices already.  What is missing
> > from that subsystem that does not work for you here?
> > 
> We were not aware of mfd until now. I looked at very high level now. It's a wrapper to platform devices and seems widely use.
> Before subdev proposal, Jason suggested an alternative is to create platform devices and driver attach to it.
> 
> When I read kernel documentation [1], it says "platform devices typically appear as autonomous entities"
> Here instead of autonomy, it is in user's control.
> Platform devices probably don't disappear a lot in live system as opposed to subdevices which are created and removed dynamically a lot often.
> 
> Not sure if platform device is abuse for this purpose or not.

No, do not abuse a platform device.  You should be able to just use a
normal PCI device for this just fine, and if not, we should be able to
make the needed changes to mfd for that.

thanks,

greg k-h
