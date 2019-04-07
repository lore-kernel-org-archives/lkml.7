Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE5C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C956B2171F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nKgj/rIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDGCs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:48:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDGCs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 22:48:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so11718111qta.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yoXaJd9GtyVb62iXK+1ZtlbVF87kudQErpNUHAHDV6o=;
        b=nKgj/rIy9AEfu1vgeU+PNKyTrZCXSZtRRL29yKv/PbvtGYgjSFf1hF75LO2q1dTSHy
         dMHWVcynyQ2ipzCqdfG9r4NdZmEz3C9JLUfmSDu7iRbOvo6tn8xNPZJani3NJRAwbaeo
         VT3DVfXf26bFfx3tuRUnHPy6AFGWw6j96O4e73g3YluK74ll83a+duslTX8hqtc1D8ZR
         XpeRxv+zpMs9sPO0GmMwvf9sLHzzNafMTIoXl5Jjy3E+ap8waUW+3A1joRiYlguqovC2
         HFgMDaWZNh6t7ekNw4mioIphMUu9BetmujKjqhmz1siVSk2l7Dy5xWW6Dc7u2xTjCmUI
         XcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yoXaJd9GtyVb62iXK+1ZtlbVF87kudQErpNUHAHDV6o=;
        b=BA9Rytvb3afxW0zyM2QBsgcUe3yeOL8u3YAeviObWsnkLd4odsBQXV9NHSSgy3m6Og
         x9WhGbovbZtfenBGky3aPTQ+ZKFJGigmNIBb2h3JpZqg75JG8rXWvrIpRz/TX9FYFOah
         39GAEFBfaAk6HM1XxouL2J3njVhpT5yaDZMU84hMlU089qdxeLxpJI4rPmv9JXAHt3Kb
         SGyUxPGjvoEzXQcgnXI81eVai3y1v+1FejMoebjffmrbrlM3MPLb8yVwfVdacgt1oXXG
         TgS4FwZGNMXOQDZ+uHX1vV0mMCy+FCXgG5r+Nw7+980yPU3/sb8IPXYIiDEJpaEjJzVh
         iSRQ==
X-Gm-Message-State: APjAAAXaL2jWra8Zcaqsa4J5XYF47U12YyCwkMgRP3CJvVB9hJNe39Ia
        Sei/qS6Zq5e665OXLCWesZi0zg==
X-Google-Smtp-Source: APXvYqyKUeQhF6XU6NOUvDCpi7hTu0SOL9uEt/kfbvgwe/8VEwLxy0OtaEijpTeupK9aQAk0BlZ6Bw==
X-Received: by 2002:ac8:1c2c:: with SMTP id a41mr18860953qtk.292.1554605308165;
        Sat, 06 Apr 2019 19:48:28 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s50sm17743028qts.39.2019.04.06.19.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 19:48:27 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/pseries/iommu: fix set but not used values
Date:   Sat,  6 Apr 2019 22:48:08 -0400
Message-Id: <20190407024808.39821-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b7d6bf4fdd47 ("powerpc/pseries/pci: Remove obsolete SW
invalidate") left 2 variables unused.

arch/powerpc/platforms/pseries/iommu.c: In function 'tce_build_pSeries':
arch/powerpc/platforms/pseries/iommu.c:108:17: warning: variable 'tces'
set but not used [-Wunused-but-set-variable]
  __be64 *tcep, *tces;
                 ^~~~
arch/powerpc/platforms/pseries/iommu.c: In function 'tce_free_pSeries':
arch/powerpc/platforms/pseries/iommu.c:132:17: warning: variable 'tces'
set but not used [-Wunused-but-set-variable]
  __be64 *tcep, *tces;
                 ^~~~

Also, the commit 68c0449ea16d ("powerpc/pseries/iommu: Use memory@ nodes
in max RAM address calculation") set "ranges" in
ddw_memory_hotplug_max() but never use it.

arch/powerpc/platforms/pseries/iommu.c: In function
'ddw_memory_hotplug_max':
arch/powerpc/platforms/pseries/iommu.c:948:7: warning: variable 'ranges'
set but not used [-Wunused-but-set-variable]
   int ranges, n_mem_addr_cells, n_mem_size_cells, len;
       ^~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/pseries/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 36eb1ddbac69..03bbb299320e 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -105,7 +105,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      unsigned long attrs)
 {
 	u64 proto_tce;
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -113,7 +113,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index;
+	tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
@@ -129,9 +129,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 
 static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 {
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index;
+	tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--)
 		*(tcep++) = 0;
@@ -945,7 +945,7 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 
 	for_each_node_by_type(memory, "memory") {
 		unsigned long start, size;
-		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
+		int n_mem_addr_cells, n_mem_size_cells, len;
 		const __be32 *memcell_buf;
 
 		memcell_buf = of_get_property(memory, "reg", &len);
@@ -955,9 +955,6 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 		n_mem_addr_cells = of_n_addr_cells(memory);
 		n_mem_size_cells = of_n_size_cells(memory);
 
-		/* ranges in cell */
-		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
-
 		start = of_read_number(memcell_buf, n_mem_addr_cells);
 		memcell_buf += n_mem_addr_cells;
 		size = of_read_number(memcell_buf, n_mem_size_cells);
-- 
2.17.2 (Apple Git-113)

