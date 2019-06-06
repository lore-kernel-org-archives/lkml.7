Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D68C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF5B207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfFFLUK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:20:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38929 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFLUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:20:09 -0400
Received: from marcel-macpro.fritz.box (p5B3D2A37.dip0.t-ipconnect.de [91.61.42.55])
        by mail.holtmann.org (Postfix) with ESMTPSA id B0E3ECF2B4;
        Thu,  6 Jun 2019 13:28:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [5.2.0-rcx] Bluetooth: hci0: unexpected event for opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CADDKRnDimtWTrW8BXHZjLCHYRnpZ1qs5pravPtdNpwE13cWvvg@mail.gmail.com>
Date:   Thu, 6 Jun 2019 13:20:07 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DE393F06-081D-4761-82BA-014CBD3E43A9@holtmann.org>
References: <CADDKRnDWhX25QPFNXA-uPcM_tD3Bep2ui=D5A2A8A5cZvrbJtA@mail.gmail.com>
 <F99C3F13-D705-4214-ADE8-30676E29360D@holtmann.org>
 <CADDKRnDimtWTrW8BXHZjLCHYRnpZ1qs5pravPtdNpwE13cWvvg@mail.gmail.com>
To:     =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

>>> In 5.2.0-rcx I see a new error message on startup probably after
>>> loading the Bluetooth firmware:
>>> [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
>>> 
>>>> dmesg | grep Bluetooth
>>> [    0.130969] Bluetooth: Core ver 2.22
>>> [    0.130973] Bluetooth: HCI device and connection manager initialized
>>> [    0.130974] Bluetooth: HCI socket layer initialized
>>> [    0.130975] Bluetooth: L2CAP socket layer initialized
>>> [    0.130976] Bluetooth: SCO socket layer initialized
>>> [    0.374716] Bluetooth: RFCOMM TTY layer initialized
>>> [    0.374718] Bluetooth: RFCOMM socket layer initialized
>>> [    0.374718] Bluetooth: RFCOMM ver 1.11
>>> [    0.374719] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>> [    0.374720] Bluetooth: BNEP socket layer initialized
>>> [    0.374721] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>>> [    0.374722] Bluetooth: HIDP socket layer initialized
>>> [    1.422530] Bluetooth: hci0: read Intel version: 370710018002030d00
>>> [    1.422533] Bluetooth: hci0: Intel Bluetooth firmware file:
>>> intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>>> [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
>>> [    1.625557] Bluetooth: hci0: Intel firmware patch completed and activated
>>> [   21.986125] input: BluetoothMouse3600 Mouse as
>>> /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input15
>>> [   21.986329] input: BluetoothMouse3600 Consumer Control as
>>> /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input16
>>> [   21.986408] hid-generic 0005:045E:0916.0004: input,hidraw3:
>>> BLUETOOTH HID v1.10 Mouse [BluetoothMouse3600] on 80:19:34:4D:31:44
>>> 
>>> 
>>> The error message goes away if I revert following patch:
>>> f80c5dad7b64 Bluetooth: Ignore CC events not matching the last HCI command
>> 
>> if you can send btmon trace (or better btmon -w trace.log) for this event triggering it, then we can look if this is a hardware issue.
> 
> The problem is that it happens only once during startup, especially at
> the very first startup after power-on only. So I can't issue any
> command.

try to blacklist btusb.ko module. Create /etc/modprobe.d/blacklist-btusb.conf with the content of "blacklist vc4”. Then once booted, start “btmon -w trace.log” and then “modprobe btusb”. This should give you the initial firmware loading trace.

I am just assuming that the module is connected via USB, if not then you need to let me know.

>> We have only seen this with Atheros hardware so far, but it might happen for others as well. It indicates that this is an unexpected event. Normally you can ignore this warning since it just indicates an existing issue that we just papered over before. So if everything works as before, just ignore it,
> 
> Yes for me BT works as usual so ignoring it would be no problem (but
> it looks ugly because the error message is painted right on the
> boot-screen).

The 0xfc2f command is never issued by btusb.c or btintel.c actually. It is a command to apply the BDDATA information used only by Intel AG6xx devices which are UART only. So I am almost certain that this is a bug in the hardware / firmware and the patch above just started to highlight it. The trace will show if that is the case.

Regards

Marcel

