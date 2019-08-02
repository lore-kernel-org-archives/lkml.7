Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD711C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513D2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564727844;
	bh=Ki0aBx8bP81rl2gsZHWpYHCJ6q/4/jLawDTrLD+87Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iXxtYQpxrxceHcPiRLABkIXUhT7zwNqrNVK+lrdiY1iCQHZNcvIxmoSWtzMpde9Ga
	 gOBeTcnktrSYsh0KUFfLtUrbwEo72TeWxWdiSi1wWwj9jGnl9YVj1duGEDsSmVF08U
	 Jv3MayjObOAWHHpkMUvq/m1M72t0RgPwc3gugsQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbfHBGhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfHBGhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:37:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAF62086A;
        Fri,  2 Aug 2019 06:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564727842;
        bh=Ki0aBx8bP81rl2gsZHWpYHCJ6q/4/jLawDTrLD+87Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEz+wD/rj74Jwd5P3RUL5a9de80r6ve7dGLGnzvDxc7Cgsqr2dkFENy84Hn19eVGH
         G6T6fLAL7b7JmBcbqZhWhlqo70RabC1h/X3xdwvokNVDeSvGUGl3TLDdIM/sQgAKLI
         d/CPwFUXqDEwygJ/RViwZBCK06pqW27nFispkXOc=
Date:   Fri, 2 Aug 2019 08:37:20 +0200
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
Message-ID: <20190802063720.GA12789@kroah.com>
References: <20190731221721.187713-1-saravanak@google.com>
 <20190801061209.GA3570@kroah.com>
 <5a1e785d-075e-19a0-7d3d-949e1b65d726@gmail.com>
 <20190801193248.GA24916@kroah.com>
 <6366cb2a-65ea-cb44-f765-f246f3fb3bf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6366cb2a-65ea-cb44-f765-f246f3fb3bf9@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:59:25PM -0700, Frank Rowand wrote:
> On 8/1/19 12:32 PM, Greg Kroah-Hartman wrote:
> > On Thu, Aug 01, 2019 at 12:28:13PM -0700, Frank Rowand wrote:
> >> Hi Greg,
> >>
> >> On 7/31/19 11:12 PM, Greg Kroah-Hartman wrote:
> >>> On Wed, Jul 31, 2019 at 03:17:13PM -0700, Saravana Kannan wrote:
> >>>> Add device-links to track functional dependencies between devices
> >>>> after they are created (but before they are probed) by looking at
> >>>> their common DT bindings like clocks, interconnects, etc.
> >>>>
> >>>> Having functional dependencies automatically added before the devices
> >>>> are probed, provides the following benefits:
> >>>>
> >>>> - Optimizes device probe order and avoids the useless work of
> >>>>   attempting probes of devices that will not probe successfully
> >>>>   (because their suppliers aren't present or haven't probed yet).
> >>>>
> >>>>   For example, in a commonly available mobile SoC, registering just
> >>>>   one consumer device's driver at an initcall level earlier than the
> >>>>   supplier device's driver causes 11 failed probe attempts before the
> >>>>   consumer device probes successfully. This was with a kernel with all
> >>>>   the drivers statically compiled in. This problem gets a lot worse if
> >>>>   all the drivers are loaded as modules without direct symbol
> >>>>   dependencies.
> >>>>
> >>>> - Supplier devices like clock providers, interconnect providers, etc
> >>>>   need to keep the resources they provide active and at a particular
> >>>>   state(s) during boot up even if their current set of consumers don't
> >>>>   request the resource to be active. This is because the rest of the
> >>>>   consumers might not have probed yet and turning off the resource
> >>>>   before all the consumers have probed could lead to a hang or
> >>>>   undesired user experience.
> >>>>
> >>>>   Some frameworks (Eg: regulator) handle this today by turning off
> >>>>   "unused" resources at late_initcall_sync and hoping all the devices
> >>>>   have probed by then. This is not a valid assumption for systems with
> >>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
> >>>>   this due to the lack of a clear signal for when they can turn off
> >>>>   resources. This leads to downstream hacks to handle cases like this
> >>>>   that can easily be solved in the upstream kernel.
> >>>>
> >>>>   By linking devices before they are probed, we give suppliers a clear
> >>>>   count of the number of dependent consumers. Once all of the
> >>>>   consumers are active, the suppliers can turn off the unused
> >>>>   resources without making assumptions about the number of consumers.
> >>>>
> >>>> By default we just add device-links to track "driver presence" (probe
> >>>> succeeded) of the supplier device. If any other functionality provided
> >>>> by device-links are needed, it is left to the consumer/supplier
> >>>> devices to change the link when they probe.
> >>>
> >>> All now queued up in my driver-core-testing branch, and if 0-day is
> >>> happy with this, will move it to my "real" driver-core-next branch in a
> >>> day or so to get included in linux-next.
> >>
> >> I have been slow in getting my review out.
> >>
> >> This patch series is not yet ready for sending to Linus, so if putting
> >> this in linux-next implies that it will be in your next pull request
> >> to Linus, please do not put it in linux-next.
> > 
> > It means that it will be in my pull request for 5.4-rc1, many many
> > waeeks away from now.
> 
> If you are willing to revert the series before the pull request _if_ I
> have significant review issues in the next couple of days, then I am happy
> to see the patches get exposure in linux-next.

If you have significant review issues, yes, I will be glad to revert them.

thanks,

greg k-h
