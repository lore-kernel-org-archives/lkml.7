Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B2C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CD4218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570005599;
	bh=0ybPNFUhDC0HjkzvsQ82Z8pZaK/JIy0grwNqenttViw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FVV008zaGaCU9b2/8XKuphptF28q3T4jfxbMzunVsoQxcN82KJWL6SbyLasDZyxik
	 a08NRzP9ruU4PKZxWQGn3+uBo9wRjJHMfhXa4x2pRybP7nwL/iPvJr5t2cMUY+RtCl
	 +l4AAzfk0l+fqlFLcczPeXMJhWlsRNqSKxCKPqaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfJBIj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfJBIj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:39:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD26206C0;
        Wed,  2 Oct 2019 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570005596;
        bh=0ybPNFUhDC0HjkzvsQ82Z8pZaK/JIy0grwNqenttViw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0j/bB7xwdaa+EdHv0AqfkqkGOFATKfd1CjySzwA6rrwip7BtEotRZGF1cMPvhY95
         gJUyz3RsUUKCSLbaAnz9PnRpkJE0dJGauqWzc+H8CBgPgXLjiWFrj9tLmp4+kXCydF
         E2zpU5txhPfuKY3gSHweITVHzB1iueo91vLNwE0Y=
Date:   Wed, 2 Oct 2019 10:39:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191002083954.GD1687317@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
 <20191001150734.GA2714@lahna.fi.intel.com>
 <1569947262.2639.15.camel@suse.com>
 <20191002083034.GE2714@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002083034.GE2714@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:30:34AM +0300, Mika Westerberg wrote:
> On Tue, Oct 01, 2019 at 06:27:42PM +0200, Oliver Neukum wrote:
> > Am Dienstag, den 01.10.2019, 18:07 +0300 schrieb Mika Westerberg:
> > 
> > Hi,
> > 
> > > OK, but does that break existing .configs? I mean if you have already
> > > CONFIG_THUNDERBOLT in your .config/defconfig does it now just get
> > > dropped silently?
> > 
> > People will have to look at this new stuff anyway.
> > 
> > > For example firewire has CONFIG_FIREWIRE even though the "standard" name
> > > is IEEE 1394. I was thinking maybe we can do the same for
> > > USB4/Thunderbolt
> > 
> > USB and Thunderbolt used to be distinct protocols. Whereas Firewire
> > was just a colloquial name for IEEE1394. Please be wordy here.
> > "Unified support for USB4 and Thunderbolt4"
> 
> OK.
> 
> I've been thinking this bit more and since Thunderbolt will stick around
> as well (it basically implements all the optional USB4 features and
> more) so would it make sense to have the Kconfig option be
> CONFIG_THUNDERBOLT_USB4 (or CONFIG_USB4_THUNDERBOLT)? That should cover
> both.

I would stick with CONFIG_USB4 but put both in the Kconfig text.  Again,
it will be easier to handle this over time.

> Comments?
> 
> Also does anyone have any thoughts about keeping the driver under
> drivers/thunderbolt vs. moving it under usb like
> drivers/usb/thunderbolt? I'm thinking if anyone not familiar with this
> tries to enable support for USB4 so the first place he/she probably
> looks is under "USB support" menuconfig entry.

You are not sharing/needing any of the drivers/usb/ code just yet,
right?  I imagine that will happen "soon" and when it does, then sure,
moving stuff is fine with me.

thanks,

greg k-h
