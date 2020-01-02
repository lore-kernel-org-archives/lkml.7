Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D7C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8F20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgABVhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:37:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55358 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726099AbgABVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:37:10 -0500
Received: (qmail 21999 invoked by uid 2102); 2 Jan 2020 16:37:09 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2020 16:37:09 -0500
Date:   Thu, 2 Jan 2020 16:37:09 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     AceLan Kao <acelan.kao@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access
 functions
In-Reply-To: <CAFv23Qmc82p3o=1vDvmX5jkfbcOzoQFX7grxrKGwf1KD_vebig@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2001021605410.20954-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019, AceLan Kao wrote:

> Here[1] are the dmesg and the usbmon log from wireshark, and
> /sys/kernel/debug/usb/usbmon/0u.
> 
> I verified this issue on Dell XPS 13 + Dell Salomon WD19 docking
> station(plug-in 3 USB disk on it)
> After s2idle 7 times, 2 usb disks lost. But from wireshark log, the
> packets look normal, no error.
> 
> So, I re-do the test again and log the usbmon/0u output, but it's greek to me.
> Hope you can help to find some clues in the logs.
> Thanks.
> 
> 1. https://people.canonical.com/~acelan/bugs/usb_issue/

Maybe Mathias can help figure out what's going on.  It clearly is an 
xHCI-related problem of some sort.

I can't get much out of these logs.  For one thing, the time period
covered by the usbmon trace is different from the time period in your
dmesg log.  When you collect two kinds of logs for a test, it's
important that they should be collected at the _same_ time!  Otherwise 
they record different events, which is no use.

For another, your usbmon trace used the 0u file, but you should have
used the 2u file instead.  All the errors you get involve devices on 
bus 2; including other buses in the trace just makes it more confusing 
and causes more entries to be dropped.

Also, I don't understand why your Dell Dock devices show up the way
they do.  The SuperSpeed dock is on bus 2, and the high speed dock is
on bus 3, which is attached to a different xHCI controller!  A hub
(which is what a dock is) should show up twice, and both instances
should be attached to the same controller.

In any case, it's clear that you've got some problem involving the xHCI
controller and the SuperSpeed Dell Dock (device 2-1).  Here's an
excerpt from the dmesg log showing what goes wrong.  This occurs during
a system resume; apparently the dock's connection drops while the
system is suspended and there are errors when the system tries to
re-activate it:

[  721.507202] usb 2-1: USB disconnect, device number 32
[  721.507206] usb 2-1.3: USB disconnect, device number 33
[  721.507209] usb 2-1.3.1: USB disconnect, device number 35
[  721.540214] usb 2-1.3.3: USB disconnect, device number 36
[  721.584518] usb 2-1.4: USB disconnect, device number 34
[  721.647466] xhci_hcd 0000:00:0d.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.

That's the first problem.

[  721.919433] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 38 using xhci_hcd
[  721.942597] usb 2-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.47
[  721.942600] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  721.942602] usb 2-1: Product: Dell dock
[  721.942604] usb 2-1: Manufacturer: Dell Inc.
[  721.944849] hub 2-1:1.0: USB hub found
[  721.945232] hub 2-1:1.0: 4 ports detected
[  722.178395] hub 2-1:1.0: hub_ext_port_status failed (err = -71)
[  722.178570] usb 2-1-port3: attempt power cycle
[  722.559212] usb 2-1: USB disconnect, device number 38
[  722.559311] usb 2-1: Failed to suspend device, error -19

And that's a second error.  Then the system tries again:

[  722.831431] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 43 using xhci_hcd
[  722.854608] usb 2-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.47
[  722.854611] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  722.854614] usb 2-1: Product: Dell dock
[  722.854616] usb 2-1: Manufacturer: Dell Inc.
[  722.857034] hub 2-1:1.0: USB hub found
[  722.857440] hub 2-1:1.0: 4 ports detected
[  723.090106] hub 2-1:1.0: hub_ext_port_status failed (err = -71)
[  723.090316] usb 2-1-port3: attempt power cycle
[  723.471212] usb 2-1: USB disconnect, device number 43
[  723.471274] usb 2-1: Failed to suspend device, error -19

And it fails in the same way.  A third try ends up succeeding:

[  723.743465] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 48 using xhci_hcd
...

I don't see why the device numbers jump around in such a crazy manner.  
When device 38 disconnects, the next device is number 43.  And when 
that fails, the next number is 48!  It looks like device numbers are 
somehow being allocated for the four child devices even though the log 
doesn't show them being detected.

Here's a portion of the usbmon trace that apparently corresponds
somewhat to part of the log above, although it's hard to be certain.  
In this trace, device 77 on bus 2 is 2-1.  Unlike the log above, it
only has a child attached to port 3, not to port 4:

ffff9879b43ff840 291366827 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff9879b43ff840 291366846 C Ci:2:001:0 0 4 = 03020000
ffff9879b2f54780 291469875 S Ci:2:077:0 s a3 00 0000 0001 0004 4 <
ffff9879b2f54780 291470062 C Ci:2:077:0 0 4 = a0020000
ffff9879b2f54780 291470069 S Ci:2:077:0 s a3 00 0000 0002 0004 4 <
ffff9879b2f54780 291470208 C Ci:2:077:0 0 4 = a0020000
ffff9879b2f54780 291470214 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
ffff9879b2f54780 291470387 C Ci:2:077:0 0 4 = 03021000
ffff9879b2f54780 291470392 S Co:2:077:0 s 23 01 0014 0003 0000 0
ffff9879b2f54780 291470527 C Co:2:077:0 0 0
ffff9879b2f54780 291470533 S Ci:2:077:0 s a3 00 0000 0004 0004 4 <
ffff9879b2f54780 291470709 C Ci:2:077:0 0 4 = a0020000
ffff9879b43ff480 291573804 S Ii:2:077:1 -115:128 2 <
ffff9879b2f54780 291573839 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
ffff9879b2f54780 291574068 C Ci:2:077:0 0 4 = 03020000
ffff9879b2f54780 291574166 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
ffff9879b2f54780 291574363 C Ci:2:077:0 0 4 = 03020000
ffff9879b2f54780 291574383 S Co:2:077:0 s 23 03 0004 0003 0000 0
ffff9879b2f54780 291574580 C Co:2:077:0 0 0
ffff9879b2f54780 291593804 S Ci:2:077:0 s a3 00 0002 0003 0008 8 <
ffff9879ae2969c0 291595804 C Ii:2:001:1 0:2048 1 = 02
ffff9879ae2969c0 291595824 S Ii:2:001:1 -115:2048 4 <
ffff9879ba3476c0 291595843 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff9879ba3476c0 291595857 C Ci:2:001:0 0 4 = c0024100

As far as I can tell, the device was working fine until at this point
it disconnected itself.

ffff9879ba3476c0 291595863 S Co:2:001:0 s 23 01 0010 0001 0000 0
ffff9879ba3476c0 291595867 C Co:2:001:0 0 0
ffff9879ba3476c0 291595870 S Co:2:001:0 s 23 01 0019 0001 0000 0
ffff9879ba3476c0 291595875 C Co:2:001:0 0 0
ffff9879ba3476c0 291595879 S Co:2:001:0 s 23 03 001c 0001 0000 0
ffff9879ba3476c0 291595884 C Co:2:001:0 0 0
ffff9879b2f54780 291600949 C Ci:2:077:0 -71 0
ffff9879b2f54780 291600997 S Co:2:077:0 s 23 03 0004 0003 0000 0
ffff9879b2f54780 291601000 E Co:2:077:0 -19 0

Mathias, any suggestions on how Acelan can track down the reasons for 
these problems?

Alan Stern

