Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B25C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4318F21019
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354500;
	bh=ZLr0cVcvibSBi1yenOkAeu/U1OwPHIF//FCDqSsn3ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rV0f5GghZDbTLiRpNRUOH90+qQcrrh3xFOfryQbffMZ/zshSUD1g2VOS9OwGizCU5
	 265Rv7JyfQSPgPRmbuvwZRoQZ0qS0CUKkCjO8InW4FGWzibuT0kDz43sf6cay9Ypst
	 dG8gzPYHgDij34sIJfbGD4v7IWiMwiqBiPSUEM2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfKJCy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbfKJCu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:50:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B2E22583;
        Sun, 10 Nov 2019 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354227;
        bh=ZLr0cVcvibSBi1yenOkAeu/U1OwPHIF//FCDqSsn3ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U67eKehBXQQerCUbi1QmYpZdZyNiPZkNZ4hOZFWVRWqUgJUAz/CQ3qhMpntp+3h6G
         8rJaf54mmJGLnKnDBWtgPBdsUWqK1AfCMMpKD1KnoeYejnIr1pTiMuOissTgAXHUvl
         7mHXZKiBibOv+EpzDs64hALmTCr+xOm+DgBmU/d8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 64/66] usb: xhci-mtk: fix ISOC error when interval is zero
Date:   Sat,  9 Nov 2019 21:48:43 -0500
Message-Id: <20191110024846.32598-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 87173acc0d8f0987bda8827da35fff67f52ad15d ]

If the interval equal zero, needn't round up to power of two
for the number of packets in each ESIT, so fix it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mtk-sch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 73f763c4f5f59..144674913c788 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -122,7 +122,9 @@ static void setup_sch_info(struct usb_device *udev,
 		}
 
 		if (ep_type == ISOC_IN_EP || ep_type == ISOC_OUT_EP) {
-			if (esit_pkts <= sch_ep->esit)
+			if (sch_ep->esit == 1)
+				sch_ep->pkts = esit_pkts;
+			else if (esit_pkts <= sch_ep->esit)
 				sch_ep->pkts = 1;
 			else
 				sch_ep->pkts = roundup_pow_of_two(esit_pkts)
-- 
2.20.1

