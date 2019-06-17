Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FDC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21021783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfFQNbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:31:22 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:31:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMWcT-1hsbSL1duZ-00JXkC; Mon, 17 Jun 2019 15:31:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fix integer truncation
Date:   Mon, 17 Jun 2019 15:30:54 +0200
Message-Id: <20190617133101.2817807-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:chTa38z/gjbzCpsUfTMZ6NKpNwxA24x4uqV4fTfRNlScDoohZxE
 1UR/Jwd1cvsBZi9Cwv+CO14naU7ifAmSljpXWNFEf53fU9hdB6iM1CqSUCsspUGu0vXhGrA
 eGscsZlCrDJPIncYviaP81EDiKdWdO3eE8blN7GXzwc0BPHW8ybWkzP+mCcPefHu5pCJXDe
 etGOFg30YMgkRmbiSvkNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A9saYNOYImg=:MVpURSDPPJlAyB6iXvqW2g
 avKf+edpDy4W5PssdS5cRVc4QNS1IlH8SqaiwcpcqQXD5AG730d6miFbVQm+3NfvN2fKB5ypX
 mekwCj9hp4VhkTs/rAmlhLLgKhakc25AoveIlnlqhQ82UR013qCyjfBEggCtnz6JFyWCpY0Ae
 gpTuCoiLcCBfgpb93voa3QEQAbcc0kFG+LuKCP1c/aQ3c6oOiynW3XBvMU1o7eMy0MXdh5WFc
 3CqkjBO90fS7PmvkJIzCgYFlqiilL9QIwK6xN7TsZu3cqJMUMU59rRybbxHKwPqzWdZw7Uajc
 onvzMU9c/4dJsQkE/NcH1hreerofhpQpfKiUcTnp/NVxYIIU+FQzBYMaytFte09AFjS6hH5SI
 OgCNV/LEkhtk9accU8jWFayunL9DI2LkoRgWJM+Xd8aPqJvIUQSZAWkKkSWdSzZxkuK9mvted
 Dnvvr+TU5OPkk3Ry5JtTQ6oLS2tdlvdswGpG/ZWDQmxkHrMl3554mxtCA/4zXhT8qYxVtK0HI
 P2+eToyhOGotRjL8WKjylitmFO37HSxajlTmyBsMLbjhD9INYY51awWfebQE6EIRyd9v5U3G8
 n7kUgACkf13306KMTVkAjJroK7sZ2Jfnowpg2mBA/VR39OVzCyTW9BW94kXMGi0HRm7uG5ycZ
 BxugJchd22/ncPSJ9wx634vmWAW+yb/5sub343qczvMcyzJVnW9t47eD2Y3EOt1aLs0CIkDAG
 fqoBrshYUPEhHxepgHU3v2EJ3Vzlr27+eDCJbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, phys_addr_t may be different from dma_add_t,
both smaller and bigger. This can lead to an overflow during an assignment
that clang warns about:

drivers/iommu/dma-iommu.c:230:10: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to
      'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]

Use phys_addr_t here because that is the type that the variable was
declared as.

Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cc0613c83d71..a9f13313a22f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -226,8 +226,8 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		start = window->res->end - window->offset + 1;
 		/* If window is last entry */
 		if (window->node.next == &bridge->dma_ranges &&
-		    end != ~(dma_addr_t)0) {
-			end = ~(dma_addr_t)0;
+		    end != ~(phys_addr_t)0) {
+			end = ~(phys_addr_t)0;
 			goto resv_iova;
 		}
 	}
-- 
2.20.0

