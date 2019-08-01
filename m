Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF552084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564687973;
	bh=vz14t3owe2u9wPNTi1pd1alYwJBKwnmHIGoE00IrvBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QmJS3xK3Egm4mgorKZDwNroU10FmOSC6i3kSriH/8LlCcDJcUQpBusoqH32R18px8
	 i9mR++A8mV9knNzC3FM24U/91TpnxIPc52WrB6CSGYFQfhwakriyh2mWNm6HZN5VkG
	 WTmp4SvOGzJEzzfpZt4WH1Qh6fhOSIa/fvtLlojw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbfHATcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfHATcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:32:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A1220838;
        Thu,  1 Aug 2019 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564687971;
        bh=vz14t3owe2u9wPNTi1pd1alYwJBKwnmHIGoE00IrvBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXTObOOvGa3qBKa2A+jl/PLiUR51hTNk9htCQEhrhXh3FokR+J3mTbL9I2CxOEkew
         5S0vjaPIWUkEgBuAlJ4NF/sOeA/63iFsR7Bdw/slCl3U7p+fzLnFkya6w/yANW6u6H
         f3LCxoHDsJmogD3khFQADSkLoWqcHaWbyn+o1hKQ=
Date:   Thu, 1 Aug 2019 21:32:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize
 probe ordering
Message-ID: <20190801193248.GA24916@kroah.com>
References: <20190731221721.187713-1-saravanak@google.com>
 <20190801061209.GA3570@kroah.com>
 <5a1e785d-075e-19a0-7d3d-949e1b65d726@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1e785d-075e-19a0-7d3d-949e1b65d726@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:28:13PM -0700, Frank Rowand wrote:
> Hi Greg,
> 
> On 7/31/19 11:12 PM, Greg Kroah-Hartman wrote:
> > On Wed, Jul 31, 2019 at 03:17:13PM -0700, Saravana Kannan wrote:
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
> > 
> > All now queued up in my driver-core-testing branch, and if 0-day is
> > happy with this, will move it to my "real" driver-core-next branch in a
> > day or so to get included in linux-next.
> 
> I have been slow in getting my review out.
> 
> This patch series is not yet ready for sending to Linus, so if putting
> this in linux-next implies that it will be in your next pull request
> to Linus, please do not put it in linux-next.

It means that it will be in my pull request for 5.4-rc1, many many
waeeks away from now.

thanks,

greg k-h
