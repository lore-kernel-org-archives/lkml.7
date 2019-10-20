Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB32CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984AC21928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwgOsRMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfJTFDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 01:03:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35890 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJTFDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 01:03:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so6275674pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywjurEp+Cqg9Fe4cTYNr3xdPVL+AQ1tEWRef7MBO2GM=;
        b=UwgOsRMTJdf+LgBr0C20ejDPIAr9ydq6HPqifia3cf2sUDbcy29b0cQ7haAAoaxH9M
         o0gSiH8mSnEWttP3FaZxSqF3TEW+GF1zdaoQrV++F4z7IOT5nK2/s47etV0YlDbhxUL/
         XJWssf9Q4WAoPZ3+IUx6qZBCzKlboTmJkUG6CzzL0WsJLPUqV7FI8a1XAC+Gkle+djPG
         vgvRCyMFONAJrtZWIOehm5TLiYtvPU2zaLC1ArRBGH39CrsmQZougjogh+YiBTIceHBH
         x5zjL0GPGoU13XhRj/s0xyuzA8/6ttP69rpJHIzSAR6Pgaqq58fnEZtidpd8KEuQhMCl
         kIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywjurEp+Cqg9Fe4cTYNr3xdPVL+AQ1tEWRef7MBO2GM=;
        b=XRphqReuPMQWth7d5ljDs5qHZuEY6tccCT/zeE2X4qMNdPZqbGkfuYQfus5+gotEF3
         wOM5QGigwnMlWv2CvCXftO7K5GrAJPvW56TKhLlb4So+BSHngqX/WSCtuSOXmxSZPN8I
         GI3HNj79Z8mkHmilnCR+uUhoRDrWTydIjDp6mpi4rZm3cfJ6PXCnOp1/k/G/n102VAvV
         7c4XK1mc9yNgkhDdnpMOw5srTP6VF9VnNjzGigXpe7hJSatfyoC/vJfialvcGzdQw2WB
         /XLgkF/x0e/P/cilCSOMyHKo/QY15JhyMVduHrIs9JfiBnoU+YrG5d1zKH87ZJMPyQwr
         B0cg==
X-Gm-Message-State: APjAAAVYss4hRSSubXW1MlG9dLH0wNdWTjwWeQ7lF4+5CoKMvSD+8lwB
        +HVGm5i6Sv7f57QXtAXxDBg=
X-Google-Smtp-Source: APXvYqzhq4Y6f40ITf9PsyqNcqlgvSoGUJy957fifRTQB2oiJKf62ter96xFc16NqqLRxmzBGJmp+A==
X-Received: by 2002:a62:2501:: with SMTP id l1mr15797770pfl.148.1571547824131;
        Sat, 19 Oct 2019 22:03:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:120d:c531:1e8a:2547:3f6b:fbca])
        by smtp.gmail.com with ESMTPSA id m5sm11238263pgt.15.2019.10.19.22.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 22:03:43 -0700 (PDT)
From:   Shyam Saini <mayhs11saini@gmail.com>
To:     kernel-hardening@lists.openwall.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shyam Saini <mayhs11saini@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH V2] kernel: dma: contigous: Make CMA parameters __initdata/__initconst
Date:   Sun, 20 Oct 2019 10:33:22 +0530
Message-Id: <20191020050322.2634-1-mayhs11saini@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These parameters are only referenced by __init routine calls during early
boot so they should be marked as __initdata and __initconst accordingly.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
V1->V2:
	mark cma parameters as __initdata/__initconst
	instead of __ro_after_init. As these parameters
	are only used by __init calls and never used afterwards
	which contrast the __ro_after_init usage.
---
 kernel/dma/contiguous.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..10bfc8c44c54 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
-static phys_addr_t size_cmdline = -1;
-static phys_addr_t base_cmdline;
-static phys_addr_t limit_cmdline;
+static const phys_addr_t size_bytes __initconst = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t  size_cmdline __initdata = -1;
+static phys_addr_t base_cmdline __initdata;
+static phys_addr_t limit_cmdline __initdata;
 
 static int __init early_cma(char *p)
 {
-- 
2.20.1

