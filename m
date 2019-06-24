Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A96CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6708A208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfFXOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:22:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56826 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727451AbfFXOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:22:11 -0400
Received: (qmail 1735 invoked by uid 2102); 24 Jun 2019 10:22:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2019 10:22:10 -0400
Date:   Mon, 24 Jun 2019 10:22:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Tejun Heo <tj@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [RFC] deadlock with flush_work() in UAS
In-Reply-To: <1561366612.2846.10.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1906241007350.1609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Oliver Neukum wrote:

> Am Donnerstag, den 20.06.2019, 07:10 -0700 schrieb Tejun Heo:
> > Hello,
> > 
> > On Tue, Jun 18, 2019 at 11:59:39AM -0400, Alan Stern wrote:
> > > > > Even if you disagree, perhaps we should have a global workqueue with a
> > > > > permanently set noio flag.  It could be shared among multiple drivers
> > > > > such as uas and the hub driver for purposes like this.  (In fact, the 
> > > > > hub driver already has its own dedicated workqueue.)
> > > > 
> > > > That is a good idea. But does UAS need WQ_MEM_RECLAIM?
> > > 
> > > These are good questions, and I don't have the answers.  Perhaps Tejun 
> > > or someone else on LKML can help.
> > 
> > Any device which may host a filesystem or swap needs to use
> > WQ_MEM_RECLAIM workqueues on anything which may be used during normal
> > IOs including e.g. error handling which may be invoked.  One
> > WQ_MEM_RECLAIM workqueue guarantees one level of concurrency for all
> > its tasks regardless of memory situation, so as long as there's no
> > interdependence between work items, the workqueue can be shared.
> 
> Ouch.
> 
> Alan, in that case anything doing a reset, suspend or resume needs
> to use WQ_MEM_RECLAIM, it looks to me. What do we do?

I'm not sure this is really a problem.

For example, the reset issue arises only when a driver does the 
following:

	Locks the device.

	Queues a work routine to reset the device.

	Waits for the reset to finish.

	Unlocks the device.

But that pattern makes no sense; a driver would never use it.  The 
driver would just do the reset itself.

There's no problem if the locking is done in the work routine; in that
case the usb-storage or uas driver would be able to carry out any
necessary resets if the work routine was unable to start for lack of
memory.

Similarly, while async wakeups might get blocked by lack of memory, the 
normal USB driver paths use synchronous wakeup.

Alan Stern

