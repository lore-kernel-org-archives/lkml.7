Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF401C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E6720644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3URqt7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfGODUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:20:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGODUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:20:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so691485pgr.2;
        Sun, 14 Jul 2019 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a7cYkb48u1/THE35/OWlII8Gna9fLu0HquRGryosopo=;
        b=k3URqt7PLHSS3RC8pv4JgWz9tCWnECtG/Jv9Fay1Sq1/hbHjdBvcq4mk6mSsU/nyQg
         fZdHvyl6nIFNwTGXVgzVY6ms1trWSSANURfgs0l4wdBlBTa7XPAl2kcrms0BX6pvZQ3y
         EIRW+wWc2ay0IW2rRRWaha/Z2cemrTxfyhk9OTlg6E9mD9+8aZ7+htD1Xs0MUGN4FPqQ
         XfX/AkqZVqwACClQKomlExZFLnRqm/cbHO1dzB3OLEsgKM4gdvB6fgUXITOjX6Nemey/
         kMZLrSNN+JGRb5p/Mu5GuyRvAhzBlkQDkT6VD+yHjcmG+ru9sGP7rKk/EDaTakw5o9Sv
         oFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a7cYkb48u1/THE35/OWlII8Gna9fLu0HquRGryosopo=;
        b=kuB00giwnRmK72BSQYtUdh5d1/3gqD5Sp16ZOt/ij7IIQ+j65M3U1rAu/F0MLQRtW3
         qfqCADUmACbtwKrSYeAr7pY49SV9ILmpZndV8fPLxC6Gr4jhVnlaqd6IZTOQRjR2PnXF
         7fY80IPOksAhUCPYz0JS571/+Vt4oI4c2kEd85K6DvY2WzspDan8fXBV83s3T3rBGBkC
         wX/ghfg+d5nCB9JQlWDQL8bjnPAWj/8rJBEVmM+WYCqcPFoWqt9ui+/O8ajsRtlhfDWU
         rcALSpB4NOTzzZ8BLBloEUWoygETB4X/T0DQyyKm/4p9MNwuynHQklTkPzZLR7KU0WPV
         MAmg==
X-Gm-Message-State: APjAAAXl7TbQ1vmWUY92uF38bEiE8NDWz9fSCGoTp3Ss7T2I30t+h/T3
        lH9GYgW8dNAwL0pCL0EWf/I=
X-Google-Smtp-Source: APXvYqzBOwMbkLZkidheWKf1vGfsCvmAVMCMhhIPC6TjyIm64u5BM/c0K5fo5vREjjOr1yQwrTOVsA==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr23864892pgd.96.1563160815362;
        Sun, 14 Jul 2019 20:20:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id p2sm24360227pfb.118.2019.07.14.20.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:20:15 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 23/24] usb: host: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:20:10 +0800
Message-Id: <20190715032010.7258-1-huangfq.daxian@gmail.com>
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

