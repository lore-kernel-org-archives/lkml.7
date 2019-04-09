Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3914AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103F22084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDIMi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:38:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:36128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIMi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:38:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 05:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="162716165"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 09 Apr 2019 05:38:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2019 15:38:20 +0300
Date:   Tue, 9 Apr 2019 15:38:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 10/11] platform/x86: intel_cht_int33fe: Link with
 external dependencies using fwnodes
Message-ID: <20190409123820.GA20058@kuha.fi.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
 <20190403164537.24643-11-heikki.krogerus@linux.intel.com>
 <CAHp75VeTUCQax01xVNg7N6oAYKoxadX9vL-X9oEQFHHJ6OSrpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeTUCQax01xVNg7N6oAYKoxadX9vL-X9oEQFHHJ6OSrpg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:42:52PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 3, 2019 at 7:46 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Supplying also external devices - the DisplayPort connector
> > and the USB role switch - software fwnodes. After this the
> > driver has access to all the components tied to the USB
> > Type-C connector and can start creating software node
> > references to actually associate them with the USB Type-C
> > connector device.
> 
> > +static int role_switch_match(struct device *dev, void *name)
> > +{
> > +       return !strcmp(dev_name(dev), name);
> > +}
> > +
> > +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> > +{
> 
> > +       /* First let's find xHCI PCI device */
> > +       pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> > +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> > +               return -ENODEV;
> > +
> 
> > +       /* Then the child platform device */
> > +       p = device_find_child(&pdev->dev, "intel_xhci_usb_sw",
> > +                             role_switch_match);
> 
> We have already similar code in kernel
> (drivers/nvdimm/claim.c::namespace_match), perhaps
> you at least can (locally) introduce
> 
> static int match_name(...) // or re-use from drivers/base/bus.c
> {
> ...
> }

OK.

> static device_find_child_by_name(...)
> {
> ...
> }
> 
> which we may move to the driver core now or later on.
> 
> > +       pci_dev_put(pdev);
> > +       if (!p)
> > +               return -EPROBE_DEFER;
> > +
> 
> > +       /* Finally the mux device */
> > +       dev = device_find_child(p, "intel_xhci_usb_sw-role-switch",
> > +                               role_switch_match);
> 
> Ditto.
> 
> > +       put_device(p);
> > +       if (!dev)
> > +               return -EPROBE_DEFER;
> 
> > +       return 0;
> 
> > +}
> 
> > +static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
> > +{
> > +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> > +       struct pci_dev *pdev;
> > +
> > +       /* First let's find the GPU PCI device */
> > +       pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> > +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> > +               return -ENODEV;
> > +
> > +       /* Then the DP child device node */
> > +       data->dp = device_get_named_child_node(&pdev->dev, "DD02");
> > +       pci_dev_put(pdev);
> > +       if (!data->dp)
> > +               return -ENODEV;
> > +
> 
> > +       fwnode->secondary = ERR_PTR(-ENODEV);
> > +       data->dp->secondary = fwnode;
> 
> Can't generic helper be in charge of doing this, i.e. chaining fwnodes?
> 
> ///
> void fwnode_chain(parent, new)
> {
> ...
> }
> ///

We probable should just export set_secondary_fwnode(). I'll add a
patch for that.


thanks Andy,

-- 
heikki
