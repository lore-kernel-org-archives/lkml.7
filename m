Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FFCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EEB216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564639934;
	bh=Kf9F99HAMzGrPtF2pYR7HcFniqs9SPbi7rgKcKmPi8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mWRmTHROFb+51jVBmEXVGcadCyJNmDdq2FFYGW517b8SPqaJYzXLwUfuyab+2sAxi
	 06ysR3ISQxgqLCyfOnL46S7vNuKh508Tm9fs32X3xhgywkctuTemglivvcA89jxe4t
	 58iSzkBR0KKKvFUX8qEFClXLSIk7kGyTueDSmaRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfHAGMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHAGMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:12:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C76206A3;
        Thu,  1 Aug 2019 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564639931;
        bh=Kf9F99HAMzGrPtF2pYR7HcFniqs9SPbi7rgKcKmPi8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbX1VgA2joEhHsuSuwUWJzYS8C/f59uUG/WWNEpploabAMCvrtToul+7mdf2d5uQr
         7HRR1/a4nuuLam+T5WV4W0j1bCfp8XNmgeiDLdkfPtlr6wN8bEcdKXrRwvErEcL1ZT
         JX0X/D+W6a6fK5mJF2kBuD4hE4CrJtPV4WE3XFeg=
Date:   Thu, 1 Aug 2019 08:12:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize
 probe ordering
Message-ID: <20190801061209.GA3570@kroah.com>
References: <20190731221721.187713-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731221721.187713-1-saravanak@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:17:13PM -0700, Saravana Kannan wrote:
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

All now queued up in my driver-core-testing branch, and if 0-day is
happy with this, will move it to my "real" driver-core-next branch in a
day or so to get included in linux-next.

thanks for sticking with this!

greg k-h
