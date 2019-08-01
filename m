Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73642C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B83A214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564649287;
	bh=4xrW53rvWPD3pPegD4ti28KqG5APQ7CQidIuoGRmFAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KMv6S2g0wVD39HBQH+AB/m7K2SpbIXyZeVeQ3Viv4v4JF+aqdiZQ9HG01JJJdW1je
	 svDHWByJvKTjJFAtbrmJNeYWjY9eYEzb2kG+g1W/xL5cYUrnsRujUodSSgvadZu92V
	 gyhRKYcPUdS2s/QnXQ3bj930uhA0BuAhd5fwYq2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfHAIsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfHAIsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:48:05 -0400
Received: from localhost (ip-213-127-251-216.ip.prioritytelecom.net [213.127.251.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C9C206A3;
        Thu,  1 Aug 2019 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564649284;
        bh=4xrW53rvWPD3pPegD4ti28KqG5APQ7CQidIuoGRmFAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9v980GjYu7u0qo7sRMaSmu8g2MsZZclP0vxzIWxUokUf2ms9c05i9muY46zCRKwg
         7Z/Db9Qpg2FeiFVHHqY83FYHPr+YoAsEhAuL1g6fjpfx+MnOS5HfF5VUWa7CYdC045
         4jaM3Y1aZyrMl2veqV6efHroQwVVLyRbz5eEnDcc=
Date:   Thu, 1 Aug 2019 10:47:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH 4.19 112/113] libnvdimm/bus: Stop holding
 nvdimm_bus_list_mutex over __nd_ioctl()
Message-ID: <20190801084759.GC1085@kroah.com>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190721.610390670@linuxfoundation.org>
 <20190731181444.GA821@amd>
 <CAPcyv4iM3i3oBS3WRe8QHmD6zncAy0-CsgdbJ0WSt9RBiVgVqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iM3i3oBS3WRe8QHmD6zncAy0-CsgdbJ0WSt9RBiVgVqg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:31:07PM -0700, Dan Williams wrote:
> On Wed, Jul 31, 2019 at 11:15 AM Pavel Machek <pavel@denx.de> wrote:
> >
> > On Mon 2019-07-29 21:23:19, Greg Kroah-Hartman wrote:
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > commit b70d31d054ee3a6fc1034b9d7fc0ae1e481aa018 upstream.
> > >
> > > In preparation for fixing a deadlock between wait_for_bus_probe_idle()
> > > and the nvdimm_bus_list_mutex arrange for __nd_ioctl() without
> > > nvdimm_bus_list_mutex held. This also unifies the 'dimm' and 'bus' level
> > > ioctls into a common nd_ioctl() preamble implementation.
> >
> > Ok, so this is a preparation patch, not a fix...
> >
> > > Marked for -stable as it is a pre-requisite for a follow-on fix.
> >
> > ...but follow-on fixes are going to be applied for 5.2 but not
> > 4.19. So perhaps this one should not be in 4.19, either?
> 
> I plan to follow up with a backport of the series for 4.19. I have no
> problem with v4.19 carrying this in the meantime, but if you want to
> kick it out and wait for the backport, that's fine too.

I didn't mean to include this, I was going to go and remove it, my fault
for keeping it in.  But, if you are going to send the series backported,
I'll leave this in for now as that will make your work easier.

thanks,

greg k-h
