Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76293C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E3820856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDBNnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43576 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731503AbfDBNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:10 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002o0-Ty; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004yI-7G; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Bingkuo Liu" <bingkuol@vmware.com>,
        "Shrikrishna Khare" <skhare@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.810081884@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 97/99] Driver: Vmxnet3: Fix regression caused by 5738a09
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shrikrishna Khare <skhare@vmware.com>

commit 58caf637365fef97c8e84ea5699a8e34d68fce93 upstream.

Reported-by: Bingkuo Liu <bingkuol@vmware.com>
Signed-off-by: Shrikrishna Khare <skhare@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Bump version from 1.2.2.0-k to 1.2.3.0-k, which wasn't used in mainline
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 8 ++++----
 drivers/net/vmxnet3/vmxnet3_int.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1308,9 +1308,9 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 				goto rcd_done;
 			}
 			new_dma_addr = dma_map_page(&adapter->pdev->dev,
-						rbi->page,
-						0, PAGE_SIZE,
-						PCI_DMA_FROMDEVICE);
+						    new_page,
+						    0, PAGE_SIZE,
+						    PCI_DMA_FROMDEVICE);
 			if (dma_mapping_error(&adapter->pdev->dev,
 					      new_dma_addr)) {
 				put_page(new_page);
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.2.2.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.2.3.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01020200
+#define VMXNET3_DRIVER_VERSION_NUM      0x01020300
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */

