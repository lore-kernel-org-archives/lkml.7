Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F633C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23032064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfDQLE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:04:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:44182 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfDQLEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:04:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 04:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="165495703"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2019 04:04:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Apr 2019 14:04:13 +0300
Date:   Wed, 17 Apr 2019 14:04:13 +0300
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
Message-ID: <20190417110413.GR1747@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
 <9304d771-df1f-aea4-43d2-7db540953cdd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9304d771-df1f-aea4-43d2-7db540953cdd@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:52:15AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-04-19 11:32, Heikki Krogerus wrote:
> > On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 17-04-19 08:39, Heikki Krogerus wrote:
> > > > On Tue, Apr 16, 2019 at 11:35:36PM +0200, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 12-04-19 15:41, Heikki Krogerus wrote:
> > > > > > Now that the software nodes support references, and the
> > > > > > device connection API support parsing fwnode references,
> > > > > > replacing the old connection descriptions with software node
> > > > > > references. Relying on device names when matching the
> > > > > > connection would not have been possible to link the USB
> > > > > > Type-C connector and the DisplayPort connector together, but
> > > > > > with real references it's not problem.
> > > > > > 
> > > > > > The DisplayPort ACPI node is dag up, and the drivers own
> > > > > > software node for the DisplayPort is set as the secondary
> > > > > > node for it. The USB Type-C connector refers the software
> > > > > > node, but it is now tied to the ACPI node, and therefore any
> > > > > > device entry (struct drm_connector in practice) that the
> > > > > > node combo is assigned to.
> > > > > > 
> > > > > > The USB role switch device does not have ACPI node, so we
> > > > > > have to wait for the device to appear. Then we can simply
> > > > > > assign our software node for the to the device.
> > > > > > 
> > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > 
> > > > > So as promised I've been testing this series and this commit
> > > > > breaks type-c functionality on devices using this driver.
> > > > > 
> > > > > The problem is that typec_switch_get() and  typec_mux_get()
> > > > > after this both return the same pointer, which is pointing
> > > > > to the switch, so typec_mux_get() is returning the wrong
> > > > > pointer.
> > > > > 
> > > > > This is not surprising since the references for both are
> > > > > both pointing to the fwnode attached to the piusb30532 devices:
> > > > > 
> > > > > 	args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
> > > > > 
> > > > > So the class_find_device here:
> > > > > 
> > > > > static void *typec_switch_match(struct device_connection *con, int ep,
> > > > >                                   void *data)
> > > > > {
> > > > >           struct device *dev;
> > > > > 
> > > > >           if (con->fwnode) {
> > > > >                   if (con->id && !fwnode_property_present(con->fwnode, con->id))
> > > > >                           return NULL;
> > > > > 
> > > > >                   dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
> > > > >                                           fwnode_match);
> > > > >           } else {
> > > > >                   dev = class_find_device(&typec_mux_class, NULL,
> > > > >                                           con->endpoint[ep], name_match);
> > > > >           }
> > > > > 
> > > > >           return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> > > > > }
> > > > > 
> > > > > Simply returns the first typec_mux_class device registered.
> > > > > 
> > > > > I see 2 possible solutions to this problem:
> > > > > 
> > > > > 1) Use separate typec_mux_class and typec_orientation_switch_class-es
> > > > > 
> > > > > 2) Merge struct typec_switch and struct typec_mux into a single struct,
> > > > > so that all typec_mux_class devices have the same memory layout, add
> > > > > a subclass enum to this new merged struct and use that to identify
> > > > > which of the typec_mux_class devices with the same fwnode pointer we
> > > > > want.
> > > > > 
> > > > > Any other suggestions?
> > > > 
> > > > I think the correct fix is that we supply separate nodes for both
> > > > device entries.
> > > 
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
> Ok.
> 
> > > Note that another problem with this series which I noticed while testing
> > > is that the usb-role-switch is not being found at all anymore after
> > > this ("Replacing the old connections with references") patch. I still need
> > > start debugging that.
> > 
> > OK, I'll wait for you results on that.
> 
> I understand that you want to wait with doing a v4 until this is resolved,
> but can you (privately) send me a v3.5 fixing the mux/switch issue so that
> I can test that (and get the problem out of the way for debugging the other
> stuff) ?
> 
> I've also just replied to the following patch with a review remark:
> [PATCH v3 11/13] platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
> 
> Since you need to respin the series anyways, it would be good if you can
> address that too.

Sure thing. I don't have time today to prepare the patches for you to
test today, nor tomorrow depending I'm a travelling or not, so this may
have wait for next week (Friday's off) :-(


thanks,

-- 
heikki
