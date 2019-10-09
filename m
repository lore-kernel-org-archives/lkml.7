Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C3C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19C5206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gqX4rq+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfJIBHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:07:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50200 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfJIBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570583265; x=1602119265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Drzoga2/qb62rG5gRYCswouIqBr/dzKl/+yVPPdGcgM=;
  b=gqX4rq+byIyj1ksBIeDBh08ZebXT+zg1G4E4L76I+9xaS9k8v4oRLhy6
   y6YHoIfllPO6Aw1+1jHSemvoWWFk83QpwO2ZE1UYnW8qEJXfK8bR0PL91
   O97a56JTEl0kzkC82f7MkKHv+PeAxlGOJ+mZKTEeWRNjlw91pP5Mt2PN5
   6tC3YkVXhdm9WP7iagbIlk/BDsXLvmgIawta78nZ4SXYwqYQxrl7AQB0U
   n6shSusgiMxPG+gb/wG6fBmB2TFhVlejbxta59BISt/qNd9XfKll0KLTS
   EUAj2LlqKdLq556bQizbgIKjPWDLy1cibk5TCHTN6DJbSZzXryZWsbtT8
   A==;
IronPort-SDR: 3+RpQDAq64bceBLSfJd5B9q24cS+ftolY/chFzcWPY7vSB+KRg6fedks6BmXFqM+/0xsipKLUH
 IbDFdJAFSjGtZeH7W7PVqC/vfjWjZmRR1NXfndrwwHCXSWU22U+/6IVI+qOuwAfsyiX5wUZf44
 N0WjHu744XQD45KvYxoyr0KiK4uCQ21h0ncEl5vR8aLeXuST6SZfChGYn1IMFQf2I02DtQgXg+
 5qPe1j5NjCktV9hEINujEFRNNGS86PTcTcWUXKFh7ETFpvyHoSPpkd+bsilr2h9H+hfDI6fP5N
 hcA=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; 
   d="scan'208";a="221061441"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 09:07:44 +0800
IronPort-SDR: cLCQNGPHyGUGzBm9V1LBory8UsD0X1wmK818LvJjnm78kl0vV9sBomzclstRrwHsuBI9YUPC+i
 I6pRyN2Y4Tq1xA+n1y5Bk5jT7VFvOWKtdZPMgEqbzswCiUqL0490CRR/DyHLKknLuT2ObpK+f1
 qbh8qha6tdFCzuRntg487lnWHuXSG0e6hS18SRRHcDHXfMBCk9ZBA2VJlwt8h91a7GshmUf6zS
 rZ7Honi4yCz40tHUIXFuhPFrmNIMU+l6T7lVqN0e5M18lHJsJZbSDGJxIq4QgG6tLBGnOA+rGD
 KQW3xLBOyQz/A+/Z/us5mLqs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 18:02:59 -0700
IronPort-SDR: WGv8QSqeoPrRU4wj9q+DsbCGhW6kDwro69+hpsH/32hMiPv+tpqPC9K76rfmXhXKkaW8uM3d08
 xkO7tt7ppZ8Sff79lVGqkdKX/if+MxfB0grUGXIYHkyd7Rlm5NeZuTy8JMnbpCS27qsFJS5/te
 5Ku7OL1c/skrw1+qmMsoUgNM/y6vrPwriBmMOhvSb1UMlW1N6JHZiEn5bUAc8f60A2F0gmYJ0I
 2VsOI9JxPfFUKgk4trI5/VjmpC7/bwXhlGF5oLc6IJyWzBekiTDR5jrC6Bfa8b09NdAt8DZlGO
 xKg=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 18:06:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Karsten Merker <merker@debian.org>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Typo fixes in image header and documentation.
Date:   Tue,  8 Oct 2019 18:06:37 -0700
Message-Id: <20191009010637.9955-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some typos in boot image header and riscv boot documentation.

Fix the typos.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 Documentation/riscv/boot-image-header.rst | 4 ++--
 arch/riscv/include/asm/image.h            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
index 7b4d1d747585..8efb0596a33f 100644
--- a/Documentation/riscv/boot-image-header.rst
+++ b/Documentation/riscv/boot-image-header.rst
@@ -22,7 +22,7 @@ The following 64-byte header is present in decompressed Linux kernel image::
 	u64 res2 = 0;		  /* Reserved */
 	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
 	u32 magic2 = 0x56534905;  /* Magic number 2, little endian, "RSC\x05" */
-	u32 res4;		  /* Reserved for PE COFF offset */
+	u32 res3;		  /* Reserved for PE COFF offset */
 
 This header format is compliant with PE/COFF header and largely inspired from
 ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
@@ -34,7 +34,7 @@ Notes
 - This header can also be reused to support EFI stub for RISC-V in future. EFI
   specification needs PE/COFF image header in the beginning of the kernel image
   in order to load it as an EFI application. In order to support EFI stub,
-  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
+  code0 should be replaced with "MZ" magic string and res3(at offset 0x3c) should
   point to the rest of the PE/COFF header.
 
 - version field indicate header version number
diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
index 344db5244547..4f8061a5ac4a 100644
--- a/arch/riscv/include/asm/image.h
+++ b/arch/riscv/include/asm/image.h
@@ -42,7 +42,7 @@
  * @res2:		reserved
  * @magic:		Magic number (RISC-V specific; deprecated)
  * @magic2:		Magic number 2 (to match the ARM64 'magic' field pos)
- * @res4:		reserved (will be used for PE COFF offset)
+ * @res3:		reserved (will be used for PE COFF offset)
  *
  * The intention is for this header format to be shared between multiple
  * architectures to avoid a proliferation of image header formats.
@@ -59,7 +59,7 @@ struct riscv_image_header {
 	u64 res2;
 	u64 magic;
 	u32 magic2;
-	u32 res4;
+	u32 res3;
 };
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_IMAGE_H */
-- 
2.21.0

