Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D6C21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948783;
	bh=tJCaqfcO8B+AE8KOjoSqsm4KEI4rGIfQR2coy5zqq08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vLFZWvtJH14t781crQEqZ4EwbWeBdU+0sQDdGWmDC5eV+hLn0ktPJKLAEMpGL0ezo
	 w2z8pAKVu0MmzxMUeZ7r2VvGUpIqGNWqXRQuzTdj9YUZtN09Qz9mqH0fHxm4A16hl9
	 zbX8VCVVGv9jB66mExWjxRukZG3QcNNJ0Qk3Mrjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbfJAQw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbfJAQng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA532168B;
        Tue,  1 Oct 2019 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948216;
        bh=tJCaqfcO8B+AE8KOjoSqsm4KEI4rGIfQR2coy5zqq08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQRDw945y0zvca7aTQZ9styCiPq5t4D7mYzUDhXOCpO5hmCy57xNa6BjHqa9RkRAf
         muZWdIzAAVBiKoAWrTq8FmUPUNZrLRBKiEDQzFJk0iJhTRMMsz1InZv092jUcxgQBn
         GHmQRaXOh96/aXWg9K2JS8K12c6vNlNm3YD8LlNg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        syzbot+ce366e2b8296e25d84f5@syzkaller.appspotmail.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/43] cdc_ncm: fix divide-by-zero caused by invalid wMaxPacketSize
Date:   Tue,  1 Oct 2019 12:42:46 -0400
Message-Id: <20191001164311.15993-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjørn Mork <bjorn@mork.no>

[ Upstream commit 3fe4b3351301660653a2bc73f2226da0ebd2b95e ]

Endpoints with zero wMaxPacketSize are not usable for transferring
data. Ignore such endpoints when looking for valid in, out and
status pipes, to make the driver more robust against invalid and
meaningless descriptors.

The wMaxPacketSize of the out pipe is used as divisor. So this change
fixes a divide-by-zero bug.

Reported-by: syzbot+ce366e2b8296e25d84f5@syzkaller.appspotmail.com
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 1eaec648bd1f7..f53e3e4e25f37 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -681,8 +681,12 @@ cdc_ncm_find_endpoints(struct usbnet *dev, struct usb_interface *intf)
 	u8 ep;
 
 	for (ep = 0; ep < intf->cur_altsetting->desc.bNumEndpoints; ep++) {
-
 		e = intf->cur_altsetting->endpoint + ep;
+
+		/* ignore endpoints which cannot transfer data */
+		if (!usb_endpoint_maxp(&e->desc))
+			continue;
+
 		switch (e->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
 		case USB_ENDPOINT_XFER_INT:
 			if (usb_endpoint_dir_in(&e->desc)) {
-- 
2.20.1

