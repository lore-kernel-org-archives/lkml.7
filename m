Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B88C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E9217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407323AbfHIPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:13:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54882 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726342AbfHIPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:13:02 -0400
Received: (qmail 1813 invoked by uid 2102); 9 Aug 2019 11:13:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 11:13:00 -0400
Date:   Fri, 9 Aug 2019 11:13:00 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com>,
        Michael Hund <mhund@ld-didactic.de>,
        <akpm@linux-foundation.org>, <andreyknvl@google.com>, <cai@lca.pw>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tglx@linutronix.de>
Subject: Re: BUG: bad usercopy in ld_usb_read
In-Reply-To: <20190809085545.GB21320@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1908091100580.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, Greg KH wrote:

> On Thu, Aug 08, 2019 at 04:06:32PM -0700, Kees Cook wrote:
> > On Thu, Aug 08, 2019 at 02:46:54PM +0200, Greg KH wrote:
> > > On Thu, Aug 08, 2019 at 05:38:06AM -0700, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13aeaece600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b2f40f0778cfa7634e
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > 
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com
> > > > 
> > > > ldusb 6-1:0.124: Read buffer overflow, -131383996186150 bytes dropped
> > > 
> > > That's a funny number :)
> > > 
> > > Nice overflow found, I see you are now starting to fuzz the char device
> > > nodes of usb drivers...
> > > 
> > > Michael, care to fix this up?
> > 
> > This looks like the length in the read-from-device buffer is unchecked:
> > 
> >         /* actual_buffer contains actual_length + interrupt_in_buffer */
> >         actual_buffer = (size_t *)(dev->ring_buffer + dev->ring_tail * (sizeof(size_t)+dev->interrupt_in_endpoint_size));
> >         bytes_to_read = min(count, *actual_buffer);
> >         if (bytes_to_read < *actual_buffer)
> >                 dev_warn(&dev->intf->dev, "Read buffer overflow, %zd bytes dropped\n",
> >                          *actual_buffer-bytes_to_read);
> > 
> >         /* copy one interrupt_in_buffer from ring_buffer into userspace */
> >         if (copy_to_user(buffer, actual_buffer+1, bytes_to_read)) {
> >                 retval = -EFAULT;
> >                 goto unlock_exit;
> >         }
> > 
> > I assume what's stored at actual_buffer is bogus and needs validation
> > somewhere before it's actually used. (If not here, maybe where ever the
> > write into the buffer originally happens?)
> 
> I think it should be verified here, as that's when it is parsed.  The
> data is written to the buffer in ld_usb_interrupt_in_callback() but it
> does not "know" how to parse it at that location.

I looked at this bug report, and it is very puzzling.

Yes, the value stored in *actual_buffer is written in
ld_usb_interrupt_in_callback(), but the value is simply
urb->actual_length and therefore does not need any validation.  The 
URB's transfer_buffer_length is taken from 
dev->interrupt_in_endpoint_size, which comes from usb_endpoint_maxp() 
and therefore cannot be larger than 2048.

(On the other hand, actual_buffer might not be aligned on a 32-bit 
address.  For x86, of course, this doesn't matter, but it can affect 
other architectures.)

Furthermore, the computation leading to the dev_warn() involves only
size_t types and therefore is carried out entirely using unsigned
arithmetic.  The warning's format string uses %zd instead of %zu;  
that's why the number showed up as negative but doesn't explain why it
looks so funny.

In fact, I don't see why any of the computations here should overflow
or wrap around, or even give rise to a negative value.  If syzbot had a
reproducer we could get more debugging output -- but it doesn't.

Alan Stern

