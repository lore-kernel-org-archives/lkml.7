Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF1FC5B577
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B1208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9U+Il8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfF1CuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34319 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1CuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so1910996pgn.1;
        Thu, 27 Jun 2019 19:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bbsWcZhbi7tBjumCYh7c25rbCEMw05IRcZEp5w+Bqv8=;
        b=M9U+Il8agGS6QpXu/NToG92d8X5k/l/ZTeDkZ7QEH2NWuGfFN60GzSaDiSamlVUzAB
         K43XSTiUeitfLaD2udCPD7CJZtj9QK6IzdJL6FbE61wyGaKKjJ6hnDbv8v8na/se9BgW
         oZpZ3XujRP8a+zTyKuCvn39OQsKfLYQEHvCJDhK6bYL3G09klskTDitfunEqU4LeWcz1
         1BGVXvF7Z55eiWiEfexE3DIKUkGr7XIlew8nvCNVgOiFuNg/+cN4RvqPMFqzMFNQ+WJN
         WLKJdX11xffTYHadckn/r9IE7kU9BfVVPReA6lSG1zFUXUtVeqctl9I8LYTwAPseWFrx
         vWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bbsWcZhbi7tBjumCYh7c25rbCEMw05IRcZEp5w+Bqv8=;
        b=khHCIyMGYWqnpfEhxrXQgni16D4qffoYNh1mRY52B0UpIp9SR1EWokZhfB0BlOcSOn
         2d+kt+IoG+x+1WCxAy6rGEnDSXpiPWi6XoUyWvioqsTtH4hII/LrdXgHMtwtl+OBozJY
         evKdioy+OcrMqpeoYZXhBOjTT8zeHxObo1nM1EaA4sA/VurV2TbK0kJ0XfjdljiDU0q6
         M731hatkffb1U7VfLwMjQP89Et8RybFbZPXkXlY7czEAYfBcuK3ELfKYxEkcTmw9fD3A
         5JoQCqwQVBljKj9qgh5jfrcrdGxAsmWa5k/Lj0z2sADgC795DX/3HJow7Ix7/yU+tkmz
         tq5Q==
X-Gm-Message-State: APjAAAW9TKJKP+epfXCrqoLuaHRzJEsAdTLMCsJrSy1iDRdYC2c3Ibpj
        9RO1tzcaEY9r3Y5c4f+x1UE=
X-Google-Smtp-Source: APXvYqw8wcFi20L9JeG3x6QJuQsq8PK1OmzA3J8Hh1Hxv7HjYJe6UvGuU9at3YSgo0kg8d/BjjHU5Q==
X-Received: by 2002:a17:90a:19d:: with SMTP id 29mr10348043pjc.71.1561690216360;
        Thu, 27 Jun 2019 19:50:16 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id l13sm512093pjq.20.2019.06.27.19.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:15 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/27] usb: remove unneeded memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 10:50:09 +0800
Message-Id: <20190628025009.15974-1-huangfq.daxian@gmail.com>
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

