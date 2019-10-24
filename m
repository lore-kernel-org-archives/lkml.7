Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA941CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D520684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437249AbfJXTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:17:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59946 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2437179AbfJXTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:17:18 -0400
Received: (qmail 6262 invoked by uid 2102); 24 Oct 2019 15:17:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2019 15:17:18 -0400
Date:   Thu, 24 Oct 2019 15:17:18 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: divide error in dummy_timer
In-Reply-To: <CAAeHK+yu2MYmh86wJ_DxYoUEU-vp9R+jXRVMh_SpsSNFdHVO7g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1910241507450.1318-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Andrey Konovalov wrote:

> On Thu, Oct 24, 2019 at 7:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, 24 Oct 2019, Andrey Konovalov wrote:
> >
> > > > Is this really the sort of thing we need to catch?  It isn't a bug in
> > > > any existing kernel code, as far as I know.  Maybe only gadgetfs and
> > > > configfs need to worry about it.
> > >
> > > Hi Alan,
> > >
> > > Do you mean that the gadget driver must ensure that the max packet
> > > size in the endpoint descriptor is not zero? Do HCDs rely on that? I
> > > can add this check into the driver we use for USB fuzzing.
> >
> > Well, if there are any gadget drivers in the kernel which do set an
> > endpoint's maxpacket size to 0, they should be fixed.  I'm not aware of
> > any.
> >
> > Of course, gadget drivers in userspace are always suspect.  That's why
> > I suggested having gadgetfs and configfs perform this check.  Even so
> > it's not really a _security_ risk, because only the superuser is
> > allowed to run a userspace gadget driver.  (Although obviously it is
> > better to have a clean failure than to crash the system when a buggy
> > program runs with superuser privileges.)
> >
> > Yes, HCDs do depend on endpoints having reasonable maxpacket values.  I
> > suppose the core should check for this.  Currently we check for values
> > that are too large or invalid in other ways (like high-speed bulk
> > endpoints with maxpacket != 512), but we don't check for 0.
> 
> Oh, I think I've confused the terms here. I meant to ask about UDCs.
> The question is whether it's OK to try and emulate a gadget with
> maxpacket = 0 on a board with a hardware UDC? Or can it cause issues?
> The fact that HCDs must ensure correct maxpacket values of course
> makes sense.

It doesn't make any sense to have an endpoint with maxpacket = 0 --
either real or emulated.  The USB spec doesn't prohibit them (probably
an oversight), but such endpoints would be useless since it would not
be possible to transfer any data to/from them.

And as you surmised, it wouldn't be at all surprising for UDC drivers
to crash (much like dummy-hcd does) when faced with an endpoint having
maxpacket = 0.  Best to rule out the possibility entirely.

Alan Stern

