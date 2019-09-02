Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85E216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567452826;
	bh=PayzVtvb1IrG2V07glwrkJeACX2e/Z4eCtEZGxId41c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LuWC0iUIn2qiWXtEyotTOLa+aq0XVj4RAb3kdk1b3NNtywd2hGrJNU5T5/hpYHrkH
	 moz00OWeDMQHsKEcGPA6yNIZ+FL4a8yD7Rqny7oU+7QW9sSH7CmvLu+K46HLPe08XA
	 X9Pb2o229mqTQKvjC8GRkMuPFjIP8kDwIHzs9gnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfIBTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfIBTdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:33:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884A20674;
        Mon,  2 Sep 2019 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567452824;
        bh=PayzVtvb1IrG2V07glwrkJeACX2e/Z4eCtEZGxId41c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZNSSlw7HOuJ+Pkrf+mxy/A6QUPTkfVDeOc3z7+mzfz1MCEPmzt9Cp8pzpgUn9qyT
         hMfq7dcAuT0T7Awc2humYKdVBjxAgHzHNtG4CffeVCM6W0QUA6tU9KOghWcw1za0Xz
         JN+wu3TrPCcQCYQgql9arF9gn3qSngy9Tpw3lrgA=
Date:   Mon, 2 Sep 2019 21:33:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190902193341.GA28723@kroah.com>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
 <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de>
 <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:14:39AM -0700, Sagi Grimberg wrote:
> 
> > > > > > > You are correct that this information can be derived from sysfs, but the
> > > > > > > main reason why we add these here, is because in udev rule we can't
> > > > > > > just go ahead and start looking these up and parsing these..
> > > > > > > 
> > > > > > > We could send the discovery aen with NVME_CTRL_NAME and have
> > > > > > > then have systemd run something like:
> > > > > > > 
> > > > > > > nvme connect-all -d nvme0 --sysfs
> > > > > > > 
> > > > > > > and have nvme-cli retrieve all this stuff from sysfs?
> > > > > > 
> > > > > > Actually that may be a problem.
> > > > > > 
> > > > > > There could be a hypothetical case where after the event was fired
> > > > > > and before it was handled, the discovery controller went away and
> > > > > > came back again with a different controller instance, and the old
> > > > > > instance is now a different discovery controller.
> > > > > > 
> > > > > > This is why we need this information in the event. And we verify this
> > > > > > information in sysfs in nvme-cli.
> > > > > 
> > > > > Well, that must be a usual issue with uevents, right?  Don't we usually
> > > > > have a increasing serial number for that or something?
> > > > 
> > > > Yes we do, userspace should use it to order events.  Does udev not
> > > > handle that properly today?
> > > 
> > > The problem is not ordering of events, its really about the fact that
> > > the chardev can be removed and reallocated for a different controller
> > > (could be a completely different discovery controller) by the time
> > > that userspace handles the event.
> > 
> > So?  You will have gotten the remove and then new addition uevent in
> > order showing you this.  So your userspace code knows that something
> > went away and then came back properly so you should be kept in sync.
> 
> Still don't understand how this is ok...
> 
> I have /dev/nvme0 represents a network endpoint that I would discover
> from, it is raising me an event to do a discovery operation (namely to
> issue an ioctl to it) so my udev code calls a systemd script.
> 
> By the time I actually get to do that, /dev/nvme0 represents now a new
> network endpoint (where the event is no longer relevant to). I would
> rather the discovery to explicitly fail than to give me something
> different, so we pass some arguments that we verify in the operation.
> 
> Its a stretch case, but it was raised by people as a potential issue.

Ok, and how do you handle this same thing for something like /dev/sda ?
(hint, it isn't new, and is something we solved over a decade ago)

If you worry about stuff like this, use a persistant device naming
scheme and have your device node be pointed to by a symlink.  Create
that symlink by using the information in the initial 'ADD' uevent.

That way, when userspace opens the device node, it "knows" exactly which
one it opens.  It sounds like you have a bunch of metadata to describe
these uniquely, so pass that in the ADD event, not in some other crazy
non-standard manner.

thanks,

greg k-h
