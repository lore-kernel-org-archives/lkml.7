Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45EDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848EF20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKOQmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:42:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:14355 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfKOQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:42:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 08:41:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="214806201"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 15 Nov 2019 08:41:55 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Nov 2019 18:41:55 +0200
Date:   Fri, 15 Nov 2019 18:41:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     Benson Leung <bleung@google.com>, enric.balletbo@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org, Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
Message-ID: <20191115164155.GH4013@kuha.fi.intel.com>
References: <20191113031044.136232-1-jflat@chromium.org>
 <20191113175127.GA171004@google.com>
 <20191113182537.GC4013@kuha.fi.intel.com>
 <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
 <20191114152432.GD4013@kuha.fi.intel.com>
 <CACJJ=pywjs1=6mC7M8bOYKR3HfKx97C9jMEft7d98c6-go-Ubg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACJJ=pywjs1=6mC7M8bOYKR3HfKx97C9jMEft7d98c6-go-Ubg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 14, 2019 at 01:00:42PM -0800, Jon Flatley wrote:
> On Thu, Nov 14, 2019 at 7:24 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Jon,
> >
> > On Wed, Nov 13, 2019 at 05:09:56PM -0800, Jon Flatley wrote:
> > > > I'll go over these tomorrow, but I have one question already. Can you
> > > > guys influence what goes to the ACPI tables?
> > > >
> > > > Ideally every Type-C connector is always described in its own ACPI
> > > > node (or DT node if DT is used). Otherwise getting the correct
> > > > capabilities and especially connections to other devices (like the
> > > > muxes) for every port may get difficult.
> > >
> > > Hey Heikki, thank you for your quick response!
> > >
> > > In general we do have control over the ACPI tables and over DT. The
> > > difference for ChromeOS is that the PD implementation and policy
> > > decisions are handled by the embedded controller. This includes
> > > alternate mode transitions and control over the muxes. I don't believe
> > > there is any information about port capabilities in ACPI or DT, that's
> > > all handled by the EC. With current EC firmware we are mostly limited
> > > to querying the EC for port capabilities and state. There may be some
> > > exceptions to this, such as with Rockchip platforms, but even then the
> > > EC is largely in control.
> >
> > The capabilities here mean things like is the port: source, sink or
> > DRP; host, device or DRD; etc. So static information.
> >
> > I do understand that the EC is in control of the Port Controller (or
> > PD controller), the muxes, the policy decisions and what have you, and
> > that is fine. My point is that the operating system should not have to
> > get also the hardware description from the EC. That part should always
> > come from ACPI tables or DT, even when the components are attached to
> > the EC instead of the host CPU. Otherwise we loose scalability for no
> > good reason.
> >
> > Note. The device properties for the port capabilities are already
> > documented in kernel:
> > Documentation/devicetree/bindings/connector/usb-connector.txt (the
> > same properties work in ACPI as well).
> >
> > > I think you raise a valid point, but such a change is probably out of
> > > scope for this implementation.
> >
> > This implementation should already be made so that it works with a
> > properly prepared ACPI tables or DT. If there are already boards that
> > don't supply the nodes in ACPI tables for the ports, then software
> > nodes can be used with those, but all new boards really should have a
> > real firmware node represeting every Type-C port.
> 
> Hey Heikki,
> 
> I spoke with Benson and Prashant and you raise a good point. Moving
> forward we should probably be describing these capabilities in ACPI.
> We do want to support existing devices, and making changes to the ACPI
> tables would mean firmware modifications for each and every one, which
> is a complicated process.
> 
> To date the port capabilities on all ChromeOS devices have been the
> same. I recall now that we don't (and with current firmware can't)
> query the port capabilities from the EC; they're just hard coded into
> the driver. In the absence of these nodes in the ACPI tables we can
> populate these capabilities in software nodes. This would allow us to
> support existing systems without the expensive firmware change, and I
> think it still provides the scalability you're asking for.
> 
> Are you suggesting that every port on the device gets its own ACPI/DT node?

Yes. Every port (or maybe I should say "connector") should always have
its own ACPI/DT node.

There should also be a separate parent node for the port nodes that
represents the USB Type-C controller part (in EC), meaning you
probable don't want to simply make the port nodes child nodes directly
under the root EC node (the one that has ACPI HID GOOG0004 or
GOOG0008). The controller node is the one that is child of the root EC
node, and the port nodes are children of the controller. The
controller node ideally will have its own ACPI HID, but the port nodes
themselves don't need HIDs. I guess this part is clear..

I proposed in my review (patch 3/3) that there should be actually a
single parent controller node for every port, so that you would have
always a controller node with a single port node for every connector,
but that may be overkill. I was thinking about past problems where it
is no clear which port (number) should be mapped to which port node,
but you do not have that problem.

So I think you only need a single "EC Type-C Controller" node that
is the parent for the port nodes.

I'll put here a short ASL example snippet that has nodes for two
ports, that hopefully helps explain how I think this should be
described in the ACPI tables:

DefinitionBlock ("usbc.aml", "SSDT", 5, "GOOGLE", "USBC", 1)
{
    /* I'm assuming here that H_EC is the EC device. */
    Scope (\_SB.H_EC)
    {
        /*
         * This is the controller (port parent) device that communicates with
         * the EC. It is the node that would create the device instance for the
         * driver (drivers/platform/chrome/cros_ec_typec.c).
         */
        Device (USBC)
        {
            Name (_HID, "GOOGXXXX") /* FIXME!!!!!! */
            Name (_DDN, "ChromeOS Embedded Controller USB Type-C Control")

            /*
             * Each connector shall have its own ACPI device entry (node),
             * under the actual interface (controller) device.
             */
            Device (CON1)
            {
                /* Port number 1 */
                Name (_ADR, One)

                /* The port capability device properties. */
                Name (_DSD, Package () {
                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package() {
                        Package () {"power-role", "dual"},
                        Package () {"data-role", "dual"},
                    },
                })
            }

            Device (CON2)
            {
                /* Port number 2 */
                Name (_ADR, Two)

                Name (_DSD, Package () {
                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package() {
                        Package () {"power-role", "dual"},
                        Package () {"data-role", "dual"},
                    },
                })
            }
        }
    }
}

To play it safe (and be compatible with DT), the port number does not
have to be the node address (_ADR). You can get the port number also
from a device property as well of course.

Br,

-- 
heikki
