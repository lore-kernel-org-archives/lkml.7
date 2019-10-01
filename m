Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB42ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CA821872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569943179;
	bh=oPP01wWGd043s57vaWHPnGdkRRNGRk9rhQTfDKdV+wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uRC7zsyvZelqPni+DXa7hm+D1pmZrQ+iRlIDoAeROdiOkf70+gtZ66KzDL8VNNqsD
	 pYfccKULs3eDfbH9LgqAD9WX1BidmGkrhVC8vIerk4rvJaUIqZy6aAmeJPy5smLgFl
	 326ep8KeGb0UpQQNCNID0hqBtPVK/p4XcF1iP2Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbfJAPTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731893AbfJAPTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:19:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5202133F;
        Tue,  1 Oct 2019 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569943177;
        bh=oPP01wWGd043s57vaWHPnGdkRRNGRk9rhQTfDKdV+wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VH+T0EKVMsL0HZuofffSGj9XBTKML9DobPL3lwz6J+rst9DASxXpKIblruJyzUSNw
         cXq9McQ9z1QACt7YSYggYLcrrlhFpgwAnQadnpxIoLr7wEVGPXcji2r/CDGr04mXwR
         1s+4P3i+AEJOPaxI00MGoLMrHR+jWhFzfECp3y/s=
Date:   Tue, 1 Oct 2019 17:19:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191001151935.GA3450435@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
 <20191001150734.GA2714@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001150734.GA2714@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:07:34PM +0300, Mika Westerberg wrote:
> On Tue, Oct 01, 2019 at 04:53:54PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 01, 2019 at 04:09:05PM +0300, Mika Westerberg wrote:
> > > On Tue, Oct 01, 2019 at 02:47:48PM +0200, Greg Kroah-Hartman wrote:
> > > > > -	  Thunderbolt Controller driver. This driver is required if you
> > > > > -	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
> > > > > -	  with Intel Falcon Ridge or newer.
> > > > > +	  USB4 (Thunderbolt) driver. USB4 is the public spec based on
> > > > > +	  Thunderbolt 3 protocol. This driver is required if you want to
> > > > > +	  hotplug Thunderbolt and USB4 compliant devices on Apple
> > > > > +	  hardware or on PCs with Intel Falcon Ridge or newer.
> > > > 
> > > > Wait, did "old" thunderbolt just get re-branded as USB4?
> > > 
> > > Not but the driver started supporting USB4 as well :)
> > > 
> > > USB4 is pretty much public spec of Thunderbolt 3 but with some
> > > differences in register layouts (this is because Thunderbolt uses some
> > > vendor specific capabilities which are now moved to more "standard"
> > > places). 
> > 
> > Ok, then we need to rename the Kconfig option as well, otherwise no one
> > will "know" that this changed, so they will not be prompted for it.
> > 
> > > > Because if I have an "old" laptop that needs Thunderbolt support, how am
> > > > I going to know it is now called USB4 instead?
> > > 
> > > Well the Kconfig option tries to have both names there:
> > > 
> > >   tristate "USB4 (Thunderbolt) support"
> > > 
> > > and then
> > > 
> > >   USB4 (Thunderbolt) driver. USB4 is the public spec based on
> > >   Thunderbolt 3 protocol. This driver is required if you want to hotplug
> > >   Thunderbolt and USB4 compliant devices on Apple hardware or on PCs
> > >   with Intel Falcon Ridge or newer.
> > > 
> > > and the Kconfig option is still CONFIG_THUNDERBOLT. I know this is
> > > confusing but I don't have better ideas how we can advertise both. I
> > > borrowed this "format" from firewire.
> > 
> > CONFIG_USB4 instead?
> 
> OK, but does that break existing .configs? I mean if you have already
> CONFIG_THUNDERBOLT in your .config/defconfig does it now just get
> dropped silently?

Yup.  And then you get asked about CONFIG_USB4

> For example firewire has CONFIG_FIREWIRE even though the "standard" name
> is IEEE 1394. I was thinking maybe we can do the same for
> USB4/Thunderbolt?

It comes down to the what do you want to do for the next 20+ years,
explain to people that "to get USB4 support, enable CONFIG_THUNDERBOLT"?

:)

thanks,

greg k-h
