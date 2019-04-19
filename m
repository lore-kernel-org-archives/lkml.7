Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDE0C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287B2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfDSSgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:36:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60902 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727338AbfDSSgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:36:39 -0400
Received: (qmail 7714 invoked by uid 2102); 19 Apr 2019 14:36:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2019 14:36:38 -0400
Date:   Fri, 19 Apr 2019 14:36:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: UDC hardware for fuzzing [was: Re: INFO: task hung in usb_kill_urb]
In-Reply-To: <CAAeHK+zCwXpAb02vaPuanStYCp_x8g92HDEvm_LTN_F+Y_wOfQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904191429230.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Andrey Konovalov wrote:

> On Tue, Apr 16, 2019 at 8:25 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 16 Apr 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer still triggered
> > > crash:
> > > INFO: task hung in usb_kill_urb
> >
> > Okay, I think I found the problem.  dummy-hcd doesn't check for
> > unsupported speeds until it is too late.  Andrey, what values does your
> > usb-fuzzer gadget driver set for its max_speed field?
> 
> It's passed from userspace without any validation :( I'll fix this!
> Thanks for looking into it!
> 
> I wonder why other people saw this hang as well, they didn't use the
> dummy hcd module for sure. I guess there are might be other reasons.

Unquestionably it would be for other reasons.  usb_kill_urb() is a 
host-side routine, not used by gadget drivers.  If it fails, the reason 
lies in host controller driver.  And if people aren't using dummy-hcd 
then they must be using a different host controller driver.

Is there any chance you could get hold of a USB device controller for 
more fuzzing tests?  With it, you could test other parts of the USB 
stack: the UDC driver for whatever hardware you get, and the host 
controller driver for whatever you plug the UDC into.

I don't know what types of UDC are readily available for the type of
computer syzkaller uses.  Perhaps Felipe or other people on the mailing
list will have some suggestions.

Alan Stern

