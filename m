Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7FA2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556347282;
	bh=k+jbso5y0czuqNdJXS/3uk4ffMe4EBc3mWalLxYAsCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DL/Kp8o8D9rQGJeemB8obp/ZSoOFi8UsP8WnCqE4JzaIAGPv0BGDMJSnX4WmGhO3Z
	 +ifNCIWDVwYrdVO0diu3BTy/zBRaUjS8YTz33yt9NpcADMPYvbmeiQQJJKXNMIw40y
	 q+8tfBOd6pNUJrbhAl2HAhqOQId60+v0lAQfAoG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfD0GlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfD0GlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:41:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEA32087C;
        Sat, 27 Apr 2019 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556347279;
        bh=k+jbso5y0czuqNdJXS/3uk4ffMe4EBc3mWalLxYAsCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Isou8/8d2XTBeboRXM7KdVs8xSKtCs7ylb4Qy/PUfC7bDXlFDyEYsbG4NgpDIP+6
         izMnAgBRQUTGXouFaktP6pXrogKl8hIwV8wbknJxm2sJu/lvISG+ahJarnKOjb6DQx
         mee+txwR3nadQMjcVp2o5C1xW7cvL7dzFZlJP0Bw=
Date:   Sat, 27 Apr 2019 08:41:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kobject: Add default group support to kobj_type
 and replace subsystem uses
Message-ID: <20190427064117.GA15575@kroah.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
 <20190425201253.GA12131@kroah.com>
 <20190427061856.GA675@ubu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427061856.GA675@ubu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:18:56AM -0400, Kimberly Brown wrote:
> On Thu, Apr 25, 2019 at 10:12:53PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 01, 2019 at 10:51:10PM -0400, Kimberly Brown wrote:
> > > This patchset adds support for default attribute groups to kobj_type.
> > > Also, the uses of kobj_type's default_attrs field are replaced with
> > > default_groups in the following subsystems:
> > >  - samples
> > >  - block
> > >  - net
> > >  - irq
> > >  - padata
> > >  - cpufreq
> > >  - livepatch
> > > 
> > > The subsystem maintainers and lists will be copied on the subsystem
> > > patches.
> > > 
> > > The uses of kobj_type's default_attrs field in the other subsystems will
> > > be replaced in future patchsets.
> > 
> > Thanks for all of these, now queued up.  Patches to fix up the other
> > subsystems are always welcome :)
> > 
> > greg k-h
> 
> Thanks, Greg! I'll start preparing more patches.
> 
> I know that patches should be in linux-next for some time before the
> merge window opens. How long do they typically need to be in linux-next?

It depends on the maintainer, what they feel like.  I like to have a
week or so, but some like more, and others less.

Sorry there's not a single answer.

> I'm trying to figure out if the next patches I work on could be included
> in the next merge window, in which case I'll let the maintainers know
> that the patch will either need to go through the driver-core tree or
> wait for the next release cycle.

Mention that I can take them all through my tree now, as that's usually
the easiest thing for api changes like this.

thanks,

greg k-h
