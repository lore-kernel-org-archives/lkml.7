Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06F621850
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353954;
	bh=O3mFNZoIUng350Ipl4qr82fCz1yUrnK9uVXdJCEkPLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVLaVapkFM7BkML3srBGiFlRDl0BSo4ttgZ1oBpo7i6mUlk0Bo30rVh8eoRXkF3nX
	 AjmzWD22oYp2UkAG2BXfzjYoMHtRPuX1WDIJ8zGL8ARxm1oLwltTG65A8n3Tpm6MPJ
	 s3NHXTRoAcLUg+sNTLHhrRM1FNXca+AnHR3ad5+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfKJCpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfKJCpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B243214E0;
        Sun, 10 Nov 2019 02:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353921;
        bh=O3mFNZoIUng350Ipl4qr82fCz1yUrnK9uVXdJCEkPLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQpshlpWWEEm34QMbzlQm3PB5R+xaKMgcqngyhQzRdm5Y/06bUBBpcfCQibtCxAr6
         +aJlTLosAb7s/K24bRXUvJJS+2D/cHz+1hR7WHv/gKP51KOqs5RW+2zSgaRbF00Coi
         oHtc1HhEkd5nSVKPH81nlvCyWgPwejPqOAlTuCM4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 184/191] usb: xhci-mtk: fix ISOC error when interval is zero
Date:   Sat,  9 Nov 2019 21:40:06 -0500
Message-Id: <20191110024013.29782-184-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
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
index fa33d6e5b1cbd..d04fdd173ed2e 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -113,7 +113,9 @@ static void setup_sch_info(struct usb_device *udev,
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

