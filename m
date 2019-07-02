Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105ACC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B9320659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pve7Qtj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGBH7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so7861596pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a7cYkb48u1/THE35/OWlII8Gna9fLu0HquRGryosopo=;
        b=pve7Qtj2Orf7wFpefZ+M7oDQymE0Wz2EdIpAqbkZQ/rY8inPMQhlpoe7wNd6jK6QdZ
         eSwp456/yKyWYkGaWhG7H8MCk6IzkCm0O32OI0XyCf0wiANKjN2+GL49PXjcimB3NlLa
         ntItf274MTGq/e+PgryxRLB0GkC4Uvd4hYRTQSEviZfFFkbolbg6Q7BideBr3aE3kVHj
         ksCOMzMS0EVjGL0spyVNdGwDkPXg+x3vvTsCYmFDu31vSFY4pvAvHX7itHqRLQ3XUO9t
         1QX0S7dsdtP5tTodloiW7NuWwn4zoHwqKi5PRLm9f7G1kyq1v4+hvuYP+UK+ezoRU8pJ
         Gvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a7cYkb48u1/THE35/OWlII8Gna9fLu0HquRGryosopo=;
        b=ShAkMG6LYahnf6q2Nos+YWgg5v5CY/lpV5jHDPL+Ywqm6NLn5gnjqNdgIvdp3UxeFe
         66Xry/Ocxy6HLJPGk91mdbD6St6LyzV+uF+xpLe/Pfl/Ea3FMt7e7CQzNb8AC2XRl/Zj
         0+NR3KJLed5dlRk3qd4QmJsh8XQiVa20cP/sXJEr7ZZuFHQkT/AbAZalLJa6i5NCv+yp
         DwvO0j8De/bJsbpAz3c4dtu/5NCSrbo4OX42+BBLf+ImgtMAoeSecE6CZJDxPqSHcC8d
         TExpCCY6CZ+7ncpigOiv3K7s32YJ54whce3jBfaJ7UQx24PGe2lNxODqTn3mcdro5wgQ
         9v3Q==
X-Gm-Message-State: APjAAAUZBqHKUbr/d6gCy7b54uXCSizZAxGKQvGKL1RY9oKvCy4N8yKz
        oxtR1aDl7dJ9JKuCcfmh7oD//gA5w7A=
X-Google-Smtp-Source: APXvYqx0npnNQy/eF0QtDsR+IebaiIimITmyZZJ8vIMzNsvZhOjJ+TkR647HQoGdpg89iKM8nIRwww==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr4123554pjq.120.1562054378662;
        Tue, 02 Jul 2019 00:59:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y12sm12208955pgi.10.2019.07.02.00.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:38 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 22/27] usb: remove unneeded memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:59:32 +0800
Message-Id: <20190702075932.24539-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/usb/host/xhci-dbgcap.c | 1 -
 drivers/usb/host/xhci-mem.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 52e32644a4b2..93e2cca5262d 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -22,7 +22,6 @@ dbc_dma_alloc_coherent(struct xhci_hcd *xhci, size_t size,
 
 	vaddr = dma_alloc_coherent(xhci_to_hcd(xhci)->self.sysdev,
 				   size, dma_handle, flags);
-	memset(vaddr, 0, size);
 	return vaddr;
 }
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index cf5e17962179..e16eda6e2b8b 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2399,7 +2399,6 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 			flags);
 	if (!xhci->dcbaa)
 		goto fail;
-	memset(xhci->dcbaa, 0, sizeof *(xhci->dcbaa));
 	xhci->dcbaa->dma = dma;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"// Device context base array address = 0x%llx (DMA), %p (virt)",
-- 
2.11.0

