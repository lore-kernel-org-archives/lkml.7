Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603DFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5C2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFFGS3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:18:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33515 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:18:27 -0400
Received: from marcel-macpro.fritz.box (p5B3D2A37.dip0.t-ipconnect.de [91.61.42.55])
        by mail.holtmann.org (Postfix) with ESMTPSA id F2632CF2B3;
        Thu,  6 Jun 2019 08:26:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [5.2.0-rcx] Bluetooth: hci0: unexpected event for opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CADDKRnDWhX25QPFNXA-uPcM_tD3Bep2ui=D5A2A8A5cZvrbJtA@mail.gmail.com>
Date:   Thu, 6 Jun 2019 08:18:25 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F99C3F13-D705-4214-ADE8-30676E29360D@holtmann.org>
References: <CADDKRnDWhX25QPFNXA-uPcM_tD3Bep2ui=D5A2A8A5cZvrbJtA@mail.gmail.com>
To:     =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> In 5.2.0-rcx I see a new error message on startup probably after
> loading the Bluetooth firmware:
> [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> 
>> dmesg | grep Bluetooth
> [    0.130969] Bluetooth: Core ver 2.22
> [    0.130973] Bluetooth: HCI device and connection manager initialized
> [    0.130974] Bluetooth: HCI socket layer initialized
> [    0.130975] Bluetooth: L2CAP socket layer initialized
> [    0.130976] Bluetooth: SCO socket layer initialized
> [    0.374716] Bluetooth: RFCOMM TTY layer initialized
> [    0.374718] Bluetooth: RFCOMM socket layer initialized
> [    0.374718] Bluetooth: RFCOMM ver 1.11
> [    0.374719] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    0.374720] Bluetooth: BNEP socket layer initialized
> [    0.374721] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    0.374722] Bluetooth: HIDP socket layer initialized
> [    1.422530] Bluetooth: hci0: read Intel version: 370710018002030d00
> [    1.422533] Bluetooth: hci0: Intel Bluetooth firmware file:
> intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [    1.625557] Bluetooth: hci0: Intel firmware patch completed and activated
> [   21.986125] input: BluetoothMouse3600 Mouse as
> /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input15
> [   21.986329] input: BluetoothMouse3600 Consumer Control as
> /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input16
> [   21.986408] hid-generic 0005:045E:0916.0004: input,hidraw3:
> BLUETOOTH HID v1.10 Mouse [BluetoothMouse3600] on 80:19:34:4D:31:44
> 
> 
> The error message goes away if I revert following patch:
> f80c5dad7b64 Bluetooth: Ignore CC events not matching the last HCI command

if you can send btmon trace (or better btmon -w trace.log) for this event triggering it, then we can look if this is a hardware issue. We have only seen this with Atheros hardware so far, but it might happen for others as well. It indicates that this is an unexpected event. Normally you can ignore this warning since it just indicates an existing issue that we just papered over before. So if everything works as before, just ignore it, but send me the trace and I can look if the event is erroneous or if we can silence the warning for the Intel hardware.

Regards

Marcel

