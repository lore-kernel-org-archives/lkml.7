Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127B21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:35:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55960 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726641AbfKHPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:35:04 -0500
Received: (qmail 1859 invoked by uid 2102); 8 Nov 2019 10:35:03 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Nov 2019 10:35:03 -0500
Date:   Fri, 8 Nov 2019 10:35:03 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Oliver Neukum <oneukum@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4.19 114/149] UAS: Revert commit 3ae62a42090f ("UAS: fix
 alignment of scatter/gather segments")
In-Reply-To: <20191108072342.GA583220@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1911081029440.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Greg Kroah-Hartman wrote:

> On Thu, Nov 07, 2019 at 12:32:45PM +0100, Oliver Neukum wrote:
> > Am Dienstag, den 05.11.2019, 17:38 +0100 schrieb Greg Kroah-Hartman:
> > > > > Given this information, perhaps you will decide that the revert is 
> > > > > worthwhile.
> > > > 
> > > > Damned if I do, damned if I do not.
> > > > Check for usbip and special case it?
> > > 
> > > We should be able to do that in the host controller driver for usbip,
> > > right?  What is the symptom if you use a UAS device with usbip and this
> > > commit?
> > 
> > Yes, that patch should then also be applied. Then it will work.
> > Without it, commands will fail, as transfers will end prematurely.
> 
> Ok, I'm confused now.  I just checked, and I really have no idea what
> needs to be backported anymore.  3ae62a42090f ("UAS: fix alignment of
> scatter/gather segments") was backported to all of the stable kernels,
> and now we reverted it.
> 
> So what else needs to be done here?

In one sense, nothing needs to be done.  3ae62a42090f was intended to
fix a long-standing problem with USBIP, but people reported a
regression in performance.  (Admittedly, the report was about the
correponding change to usb-storage, not the change to uas, but it's
reasonable to think the effect would be the same.)  So in line with the
no-regressions policy, we only need to revert the commit -- which you 
have already done.

On the other hand, the long-standing problem in USBIP can be fixed by
back-porting commit ea44d190764b.  But since that commit isn't a
bug-fix (and since it's rather large), you may question whether it is
appropriate for the -stable kernel series.

Alan Stern

