Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CDDC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD8021783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKKP1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:27:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38501 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKKP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:26:56 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUBac-0000hy-13; Mon, 11 Nov 2019 16:26:50 +0100
Received: from mol by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUBaa-0003bN-Qm; Mon, 11 Nov 2019 16:26:48 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Olbrich <m.olbrich@pengutronix.de>
Subject: [PATCH 0/2] usb: dwc3: gadget: improve isoc handling
Date:   Mon, 11 Nov 2019 16:26:43 +0100
Message-Id: <20191111152645.13792-1-m.olbrich@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches improve the isoc handling and make the dwc3 gadget driver
somewhat usable with the UVC gadget for isochronous endpoints.

The first patch makes starting isochronous transfers more reliable. I think
it's more less, what Thinh suggested some time ago[1]. It's still not
perfect because the first request must still be queued within 2 seconds but
it's a lot better than the current situation.

The second patch makes it possible to have gaps in the data stream. The UVC
gadget relies on such behaviour. Without this, using the UVC gadget with a
live stream stops after the first frame, because all later frames are
dropped.
I'm not sure if this is the correct solution, but all other drivers
currently work this way, from what I can tell.

Regards,
Michael

[1] https://marc.info/?l=linux-usb&m=156088170723824&w=4

Michael Olbrich (2):
  usb: dwc3: gadget: make starting isoc transfers more robust
  usb: dwc3: gadget: restart the transfer if a isoc request is queued
    too late

 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.20.1

