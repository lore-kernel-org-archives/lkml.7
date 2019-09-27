Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B11C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66609217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfI0RIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:08:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56186 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726251AbfI0RIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:08:10 -0400
Received: (qmail 4736 invoked by uid 2102); 27 Sep 2019 13:08:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 2019 13:08:09 -0400
Date:   Fri, 27 Sep 2019 13:08:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub add filter for device with specific VID&PID
In-Reply-To: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Ran Wang wrote:

> Hi Greg,
> 
> On Monday, September 23, 2019 19:07, Greg Kroah-Hartman wrote:
> > 
> > On Mon, Sep 23, 2019 at 06:51:02PM +0800, Ran Wang wrote:
> > > USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT
> > > "Unsupported Device" Message require to stop enumerating device with
> > > VID=0x1a0a PID=0x0201 and pop message to declare this device is not
> > supported.
> > 
> > Why is this a requirement?
> 
> This comes from <USB On-The-Go and Embedded Host Automated Compliance Plan
> for the On-The-Go& Embedded Host Supplement Revision2.0>

How much do we care about our support for USB OTG?  Isn't it dying off?

> Below is related description I quote from it:
> 6.7.23 A-UUT "Unsupported Device" Message
> Purpose: This test verifies that an A-UUT produces a device non-supported error message
> 	when a device it doesn't recognize, and does not support HNP, connects to it.
> Applies to: All Targeted Hosts
> Description: Get VBUS turned on, and connect to the A-UUT. Get enumerated and respond
> 	as an unknown device not supporting HNP. Check that a suitable error message is generated.
> Pass Criteria: Message "Unsupported Device"or similar is displayed on UUT
> 
> 6.7.23.1 Test Procedure
> 1. Start with cable still attached, PET applying 10ìF capacitance and 10kÙ pull-down
>     resistance between VBUS and ground, data lines not pulled up.
> 2. Get VBUS turned on, using the method described in Section6.7.1.
> 3. Wait for almost TB_SVLD_BCON max (1s - 0.1s = 0.9s) from VBUS reaching VOTG_SESS_VLD max.
> 4. Connect PET using D+ pull-up.
> 5. Allow A-UUT to enumerate PET, responding with a VID / PID combination not on the TPL
>     of the UUT and also with the OTG descriptor stating that it does not support HNP.
> 6. Start 30s timer when Device Descriptor is read.
> 7. Display Message "Click OK if 'Unsupported Device' indication displayed on UUT".
> 8. If operator clicks OK before 30s timer expires, then UUT passes test.
> 9. If 30selapses first, then UUT fails test.
> 10. PET disconnects by removing any termination on the data lines, but leaves a capacitance of
>     10ìF and a pull-down resistance of 10kÙ connected across VBUS.
> 11. Wait 2s to allow disconnection to be detected.
> End of Test.

In fact, the system should respond the same way to any unrecognized 
device that doesn't support HNP, right?  There's nothing special about 
these VID/PID values.

> > And why those specific vid/pid values?  What do they refer to?
> 
> For step 5, we got the VID / PID number from USB IF certified lab(Allion.inc at Taiwang). Looks like
> this is a reserved ID pair and will not be allocated to any vendor for their products. So it's hence used for this
> case test (like saying: you should be able to pop a not-support message for this reserved VID&PID).

Don't we do this already?

Alan Stern

