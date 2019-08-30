Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16330C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC38A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567146041;
	bh=FXijohpD1xppY/Izswf5sHL2hci61FgO5kTCmkEc/7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGWv2Ln6KYfiU+QXQ3TND9mLpT6fX8J30HKoanyUrCglWmmrxL9KU6AlVX3jg/qw5
	 7+VpwCMkyxw/c37ebOfnTEE3+4wX1sW4c7+FKFiMnzD4fXbe0p9mTXuoUzLXu/ot39
	 /yBnNq6RozH0q2aAc0Au7XPanfrjEUaaPlC4IIB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfH3GUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfH3GUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:20:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD4F2087F;
        Fri, 30 Aug 2019 06:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567146039;
        bh=FXijohpD1xppY/Izswf5sHL2hci61FgO5kTCmkEc/7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOn8NYBJdF+nYZk35tKx1gQbjgVNO4Q23JKoMz8AtE9l31oifYcJ2t0+OjDXXvrcv
         yShLLClcyqW1Y+rBw7sg3u++MbBTXHPHfp2B6Vl/dFtdMJrBHsy/ybWYhB2Z4YhKib
         xroYwIZOsz/2Drf5WkfiL0nCLbIziN4Fw4mVsTmo=
Date:   Fri, 30 Aug 2019 08:20:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190830062036.GA15257@kroah.com>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
 <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de>
 <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:21:02AM -0700, Sagi Grimberg wrote:
> 
> > > > > You are correct that this information can be derived from sysfs, but the
> > > > > main reason why we add these here, is because in udev rule we can't
> > > > > just go ahead and start looking these up and parsing these..
> > > > > 
> > > > > We could send the discovery aen with NVME_CTRL_NAME and have
> > > > > then have systemd run something like:
> > > > > 
> > > > > nvme connect-all -d nvme0 --sysfs
> > > > > 
> > > > > and have nvme-cli retrieve all this stuff from sysfs?
> > > > 
> > > > Actually that may be a problem.
> > > > 
> > > > There could be a hypothetical case where after the event was fired
> > > > and before it was handled, the discovery controller went away and
> > > > came back again with a different controller instance, and the old
> > > > instance is now a different discovery controller.
> > > > 
> > > > This is why we need this information in the event. And we verify this
> > > > information in sysfs in nvme-cli.
> > > 
> > > Well, that must be a usual issue with uevents, right?  Don't we usually
> > > have a increasing serial number for that or something?
> > 
> > Yes we do, userspace should use it to order events.  Does udev not
> > handle that properly today?
> 
> The problem is not ordering of events, its really about the fact that
> the chardev can be removed and reallocated for a different controller
> (could be a completely different discovery controller) by the time
> that userspace handles the event.

So?  You will have gotten the remove and then new addition uevent in
order showing you this.  So your userspace code knows that something
went away and then came back properly so you should be kept in sync.

thanks,

greg k-h
