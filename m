Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100BE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkctCI91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfF0Rl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:41:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF0Rl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:41:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id z19so1330117pgl.12;
        Thu, 27 Jun 2019 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bbsWcZhbi7tBjumCYh7c25rbCEMw05IRcZEp5w+Bqv8=;
        b=nkctCI919D3H2HAHj7Li5sMf4QI2MjWWSCS+6KMuqdSXKpN8gwJhb3MmBGllFO1ceN
         Bgw/6wPjGv2dHNBC9Hzh1RkALT70lFkQ94x5LtmDlIUwq6gqXBN91TjeX6jsng8/DbKt
         PAS7VMKBXomBA4aqMbdWMRguwCGlHE30zMXSP9xC1trQ0J8llH57/F196n/ZqfXLNYZF
         NVb9pB9SupqBNIbXXB7nKOgnJfMt/4mfcRDeXx2FdK5/G1B53IlmpoiZ48vqh6/N76yF
         ywjuJGK+WFtguWaiME4Ae24MYIQFzWKAI22S8sRUWgQ2I/UKnghH7ocQVng2YueT1+25
         oxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bbsWcZhbi7tBjumCYh7c25rbCEMw05IRcZEp5w+Bqv8=;
        b=BQMoB0syiTio/j7s5dB+4YaFTVkhm3QcTADjvXeTnmrCyfD+OVC4ganvq4oMt9bthB
         dCSWYlhGhXyCs14bRq+4zAKpXPOzq48KxbT1of3eSojIprNqLUWgZ5eh+1NaBzFYfD05
         Vnije/HOiaxXDIgnkTyC3Vfz+2/SAsAqEzyisSbY1uILvuNb7hMZIkqbQBbG5sIaZApC
         F/+Z+pAdH/Uinc3kiF0ryNChX8gxbjnZBIjRnDaQocuqPP4JkPS9SxODssWhAs18XOcN
         44a/eHr1oTDlbsY5K4460kQXWi6CvLo5/wb4vqlnZgkU2f2BK+lp7XpRA338r20WxlF3
         BDNA==
X-Gm-Message-State: APjAAAUiYrLoHIX3JRZFnm89xuFKprrwWcyMNy4S5YfXZ70Xw+qs9dr9
        fUbozWw7mFNf4wSMXAZVhnU=
X-Google-Smtp-Source: APXvYqw4aAJHoEfPjueXB2Onvl7IQhmEAtujSfPEQs4jH3va43Islqk084XE58m7Ascoj5sz1OhX6Q==
X-Received: by 2002:a63:c60b:: with SMTP id w11mr4735667pgg.356.1561657287612;
        Thu, 27 Jun 2019 10:41:27 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s7sm5350176pjn.28.2019.06.27.10.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:41:27 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 46/87] usb: host: remove memset after dma_alloc_coherent in xhci
Date:   Fri, 28 Jun 2019 01:41:20 +0800
Message-Id: <20190627174121.4399-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

