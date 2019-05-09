Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F0CC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE94B2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428065;
	bh=HwTDDQgpdyLKymq762qog44ANmbDGP/fSirsRKzlApc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vD/v9VnLLyuljEB/bdiBwta0iWV17Rvz+n+AjFjmF1v9roTb3eSU/IfHr03y/umKV
	 U+eK90GGH+y9S1Ft8wy68LNFY0z9SyiqAtiu8KaZjT9wSbbycPZIr0YzCHT96Gk1K+
	 DuIRV8TefDea4P7vG3UegKeOkzlr65nJ7Px0bgvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfEISyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfEISyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCFA5204FD;
        Thu,  9 May 2019 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428059;
        bh=HwTDDQgpdyLKymq762qog44ANmbDGP/fSirsRKzlApc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vka7yY1hGk8ejNNRjnINR3GTVxnsSQAgpgWHJF7jXvRMEq/Y1vEZMssBY0vqgoAfb
         fwV6AAKuj6kv1EZerunuCx63EjrYot02ooeL6QEYa+BFoe1U4OgOpYHDHgf3DFRL89
         7E8lJV6fOMbTl0rrO3YPI5S6MjucaHaN/QCnC7pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Seth Bollinger <Seth.Bollinger@digi.com>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 5.1 11/30] usb-storage: Set virt_boundary_mask to avoid SG overflows
Date:   Thu,  9 May 2019 20:42:43 +0200
Message-Id: <20190509181253.129007884@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 747668dbc061b3e62bc1982767a3a1f9815fcf0e upstream.

The USB subsystem has always had an unusual requirement for its
scatter-gather transfers: Each element in the scatterlist (except the
last one) must have a length divisible by the bulk maxpacket size.
This is a particular issue for USB mass storage, which uses SG lists
created by the block layer rather than setting up its own.

So far we have scraped by okay because most devices have a logical
block size of 512 bytes or larger, and the bulk maxpacket sizes for
USB 2 and below are all <= 512.  However, USB 3 has a bulk maxpacket
size of 1024.  Since the xhci-hcd driver includes native SG support,
this hasn't mattered much.  But now people are trying to use USB-3
mass storage devices with USBIP, and the vhci-hcd driver currently
does not have full SG support.

The result is an overflow error, when the driver attempts to implement
an SG transfer of 63 512-byte blocks as a single
3584-byte (7 blocks) transfer followed by seven 4096-byte (8 blocks)
transfers.  The device instead sends 31 1024-byte packets followed by
a 512-byte packet, and this overruns the first SG buffer.

Ideally this would be fixed by adding better SG support to vhci-hcd.
But for now it appears we can work around the problem by
asking the block layer to respect the maxpacket limitation, through
the use of the virt_boundary_mask.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Seth Bollinger <Seth.Bollinger@digi.com>
Tested-by: Seth Bollinger <Seth.Bollinger@digi.com>
CC: Ming Lei <tom.leiming@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/scsiglue.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -65,6 +65,7 @@ static const char* host_info(struct Scsi
 static int slave_alloc (struct scsi_device *sdev)
 {
 	struct us_data *us = host_to_us(sdev->host);
+	int maxp;
 
 	/*
 	 * Set the INQUIRY transfer length to 36.  We don't use any of
@@ -74,20 +75,17 @@ static int slave_alloc (struct scsi_devi
 	sdev->inquiry_len = 36;
 
 	/*
-	 * USB has unusual DMA-alignment requirements: Although the
-	 * starting address of each scatter-gather element doesn't matter,
-	 * the length of each element except the last must be divisible
-	 * by the Bulk maxpacket value.  There's currently no way to
-	 * express this by block-layer constraints, so we'll cop out
-	 * and simply require addresses to be aligned at 512-byte
-	 * boundaries.  This is okay since most block I/O involves
-	 * hardware sectors that are multiples of 512 bytes in length,
-	 * and since host controllers up through USB 2.0 have maxpacket
-	 * values no larger than 512.
-	 *
-	 * But it doesn't suffice for Wireless USB, where Bulk maxpacket
-	 * values can be as large as 2048.  To make that work properly
-	 * will require changes to the block layer.
+	 * USB has unusual scatter-gather requirements: the length of each
+	 * scatterlist element except the last must be divisible by the
+	 * Bulk maxpacket value.  Fortunately this value is always a
+	 * power of 2.  Inform the block layer about this requirement.
+	 */
+	maxp = usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0);
+	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
+
+	/*
+	 * Some host controllers may have alignment requirements.
+	 * We'll play it safe by requiring 512-byte alignment always.
 	 */
 	blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));
 


