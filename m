Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC2C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfFNRXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:23:23 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:50801 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfFNRXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:23:20 -0400
X-Greylist: delayed 2129 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 13:23:05 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id x5EGl5kL020143;
        Fri, 14 Jun 2019 19:47:10 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 9152ABCE4;
        Fri, 14 Jun 2019 19:46:58 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] musb: Improve performance for hub-attached webcams
Date:   Fri, 14 Jun 2019 19:45:48 +0300
Message-Id: <20190614164554.27679-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series is concerned to issues with isochronous transfer while
streaming the USB webcam data. I discovered the issue first time
when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
It appeared that the root issue was in numerous missed IN requests
during isochronous transfer where each missing leaded to the frame
drop. Since every IN request is triggered in MUSB driver
individually, it is important to queue the send IN request as
earlier as possible when the previous IN completed. At the same
time the URB giveback handler of the device driver has also to be
called there, that leads to arbitrarily delay depending on the
device driver performance. The details with the references are
described in [1].

The issue has two parts:

  1) peripheral driver URB callback performance
  2) MUSB host driver performance

It appeared that the first part is related to the wrong memory
allocation strategy in the most USB webcam drivers. Non-cached
memory is used in assumption that coherent DMA memory leads to
the better performance than non-coherent memory in conjunction with
the proper synchronization. Yet the assumption might be valid for
x86 platforms some time ago, the issue was fixed for PWC driver in:

    1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers for ISO transfer")

that leads to 3.5x performance gain. The more generic fix for this
common issue are coming for the rest drivers [2].

The patch allowed successfully running full-speed USB PWC webcams
attached directly to BeagleBone Black USB port.

However, the second part of the issue is still present for
peripheral device attached through the high-speed USB hub due to
its 125us frame time. The patch series is intended to reorganize
musb_advance_schedule() to allow host to send IN request quicker.

The patch series is organized as the following. First three patches
improve readability of the existing code in
musb_advance_schedule(). Patches 4 and 5 introduce updated
signature for musb_start_urb(). The last patch introduce new
code-path in musb_advance_schedule() which allows for faster
response.

References:

[1] https://www.spinics.net/lists/linux-usb/msg165735.html
[2] https://www.spinics.net/lists/linux-media/msg144279.html

Changes since v1:
 - Patch 6 was redone to keep URB giveback order and stop transmission at
   erroneous URB.

Matwey V. Kornilov (6):
  usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
  usb: musb: Introduce musb_qh_empty() helper function
  usb: musb: Introduce musb_qh_free() helper function
  usb: musb: Rename musb_start_urb() to musb_start_next_urb()
  usb: musb: Introduce musb_start_urb()
  usb: musb: Decrease URB starting latency in musb_advance_schedule()

 drivers/usb/musb/musb_host.c | 132 ++++++++++++++++++++++++++++---------------
 drivers/usb/musb/musb_host.h |   1 +
 2 files changed, 86 insertions(+), 47 deletions(-)

-- 
2.16.4

