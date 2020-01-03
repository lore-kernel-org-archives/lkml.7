Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880A7217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgACQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:54:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34942 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728040AbgACQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:54:06 -0500
Received: (qmail 5175 invoked by uid 2102); 3 Jan 2020 11:54:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jan 2020 11:54:05 -0500
Date:   Fri, 3 Jan 2020 11:54:05 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Mathias Nyman <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>, <acelan.kao@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
In-Reply-To: <B3E0C8C0-3E45-42B3-86D9-E34D669E1F4A@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2001031137290.1560-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2020, Kai-Heng Feng wrote:

> Hi Alan,
> 
> > On Jan 3, 2020, at 23:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > On Fri, 3 Jan 2020, Kai-Heng Feng wrote:
> > 
> >> Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> >> bus when bringing underlying ports from U3 to U0.
> >> 
> >> After some expirements and guessworks, the hub itself needs to be U0
> >> during setting its port's link state back to U0.
> >> 
> >> So add a new quirk to let the hub disables LPM on setting U0 for its
> >> downstream facing ports.
> >> 
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/usb/core/hub.c     | 12 ++++++++++--
> >> drivers/usb/core/quirks.c  |  7 +++++++
> >> include/linux/usb/quirks.h |  3 +++
> >> 3 files changed, 20 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >> index f229ad6952c0..35a035781c5a 100644
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> >> 	}
> >> 
> >> 	/* see 7.1.7.7; affects power usage, but not budgeting */
> >> -	if (hub_is_superspeed(hub->hdev))
> >> +	if (hub_is_superspeed(hub->hdev)) {
> >> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> >> +			usb_lock_device(hub->hdev);
> >> +			usb_unlocked_disable_lpm(hub->hdev);
> >> +		}
> >> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
> >> -	else
> >> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> >> +			usb_unlocked_enable_lpm(hub->hdev);
> >> +			usb_unlock_device(hub->hdev);
> > 
> > The locking here seems questionable.  Doesn't this code sometimes get
> > called with the hub already locked?  Or with the child device locked
> > (in which case locking the hub would violate the normal locking order:  
> > parent first, child second)?

I did a little checking.  In many cases the child device _will_ be 
locked at this point.

> Maybe introduce a new lock? The lock however will only be used by this specific hub.
> But I still want the LPM can be enabled for this hub.

Do you really need to lock the hub at all?  What would the lock protect 
against?

Alan Stern

