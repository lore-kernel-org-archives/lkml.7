Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00146C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BDC218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564151550;
	bh=UsEKQqBbR1KyOIns2QwZsJYS1wMECxstvmbvM/1QeqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YRBlJ0avwHtinJLm2BeOfJjUxyfjHpduhOx6dkAM6aAH2ePjI1vTwE4hsjoJL7Esx
	 vfhFt8l3+8xH6UIXsrJuKGIiRFYW3ktf7wAsEYQp+08De+SAzEv2xef35BHzBwhfSb
	 t/rANXpLxATw9339++ADvclL84UCjQhkGf1s7Sq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfGZOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfGZOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:32:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BEE218D3;
        Fri, 26 Jul 2019 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564151548;
        bh=UsEKQqBbR1KyOIns2QwZsJYS1wMECxstvmbvM/1QeqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRB730KtMrKgRL622ufVu06+LHxIy2EmLJ5cK2Kg2C5e5GhSGMIBhBDpSw/BrjY7N
         3wJzZfSVecrBd5MH4Fx6Wg5iqHEveiKnU4wzzV1pigbnw9fjfvjDUd+Q9feYsVJiEP
         uRHYAguJ53uCXRLCJqvJDIDvF2iBCKleDvrIMllM=
Date:   Fri, 26 Jul 2019 16:32:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH v7 0/7] Solve postboot supplier cleanup and optimize
 probe ordering
Message-ID: <20190726143225.GA13297@kroah.com>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190725134214.GD11115@kroah.com>
 <99ca3252-55af-8eea-7653-8347b0a1ab03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ca3252-55af-8eea-7653-8347b0a1ab03@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:04:23PM -0700, Frank Rowand wrote:
> On 7/25/19 6:42 AM, Greg Kroah-Hartman wrote:
> > On Tue, Jul 23, 2019 at 05:10:53PM -0700, Saravana Kannan wrote:
> >> Add device-links to track functional dependencies between devices
> >> after they are created (but before they are probed) by looking at
> >> their common DT bindings like clocks, interconnects, etc.
> >>
> >> Having functional dependencies automatically added before the devices
> >> are probed, provides the following benefits:
> >>
> >> - Optimizes device probe order and avoids the useless work of
> >>   attempting probes of devices that will not probe successfully
> >>   (because their suppliers aren't present or haven't probed yet).
> >>
> >>   For example, in a commonly available mobile SoC, registering just
> >>   one consumer device's driver at an initcall level earlier than the
> >>   supplier device's driver causes 11 failed probe attempts before the
> >>   consumer device probes successfully. This was with a kernel with all
> >>   the drivers statically compiled in. This problem gets a lot worse if
> >>   all the drivers are loaded as modules without direct symbol
> >>   dependencies.
> >>
> >> - Supplier devices like clock providers, interconnect providers, etc
> >>   need to keep the resources they provide active and at a particular
> >>   state(s) during boot up even if their current set of consumers don't
> >>   request the resource to be active. This is because the rest of the
> >>   consumers might not have probed yet and turning off the resource
> >>   before all the consumers have probed could lead to a hang or
> >>   undesired user experience.
> >>
> >>   Some frameworks (Eg: regulator) handle this today by turning off
> >>   "unused" resources at late_initcall_sync and hoping all the devices
> >>   have probed by then. This is not a valid assumption for systems with
> >>   loadable modules. Other frameworks (Eg: clock) just don't handle
> >>   this due to the lack of a clear signal for when they can turn off
> >>   resources. This leads to downstream hacks to handle cases like this
> >>   that can easily be solved in the upstream kernel.
> >>
> >>   By linking devices before they are probed, we give suppliers a clear
> >>   count of the number of dependent consumers. Once all of the
> >>   consumers are active, the suppliers can turn off the unused
> >>   resources without making assumptions about the number of consumers.
> >>
> >> By default we just add device-links to track "driver presence" (probe
> >> succeeded) of the supplier device. If any other functionality provided
> >> by device-links are needed, it is left to the consumer/supplier
> >> devices to change the link when they probe.
> >>
> >> v1 -> v2:
> >> - Drop patch to speed up of_find_device_by_node()
> >> - Drop depends-on property and use existing bindings
> >>
> >> v2 -> v3:
> >> - Refactor the code to have driver core initiate the linking of devs
> >> - Have driver core link consumers to supplier before it's probed
> >> - Add support for drivers to edit the device links before probing
> >>
> >> v3 -> v4:
> >> - Tested edit_links() on system with cyclic dependency. Works.
> >> - Added some checks to make sure device link isn't attempted from
> >>   parent device node to child device node.
> >> - Added way to pause/resume sync_state callbacks across
> >>   of_platform_populate().
> >> - Recursively parse DT node to create device links from parent to
> >>   suppliers of parent and all child nodes.
> >>
> >> v4 -> v5:
> >> - Fixed copy-pasta bugs with linked list handling
> >> - Walk up the phandle reference till I find an actual device (needed
> >>   for regulators to work)
> >> - Added support for linking devices from regulator DT bindings
> >> - Tested the whole series again to make sure cyclic dependencies are
> >>   broken with edit_links() and regulator links are created properly.
> >>
> >> v5 -> v6:
> >> - Split, squashed and reordered some of the patches.
> >> - Refactored the device linking code to follow the same code pattern for
> >>   any property.
> >>
> >> v6 -> v7:
> >> - No functional changes.
> >> - Renamed i to index
> >> - Added comment to clarify not having to check property name for every
> >>   index
> >> - Added "matched" variable to clarify code. No functional change.
> >> - Added comments to include/linux/device.h for add_links()
> >>
> >> I've also not updated this patch series to handle the new patch [1] from
> >> Rafael. Will do that once this patch series is close to being Acked.
> >>
> >> [1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/
> > 
> > 
> > This looks sane to me.  Anyone have any objections for me queueing this
> > up for my tree to get into linux-next now?
> 
> I would like for the series to get into linux-next sooner than later,
> and spend some time there.  

Ok, care to give me an ack for it?  :)

thanks,

greg k-h
