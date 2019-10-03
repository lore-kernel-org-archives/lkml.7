Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A592AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5520830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfJCO0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:26:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44202 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726393AbfJCO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:26:20 -0400
Received: (qmail 3509 invoked by uid 2102); 3 Oct 2019 10:26:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2019 10:26:19 -0400
Date:   Thu, 3 Oct 2019 10:26:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     mathias.nyman@intel.com, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: Avoid unnecessary LPM enabling and disabling
 during suspend and resume"
In-Reply-To: <123BCB7F-5ABA-4DDD-9599-46D3240903F6@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1910031024410.1797-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019, Kai-Heng Feng wrote:

> > On Oct 2, 2019, at 23:47, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > On Wed, 2 Oct 2019, Kai-Heng Feng wrote:
> > 
> >> This reverts commit d590c23111505635e1beb01006612971e5ede8aa.
> >> 
> >> Dell WD15 dock has a topology like this:
> >> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
> >>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
> >>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> >> 
> >> Their IDs:
> >> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> >> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp.
> >> Bus 004 Device 004: ID 0bda:8153 Realtek Semiconductor Corp.
> >> 
> >> Ethernet cannot be detected after plugging ethernet cable to the dock,
> >> the hub and roothub get runtime resumed and runtime suspended
> >> immediately:
> >> ...
> > 
> >> After some trial and errors, the issue goes away if LPM on the SMSC hub
> >> is disabled. Digging further, enabling and disabling LPM during runtime
> >> resume and runtime suspend respectively can solve the issue.
> >> 
> >> So bring back the old LPM behavior, which the SMSC hub inside Dell WD15
> >> depends on.
> >> 
> >> Fixes: d590c2311150 ("usb: Avoid unnecessary LPM enabling and disabling during suspend and resume")
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > 
> > Maybe it would be better to have a VID/PID-specific quirk for this?
> 
> Re-reading the spec, I think we need some clarification:
> "If the value is 3, then host software wants to selectively suspend the
> device connected to this port. The hub shall transition the link to U3
> from any of the other U states using allowed link state transitions.
> If the port is not already in the U0 state, then it shall transition the
> port to the U0 state and then initiate the transition to U3."
> 
> The phrase "then it shall transition the port to the U0 state" what does "it" here refer to?
> Is it the hub or the software?
> If it's the former then it's indeed a buggy hub, but if it's the latter I think reverting the commit is the right thing to do.

In my opinion, "it" here refers to the hub.  This is because of the 
parallel construction with the preceding sentence ("... shall 
transition the link/port"), which indicates that the subjects should be 
the same.

Alan Stern

