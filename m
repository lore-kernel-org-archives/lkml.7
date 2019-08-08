Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66156C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A452173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbfHHOAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:00:01 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41750 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733005AbfHHOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:00:00 -0400
Received: (qmail 1781 invoked by uid 2102); 8 Aug 2019 09:59:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Aug 2019 09:59:59 -0400
Date:   Thu, 8 Aug 2019 09:59:59 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
In-Reply-To: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Andrey Konovalov wrote:

> On Thu, Aug 8, 2019 at 2:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Aug 8, 2019 at 2:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > On Wed, Aug 7, 2019 at 8:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Wed, 7 Aug 2019, syzbot wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > > > crash:
> > > > >
> > > > > Reported-and-tested-by:
> > > > > syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> > > > >
> > > > > Tested on:
> > > > >
> > > > > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > > > git tree:       https://github.com/google/kasan.git
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> > > > >
> > > > > Note: testing is done by a robot and is best-effort only.
> > > >
> > > > Andrey, is there any way to get the console output from this test?
> > >
> > > Dmitry, would it be possible to link console log for successful tests as well?
> >
> > Yes. Start by filing a feature request at
> > https://github.com/google/syzkaller/issues
> 
> Filed https://github.com/google/syzkaller/issues/1322
> 
> Alan, for now I've applied your patch and run the reproducer manually:
> 
> [   90.844643][   T74] usb 1-1: new high-speed USB device number 2
> using dummy_hcd
> [   91.085789][   T74] usb 1-1: Using ep0 maxpacket: 16
> [   91.204698][   T74] usb 1-1: config 0 has an invalid interface
> number: 234 but max is 0
> [   91.209137][   T74] usb 1-1: config 0 has no interface number 0
> [   91.211599][   T74] usb 1-1: config 0 interface 234 altsetting 0
> endpoint 0x8D has an inva1
> [   91.216162][   T74] usb 1-1: config 0 interface 234 altsetting 0
> endpoint 0x7 has invalid 4
> [   91.218211][   T74] usb 1-1: config 0 interface 234 altsetting 0
> bulk endpoint 0x7 has inv4
> [   91.220131][   T74] usb 1-1: config 0 interface 234 altsetting 0
> bulk endpoint 0x8F has in0
> [   91.222052][   T74] usb 1-1: New USB device found, idVendor=0421,
> idProduct=0486, bcdDevic7
> [   91.223851][   T74] usb 1-1: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> [   91.233180][   T74] usb 1-1: config 0 descriptor??
> [   91.270222][   T74] rndis_wlan 1-1:0.234: Refcount before probe: 3
> [   91.275464][   T74] rndis_wlan 1-1:0.234: invalid descriptor buffer length
> [   91.277558][   T74] usb 1-1: bad CDC descriptors
> [   91.279716][   T74] rndis_wlan 1-1:0.234: Refcount after probe: 3
> [   91.281378][   T74] rndis_host 1-1:0.234: Refcount before probe: 3
> [   91.283303][   T74] rndis_host 1-1:0.234: invalid descriptor buffer length
> [   91.284724][   T74] usb 1-1: bad CDC descriptors
> [   91.286004][   T74] rndis_host 1-1:0.234: Refcount after probe: 3
> [   91.287318][   T74] cdc_acm 1-1:0.234: Refcount before probe: 3
> [   91.288513][   T74] cdc_acm 1-1:0.234: invalid descriptor buffer length
> [   91.289835][   T74] cdc_acm 1-1:0.234: No union descriptor, testing
> for castrated device
> [   91.291555][   T74] cdc_acm 1-1:0.234: Refcount after probe: 3
> [   91.292766][   T74] cdc_acm: probe of 1-1:0.234 failed with error -12
> [   92.001549][   T96] usb 1-1: USB disconnect, device number 2

Ah, that looks right, thank you.  The patch worked correctly -- good
work Oliver!

Alan Stern

