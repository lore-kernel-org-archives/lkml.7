Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B76ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14254205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbfJAN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:27:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:26474 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388261AbfJAN1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:27:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205063337"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 06:27:03 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 16:27:03 +0300
Date:   Tue, 1 Oct 2019 16:27:02 +0300
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
Subject: Re: [RFC PATCH 08/22] thunderbolt: Add downstream PCIe port mappings
 for Alpine and Titan Ridge
Message-ID: <20191001132702.GQ2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-9-mika.westerberg@linux.intel.com>
 <20191001124054.GC2954373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001124054.GC2954373@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:40:54PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:16PM +0300, Mika Westerberg wrote:
> > In order to keep PCIe hierarchies consistent across hotplugs, add
> > hard-coded PCIe downstream port to Thunderbolt port for Alpine Ridge and
> > Titan Ridge as well.
> 
> Oh, that makes me nervous, how could a hard-coded pcie port ever get set
> up incorrectly :)
> 
> How do we "know" that this is correct?  Is there any ACPI guarantees
> that this "always will be so"?  If not, we all know someone will mess
> this up...

For Alpine Ridge and Titan Ridge the PCIe ports are always the same.

Basically what this is about is that you have up to two Thunderbolt
ports (type-C ports). When you plug in Thunderbolt device and PCIe gets
tunneled, the PCIe hierarchy always is always extended from the same
PCIe downstream port.

If we don't do this then the PCIe device may be changing its address
each plug/unplug. Also for older generations (that code is already in
mainline) there are PCIe downstream ports that do not have enough
resources for additional devices.

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/tb.c |  4 +++-
> >  drivers/thunderbolt/tb.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index dbbe9afb9fb7..704455a4f763 100644
> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -344,10 +344,12 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
> >  		 * Hard-coded Thunderbolt port to PCIe down port mapping
> >  		 * per controller.
> >  		 */
> > -		if (tb_switch_is_cr(sw))
> > +		if (tb_switch_is_cr(sw) || tb_switch_is_ar(sw))
> >  			index = !phy_port ? 6 : 7;
> >  		else if (tb_switch_is_fr(sw))
> >  			index = !phy_port ? 6 : 8;
> > +		else if (tb_switch_is_tr(sw))
> > +			index = !phy_port ? 8 : 9;
> >  		else
> >  			goto out;
> >  
> > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > index e641dcebd50a..dbab06551eaa 100644
> > --- a/drivers/thunderbolt/tb.h
> > +++ b/drivers/thunderbolt/tb.h
> > @@ -632,6 +632,31 @@ static inline bool tb_switch_is_fr(const struct tb_switch *sw)
> >  	}
> >  }
> >  
> > +static inline bool tb_switch_is_ar(const struct tb_switch *sw)
> 
> "ar"?  Can you spell it out?

You mean call this tb_switch_is_alpine_ridge()? Sure,  I will then do
the same for tb_switch_is_fr() and the existing ones.

> 
> > +{
> > +	switch (sw->config.device_id) {
> > +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE:
> > +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE:
> > +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
> > +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static inline bool tb_switch_is_tr(const struct tb_switch *sw)
> 
> Same for "tr" please.

Sure.
