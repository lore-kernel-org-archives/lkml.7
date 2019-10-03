Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07803C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9BB21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJCIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:52:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:17229 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfJCIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:52:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="205569989"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Oct 2019 01:52:17 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Oct 2019 11:52:17 +0300
Date:   Thu, 3 Oct 2019 11:52:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 20/22] thunderbolt: Add support for USB tunnels
Message-ID: <20191003085217.GP2819@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-21-mika.westerberg@linux.intel.com>
 <1570092176.18913.7.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570092176.18913.7.camel@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:42:56AM +0200, Oliver Neukum wrote:
> Am Dienstag, den 01.10.2019, 14:38 +0300 schrieb Mika Westerberg:
> > From: Rajmohan Mani <rajmohan.mani@intel.com>
> > 
> > USB4 added a capability to tunnel USB 3.x protocol over the USB4
> > fabric. USB4 device routers may include integrated SuperSpeed HUB or a
> > function or both. USB tunneling follows PCIe so that the tunnel is
> > created between the parent and the child router from USB downstream
> > adapter port to USB upstream adapter port over a single USB4 link.
> > 
> > This adds support for USB tunneling and also capability to discover
> > existing USB tunnels (for example created by connection manager in boot
> > firmware).
> > 
> > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/switch.c  |  35 ++++++++
> >  drivers/thunderbolt/tb.c      | 153 ++++++++++++++++++++++++++------
> >  drivers/thunderbolt/tb.h      |  15 ++++
> >  drivers/thunderbolt/tb_regs.h |   9 +-
> >  drivers/thunderbolt/tunnel.c  | 158 +++++++++++++++++++++++++++++++++-
> >  drivers/thunderbolt/tunnel.h  |   9 ++
> >  drivers/thunderbolt/usb4.c    |  41 ++++++++-
> >  7 files changed, 393 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > index 58e3f54ddbb9..5a3236fefb76 100644
> > --- a/drivers/thunderbolt/switch.c
> > +++ b/drivers/thunderbolt/switch.c
> > @@ -1025,11 +1025,46 @@ bool tb_port_is_enabled(struct tb_port *port)
> >  	case TB_TYPE_DP_HDMI_OUT:
> >  		return tb_dp_port_is_enabled(port);
> >  
> > +	case TB_TYPE_USB_UP:
> > +	case TB_TYPE_USB_DOWN:
> > +		return tb_usb_port_is_enabled(port);
> > +
> >  	default:
> >  		return false;
> >  	}
> >  }
> >  
> > +/**
> > + * tb_usb_port_is_enabled() - Is the USB adapter port enabled
> > + * @port: USB port to check
> > + */
> > +bool tb_usb_port_is_enabled(struct tb_port *port)
> 
> Should these functions be called tb_usb3_port... ?
> This looks like all USB would need this.

Yes, I agree it follows the spec better that way.

> > -static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA" };
> > +static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA", "USB"};
> 
> USB3 ?

Sure.
