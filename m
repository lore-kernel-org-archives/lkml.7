Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1823400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567574742;
	bh=CXNu9IN1Uq+0JFc0kjRWO1y9r0+ATS28FSmG0b0t2mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qgEiY9jsiU0OZ+7BxemgIrA8BNcMBKgGQhIZCgToyq1QYs2Cyhw8fE37yZlC5L3B0
	 n/NxCxoBQqL2FUR5RM5UB645QIHVl1MMvqf18t9ZnI/EvElvJzyDObeutfFtPJE3bw
	 rPkkcW+vI3FKII8qHl+XFLb2AhpZnhQyAIVr3PSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfIDFZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDFZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:25:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C802339D;
        Wed,  4 Sep 2019 05:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567574740;
        bh=CXNu9IN1Uq+0JFc0kjRWO1y9r0+ATS28FSmG0b0t2mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHS6x1AV4wFH2nBQ/fs186BvlLSw8U4EgEYYBHRQle4S+DEKxvQ8C/hiKfdTTkgXM
         WpXCxyb72sNYUSsGaZQLxZxjt9YMfseuWBDqFeZuGg+of3G70kT8FpQ3meUUbNzkV/
         kTNyNEDxSMKSUaitSylkwH88KhVhUza8BemG3+oA=
Date:   Wed, 4 Sep 2019 07:25:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190904052538.GB17236@kroah.com>
References: <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de>
 <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
 <20190902193341.GA28723@kroah.com>
 <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:35:30PM -0700, Sagi Grimberg wrote:
> 
> > > Still don't understand how this is ok...
> > > 
> > > I have /dev/nvme0 represents a network endpoint that I would discover
> > > from, it is raising me an event to do a discovery operation (namely to
> > > issue an ioctl to it) so my udev code calls a systemd script.
> > > 
> > > By the time I actually get to do that, /dev/nvme0 represents now a new
> > > network endpoint (where the event is no longer relevant to). I would
> > > rather the discovery to explicitly fail than to give me something
> > > different, so we pass some arguments that we verify in the operation.
> > > 
> > > Its a stretch case, but it was raised by people as a potential issue.
> > 
> > Ok, and how do you handle this same thing for something like /dev/sda ?
> > (hint, it isn't new, and is something we solved over a decade ago)
> > 
> > If you worry about stuff like this, use a persistant device naming
> > scheme and have your device node be pointed to by a symlink.  Create
> > that symlink by using the information in the initial 'ADD' uevent.
> > 
> > That way, when userspace opens the device node, it "knows" exactly which
> > one it opens.  It sounds like you have a bunch of metadata to describe
> > these uniquely, so pass that in the ADD event, not in some other crazy
> > non-standard manner.
> 
> We could send these variables when adding the device and then validating
> them using a rich-text-explanatory symlink. Seems slightly backwards to
> me, but that would work too.

That's the way the driver model is expected to work, instead of having
to do crazy device-specific stuff.

> We create the char device using device_add (in nvme_init_subsystem),
> I didn't find any way to append env variables to that ADD uevent.

You do that in your uevent or dev_uevent callback like all other
subsystems.  Nothing "new" to do here, again, it's been working fine for
everyone else for well over a decade now :)

thanks,

greg k-h
