Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A152087E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566806364;
	bh=OG9SJrchwTyiBC/xl+WDAoFEZMQOTDerXnkioTTM3sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x58lPbfJZ1Z8k2/nngYhqqlmvrzsmTHrbWaU5IE0eJZig2147TVgA5ztY2roAzogm
	 z/bSlgBjxT00r7vPtO3dFN5lM3WKMgcycRAZ0w83/BtvlU/w8DekTiOJQwmyOXq2Rx
	 hWNdES/+aF4V8xPTK6bUKCOiO9lvf9iIs6sM81Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfHZH7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbfHZH7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:59:22 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B7F20874;
        Mon, 26 Aug 2019 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566806361;
        bh=OG9SJrchwTyiBC/xl+WDAoFEZMQOTDerXnkioTTM3sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiyo61huaB4sjI4sLb9RjnSExn8D+WToxUCMZXwaMWgjaE6DvvmH0G15+xsVeq/tT
         n1xSuyM6d+iR8Ncv6a4mU5pxce3zVpIaDN6nUud/Z847ifvoHFIv5hGIVStAfrViL7
         tNmTmbwVNL0PU1BcNb0/cwva3iknwa0+LZCHZW0o=
Date:   Mon, 26 Aug 2019 09:59:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190826075916.GA30396@kroah.com>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
 <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826065639.GA11036@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:56:39AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 22, 2019 at 12:10:23PM -0700, Sagi Grimberg wrote:
> >> You are correct that this information can be derived from sysfs, but the
> >> main reason why we add these here, is because in udev rule we can't
> >> just go ahead and start looking these up and parsing these..
> >>
> >> We could send the discovery aen with NVME_CTRL_NAME and have
> >> then have systemd run something like:
> >>
> >> nvme connect-all -d nvme0 --sysfs
> >>
> >> and have nvme-cli retrieve all this stuff from sysfs?
> >
> > Actually that may be a problem.
> >
> > There could be a hypothetical case where after the event was fired
> > and before it was handled, the discovery controller went away and
> > came back again with a different controller instance, and the old
> > instance is now a different discovery controller.
> >
> > This is why we need this information in the event. And we verify this
> > information in sysfs in nvme-cli.
> 
> Well, that must be a usual issue with uevents, right?  Don't we usually
> have a increasing serial number for that or something?

Yes we do, userspace should use it to order events.  Does udev not
handle that properly today?

thanks,

greg k-h
