Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B49218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551377184;
	bh=8Uuxb/lFsJ0rC6cZGz3qtixJcwx5rjLc+xYmengBaV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D1GMmDfj/EUXh8Oc/EZRq63tADuvcKbC1vAZMCzxD7YqIXZhErKSza7AwOi1tospi
	 aPcswzTYzTifcqyg9nAmwQ3yVjmz3iAnJMWZPYG4mXJdM1z3eVGtkrf3rHYoBlnimn
	 ZaCgSBa17it34GIY2J1+/9lEQ5gDM8Z4zow3MZo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbfB1SGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:06:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfB1SGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:06:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CBC20863;
        Thu, 28 Feb 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551377181;
        bh=8Uuxb/lFsJ0rC6cZGz3qtixJcwx5rjLc+xYmengBaV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giUy9BNN7disBe/HLmiU5gQoCF2ruLeTJUXPXtTA0graBp4+hjHPVUNqdbfgiYLnW
         D1Eie/tyLl/XXIjng3GC593lBbeOGsAith+SS7PkQ2bHc2JjYkJKMXPfDb+kV3Li9O
         oS+jkWEKxD5YeuhI3gjBAnuRSJCH7JJFrcapnX9w=
Date:   Thu, 28 Feb 2019 19:06:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] dt-bindings: usb: add non-removable device property
Message-ID: <20190228180619.GB30532@kroah.com>
References: <20190228143344.16312-1-mans@mansr.com>
 <20190228151330.GA1360@kroah.com>
 <yw1x8sy0uedr.fsf@mansr.com>
 <20190228155241.GC12050@kroah.com>
 <yw1x4l8nvmu6.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x4l8nvmu6.fsf@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:34:25PM +0000, Måns Rullgård wrote:
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -2392,6 +2392,14 @@ static void set_usb_port_removable(struct usb_device *udev)
> >>                 break;
> >>         }
> >>  
> >> +       /*
> >> +        * Otherwise, check whether DT indicates this device is non-removable.
> >> +        */
> >> +       if (of_property_read_bool(udev->dev.of_node, "non-removable")) {
> >> +               udev->removable = USB_DEVICE_FIXED;
> >> +               return;
> >> +       }
> >
> > Shouldn't this be an attribute of the USB hub's port, not the device
> > itself?  That's the way it works with ACPI, and odds are any description
> > of USB devices in DT is also going to look much like how ACPI describes
> > the devices, let's not try to diverge when it is not necessary.
> 
> Fine with me.  That's why I asked.
> 
> How about a non-removable-ports property in the hub node listing the
> hardwired ports?

Sounds reasonable to me as that should mirror what happens in ACPI, so
you should be able to just mirror what drivers/usb/core/usb-acpi.c does
for dt.

thanks,

greg k-h
