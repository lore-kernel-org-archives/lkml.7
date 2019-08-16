Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A71C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHPNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:53:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:52476 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPNxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:53:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 06:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="194995219"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 16 Aug 2019 06:52:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 16 Aug 2019 16:52:31 +0300
Date:   Fri, 16 Aug 2019 16:52:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] usb: roles: intel_xhci: Supplying software node
 for the role mux
Message-ID: <20190816135231.GA5356@kuha.fi.intel.com>
References: <20190816104515.63613-1-heikki.krogerus@linux.intel.com>
 <20190816104515.63613-3-heikki.krogerus@linux.intel.com>
 <CAHp75VcuR+X5=-+VQ9HxU5Nh-uexzDbmZzX_JbZZ2B6tYXQmAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcuR+X5=-+VQ9HxU5Nh-uexzDbmZzX_JbZZ2B6tYXQmAQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:45:50PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 16, 2019 at 1:45 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > The primary purpose for this node will be to allow linking
> > the users of the switch to it. The users will be for example
> > USB Type-C connectors. By supplying a reference to this
> > node in the software nodes representing the USB Type-C
> > controllers or connectors, the drivers for those devices can
> > access the switch.
> 
> > +       ret = software_node_register(&intel_xhci_usb_node);
> > +       if (ret)
> > +               return ret;
> > +
> > +       sw_desc.set = intel_xhci_usb_set_role,
> > +       sw_desc.get = intel_xhci_usb_get_role,
> > +       sw_desc.allow_userspace_control = true,
> > +       sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
> > +
> >         data->role_sw = usb_role_switch_register(dev, &sw_desc);
> >         if (IS_ERR(data->role_sw))
> >                 return PTR_ERR(data->role_sw);
> 
> Sounds to me like more fwnode_handle_put() calls are missed.

True. I'll fix it.

thanks,

-- 
heikki
