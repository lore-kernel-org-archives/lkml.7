Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389AFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03389222C8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118481;
	bh=hcfejRqgJw0E5uY7PyDrh38sjgIodIs3+rjUHtxGkrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlpA1jjV0aC3QpsJ5FQBe4+lhsH5xYz5V3YL/OFTIrfY5VatYZA7hn/iisz1FZgM1
	 YZbtVHv4y7wlLl9LlQoso2o9ZI0PLuQyn2VDM72gPcf3DfUSWRfJ5YrTyNm/wI8rtP
	 f6toAVaWupo7/YI3yr+nzUSZRqW4a/NuOveosU9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfJCQBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfJCQBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:01:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D77E207FF;
        Thu,  3 Oct 2019 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118476;
        bh=hcfejRqgJw0E5uY7PyDrh38sjgIodIs3+rjUHtxGkrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYy2LvuZ+IDyQ+zj5YQtCJKjE7I7F2Z6f1lafnTSfn7bQAyWlz/thGwfSf0E0Jo1N
         9FLpKry8m6upgso1dPYOD0kJHCo7PcceyajndyZb31624xk1YKPnfwg66m5NP8+f5+
         nsXJ9/vu16i04Siphi/zlsnIneBKk2lNcF8BxJaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ce366e2b8296e25d84f5@syzkaller.appspotmail.com,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.9 024/129] cdc_ncm: fix divide-by-zero caused by invalid wMaxPacketSize
Date:   Thu,  3 Oct 2019 17:52:27 +0200
Message-Id: <20191003154330.064190039@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -679,8 +679,12 @@ cdc_ncm_find_endpoints(struct usbnet *de
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


