Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B720863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfCRO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:58:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54122 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726731AbfCRO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:58:29 -0400
Received: (qmail 4435 invoked by uid 2102); 18 Mar 2019 10:58:28 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Mar 2019 10:58:28 -0400
Date:   Mon, 18 Mar 2019 10:58:28 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: hub: use non-removable-ports DT property
In-Reply-To: <yw1xlg1c1c3i.fsf@mansr.com>
Message-ID: <Pine.LNX.4.44L0.1903181055310.1533-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, [iso-8859-1] Måns Rullgård wrote:

> Mans Rullgard <mans@mansr.com> writes:
> 
> > Mark any ports listed in the non-removable-ports DT property as
> > hardwired. This is useful for boards with built-in USB devices
> > that cannot be (or have not been) marked as fixed in hardware.
> >
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> >  drivers/usb/core/hub.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> Any comments on these patches?
> 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 3adff4da2ee1..44ac49a30be1 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1328,6 +1328,9 @@ static int hub_configure(struct usb_hub *hub,
> >  	unsigned unit_load;
> >  	unsigned full_load;
> >  	unsigned maxchild;
> > +	struct property *prop;
> > +	const __be32 *cur;
> > +	u32 val;
> >
> >  	hub->buffer = kmalloc(sizeof(*hub->buffer), GFP_KERNEL);
> >  	if (!hub->buffer) {
> > @@ -1629,6 +1632,17 @@ static int hub_configure(struct usb_hub *hub,
> >  		}
> >  	}
> >
> > +	of_property_for_each_u32(hub_dev->of_node, "non-removable-ports",
> > +				 prop, cur, val) {
> > +		if (val < 1 || val > hdev->maxchild) {
> > +			dev_warn(hub_dev, "port number %u out of range\n", val);
> > +			continue;
> > +		}
> > +
> > +		hub->ports[val - 1]->connect_type =
> > +			USB_PORT_CONNECT_TYPE_HARD_WIRED;
> > +	}
> > +
> >  	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
> >
> >  	hub_activate(hub, HUB_INIT);
> > -- 
> > 2.20.1

This seems like a reasonable thing to do.  However, you should improve
the warning message; people who encounter it will have no idea what it
refers to.

Alan Stern

