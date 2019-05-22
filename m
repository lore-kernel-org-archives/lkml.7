Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFA5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3820868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qVKEKI0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfEVQKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:10:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46704 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:10:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so1799268qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUUEDLWsi2MHHuyozS2c80A815aR1j2jtUYcHsaUwqw=;
        b=qVKEKI0jwdFX7l25/Vs53mFELv4NnklG6enWTsqv3YrfJ4DYmflKWe2oZdCW88LP4q
         9tBP+zieRZ8hjlthpUlBmuk2LQuZBSEhNi7xBM3OcIzq6c4nAjodP36q61MzVCci/oFN
         nhqLm0/usBT+OxNRTKV3RizsSBhEPdVwg/p8ujcd1gnmq9Nc+/RoDP6aaQX7i6gew09c
         Ka3KcUr7V/0pcL2k82suNNlQg+h7l8EDMfSoTXm6sxjiP9UV0GvhEVcHs/EWQnFpa8zL
         K70jOjS4cSXjht+BxM5SxefaKElso42VN9rIlRQg6f2LDPgzH8zdi5BG/05EuD3/+bab
         wpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUUEDLWsi2MHHuyozS2c80A815aR1j2jtUYcHsaUwqw=;
        b=BsH2TT+F+vdrJdEdy13bRt0tWdmIigfvDuYJP/vSMkFWNli4geb+oargbyBLZJbh6o
         1ujbbwp+HH1itw3loL1bxyC+plXMZDSeZr1rEPrRmF5jcoNB5H6XsLZgrmdIjreLQRfL
         EcrMUCq9T6bWDTgPOtvUXDJq6ClDbeejVlUQpvNZwoMyMdlympNJBWZVhErRjoLgl5Z+
         Y+JG/94/1qqXOXtfD1sWHIkgwi/zSJfBx75bc8q/EMgSm5Ehrvm9thEcLcMvImEIw+HF
         PCy1+K2XHlxvF0+448HvTELby/g7s2vWXPcKnAjPeVtS5THz9610XSoUXZ0XWaQ9mWAI
         3agA==
X-Gm-Message-State: APjAAAU/oCdYwXHTxNPtbmO6YV0HusMRKfI544s3oeAeG96a1EfFfd/p
        gMct29wtcr9F4XS6JwQRPyyRrg==
X-Google-Smtp-Source: APXvYqz+KTVZkkrXq4HFkHrw6rYCj9TIrV16qTi2Kq+lg5ApDMamEoVdtLJqtAhJ41fYwlPosq2W2A==
X-Received: by 2002:a05:620a:1670:: with SMTP id d16mr2448898qko.288.1558541402697;
        Wed, 22 May 2019 09:10:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j5sm11446226qtb.30.2019.05.22.09.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:10:02 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/powernv: fix a W=1 compilation warning
Date:   Wed, 22 May 2019 12:09:29 -0400
Message-Id: <1558541369-8263-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b575c731fe58 ("powerpc/powernv/npu: Add set/unset window
helpers") called pnv_npu_set_window() in a void function
pnv_npu_dma_set_32(), but the return code from pnv_npu_set_window() has
no use there as all the error logging happen in pnv_npu_set_window(),
so just remove the unused variable to avoid a compilation warning,

arch/powerpc/platforms/powernv/npu-dma.c: In function
'pnv_npu_dma_set_32':
arch/powerpc/platforms/powernv/npu-dma.c:198:10: warning: variable ‘rc’
set but not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 495550432f3d..035208ed591f 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -195,7 +195,6 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 {
 	struct pci_dev *gpdev;
 	struct pnv_ioda_pe *gpe;
-	int64_t rc;
 
 	/*
 	 * Find the assoicated PCI devices and get the dma window
@@ -208,8 +207,8 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 	if (!gpe)
 		return;
 
-	rc = pnv_npu_set_window(&npe->table_group, 0,
-			gpe->table_group.tables[0]);
+	pnv_npu_set_window(&npe->table_group, 0,
+			   gpe->table_group.tables[0]);
 
 	/*
 	 * NVLink devices use the same TCE table configuration as
-- 
1.8.3.1

