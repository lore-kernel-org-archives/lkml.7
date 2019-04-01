Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B098520700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfDAHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:44:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:26672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731833AbfDAHoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:44:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 00:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,295,1549958400"; 
   d="scan'208";a="312083617"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 01 Apr 2019 00:44:02 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 01 Apr 2019 10:44:01 +0300
Date:   Mon, 1 Apr 2019 10:44:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        andreas.noever@gmail.com, andriy.shevchenko@linux.intel.com,
        ckellner@redhat.com
Subject: Re: [PATCH v3 00/36] thunderbolt: Software connection manager
 improvements
Message-ID: <20190401074401.GO3622@lahna.fi.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <1aaab9baea4f46b481b5601dfb060104@ausx13mpc120.AMER.DELL.COM>
 <20190328165621.GB3622@lahna.fi.intel.com>
 <20190401043111.smpqjn3dhgitmh3e@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401043111.smpqjn3dhgitmh3e@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 06:31:11AM +0200, Lukas Wunner wrote:
> On Thu, Mar 28, 2019 at 06:56:21PM +0200, Mika Westerberg wrote:
> > On Thu, Mar 28, 2019 at 03:17:57PM +0000, Mario.Limonciello@dell.com wrote:
> > > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Sent: Thursday, March 28, 2019 7:36 AM
> > > >   * Do not automatically create PCIe tunnels. Instead we implement "user"
> > > >     security level in the software connection manager as well taking
> > > >     advantage of the existing sysfs interfaces. This allows user to disable
> > > >     PCIe tunneling completely or implement different white listing
> > > >     policies. Major distros include bolt system daemon that takes care of
> > > >     this.
> > > 
> > > This is a bit unfortunate.  Is this because of IOMMU limitations in working
> > > with devices down the chain?
> > 
> > No, it just makes it possible to do things such as "disable all PCIe
> > tunneling", like the master switch we have in GNOME UI.
> 
> It appears to be a change in behavior though as PCIe tunnels are
> currently established automatically on Macs which don't use ICM.
> The change might be considered breaking userspace, not sure.

I don't think userspace is breaking here. The userspace interface we
provide is through sysfs and only change we do in this series that could
affect is in the patch 05. I Cc'd Mario and Christian just to make sure
fwupd and bolt still keep working (these are the two userspace
applications using the interface AFAIK).

I think you mean user experience instead. It should not affect because
if you run any major distro all the components including GNOME UI are
prepared to handle this.

> Also on macOS it's just plug and play without any need to configure
> whitelists or anything.

macOS does have whitelist too. If you plug in unsupported device you
don't get to use it and it is listed as "unsupported" in the system
report. I'm not sure if end users can tune the list.

In Linux side I would really like to make it possible to implement
whitelisting and disabling PCIe tunneling, and since we already have the
interface for that (the sysfs ABI) it only makes sense to use it. That
interface allows userspace to implement different kinds of policies from
disabling all PCIe tunneling to allowing everything (it can be done
using simple udev rule).
