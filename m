Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D2DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171C82190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569934199;
	bh=tGW212EaZmrIn29aaNmsRxwukQPltuKjXALvxdLiSqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t1UhsbjzEeEm385dMFQzvo50JkewNBBFjRHwNJjoYIrkEhAZ48CebatmIyQKJsmGm
	 gRyPvF18yNhdY2P4Nhyn1rPTyvjpaPE3IcPMdQwvlPhlP1aHFJcqUlB+naTSDwTH85
	 TPQ3apsRuQ8Oh6E/xKqLvsx3XTWh55TBihCHi49o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfJAMt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:49:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7160C21872;
        Tue,  1 Oct 2019 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934197;
        bh=tGW212EaZmrIn29aaNmsRxwukQPltuKjXALvxdLiSqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMuMSnOFckB43S5qaHlnoK/36P6/h3jdTZTwaFWd3frHjaQGai/xTS/gzELxjtUk2
         Rpu1UjpzbrecweumHflFu49IPS6+ih3Xnjkdt4mK9lJHvkbCkvMl2QRxd/ldD1kmef
         7OCHDEgtKzSsCuItX8L5/YHlSEPeygv67jfLkQRE=
Date:   Tue, 1 Oct 2019 14:49:54 +0200
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
Subject: Re: [RFC PATCH 00/22] thunderbolt: Add support for USB4
Message-ID: <20191001124954.GI2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:08PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> I'm sending this as RFC because the series is still missing important
> features such as power management so not ready for merging. However, I
> think it is good to get any early feedback from the community. We are
> working to add support for the missing features.
> 
> USB4 is the public specification of Thunderbolt 3 protocol and can be
> downloaded here:
> 
>   https://www.usb.org/sites/default/files/USB4%20Specification_1.zip
> 
> USB4 is about tunneling different protocols over a single cable (in the
> same way as Thunderbolt). The current USB4 spec supports PCIe, Display Port
> and USB 3.x, and also software based protocols such as networking between
> domains (hosts).
> 
> So far PCs have been using firmware based Connection Manager and Apple
> systems have been using software based one. A Connection Manager is the
> entity that handles creation of different tunnel types through the USB4
> (and Thunderbolt) fabric. With USB4 the plan is to have software based
> Connection Manager everywhere but some early systems will also support
> firmware to allow OS downgrade for example.
> 
> Current Linux Thunderbolt driver supports both "modes" and can detect which
> one to use dynamically.
> 
> This series first adds support for Thunderbolt 3 devices to the software
> connection manager and then extends that to support USB4 compliant hosts
> and devices (this applies to both firmware and software based connection
> managers). With this series the following features are supported also for
> USB4 compliant devices:
> 
>   - PCIe tunneling
>   - Display Port tunneling
>   - USB 3.x tunneling
>   - P2P networking (implemented in drivers/net/thunderbolt.c)
>   - Host and device NVM firmware upgrade
> 
> We also add two new sysfs attributes under each device that expose link
> speed and width to userspace. The rest of the userspace ABI stays the same.
> 
> I'm including Linux USB folks as well because USB4 is officially coming
> from USB-IF which puts us on same boat now.
> 
> While I changed the user visible Kconfig string to mention "USB4" (the
> Kconfig option is still CONFIG_THUNDERBOLT), I'm wondering whether we
> should move the whole Thunderbolt driver under drivers/usb/thunderbolt as
> well? 

Looks "interesting", nice work!

I stopped at patch "Add initial support for USB4" as I don't think we
want to add USB4 code to a system that we know does not have it, right?

Everything up to then is just "normal" thunderbolt, and with the
exception of a few minor comments, all look fine to me.

I didn't actually read the USB4 patch just yet, as I figured we needed
to argue about that some more :)

thanks,

greg k-h
