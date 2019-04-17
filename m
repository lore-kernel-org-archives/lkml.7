Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7659620821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfDQKo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:44:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:34257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQKo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:44:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 03:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="165492292"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2019 03:44:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Apr 2019 13:44:54 +0300
Date:   Wed, 17 Apr 2019 13:44:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Message-ID: <20190417104454.GQ1747@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
 <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:15:18PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-04-19 11:32, Heikki Krogerus wrote:
> > On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:
> 
> <snip>
> 
> > > That is not going to work since the (virtual) mux / orientation-switch
> > > devices are only registered once the driver binds to the piusb30532 i2c
> > > device, so when creating the nodes we only have the piusb30532 i2c device.
> > 
> > It's not a problem, that's why we have the software nodes. The nodes
> > can be created before the device entires. The node for pi3usb30532
> > will just be the parent node for the new nodes we add for the mux and
> > switch.
> > 
> > > I've been thinking some more about this and an easy fix is to have separate
> > > fwnode_match functions for typec_switch_match and typec_mux_match and have
> > > them check that the dev_name ends in "-mux" resp. "-switch" that requires
> > > only a very minimal change to "usb: typec: Registering real device entries for the muxes"
> > > and then everything should be fine.
> > 
> > I don't want to do anymore device name matching unless we have to, and
> > here we don't have to. We can name the nodes for those virtual mux and
> > switch, and then just do fwnode_find_named_child_node() in
> > pi3usb30532.c for both of them.
> 
> Thinking more about this, I have a feeling that this makes things needlessly
> complicated, checking the dev_name *ends* in "-mux" resp. "-switch" should be
> 100% reliable since we call:
> 
>         dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
>         dev_set_name(&mux->dev, "%s-mux", dev_name(parent));
> 
> When registering the switch / mux, so I believe doing name (suffix) comparison
> here is fine and much simpler. Anyways this is just my 2 cents on this, I'm
> happy with either solution, your choice.

You do have a point. I'll take a look how the two options look like,
but maybe your way is better after all.

thanks,

-- 
heikki
