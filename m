Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2504C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77337206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLRPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:30:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:46393 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfLRPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:30:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 07:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="222031283"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 18 Dec 2019 07:30:03 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 18 Dec 2019 17:30:02 +0200
Date:   Wed, 18 Dec 2019 17:30:02 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] thunderbolt: Add support for USB4
Message-ID: <20191218153002.GY2913417@lahna.fi.intel.com>
References: <20191217123345.31850-1-mika.westerberg@linux.intel.com>
 <20191218144316.GA321016@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218144316.GA321016@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:43:16PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2019 at 03:33:36PM +0300, Mika Westerberg wrote:
> > Hi all,
> > 
> > USB4 is the public specification of Thunderbolt 3 protocol and can be
> > downloaded here:
> > 
> >   https://www.usb.org/sites/default/files/USB4%20Specification_1.zip
> > 
> > USB4 is about tunneling different protocols over a single cable (in the
> > same way as Thunderbolt). The current USB4 spec supports PCIe, Display Port
> > and USB 3.x, and also software based protocols such as networking between
> > domains (hosts).
> > 
> > So far PCs have been using firmware based Connection Manager (FW CM, ICM)
> > and Apple systems have been using software based one (SW CM, ECM). A
> > Connection Manager is the entity that handles creation of different tunnel
> > types through the USB4 (and Thunderbolt) fabric. With USB4 the plan is to
> > have software based Connection Manager everywhere but some early systems
> > will come with firmware based connection manager.
> > 
> > Current Linux Thunderbolt driver supports both "modes" and can detect which
> > one to use dynamically.
> > 
> > This series extends the Linux Thunderbolt driver to support USB4 compliant
> > hosts and devices (this applies to both firmware and software based
> > connection managers). USB4 Features enabled by this series include:
> > 
> >   - PCIe tunneling
> >   - Display Port tunneling
> >   - USB 3.x tunneling
> >   - P2P networking (implemented in drivers/net/thunderbolt.c)
> >   - Host and device NVM firmware upgrade
> > 
> > Power management support is still work in progress. It will be submitted
> > later on once properly tested.
> > 
> > The previous versions of the series can be seen here:
> > 
> >   v1: https://lore.kernel.org/linux-usb/20191023112154.64235-1-mika.westerberg@linux.intel.com/
> >   RFC: https://lore.kernel.org/lkml/20191001113830.13028-1-mika.westerberg@linux.intel.com/
> > 
> > Changes from v1:
> > 
> >   * Rebased on top of v5.5-rc2.
> >   * Add a new patch to populate PG field in hotplug ack packet.
> >   * Rename the networking driver Kconfig symbol to CONFIG_USB4_NET to
> >     follow the driver itself (CONFIG_USB4).
> 
> At a quick glance, this looks nice and sane, good job.  I've taken all
> of these into my tree, let's see if 0-day has any problems with it :)

Thanks :)
