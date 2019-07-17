Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388ADC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176DC21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfGQT0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:26:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQT0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9491B337;
        Wed, 17 Jul 2019 12:26:31 -0700 (PDT)
Received: from tuskha01.cambridge.arm.com (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1B6D3F71A;
        Wed, 17 Jul 2019 12:26:30 -0700 (PDT)
From:   Tushar Khandelwal <tushar.khandelwal@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tushar.2nov@gmail.com, morten_bp@live.dk, jassisinghbrar@gmail.com,
        nd@arm.com, Morten Borup Petersen <morten.petersen@arm.com>
Subject: [PATCH 0/4] Arm MHUv2 Mailbox Controller Driver
Date:   Wed, 17 Jul 2019 20:26:12 +0100
Message-Id: <20190717192616.1731-1-tushar.khandelwal@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Borup Petersen <morten.petersen@arm.com>

This patch series adds a driver for the Arm MHU v2 device, with support for the
2.1 minor hardware revision.

The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller which
facilitate unidirectional communication between processing element(s).

Unidirectionality
=================
Given the unidirectional nature of the device, an MHUv2 mailbox may only be
written to or read from. If a pair of MHU devices is implemented between two
processing elements to provide bidirectional communication, these must be
specified as two separate mailboxes. This stands in contrast to the arm_mhu
driver, which assumes that MHU (v1) devices always come in pairs and thus may
be grouped into a single mailbox (and device tree entry).
While it is expected that MHUv2 devices in most cases will be provided in pairs,
this is _not_ a requirement, and thus the driver must be able to handle such
cases.

Transport Protocols
===================
As opposed to the MHUv1 driver, MHUv2 adds support for three distinct transport
protocols. Transport protocols define the method of which information is
transmitted through the device, in terms of how hardware resources (channel
windows) are used. The transport protocol determines how many mailbox channels
the mailbox controller will allocate.

- Single Word:	In single-word mode, the mailbox controller will provide a
		mailbox for each channel window available in the MHU device.
		Transmitting and receiving data through the mailbox framework in
		single-word mode is done through a struct arm_mbox_msg.
- Multi Word:	In multi word mode, the mailbox controller will provide a
		_single_ mailbox. It is required that the MHU device has at
		least 2 channel windows available for the MHU to function in
		multi word mode.
- Doorbell:	In doorbell mode, the mailbox controller will provide a mailbox
		for each flag bit available in the combined number of channel
		windows available within the MHU device.


Combined Interrupt (v2.1)
=========================
The driver adds support for the combined receiver interrupt, introduced in the
2.1 hardware revision.
The combined interrupt status registers are used when in single-word and
doorbell transport protocol mode, to more quickly identify a channel window
containing non-zero data.
The combined interrupt status registers are not used in multi word mode,
given that only a single channel window may raise a receiver interrupt in this
mode.


Device Tree Changes
===================
Compared to the device tree entry for an MHUv1 device, the following changes
exists for an MHUv2 device:
- Frame type:	A device tree node for an Arm MHUv2 device must specify either a
		receiver frame or a sender frame, indicating which end of the
		unidirectional MHU device which the device node entry describes.
- Transport protocol:	While the transport protocol for an MHU is software
			defined, transport protocol configuration is static and
			should be specified in the device tree.
- reg:		Given the unidirectional nature of the device, MHUv2 mandates
		that only a single reg entry is provided. This is a change from
		MHUv1, which specified two reg entries for tx and rx
		respectively.
- irq:		The MHUv2 driver adds support for a single interrupt for
		receiver frames. Thus, no irq property should be specified for
		sender frames.


struct arm_mbox_msg
===================
The MHUv2 driver differs significantly in terms of its integration with the
common mailbox framework compared to MHUv1.
The common mailbox framework provides a void* to pass data between a mailbox
client and controller, when sending and receiving data. In MHUv1, given that
it only provided an implementation of the single-word message protocol, this
void* was used to pass the actual data which was to be transmitted. This was
possible given that the size of the STAT register within the MHU is 4 bytes,
identical to the size of a void* on 32-bit systems.
Given the introduction of different transport protocols - mainly multi-word -
this method of passing data between client and controller is insufficient. This
is given that multi-word makes sense when a higher bandwidth is desired, at
the sacrifice of mailbox channels.
To utilize this bandwidth, it should therefore be possible to pass a notion
of data length to the mailbox controller, which may then utilize its available
resources to efficiently transmit the message.

The arm_mbox_msg structure is provided, which is used to pass data- and length
information between a mailbox client and mailbox controller, through the
provided void* of the common mailbox frameworks send- and receive APIs.
No message protocol is enforced through this structure - a utilizing mailbox
client driver shall implement its own message protocol, which may then be
transmitted through an arm_mbox_msg.

Testing
=======
The driver has been tested using an Arm fixed virtual platform (FVP).
The driver has not been tested on hardware.

========
Cheers, Morten

Morten Borup Petersen (4):
  mailbox: arm_mhuv2: add device tree binding documentation
  mailbox: arm_mhuv2: add arm mhuv2 driver
  mailbox: arm_mhuv2: add doorbell transport protocol operations
  mailbox: arm_mhuv2: add multi word transport protocol operations

 .../devicetree/bindings/mailbox/arm,mhuv2.txt |  108 ++
 drivers/mailbox/Kconfig                       |    7 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/arm_mhu_v2.c                  | 1068 +++++++++++++++++
 include/linux/mailbox/arm-mbox-message.h      |   37 +
 5 files changed, 1222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
 create mode 100644 drivers/mailbox/arm_mhu_v2.c
 create mode 100644 include/linux/mailbox/arm-mbox-message.h

-- 
2.17.1

