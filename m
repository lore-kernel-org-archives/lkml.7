Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691AC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D9D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfJDIBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:01:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:33959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDIBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:01:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="205801934"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 01:00:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Oct 2019 11:00:58 +0300
Date:   Fri, 4 Oct 2019 11:00:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
Message-ID: <20191004080058.GD1048@kuha.fi.intel.com>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <20191003112618.GA2420393@kroah.com>
 <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
 <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:56:24PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 03-10-2019 22:45, John Stultz wrote:
> > On Thu, Oct 3, 2019 at 4:26 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Wed, Oct 02, 2019 at 11:16:16PM +0000, John Stultz wrote:
> > > > From: Yu Chen <chenyu56@huawei.com>
> > > > 
> > > > This patch adds notifier for drivers want to be informed of the usb role
> > > > switch.
> > > 
> > > Ick, I hate notifiers, they always come back to cause problems.
> > > 
> > > What's just wrong with a "real" call to who ever needs to know this?
> > > And who does need to know this anyway?  Like Hans said, if we don't have
> > > a user for it, we should not add it.
> > 
> > So in this case, its used for interactions between the dwc3 driver and
> > the hikey960 integrated USB hub, which is controlled via gpio (which I
> > didn't submit here as I was trying to keep things short and
> > reviewable, but likely misjudged).
> > 
> > The HiKey960 has only one USB controller, but in order to support both
> > USB-C gadget/OTG and USB-A (host only) ports. When the USB-C
> > connection is attached, it powers down and disconnects the hub. When
> > the USB-C connection is detached, it powers the hub on and connects
> > the controller to the hub.
> 
> When you say one controller, do you mean 1 host and 1 gadget controller,
> or is this one of these lovely devices where a gadget controller gets
> abused as / confused with a proper host controller?
> 
> And since you are doing a usb-role-switch driver, I guess that the
> role-switch is integrated inside the SoC, so you only get one pair
> of USB datalines to the outside ?

Unless I'm mistaken, the dwc3 driver in this case is the
usb-role-switch. The DWC3 IP includes both USB dost and device blocks,
i.e. it's a dual role controller. Drivers like tcpm.c that negotiate
the actual role need to tell the outcome of the negotiation to the
dwc3 driver. So I think this part is OK.

The platform has also some kind of discrete switch for routing the
signals to either Standard-A (the hub) or Type-C connector, so it does
not represent the usb-role-switch. It should however affect the USB role,
as if that switch routes the data signals to the Standard-A port (to
the hub) instead of USB Type-C, the USB role needs to be fixed to host
mode.

I guess this series does not include the driver for that discrete
switch/mux. I don't remember/know how that switch was planned to be
handled.

> This does seem rather special, it might help if you can provide a diagram
> with both the relevant bits inside the SoC as well as what lives outside
> the Soc. even if it is in ASCII art...

thanks,

-- 
heikki
