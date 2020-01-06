Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E342072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgAFPIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:08:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53008 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726296AbgAFPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:08:44 -0500
Received: (qmail 1584 invoked by uid 2102); 6 Jan 2020 10:08:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jan 2020 10:08:42 -0500
Date:   Mon, 6 Jan 2020 10:08:42 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Mathias Nyman <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>, <acelan.kao@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
In-Reply-To: <90B37743-30D1-41BB-8272-D5FBDC89C88F@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2001061007070.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020, Kai-Heng Feng wrote:

> > On Jan 5, 2020, at 00:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > On Sat, 4 Jan 2020, Kai-Heng Feng wrote:
> > 
> >>>>>> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> >>>>>> 	}
> >>>>>> 
> >>>>>> 	/* see 7.1.7.7; affects power usage, but not budgeting */
> >>>>>> -	if (hub_is_superspeed(hub->hdev))
> >>>>>> +	if (hub_is_superspeed(hub->hdev)) {
> >>>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> >>>>>> +			usb_lock_device(hub->hdev);
> >>>>>> +			usb_unlocked_disable_lpm(hub->hdev);
> >>>>>> +		}
> >>>>>> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
> >>>>>> -	else
> >>>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> >>>>>> +			usb_unlocked_enable_lpm(hub->hdev);
> >>>>>> +			usb_unlock_device(hub->hdev);
> >>>>> 
> >>>>> The locking here seems questionable.  Doesn't this code sometimes get
> >>>>> called with the hub already locked?  Or with the child device locked
> >>>>> (in which case locking the hub would violate the normal locking order:  
> >>>>> parent first, child second)?
> >>> 
> >>> I did a little checking.  In many cases the child device _will_ be 
> >>> locked at this point.
> >>> 
> >>>> Maybe introduce a new lock? The lock however will only be used by this specific hub.
> >>>> But I still want the LPM can be enabled for this hub.
> >>> 
> >>> Do you really need to lock the hub at all?  What would the lock protect 
> >>> against?
> >> 
> >> There can be multiple usb_port_resume() run at the same time for different ports, so this is to prevent LPM enable/disable race.
> > 
> > But there can't really be an LPM enable/disable race, can there?  The 
> > individual function calls are protected by the bandwidth mutex taken by 
> > the usb_unlocked_{en|dis}able_lpm routines, and the overall LPM setting 
> > is controlled by the hub device's lpm_disable_counter.
> 
> For enable/disable LPM itself, there's no race.
> But the lock here is to protect hub_set_port_link_state().
> If we don't lock the hub, other instances of usb_port_resume()
> routine can enable LPM and we want the LPM stays disabled until
> hub_set_port_link_state() is done.

That's what I was trying to explain above.  Other instances of 
usb_port_resume() _can't_ enable LPM while this instance is running, 
because the lpm_disable_counter value will be > 0.

Alan Stern

