Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76981C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A220700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519717;
	bh=T0ZeePh69wfZFJoEVb5zMxvl/KiHPmT9h9JmdM695A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFsB2pRCODT7ehqKqYZ4K2tjh8MNuX1h7Dx5PvhtFZ30FKx9grdBIvY7ScLpMTQGE
	 FWigEWpGYgUhZ1yWSAoWDfkgf8nq0ejdyPt0k1RpuFKomNEqcx62S7sLSN2KIXVaiG
	 tTkMXqOMg6oMK5fuYjxrcwIUjcJWixNJ+dwQny70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfLPSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbfLPSId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:08:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAA720700;
        Mon, 16 Dec 2019 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519713;
        bh=T0ZeePh69wfZFJoEVb5zMxvl/KiHPmT9h9JmdM695A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRdWklecFle0ZVNlQqpLuTPNyTNxyw/UkClgkhKWsUp6wcLhi2JqjR5sHxAUp61ie
         K0kJNXdspmVQezMyyJnSKD6AyrET8m3yC/Wfujg+HLS7/IXy+HqWg8whw0x6zohta1
         HjvHJhWLxneFST9B2ukf8puLq7RP2qoFZxgWON7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Subject: [PATCH 5.3 039/180] usb: core: urb: fix URB structure initialization function
Date:   Mon, 16 Dec 2019 18:47:59 +0100
Message-Id: <20191216174816.603573537@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emiliano Ingrassia <ingrassia@epigenesys.com>

commit 1cd17f7f0def31e3695501c4f86cd3faf8489840 upstream.

Explicitly initialize URB structure urb_list field in usb_init_urb().
This field can be potentially accessed uninitialized and its
initialization is coherent with the usage of list_del_init() in
usb_hcd_unlink_urb_from_ep() and usb_giveback_urb_bh() and its
explicit initialization in usb_hcd_submit_urb() error path.

Signed-off-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191127160355.GA27196@ingrassia.epigenesys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/urb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -45,6 +45,7 @@ void usb_init_urb(struct urb *urb)
 	if (urb) {
 		memset(urb, 0, sizeof(*urb));
 		kref_init(&urb->kref);
+		INIT_LIST_HEAD(&urb->urb_list);
 		INIT_LIST_HEAD(&urb->anchor_list);
 	}
 }


