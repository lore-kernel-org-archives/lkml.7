Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05560206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfKTRjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:39:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:7956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfKTRjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:39:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 09:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="215871713"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 09:39:06 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 19:39:06 +0200
Date:   Wed, 20 Nov 2019 19:39:06 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     pmenzel@molgen.mpg.de, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com, ck@xatom.net,
        linux-kernel@vger.kernel.org, anthony.wong@canonical.com
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191120173906.GN11621@lahna.fi.intel.com>
References: <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <ccfa5f1a1b5e475aa4ddcbed2297b9c4@AUSX13MPC105.AMER.DELL.COM>
 <20191120152351.GJ11621@lahna.fi.intel.com>
 <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:06:39PM +0000, Mario.Limonciello@dell.com wrote:
> 
> > > Yeah it might be useful to enumerate all the BIOS settings that are selected
> > > related to Thunderbolt.  Some of them are a bit confusing.
> > 
> > BTW, I played a bit with 9380 and it looks like there is no option to
> > enable Preboot ACL which means that if you have TBT security enabled
> > (user or secure) the Dock PCIe side is not functional during boot, only
> > once the OS has booted up. That's fine unless you want to enter BIOS
> > menu from the keyboard you have connected to the TB16 dock (probably not
> > too common use case anyway).
> 
> Eh?  On 9380 in front of me:
> System Configuration -> Thunderbolt (TM) Adapter Configuration
> 
> There is a checkbox for "Enable Thunderbolt (and PCIe behind TBT) Pre-boot
> modules".  It's not checked by default, but that should turn on pre-boot ACL
> stuff.  That's the thing that Paul probably needs checked too.

Ah, it's that one :) I found it as well but did not realize it is the
Preboot ACL support. The "modules" at the end got me confused.

Yes, Paul that you need to enable if you want the devices behind the
dock to work before OS gets control.

> But I mean this is generally an unsafe (but convenient) option, it means that you
> throw out security pre-boot, and all someone needs to do is turn off your machine,
> plug in a malicious device, turn it on and then they have malicious device all the way
> into OS.

Yup.
