Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E048C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175AD2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564062141;
	bh=WXWR1Y2i0YG6mr1nhE0Yc2dl5l/bxd4nTtbBmCEm9l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jvqgqn5Gp0NAxorKkDJYQFW3kY7eE0JCKAgg0+gcoHJV9sZzzhUo9BbISqz7b4YMB
	 Qx91gvOVf83eaKA9nQe3nLiCfzTcDCXrRxvdCYuK+e1Lvog419F98EXDlox+/mWSFG
	 CuXtCT88aBYhUEaciWXR2pXWLJm6bUbSWvbVqw+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfGYNmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389989AbfGYNmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:42:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BE72238C;
        Thu, 25 Jul 2019 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564062137;
        bh=WXWR1Y2i0YG6mr1nhE0Yc2dl5l/bxd4nTtbBmCEm9l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euxSMtDuQF2FfuclgA4knYbYqjBAlCbqIJsi9m8N+oopRWZEJFBmcNtEQE9gweuI1
         NjGod3ir2lY+CRrgaZXr0LhZzdrnmuhu11GS+zqBl5LgC1YZ1J0W/PQTVjpkphmzpH
         0r93wEiZw7xrPO5qoCgxebVErHNBerWWmtMMDWEE=
Date:   Thu, 25 Jul 2019 15:42:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH v7 0/7] Solve postboot supplier cleanup and optimize
 probe ordering
Message-ID: <20190725134214.GD11115@kroah.com>
References: <20190724001100.133423-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:10:53PM -0700, Saravana Kannan wrote:
> Add device-links to track functional dependencies between devices
> after they are created (but before they are probed) by looking at
> their common DT bindings like clocks, interconnects, etc.
> 
> Having functional dependencies automatically added before the devices
> are probed, provides the following benefits:
> 
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
> 
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
> 
> - Supplier devices like clock providers, interconnect providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
> 
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
> 
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
> 
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
> 
> v1 -> v2:
> - Drop patch to speed up of_find_device_by_node()
> - Drop depends-on property and use existing bindings
> 
> v2 -> v3:
> - Refactor the code to have driver core initiate the linking of devs
> - Have driver core link consumers to supplier before it's probed
> - Add support for drivers to edit the device links before probing
> 
> v3 -> v4:
> - Tested edit_links() on system with cyclic dependency. Works.
> - Added some checks to make sure device link isn't attempted from
>   parent device node to child device node.
> - Added way to pause/resume sync_state callbacks across
>   of_platform_populate().
> - Recursively parse DT node to create device links from parent to
>   suppliers of parent and all child nodes.
> 
> v4 -> v5:
> - Fixed copy-pasta bugs with linked list handling
> - Walk up the phandle reference till I find an actual device (needed
>   for regulators to work)
> - Added support for linking devices from regulator DT bindings
> - Tested the whole series again to make sure cyclic dependencies are
>   broken with edit_links() and regulator links are created properly.
> 
> v5 -> v6:
> - Split, squashed and reordered some of the patches.
> - Refactored the device linking code to follow the same code pattern for
>   any property.
> 
> v6 -> v7:
> - No functional changes.
> - Renamed i to index
> - Added comment to clarify not having to check property name for every
>   index
> - Added "matched" variable to clarify code. No functional change.
> - Added comments to include/linux/device.h for add_links()
> 
> I've also not updated this patch series to handle the new patch [1] from
> Rafael. Will do that once this patch series is close to being Acked.
> 
> [1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/


This looks sane to me.  Anyone have any objections for me queueing this
up for my tree to get into linux-next now?

thanks,

greg k-h
