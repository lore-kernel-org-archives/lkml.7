Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6716C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7858321872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfJAMsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:48:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:56151 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJAMsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:48:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 05:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205057860"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 05:48:42 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 15:48:41 +0300
Date:   Tue, 1 Oct 2019 15:48:41 +0300
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
Subject: Re: [RFC PATCH 03/22] thunderbolt: Log warning if adding switch fails
Message-ID: <20191001124841.GM2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-4-mika.westerberg@linux.intel.com>
 <20191001121804.GC2951658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001121804.GC2951658@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:18:04PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:11PM +0300, Mika Westerberg wrote:
> > If we fail to add a switch for some reason log a warning with the error
> > code. This is useful for debugging.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/tb.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index 1f7a9e1cc09c..541295be9bfc 100644
> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -143,6 +143,7 @@ static void tb_scan_port(struct tb_port *port)
> >  	struct tb_cm *tcm = tb_priv(port->sw->tb);
> >  	struct tb_port *upstream_port;
> >  	struct tb_switch *sw;
> > +	int ret;
> >  
> >  	if (tb_is_upstream_port(port))
> >  		return;
> > @@ -203,7 +204,9 @@ static void tb_scan_port(struct tb_port *port)
> >  	if (!tcm->hotplug_active)
> >  		dev_set_uevent_suppress(&sw->dev, true);
> >  
> > -	if (tb_switch_add(sw)) {
> > +	ret = tb_switch_add(sw);
> > +	if (ret) {
> > +		dev_warn(&sw->dev, "failed to register switch: %d\n", ret);
> 
> Shouldn't tb_switch_add() do the error reporting instead?  That way it
> makes it easier to call functions and not always have to print failure
> messages :)

Yes, that's better - I'll move it there.
