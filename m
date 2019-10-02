Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E569C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8146D206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJBIjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:39:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:10445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfJBIjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:39:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 01:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; 
   d="scan'208";a="205279402"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 01:39:14 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 11:39:14 +0300
Date:   Wed, 2 Oct 2019 11:39:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191002083913.GG2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:14:23PM +0000, Mario.Limonciello@dell.com wrote:
> One more thought; would you consider exporting to sysfs sw->config.vendor_id?
> Maybe an attribute that is switch_vendor?
> 
> Userland fwupd also does validation on the NVM and will need to follow this.
> The same check will go into fwupd to match the vendor and lack of nvm_non_active0
> to mark the device as not updatable.  When the checks in the kernel get relaxed,
> some NVM parsing will have to make it over to fwupd too to relax the check at that point.

The original idea was that the kernel does the basic validation and
userspace then does more complex checks. Currently you can compare the
two NVM images (active one and the new) and find that information there.
I think fwupd is doing just that already. Is that not enough?
