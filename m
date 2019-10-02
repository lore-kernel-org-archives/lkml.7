Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815B7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfJBIev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:34:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:57526 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfJBIev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:34:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 01:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; 
   d="scan'208";a="205279023"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 01:34:46 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 11:34:46 +0300
Date:   Wed, 2 Oct 2019 11:34:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191002083446.GF2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:05:09PM +0000, Mario.Limonciello@dell.com wrote:
> > @@ -322,9 +398,21 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
> >  	u32 val;
> >  	int ret;
> > 
> > -	if (!sw->dma_port)
> > +	if (!nvm_readable(sw))
> >  		return 0;
> > 
> > +	/*
> > +	 * The NVM format of non-Intel hardware is not known so
> > +	 * currently restrict NVM upgrade for Intel hardware. We may
> > +	 * relax this in the future when we learn other NVM formats.
> > +	 */
> > +	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL) {
> > +		dev_info(&sw->dev,
> > +			 "NVM format of vendor %#x is not known, disabling NVM
> > upgrade\n",
> > +			 sw->config.vendor_id);
> > +		return 0;
> > +	}
> > +
> 
> Don't you actually have an attribute you can use here for this exact purpose that you
> could  be setting rather than returning immediately?
> sw->no_nvm_upgrade
> 
> Then potentially you can at least let users "dump out" the nvm on !Intel but don't let
> it be written until ready to relax further.

Problem is that we currently read NVM version and size from a known
location in the NVM. If we don't know the format we can't do that so
that would mean we need to expose active NVM with some size and hide
nvm_version. I would rather have this support included in the kernel
driver and expose standard set of attributes but no strong feelings from
one way or another.
