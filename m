Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C5921906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJANaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:30:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:28518 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfJANaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:30:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205063718"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 06:30:16 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 16:30:16 +0300
Date:   Tue, 1 Oct 2019 16:30:16 +0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 12/22] thunderbolt: Add Display Port CM handshake for
 Titan Ridge devices
Message-ID: <20191001133016.GS2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-13-mika.westerberg@linux.intel.com>
 <20191001124409.GG2954373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001124409.GG2954373@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:44:09PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:20PM +0300, Mika Westerberg wrote:
> > Titan Ridge devices and newer need an additional connection manager
> > handshake in order to do proper Display Port tunneling so implement it
> > here.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/tb_regs.h |  3 +++
> >  drivers/thunderbolt/tunnel.c  | 44 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> > index 3a39490a954b..8d11b4a2d552 100644
> > --- a/drivers/thunderbolt/tb_regs.h
> > +++ b/drivers/thunderbolt/tb_regs.h
> > @@ -252,6 +252,9 @@ struct tb_regs_port_header {
> >  #define ADP_DP_CS_3_HDPC			BIT(9)
> >  #define DP_LOCAL_CAP				0x04
> >  #define DP_REMOTE_CAP				0x05
> > +#define DP_STATUS_CTRL				0x06
> > +#define DP_STATUS_CTRL_CMHS			BIT(25)
> > +#define DP_STATUS_CTRL_UF			BIT(26)
> >  
> >  /* PCIe adapter registers */
> >  #define ADP_PCIE_CS_0				0x00
> > diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> > index 3353396e0806..369800110e5e 100644
> > --- a/drivers/thunderbolt/tunnel.c
> > +++ b/drivers/thunderbolt/tunnel.c
> > @@ -6,6 +6,7 @@
> >   * Copyright (C) 2019, Intel Corporation
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/slab.h>
> >  #include <linux/list.h>
> >  
> > @@ -242,6 +243,41 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
> >  	return tunnel;
> >  }
> >  
> > +static int tb_dp_cm_handshake(struct tb_port *in, struct tb_port *out)
> > +{
> > +	int timeout = 10;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* Both ends need to support this */
> > +	if (!tb_switch_is_tr(in->sw) || !tb_switch_is_tr(out->sw))
> > +		return 0;
> 
> So if the ends are both "Titan Ridge", matches your changelog text, but
> where is the "and newer" comment being checked here?

By "and newer" I mean USB4 devices which are added in patch 17/22. I can
update the changelog here to mention just Titan Ridge, though.
