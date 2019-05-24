Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42819C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0478521841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558677142;
	bh=isQJuIhcuCBrs0hEM9Rq67SyZfcwBKSPB6Sk8DBiWws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PqnJDd2RbYFx7L5Y/jJaTAPn9VxcbuO+6Uux2QGAeV0DmSC4Zoyh6wBYAPewcC2Qg
	 Cnz+i7v8l83i/HPsXz1RFK7GOy3BvLa47KuXvlfXwN50SLHUShuZcyxwNkbTqW7DDr
	 AxaY6uAKmZCAQdYx7CXLN/dRDLNnA2eciLphUYuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfEXFwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfEXFwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:52:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013ED20657;
        Fri, 24 May 2019 05:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558677139;
        bh=isQJuIhcuCBrs0hEM9Rq67SyZfcwBKSPB6Sk8DBiWws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP7FW/cO8V34XYmZg9rWhYsL+PlOydNwPAReC9ZvfvYHaN/b35fM+DhbXsDD67mLp
         bi3k1OgRmDaUQFf0FVg8SK9pE8qEzstPunr67zKr1kYB8kOlV2hBMjdlV6RYrQgZVT
         n3laM/k1NfzSjlro/5hQ+q4XG8fMNd+89CIJuUu4=
Date:   Fri, 24 May 2019 07:52:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize
 probe ordering
Message-ID: <20190524055217.GC31664@kroah.com>
References: <20190524010117.225219-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:01:11PM -0700, Saravana Kannan wrote:
> Add a generic "depends-on" property that allows specifying mandatory
> functional dependencies between devices. Add device-links after the
> devices are created (but before they are probed) by looking at this
> "depends-on" property.
> 
> This property is used instead of existing DT properties that specify
> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> is because not all resources referred to by existing DT properties are
> mandatory functional dependencies. Some devices/drivers might be able
> to operate with reduced functionality when some of the resources
> aren't available. For example, a device could operate in polling mode
> if no IRQ is available, a device could skip doing power management if
> clock or voltage control isn't available and they are left on, etc.
> 
> So, adding mandatory functional dependency links between devices by
> looking at referred phandles in DT properties won't work as it would
> prevent probing devices that could be probed. By having an explicit
> depends-on property, we can handle these cases correctly.
> 
> Having functional dependencies explicitly called out in DT and
> automatically added before the devices are probed, provides the
> following benefits:
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
> - Supplier devices like clock providers, regulators providers, etc
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

Somewhere in this wall of text you need to say:
	MAKES DEVICES BOOT FASTER!
right?  :)

So in short, this solves the issue of deferred probing with systems with
loads of modules for platform devices and device tree, in that now you
have a chance to probe devices in the correct order saving loads of busy
loops.

A good thing, I like this, very nice work, all of these are:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
but odds are I'll take this through my tree, so I'll add my s-o-b then.
But only after the DT people agree on the new entry.

thanks,

greg k-h
