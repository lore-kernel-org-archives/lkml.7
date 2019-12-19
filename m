Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31685C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023C7222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="wACAMuy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLSLyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:54:38 -0500
Received: from dougal.metanate.com ([90.155.101.14]:54058 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfLSLyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tmKdpt8FfuaV6nRnJAttHNQVsa8S40+mibR855aHQJg=; b=wACAMuy2aD0a0GYTT1d2De4df5
        Osp+Jt0hP6KqVmVaP4NXmXxS2prRPv5FjUW8XIudomRk3VnUCQBbpXyPbFQ0kkRNrxVnjTqwpOsGj
        oUY5SoF3GZ05cXNgDxNhpVSFanqqcroaox+vRe0JFXequ5RRDnm5nun2VViGeOHXXyShM6uD9erSI
        jXtWi2fPTtVooOUmTtXLaI/Y88p+GxN9lz7HSQOLmy9ykBdtC6Cr3dSTtv8ribR4ifiLkCWJe/Ead
        +lIjqdjyybE0XhlRRLRwiQTpuOkd0Xf8sEopsR0K/GRH6DlG4lmSq7haV+BoxWTIVlrf/hIjLLSO6
        2ws5Curw==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1ihu4j-00024T-UX; Thu, 19 Dec 2019 11:34:38 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        John Keeping <john@metanate.com>
Subject: [PATCH 1/2] usb: dwc2: Fix IN FIFO allocation
Date:   Thu, 19 Dec 2019 11:34:31 +0000
Message-Id: <20191219113432.1229852-1-john@metanate.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On chips with fewer FIFOs than endpoints (for example RK3288 which has 9
endpoints, but only 6 which are cabable of input), the DPTXFSIZN
registers above the FIFO count may return invalid values.

With logging added on startup, I see:

	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=1 sz=256
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=2 sz=128
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=3 sz=128
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=4 sz=64
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=5 sz=64
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=6 sz=32
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=7 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=8 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=9 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=10 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=11 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=12 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=13 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=14 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=15 sz=0

but:

	# cat /sys/kernel/debug/ff580000.usb/fifo
	Non-periodic FIFOs:
	RXFIFO: Size 275
	NPTXFIFO: Size 16, Start 0x00000113

	Periodic TXFIFOs:
		DPTXFIFO 1: Size 256, Start 0x00000123
		DPTXFIFO 2: Size 128, Start 0x00000223
		DPTXFIFO 3: Size 128, Start 0x000002a3
		DPTXFIFO 4: Size 64, Start 0x00000323
		DPTXFIFO 5: Size 64, Start 0x00000363
		DPTXFIFO 6: Size 32, Start 0x000003a3
		DPTXFIFO 7: Size 0, Start 0x000003e3
		DPTXFIFO 8: Size 0, Start 0x000003a3
		DPTXFIFO 9: Size 256, Start 0x00000123

so it seems that FIFO 9 is mirroring FIFO 1.

Fix the allocation by using the FIFO count instead of the endpoint count
when selecting a FIFO for an endpoint.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 92e8de9cb45c..911b950ef25e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4059,11 +4059,12 @@ static int dwc2_hsotg_ep_enable(struct usb_ep *ep,
 	 * a unique tx-fifo even if it is non-periodic.
 	 */
 	if (dir_in && hsotg->dedicated_fifos) {
+		unsigned fifo_count = dwc2_hsotg_tx_fifo_count(hsotg);
 		u32 fifo_index = 0;
 		u32 fifo_size = UINT_MAX;
 
 		size = hs_ep->ep.maxpacket * hs_ep->mc;
-		for (i = 1; i < hsotg->num_of_eps; ++i) {
+		for (i = 1; i <= fifo_count; ++i) {
 			if (hsotg->fifo_map & (1 << i))
 				continue;
 			val = dwc2_readl(hsotg, DPTXFSIZN(i));
-- 
2.24.1

