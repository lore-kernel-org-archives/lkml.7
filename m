Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24FCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CEE2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfDBNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43592 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728817AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002oa-U4; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004xx-48; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.24849891@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 93/99] ibmveth: fix DMA unmap error in
 ibmveth_xmit_start error path
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

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit 756af9c642329d54f048bac2a62f829b391f6944 upstream.

Commit 33a48ab105a7 ("ibmveth: Fix DMA unmap error") fixed an issue in the
normal code path of ibmveth_xmit_start() that was originally introduced by
Commit 6e8ab30ec677 ("ibmveth: Add scatter-gather support"). This original
fix missed the error path where dma_unmap_page is wrongly called on the
header portion in descs[0] which was mapped with dma_map_single. As a
result a failure to DMA map any of the frags results in a dmesg warning
when CONFIG_DMA_API_DEBUG is enabled.

------------[ cut here ]------------
DMA-API: ibmveth 30000002: device driver frees DMA memory with wrong function
  [device address=0x000000000a430000] [size=172 bytes] [mapped as page] [unmapped as single]
WARNING: CPU: 1 PID: 8426 at kernel/dma/debug.c:1085 check_unmap+0x4fc/0xe10
...
<snip>
...
DMA-API: Mapped at:
ibmveth_start_xmit+0x30c/0xb60
dev_hard_start_xmit+0x100/0x450
sch_direct_xmit+0x224/0x490
__qdisc_run+0x20c/0x980
__dev_queue_xmit+0x1bc/0xf20

This fixes the API misuse by unampping descs[0] with dma_unmap_single.

Fixes: 6e8ab30ec677 ("ibmveth: Add scatter-gather support")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/ibm/ibmveth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1059,11 +1059,15 @@ out:
 
 map_failed_frags:
 	last = i+1;
-	for (i = 0; i < last; i++)
+	for (i = 1; i < last; i++)
 		dma_unmap_page(&adapter->vdev->dev, descs[i].fields.address,
 			       descs[i].fields.flags_len & IBMVETH_BUF_LEN_MASK,
 			       DMA_TO_DEVICE);
 
+	dma_unmap_single(&adapter->vdev->dev,
+			 descs[0].fields.address,
+			 descs[0].fields.flags_len & IBMVETH_BUF_LEN_MASK,
+			 DMA_TO_DEVICE);
 map_failed:
 	if (!firmware_has_feature(FW_FEATURE_CMO))
 		netdev_err(netdev, "tx: unable to map xmit buffer\n");

