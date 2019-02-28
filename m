Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5958EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B40F218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551369168;
	bh=c9yuCKsUO7/9DLEwh+U+j5iJb2ZQp9LT8AL1r6ahPnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QG0kYfDc1j1GufjFeJCcpCziU2QTf7zd5gJoQ/bQB1ETeVVI/aR9AAJ9tUITYrLB0
	 583JZFAz0CycQEaUyA5oXJl0eaMcqId2Lj3BfklEk9yEtxDY/rpmY1g0CdGrOYWjSG
	 HYDDsWUy0bbuZfOrxUC1A7icdFAB0JPFNdT/hGgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfB1Pwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfB1Pwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:52:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8868218AE;
        Thu, 28 Feb 2019 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551369164;
        bh=c9yuCKsUO7/9DLEwh+U+j5iJb2ZQp9LT8AL1r6ahPnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM3FKF8fj0NH5hVCFObCe4oLCEYKioNxDp6i1C4c+mSobJv58vbBOrvcXrBLtldI3
         z3JAz0ZyKeT/7h8trXL0CXMot7d6Cz6kae37BU3juqt9ALIuJZJZZyREniYhx/lff4
         BiVDyv3vxoT5cz97VLvDzToEEDGRNh/kJcMLSUeg=
Date:   Thu, 28 Feb 2019 16:52:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] dt-bindings: usb: add non-removable device property
Message-ID: <20190228155241.GC12050@kroah.com>
References: <20190228143344.16312-1-mans@mansr.com>
 <20190228151330.GA1360@kroah.com>
 <yw1x8sy0uedr.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x8sy0uedr.fsf@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:22:24PM +0000, Måns Rullgård wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Feb 28, 2019 at 02:33:44PM +0000, Mans Rullgard wrote:
> >> Add a boolean property indicating that a device is hardwired to the
> >> upstream port.  Although hubs can provide this information, they are not
> >> always configured correctly.  An alternate means of indicating this for
> >> built-in USB devices is thus useful.
> >> 
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >> I have a situation where userspace would like to know which USB devices
> >> are built-in, but the on-board hub doesn't have the right setting.
> >> Also, the hub itself can't be indicated as fixed in any other way that
> >> I'm aware of.
> >
> > Then that's a firmware bug, right?  We have a way for firmware to export
> > this to the USB core, why not use that?  Your on-board hub should get a
> > firmware update with this information, let's not try to create
> > yet-another-way to define this type of information please.
> 
> What firmware?  This is not an ACPI system, obviously, so DT _is_ the
> firmware.

Firmware in your hub.  There's a whole crazy software stack in that
beast :)

> >> In a way, adding this property seems a bit silly since dt can only
> >> sensibly be used for hardwired devices in the first place.  Thus the
> >> mere presence of a dt node could be taken to indicate the same thing.
> >> On the other hand, it's conceivable that someone might dynamically
> >> generate a devicetree based on what happens to be connected on boot or
> >> something.  For that reason, and explicit property seems safer.
> >> ---
> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >
> > Can you show some code actually using this?  Again, this should "just
> > work" for USB today unless your platform is really broken (and if it is,
> > go complain to the vendor...)
> 
> You know full well that complaining to the vendor is rarely something
> that works.  Especially not when there are already thousands of the
> devices in the field.

Understood, but constantly working around broken hardware is annoying at
times.

> This is how I meant to use it:
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3adff4da2ee1..81ef3cb705b7 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2392,6 +2392,14 @@ static void set_usb_port_removable(struct usb_device *udev)
>                 break;
>         }
>  
> +       /*
> +        * Otherwise, check whether DT indicates this device is non-removable.
> +        */
> +       if (of_property_read_bool(udev->dev.of_node, "non-removable")) {
> +               udev->removable = USB_DEVICE_FIXED;
> +               return;
> +       }

Shouldn't this be an attribute of the USB hub's port, not the device
itself?  That's the way it works with ACPI, and odds are any description
of USB devices in DT is also going to look much like how ACPI describes
the devices, let's not try to diverge when it is not necessary.

thanks,

greg k-h
