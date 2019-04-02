Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3240EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26321473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfDBNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:42:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43784 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731547AbfDBNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:13 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe6-0002oY-Rj; Tue, 02 Apr 2019 14:40:11 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004v7-TO; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Frank Haverkamp" <haver@linux.vnet.ibm.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.618691394@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 58/99] genwqe: Fix size check
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit fdd669684655c07dacbdb0d753fd13833de69a33 upstream.

Calling the test program genwqe_cksum with the default buffer size of
2MB triggers the following kernel warning on s390:

WARNING: CPU: 30 PID: 9311 at mm/page_alloc.c:3189 __alloc_pages_nodemask+0x45c/0xbe0
CPU: 30 PID: 9311 Comm: genwqe_cksum Kdump: loaded Not tainted 3.10.0-957.el7.s390x #1
task: 00000005e5d13980 ti: 00000005e7c6c000 task.ti: 00000005e7c6c000
Krnl PSW : 0704c00180000000 00000000002780ac (__alloc_pages_nodemask+0x45c/0xbe0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
Krnl GPRS: 00000000002932b8 0000000000b73d7c 0000000000000010 0000000000000009
           0000000000000041 00000005e7c6f9b8 0000000000000001 00000000000080d0
           0000000000000000 0000000000b70500 0000000000000001 0000000000000000
           0000000000b70528 00000000007682c0 0000000000277df2 00000005e7c6f9a0
Krnl Code: 000000000027809e: de7195001000	ed	1280(114,%r9),0(%r1)
	   00000000002780a4: a774fead		brc	7,277dfe
	  #00000000002780a8: a7f40001		brc	15,2780aa
	  >00000000002780ac: 92011000		mvi	0(%r1),1
	   00000000002780b0: a7f4fea7		brc	15,277dfe
	   00000000002780b4: 9101c6b6		tm	1718(%r12),1
	   00000000002780b8: a784ff3a		brc	8,277f2c
	   00000000002780bc: a7f4fe2e		brc	15,277d18
Call Trace:
([<0000000000277df2>] __alloc_pages_nodemask+0x1a2/0xbe0)
 [<000000000013afae>] s390_dma_alloc+0xfe/0x310
 [<000003ff8065f362>] __genwqe_alloc_consistent+0xfa/0x148 [genwqe_card]
 [<000003ff80658f7a>] genwqe_mmap+0xca/0x248 [genwqe_card]
 [<00000000002b2712>] mmap_region+0x4e2/0x778
 [<00000000002b2c54>] do_mmap+0x2ac/0x3e0
 [<0000000000292d7e>] vm_mmap_pgoff+0xd6/0x118
 [<00000000002b081c>] SyS_mmap_pgoff+0xdc/0x268
 [<00000000002b0a34>] SyS_old_mmap+0x8c/0xb0
 [<000000000074e518>] sysc_tracego+0x14/0x1e
 [<000003ffacf87dc6>] 0x3ffacf87dc6

turns out the check in __genwqe_alloc_consistent uses "> MAX_ORDER"
while the mm code uses ">= MAX_ORDER". Fix genwqe.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/misc/genwqe/card_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -206,7 +206,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u
 void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
 			       dma_addr_t *dma_handle)
 {
-	if (get_order(size) > MAX_ORDER)
+	if (get_order(size) >= MAX_ORDER)
 		return NULL;
 
 	return pci_alloc_consistent(cd->pci_dev, size, dma_handle);

