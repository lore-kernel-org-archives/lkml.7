Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C0DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E01020665
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfFFORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:17:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51784 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727168AbfFFORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:17:09 -0400
Received: (qmail 2998 invoked by uid 2102); 6 Jun 2019 10:17:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2019 10:17:08 -0400
Date:   Thu, 6 Jun 2019 10:17:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
In-Reply-To: <1C63D05A-1AEF-40F6-8127-4958A4112676@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1906061013490.1641-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019, Kai-Heng Feng wrote:

> at 15:55, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> > at 18:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> >> at 00:01, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >>
> >>>> On Jan 30, 2019, at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
> >>>>> The QCA Rome USB Bluetooth controller has several issues once LPM gets
> >>>>> enabled:
> >>>>> - Fails to get enumerated in coldboot. [1]
> >>>>> - Drains more power (~ 0.2W) when the system is in S5. [2]
> >>>>> - Disappears after a warmboot. [2]
> >>>>>
> >>>>> The issue happens because the device lingers at LPM L1 in S5, so device
> >>>>> can't get enumerated even after a reboot.
> >>>>>
> >>>>> Disable LPM at shutdown to solve the issue.
> >>>>>
> >>>>> [1] https://bugs.launchpad.net/bugs/1757218
> >>>>> [2] https://patchwork.kernel.org/patch/10607097/
> >>>>>
> >>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>>> ---
> >>>>> v2: Use new LPM helpers.
> >>>>>
> >>>>> drivers/usb/core/port.c | 9 +++++++++
> >>>>> 1 file changed, 9 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> >>>>> index 1a06a4b5fbb1..bbbb35fa639f 100644
> >>>>> --- a/drivers/usb/core/port.c
> >>>>> +++ b/drivers/usb/core/port.c
> >>>>> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct  
> >>>>> device *dev)
> >>>>> }
> >>>>> #endif
> >>>>>
> >>>>> +static void usb_port_shutdown(struct device *dev)
> >>>>> +{
> >>>>> +	struct usb_port *port_dev = to_usb_port(dev);
> >>>>> +
> >>>>> +	if (port_dev->child)
> >>>>> +		usb_disable_usb2_hardware_lpm(port_dev->child);
> >>>>> +}
> >>>>> +
> >>>>> static const struct dev_pm_ops usb_port_pm_ops = {
> >>>>> #ifdef CONFIG_PM
> >>>>> 	.runtime_suspend =	usb_port_runtime_suspend,
> >>>>> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
> >>>>> static struct device_driver usb_port_driver = {
> >>>>> 	.name = "usb",
> >>>>> 	.owner = THIS_MODULE,
> >>>>> +	.shutdown = usb_port_shutdown,
> >>>>> };
> >>>>
> >>>> So you now do this for all ports in the system, no matter what is
> >>>> plugged in or not.  Are you _SURE_ you want to do that?  It seems like a
> >>>> big hammer to solve just one single device's problems.
> >>>
> >>> Yes I think this should be universally applied.
> >>>
> >>> I don’t think the bug only happens to one device. Users won’t find this
> >>> unless they connect their laptop to a power meter.
> >>>
> >>> Platform may not completely cut off USB bus power during shutdown,
> >>> so the device transits to L1 after system shutdown. Now xHC is disabled
> >>> so nothing can bring it back to L0 or L2.
> >>
> >> It would be great if someone can come up with better ideas.
> >>
> >> We can also use other approaches, but currently this is the only way I  
> >> can think of.
> >
> > Alan and Mathias,
> >
> > It would be great if you can review this patch, or give me some suggestion.
> 
> Can I get some advice here?
> I really think disabling LPM should be universally applied.
> 
> Kai-Heng

I agree with Kai-Heng, this seems like a fairly light-weight solution 
to a reasonable problem.

As to the issue of how much it will slow down system shutdowns, I have 
no idea.  Probably not very much, unless somebody has an unusually 
large number of USB devices plugged in, but only testing can give a 
real answer.

I suppose we could add an HCD flag for host controllers which require 
this workaround.  Either way, it's probably not a very big deal.

Alan Stern

