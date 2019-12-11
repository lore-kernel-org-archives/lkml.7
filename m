Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A96C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D78208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfLKQNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:13:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55056 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730381AbfLKPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:08:28 -0500
Received: (qmail 1705 invoked by uid 2102); 11 Dec 2019 10:08:27 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2019 10:08:27 -0500
Date:   Wed, 11 Dec 2019 10:08:27 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] USB: core: Attempt power cycle port when it's in
 eSS.Disabled state
In-Reply-To: <62C4527A-5231-4A69-BE7C-9844E2123A90@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1912111006280.1549-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Kai-Heng Feng wrote:

> 
> 
> > On Nov 30, 2019, at 01:41, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > 
> > On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
> > then connects to ASMedia xHCI's root hub:
> > 
> > /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
> >    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
> >            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> > 
> > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
> > Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
> > 
> > The SMSC hub may disconnect after system resume from suspend. When this
> > happens, the reset resume attempt fails, and the last resort to disable
> > the port and see something comes up later, also fails.
> > 
> > When the issue occurs, the link state stays in eSS.Disabled state
> > despite the warm reset attempts. Accoding to spec this can be caused by
> > invalid VBus, after some expiremets, the SMSC hub can be brought back
> > after a powercycle.
> > 
> > So let's power cycle the port at the end of reset resume attempt, if
> > it's in eSS.Disabled state.
> 
> If there's no objection, can this fix be reviewed and merged?
> 
> Kai-Heng

The patch is okay as far as I'm concerned, since it doesn't do anything 
for non-SuperSpeed connections.  It should be reviewed by Mathias.

Alan Stern

> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> > - Lower dev_info() to dev_dbg().
> > 
> > drivers/usb/core/hub.c | 16 ++++++++++++++++
> > 1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 6b6cd76ac5e6..a2e6001046f5 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2739,6 +2739,18 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
> > 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
> > }
> > 
> > +static bool hub_port_power_cycle_required(struct usb_hub *hub, int port1,
> > +		u16 portstatus)
> > +{
> > +	u16 link_state;
> > +
> > +	if (!hub_is_superspeed(hub->hdev))
> > +		return false;
> > +
> > +	link_state = portstatus & USB_PORT_STAT_LINK_STATE;
> > +	return link_state == USB_SS_PORT_LS_SS_DISABLED;
> > +}
> > +
> > static void hub_port_power_cycle(struct usb_hub *hub, int port1)
> > {
> > 	struct usb_port *port_dev = hub->ports[port1  - 1];
> > @@ -3601,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> > 	if (status < 0) {
> > 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
> > 		hub_port_logical_disconnect(hub, port1);
> > +		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
> > +			dev_dbg(&udev->dev, "device in disabled state, attempt power cycle\n");
> > +			hub_port_power_cycle(hub, port1);
> > +		}
> > 	} else  {
> > 		/* Try to enable USB2 hardware LPM */
> > 		usb_enable_usb2_hardware_lpm(udev);
> > -- 
> > 2.17.1

